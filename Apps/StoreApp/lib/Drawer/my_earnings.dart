import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:vendor/Components/drawer.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Theme/colors.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/orderbean/completedhistory.dart';

class MyEarningsPage extends StatefulWidget {
  @override
  _MyEarningsPageState createState() => _MyEarningsPageState();
}

class _MyEarningsPageState extends State<MyEarningsPage> {
  List<CompletedHistoryOrder> newOrders = [];
  bool isLoading = false;
  var http = Client();
  String storeImage = '';
  String ordersRevenue = '0';
  dynamic apCurrency;

  @override
  void initState() {
    super.initState();
    getOrderList();
  }

  @override
  void dispose() {
    http.close();
    super.dispose();
  }

  void getOrderList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      storeImage = prefs.getString('store_photo');
      apCurrency = prefs.getString('app_currency');
    });
    http.post(storeOrderHistoryUri, body: {'store_id': '${prefs.getInt('store_id')}'}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        if ('${value.body}' != '[{\"order_details\":\"no orders found\"}]') {
          CompletedHistory history = CompletedHistory.fromJson(jsonDecode(value.body));
          setState(() {
            ordersRevenue = '${history.totalRevenue}';
            newOrders.clear();
            newOrders = List.from(history.data);
          });
        } else {
          setState(() {
            newOrders.clear();
          });
        }
      } else {
        setState(() {
          newOrders.clear();
        });
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: buildDrawer(context),
      body: Stack(
        children: [
          Image.network(
            storeImage,
            height: 180,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: AppBar(
              title: Text(
                locale.myEarnings,
                style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
              ),
              centerTitle: true,
              iconTheme: new IconThemeData(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 180),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 15,
                ),
                // Container(
                //   child: Image.asset(
                //     'assets/charts.png',
                //     fit: BoxFit.fill,
                //   ),
                //   height: 200,
                //   margin: EdgeInsets.symmetric(horizontal: 10),
                //   decoration: BoxDecoration(
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey[400],
                //         blurRadius: 0.0, // soften the shadow
                //         spreadRadius: 0.5, //extend the shadow
                //       ),
                //     ],
                //     borderRadius: BorderRadius.circular(8),
                //     color: Theme.of(context).scaffoldBackgroundColor,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
                  child: Text(
                    locale.recentTransactions,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
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
                        }),
              ],
            ),
          ),
          Positioned.directional(
            textDirection: Directionality.of(context),
            top: 130,
            start: 0,
            end: 0,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[400],
                    blurRadius: 0.0, // soften the shadow
                    spreadRadius: 0.5, //extend the shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Spacer(),
                    Container(
                      height: 80,
                      child: Center(
                        child: (!isLoading)
                            ? RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(text: locale.revenue + '\n', style: Theme.of(context).textTheme.subtitle2),
                                  TextSpan(text: (ordersRevenue != null) ? '$apCurrency $ordersRevenue' : '$apCurrency 0.0', style: Theme.of(context).textTheme.subtitle1.copyWith(height: 2)),
                                ]))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 60,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 60,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Spacer(),
                    VerticalDivider(
                      color: Colors.grey[400],
                      width: 20,
                    ),
                    Spacer(),
                    Container(
                      height: 80,
                      child: Center(
                        child: (!isLoading)
                            ? RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(children: <TextSpan>[
                                  TextSpan(text: locale.orders + '\n', style: Theme.of(context).textTheme.subtitle2),
                                  TextSpan(text: (newOrders != null && newOrders.length > 0) ? '${newOrders.length}' : '0', style: Theme.of(context).textTheme.subtitle1.copyWith(height: 2)),
                                ]))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 60,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 10,
                                    width: 60,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                      ),
                    ),
                    Spacer(),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.pushNamed(context, PageRoutes.sendToBank);
                    //   },
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadiusDirectional.horizontal(
                    //             end: Radius.circular(8)),
                    //         color: Theme.of(context).primaryColor),
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: MediaQuery.of(context).size.width / 16),
                    //     height: 80,
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(locale.sendTo,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyText1
                    //                 .copyWith(
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w300)),
                    //         SizedBox(
                    //           height: 6,
                    //         ),
                    //         Row(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           children: [
                    //             Text(locale.bank,
                    //                 style:
                    //                     Theme.of(context).textTheme.bodyText1),
                    //             SizedBox(
                    //               width: 4,
                    //             ),
                    //             Icon(Icons.arrow_forward_ios,
                    //                 color: Colors.white, size: 14),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildTransactionCard(BuildContext context, CompletedHistoryOrder newOrder) {
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
              ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    newOrder.data[0].varientImage,
                    fit: BoxFit.fill,
                    height: 70,
                    width: 80,
                  )),
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
              '\n\n$apCurrency ${newOrder.price}',
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
