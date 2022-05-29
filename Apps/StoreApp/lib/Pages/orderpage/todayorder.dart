import 'dart:convert';
import 'dart:typed_data';

import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as BluetoothP;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:http/http.dart';
import 'package:image/image.dart' as childImage;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Pages/Other/order_info.dart';
import 'package:vendor/Theme/colors.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/appinfomodel.dart';
import 'package:vendor/beanmodel/orderbean/todayorderbean.dart';
import 'package:vendor/beanmodel/util/invoice.dart';

class TodayOrder extends StatefulWidget {
  @override
  _TodayOrderState createState() => _TodayOrderState();
}

class _TodayOrderState extends State<TodayOrder> {
  BluetoothP.PrinterBluetoothManager printerManager = BluetoothP.PrinterBluetoothManager();
  List<BluetoothP.PrinterBluetooth> _deviceList = [];
  BluetoothManager bluetoothManager = BluetoothManager.instance;
  //bool _connected = false;
  BluetoothP.PrinterBluetooth _device;
  // List<BluetoothDevice> _deviceList = [];
  String tips = 'no device connect';
  List<TodayOrderMain> newOrders = [];
  bool isLoading = false;
  var http = Client();

  dynamic apCurrency;

  @override
  void initState() {
    super.initState();
    initBluetooth();
    hitAppInfo();
  }

  @override
  void dispose() {
    _onDisconnect();
    http.close();
    super.dispose();
  }

  Future<void> initBluetooth() async {
    printerManager.startScan(Duration(seconds: 4));
    printerManager.scanResults.listen((printers) async {
      print('printer');
      setState(() {
        print(printers.toList().toString());
        _deviceList.clear();
        _deviceList = List.from(printers);
        print(_deviceList.toString());
      });
    });
  }

  void _onConnect() async {
    if (_device != null && _device.address != null) {
      printerManager.selectPrinter(_device);
      // await printerManager.connect(_device);
    } else {
      setState(() {
        tips = 'please select device';
      });
      print('please select device');
    }
  }

  void _onDisconnect() async {
    printerManager.stopScan();
  }

