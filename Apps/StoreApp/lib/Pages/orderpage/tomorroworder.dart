import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Pages/Other/order_info.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/appinfomodel.dart';
import 'package:vendor/beanmodel/orderbean/todayorderbean.dart';

class TomorrowOrder extends StatefulWidget {
  @override
  _TomorrowOrderState createState() => _TomorrowOrderState();
}

class _TomorrowOrderState extends State<TomorrowOrder> {
  List<TodayOrderMain> newOrders = [];
  bool isAppActive = false;
  var http = Client();
  bool isLoading = false;
  dynamic apCurrency;

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       print("app in resumed");
  //       break;
  //     case AppLifecycleState.inactive:
  //       print("app in inactive");
  //       break;
  //     case AppLifecycleState.paused:
  //       print("app in paused");
  //       break;
  //     case AppLifecycleState.detached:
  //       setState(() {
  //         isAppActive = true;
  //       });
  //       print("app in detached");
  //       break;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
    hitAppInfo();
  }

  @override
  void dispose() {
    http.close();
    super.dispose();
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
    http.post(storenextdayOrdersUri, body: {'store_id': '${prefs.getInt('store_id')}'}).then((value) {
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
          ? ListView.builder(
              padding: EdgeInsets.only(bottom: 20),
              physics: ScrollPhysics(),
              itemCount: newOrders.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return buildCompleteCard(context, newOrders[index]);
              })
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

  // CircleAvatar buildStatusIcon(IconData icon, {bool disabled = false}) =>
  //     CircleAvatar(
  //         backgroundColor: !disabled ? Color(0xff222e3e) : Colors.grey[300],
  //         child: Icon(
  //           icon,
  //           size: 20,
  //           color: !disabled
  //               ? Theme.of(context).primaryColor
  //               : Theme.of(context).scaffoldBackgroundColor,
  //         ));

  GestureDetector buildCompleteCard(BuildContext context, TodayOrderMain mainP) {
    //var locale = AppLocalizations.of(context);
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

  // Padding buildAmountRow(String name, String price,
  //     {FontWeight fontWeight = FontWeight.w500}) {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 10.0),
  //     child: Row(
  //       children: [
  //         Text(
  //           name,
  //           style: TextStyle(fontWeight: fontWeight),
  //         ),
  //         Spacer(),
  //         Text(
  //           price,
  //           style: TextStyle(fontWeight: fontWeight),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
}
