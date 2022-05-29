import 'dart:convert';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Pages/drawer.dart';
import 'package:driver/Pages/home_page.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/baseurl/baseurlg.dart';
import 'package:driver/beanmodel/completedorderhistory.dart';
import 'package:driver/beanmodel/driverstatus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class InsightPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      drawer: AccountDrawer(context),
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text(locale.insight.toUpperCase()),
        centerTitle: true,
        titleSpacing: 0.0,
        // actions: <Widget>[
        //   FlatButton(
        //     onPressed: (){},
        //     child: Row(
        //       children: [
        //         Text(locale.today),
        //         Icon(Icons.arrow_drop_down),
        //       ],
        //     ),
        //   ),
        // ],
      ),
      body: Insight(),
    );
  }
}

class Insight extends StatefulWidget {
  @override
  InsightState createState() {
    return InsightState();
  }
}

class InsightState extends State<Insight> {
  var http = Client();
  bool isLoading = false;
  List<OrderHistoryCompleted> newOrders = [];
  int totalOrder = 0;
  double totalincentives = 0.0;
  dynamic apCurrency;

  void getOrderHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      apCurrency = prefs.getString('app_currency');
    });
    http.post(completedOrdersUrl, body: {'dboy_id': '${prefs.getInt('db_id')}'}).then((value) {
      if (jsonDecode(value.body) != '[{\"order_details\":\"no orders found\"}]') {
        var js = jsonDecode(value.body) as List;
        if (js != null && js.length > 0) {
          newOrders.clear();
          newOrders = js.map((e) => OrderHistoryCompleted.fromJson(e)).toList();
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getOrderHistory();
    getDrierStatus();
  }

  @override
  void dispose() {
    http.close();
    super.dispose();
  }

  void getDrierStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.post(driverStatusUri, body: {'dboy_id': '${prefs.getInt('db_id')}'}).then((value) {
      if (value.statusCode == 200) {
        DriverStatus dstatus = DriverStatus.fromJson(jsonDecode(value.body));
        if ('${dstatus.status}' == '1') {
          int onoff = int.parse('${dstatus.onlineStatus}');
          prefs.setInt('online_status', onoff);
          totalOrder = int.parse('${dstatus.totalOrders}');
          totalincentives = double.parse('${dstatus.totalIncentive}');
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Divider(thickness: 6.0),
          Container(
            color: kWhiteColor,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildRowChild(theme, '$totalOrder', locale.orders),
                buildRowChild(theme, '$apCurrency $totalincentives', locale.earnings),
              ],
            ),
          ),
          Divider(thickness: 6),
          (!isLoading)
              ? (newOrders != null && newOrders.length > 0)
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(vertical: 0),
                      shrinkWrap: true,
                      itemCount: newOrders.length,
                      itemBuilder: (context, index) {
                        return buildTransactionCard(context, newOrders[index]);
                      })
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      alignment: Alignment.center,
                      child: Text(locale.nohistoryfound),
                    )
              : ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 0),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return buildTransactionSHCard();
                  })
        ],
      ),
    );
  }

  Container buildTransactionCard(BuildContext context, OrderHistoryCompleted newOrder) {
    var locale = AppLocalizations.of(context);
    return Container(
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
              // ClipRRect(
              //     borderRadius: BorderRadius.circular(8),
              //     child: Image.network(
              //       newOrder.data[0].varientImage,
              //       fit: BoxFit.fill,
              //       height: 70,
              //       width: 80,
              //     )),
              SizedBox(
                width: 10,
              ),
              RichText(
                  text: TextSpan(style: Theme.of(context).textTheme.subtitle1, children: <TextSpan>[
                TextSpan(text: '${newOrder.userName}\n'),
                TextSpan(text: locale.deliveryDate + ' ${newOrder.deliveryDate}\n\n', style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 12, height: 1.3)),
                TextSpan(text: locale.orderID + ' ', style: Theme.of(context).textTheme.subtitle2.copyWith(height: 0.5)),
                TextSpan(text: '#${newOrder.cartId}', style: Theme.of(context).textTheme.bodyText2.copyWith(height: 0.5, fontWeight: FontWeight.w500)),
              ])),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Text(
              '\n\n$apCurrency ${newOrder.remainingPrice}',
              style: Theme.of(context).textTheme.bodyText2.copyWith(color: '${newOrder.orderStatus}'.toUpperCase() == 'Completed'.toUpperCase() ? kMainColor : kRedColor, fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTransactionSHCard() {
    return Shimmer(
      duration: Duration(seconds: 3),
      color: Colors.white,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
      child: Container(
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
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 70,
                      width: 70,
                      color: Colors.grey[300],
                    )),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 60,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 10,
                      width: 60,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 10,
                      width: 60,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