  void hitAppInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var http = Client();
    http.post(appInfoUri, body: {'user_id': ''}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        AppInfoModel data1 = AppInfoModel.fromJson(jsonDecode(value.body));
        if (data1.status == "1" || data1.status == 1) {
          prefs.setString('app_currency', '${data1.currencySign}');
          prefs.setString('app_referaltext', '${data1.refertext}');
          prefs.setString('numberlimit', '${data1.phoneNumberLength}');
          prefs.setString('imagebaseurl', '${data1.imageUrl}');
          prefs.setString('liveChat', '${data1.liveChat}');
          getImageBaseUrl();
        }
      }
    }).catchError((e) {
      print(e);
    });
    getOrderList();
  }

  void getOrderList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      apCurrency = prefs.getString('app_currency');
    });
    http.post(storetodayOrdersUri, body: {'store_id': '${prefs.getInt('store_id')}'}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        var jsD = jsonDecode(value.body) as List;
        if ('${jsD[0]['order_details']}'.toUpperCase() != 'NO ORDERS FOUND') {
          newOrders = List.from(jsD.map((e) => TodayOrderMain.fromJson(e)).toList());
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
        newOrders.clear();
      });
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Container(
      color: Colors.grey[200],
      child: (!isLoading && newOrders != null && newOrders.length > 0)
          ? ListView(
              physics: BouncingScrollPhysics(),
              children: [
                ListView.builder(
                    padding: EdgeInsets.only(bottom: 20),
                    physics: ScrollPhysics(),
                    itemCount: newOrders.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildCompleteCard(context, newOrders[index]);
                    }),
              ],
            )
          : isLoading
              ? Align(
                  widthFactor: 40,
                  heightFactor: 40,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : Align(
                  alignment: Alignment.center,
                  child: Text(locale.noorderfnd),
                ),
    );
  }

  CircleAvatar buildStatusIcon(IconData icon, {bool disabled = false}) => CircleAvatar(
      backgroundColor: !disabled ? Color(0xff222e3e) : Colors.grey[300],
      child: Icon(
        icon,
        size: 20,
        color: !disabled ? Theme.of(context).primaryColor : Theme.of(context).scaffoldBackgroundColor,
      ));

  GestureDetector buildCompleteCard(BuildContext context, TodayOrderMain mainP) {
    var locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderInfo(mainP))).then((value) {
          if (value != null && value) {
            getOrderList();
          }
        });
      },
      child: Card(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        margin: EdgeInsets.only(left: 14, right: 14, top: 14),
        color: Colors.white,
        elevation: 1,
        child: Column(
          children: [
            buildItem(context, mainP),
            buildOrderInfoRow(context, '$apCurrency ${mainP.order_price}', '${mainP.payment_mode}', '${mainP.order_status}'),
            buildPrintRow(context, locale, cartId: '${mainP.cart_id}'),
          ],
        ),
      ),
    );
  }

  Container buildOrderInfoRow(BuildContext context, String price, String prodID, String orderStatus, {double borderRadius = 8}) {
    var locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(borderRadius)),
        color: Colors.grey[100],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 12),
      child: Row(
        children: [
          buildGreyColumn(context, locale.payment, price),
          Spacer(),
          buildGreyColumn(context, locale.paymentmode, prodID),
          // Spacer(),
          // buildGreyColumn(context, 'Qty', '1'),
          Spacer(),
          buildGreyColumn(context, locale.orderStatus, orderStatus, text2Color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }

  Container buildPrintRow(BuildContext context, AppLocalizations locale, {double borderRadius = 8, dynamic cartId}) {
    var locale = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(borderRadius)),
        color: Colors.grey[100],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 12),
      child: Align(
        alignment: Alignment.centerRight,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kMainColor),
          ),
          onPressed: () {
            bluetoothManager.isConnected.then((value) {
              if (value) {
                getInvoice(cartId, locale);
              } else {}
            }).catchError((e) {});
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext contextd) {
                  return AlertDialog(
                    title: Text(locale.headingAlert1),
                    content: _deviceList != null && _deviceList.length > 0
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: _deviceList.length,
                            itemBuilder: (cntxt, index) {
                              return buildBluetoothCard(contextd, _deviceList[index], locale);
                            })
                        : SizedBox(),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                          overlayColor: MaterialStateProperty.all(Colors.transparent),
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          foregroundColor: MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              side: BorderSide(color: Colors.transparent),
                            ),
                          ),
                        ),
                        child: Text(
                          locale.close,
                          style: TextStyle(color: kMainColor),
                        ),
                        //textColor: kMainColor,
                        onPressed: () => Navigator.pop(contextd),
                      ),
                    ],
                  );
                });
          },
          //color: kMainColor,
          child: Text(locale.printinvoice),
          //textColor: kWhiteColor,
        ),
      ),
    );
  }

  void getInvoice(dynamic cartId, AppLocalizations locale) async {
    // const PaperSize paper = PaperSize.mm80;
    // final profile = await CapabilityProfile.load();
    http.post(getInvoiceUri, body: {'cart_id': cartId}).then((value) {
      if (value.statusCode == 200) {
        Invoice invoice = Invoice.fromJson(jsonDecode(value.body));
        if ('${invoice.status}' == '1') {
          // bluetoothManager.isConnected.then((conn){
          //   if(conn){
          //     // final printer = NetworkPrinter(paper, profile);
          //
          //   }
          // });
          printOrCreateInvoice(invoice, locale).then((pTicket) async {
            final BluetoothP.PosPrintResult res = await printerManager.printTicket(pTicket);
            print('Print result: ${res.msg}');
          });
        }
      }
    }).catchError((e) {});
  }

  Future<Ticket> printOrCreateInvoice(Invoice invoice, AppLocalizations locale) async {
    final Ticket ticket = Ticket(PaperSize.mm80);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final ByteData data = await rootBundle.load('assets/icon.jpg');
    final Uint8List bytes = data.buffer.asUint8List();
    final childImage.Image image = childImage.decodeImage(bytes);
    ticket.image(image);

    ticket.text(prefs.getString('app_name'),
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    ticket.text('${invoice.address}', styles: PosStyles(align: PosAlign.center));
    ticket.text('${invoice.city} (${invoice.pincode})', styles: PosStyles(align: PosAlign.center));
    ticket.text('Tel: ${invoice.number}', styles: PosStyles(align: PosAlign.center));
    ticket.hr();
    ticket.row([
      PosColumn(text: '#', width: 1),
      PosColumn(text: locale.invoice1h, width: 7),
      PosColumn(text: locale.invoice2h, width: 1),
      PosColumn(text: locale.invoice3h, width: 2, styles: PosStyles(align: PosAlign.right)),
      PosColumn(text: locale.invoice4h, width: 2, styles: PosStyles(align: PosAlign.right)),
    ]);
    List<OrderDetails> orderDetaisl = List.from(invoice.orderDetails);
    int it = 1;
    for (OrderDetails details in orderDetaisl) {
      ticket.row([
        PosColumn(text: '$it', width: 1),
        PosColumn(text: '${details.productName} (${details.quantity} ${details.unit})', width: 7),
        PosColumn(text: '${details.qty}', width: 1),
        PosColumn(text: '${details.price}', width: 2, styles: PosStyles(align: PosAlign.right)),
        PosColumn(text: '${double.parse('${details.price}') * double.parse('${details.qty}')}', width: 2, styles: PosStyles(align: PosAlign.right)),
      ]);
      it++;
    }

    ticket.hr();

    ticket.row([
      PosColumn(
          text: locale.invoice4h,
          width: 6,
          styles: PosStyles(
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
      PosColumn(
          text: '$apCurrency ${double.parse('${invoice.totalPrice}') + double.parse('${invoice.deliveryCharge}')}',
          width: 6,
          styles: PosStyles(
            align: PosAlign.right,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          )),
    ]);

    ticket.hr(ch: '=', linesAfter: 1);
    ticket.row([
      PosColumn(text: locale.invoice5h, width: 7, styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(text: '$apCurrency ${invoice.totalPrice}', width: 5, styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);
    ticket.row([
      PosColumn(text: locale.invoice6h, width: 7, styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
      PosColumn(text: '$apCurrency ${invoice.deliveryCharge}', width: 5, styles: PosStyles(align: PosAlign.right, width: PosTextSize.size2)),
    ]);

    ticket.feed(2);
    ticket.text(locale.invoice7h, styles: PosStyles(align: PosAlign.center, bold: true));

    final now = DateTime.now();
    final formatter = DateFormat('MM/dd/yyyy H:m');
    final String timestamp = formatter.format(now);
    ticket.text(timestamp, styles: PosStyles(align: PosAlign.center), linesAfter: 2);
    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

  Padding buildItem(BuildContext context, TodayOrderMain mainP) {
    var locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset('assets/icon.png', height: 70)),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      mainP.user_name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 6),
                    Text(
                      mainP.user_phone,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 6),
                    Text(
                      mainP.user_address,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 16),
                    Text(locale.orderedOn + ' ${mainP.order_details[0].order_date}', style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 10.5)),
                  ],
                ),
              ),
            ],
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            end: 0,
            bottom: 0,
            child: Text(
              locale.orderID + ' #${mainP.cart_id}',
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 10.5),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildAmountRow(String name, String price, {FontWeight fontWeight = FontWeight.w500}) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: fontWeight),
          ),
          Spacer(),
          Text(
            price,
            style: TextStyle(fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }

  Column buildGreyColumn(BuildContext context, String text1, String text2, {Color text2Color = Colors.black}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text1, style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 11)),
        SizedBox(height: 8),
        LimitedBox(
          maxWidth: 100,
          child: Text(text2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: text2Color)),
        ),
      ],
    );
  }

  Container buildBluetoothCard(BuildContext context, BluetoothP.PrinterBluetooth bt, AppLocalizations locale) {
    var locale = AppLocalizations.of(context);
    return Container(
      // height: 500,
      // width: 200,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(8), child: Icon(Icons.bluetooth_audio_sharp)),
              SizedBox(
                width: 10,
              ),
              RichText(
                  text: TextSpan(style: Theme.of(context).textTheme.subtitle1, children: <TextSpan>[
                TextSpan(text: '${bt.name}\n'),
                TextSpan(text: '${locale.apparel}\n\n', style: Theme.of(context).textTheme.subtitle2),
                TextSpan(text: '${bt.address} ${locale.sold}', style: Theme.of(context).textTheme.bodyText2.copyWith(height: 0.5)),
              ])),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    _device = bt;
                  });
                  Navigator.of(context);
                  _onConnect();
                },
                child: Text(locale.connect),
                color: kMainColor,
                textColor: kWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
