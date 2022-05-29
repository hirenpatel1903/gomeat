import 'dart:convert';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/baseurl/baseurlg.dart';
import 'package:driver/beanmodel/orderhistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodayOrder extends StatefulWidget {
  @override
  _TodayOrderState createState() => _TodayOrderState();
}

class _TodayOrderState extends State<TodayOrder> {
  List<OrderHistory> newOrders = [];
  bool isLoading = false;
  var http = Client();
  dynamic apCurency;
  bool pageDestroy = false;

  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  @override
  void dispose() {
    pageDestroy = true;
    http.close();
    super.dispose();
  }

  void getOrderList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!pageDestroy) {
      setState(() {
        isLoading = true;
        apCurency = prefs.getString('app_currency');
      });
    }

    http.post(ordersfortodayUri, body: {'dboy_id': '${prefs.getInt('db_id')}'}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        if ('${value.body}' != '\n[{\"order_details\":\"no orders found\"}]') {
          var jsD = jsonDecode(value.body) as List;
          if (!pageDestroy) {
            setState(() {
              newOrders.clear();
              newOrders = List.from(jsD.map((e) => OrderHistory.fromJson(e)).toList());
            });
          }
        } else {
          if (!pageDestroy) {
            setState(() {
              newOrders.clear();
            });
          }
        }
      } else {
        if (!pageDestroy) {
          setState(() {
            newOrders.clear();
          });
        }
      }
      if (!pageDestroy) {
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((e) {
      if (!pageDestroy) {
        setState(() {
          isLoading = false;
          newOrders.clear();
        });
      }
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          locale.todayorder,
          style: TextStyle(
            color: kMainTextColor,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: (!isLoading && newOrders != null && newOrders.length > 0)
            ? ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ListView.builder(
                      padding: EdgeInsets.only(bottom: 20),
                      physics: NeverScrollableScrollPhysics(),
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
                    child: Text(
                      locale.noorder,
                      textAlign: TextAlign.center,
                    ),
                  ),
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

  GestureDetector buildCompleteCard(BuildContext context, OrderHistory mainP) {
    return GestureDetector(
      onTap: () {
        if ('${mainP.orderStatus}'.toUpperCase() == 'CONFIRMED') {
          Navigator.pushNamed(context, PageRoutes.orderAcceptedPage, arguments: {'OrderDetail': mainP}).then((value) {
            getOrderList();
          });
        } else if ('${mainP.orderStatus}'.toUpperCase() == 'OUT FOR DELIVERY') {
          Navigator.pushNamed(context, PageRoutes.signatureview, arguments: {'OrderDetail': mainP}).then((value) {
            getOrderList();
          });
        }
      },
      child: Card(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        margin: EdgeInsets.only(left: 14, right: 14, top: 14),
        color: Colors.white,
        elevation: 1,
        child: Column(
          children: [
            buildItem(context, mainP),
            buildOrderInfoRow(context, '$apCurency ${mainP.remainingPrice}', '${mainP.paymentMethod}'.toUpperCase() == 'SODEXO' ? 'Sodexo on delivery' : '${mainP.paymentMethod}', '${mainP.orderStatus}'),
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

  Padding buildItem(BuildContext context, OrderHistory mainP) {
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
                      mainP.userName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 6),
                    Text(
                      mainP.userPhone,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(height: 6),
                    Text(
                      mainP.userAddress,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 12),
                    ),
                    SizedBox(height: 16),
                    // Text(locale.orderedOn + ' ${mainP.items[0].orderDate}',
                    //     style: Theme.of(context)
                    //         .textTheme
                    //         .subtitle2
                    //         .copyWith(fontSize: 10.5)),
                    (mainP.items != null && mainP.items.length > 0) ? Text(locale.orderedOn + ' ${mainP.items[0].orderDate}', style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 10.5)) : SizedBox.shrink(),
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
              locale.orderID + ' #${mainP.cartId}',
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
}
