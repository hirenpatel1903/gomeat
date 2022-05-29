import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:vendor/Components/drawer.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/baseurl/baseurlg.dart' as baseUrl;
import 'package:vendor/beanmodel/notification.dart';
import 'package:vendor/beanmodel/revenue/topselling.dart';

class NotificationListPage extends StatefulWidget with WidgetsBindingObserver {
  @override
  _NotificationListPageState createState() => _NotificationListPageState();
}

class _NotificationListPageState extends State<NotificationListPage> {
  //List<ChatStore> _stores = [];
  var http = Client();

  List<NotificationData> notificationList = [];
  TopSellingRevenueOrdCount orderCount;
  bool isLoading = false;
  dynamic apCurrency;

  String storeImage = '';

  @override
  void initState() {
    super.initState();

    _init();
  }

  _init() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // int storeId = prefs.getInt('store_id');
    getNotification();
  }

  @override
  void dispose() {
    http.close();
    super.dispose();
  }

  void getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    http.post(storeNotificationUri, body: {'store_id': '${prefs.getInt('store_id')}'}).then((value) {
      if (value.statusCode == 200) {
        Notifications notification = Notifications.fromJson(jsonDecode(value.body));
        // setState(() {
        //   orderCount = notification;
        // });
        if ('${notification.status}' == '1') {
          setState(() {
            notificationList.clear();
            notificationList = List.from(notification.data);
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    });
  }

  void deleteNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    http.post(storeNotificationDeleteAllUri, body: {'store_id': '${prefs.getInt('store_id')}'}).then((value) {
      if (value.statusCode == 200) {
        Notifications notification = Notifications.fromJson(jsonDecode(value.body));
        // setState(() {
        //   orderCount = notification;
        // });
        if ('${notification.status}' == '1') {
          setState(() {
            notificationList.clear();
            // notificationList = List.from(notification.data);
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    });
  }

  Future _removeAllNotificationConfirmationDIalog() async {
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text(
                'Delete all notification',
              ),
              contentTextStyle: Theme.of(context).primaryTextTheme.bodyText1,
              content: Text('Are you sure you want to delete all notifications'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: Text(
                    'Yes',
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    deleteNotification();
                  },
                )
              ],
            );
          });
    } catch (e) {
      print("Exception - event_detail.dart- _removeAllNotificationConfirmationDIalog():" + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      drawer: buildDrawer(context),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            locale.notifications,
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          centerTitle: true,
          actions: [
            notificationList.length > 0
                ? Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: IconButton(
                        onPressed: () async {
                          await _removeAllNotificationConfirmationDIalog();
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        )),
                  )
                : SizedBox()
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: (!isLoading)
                ? notificationList.length > 0
                    ? ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 0),
                        shrinkWrap: true,
                        itemCount: notificationList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ChatInfo(
                                //               chatId: _stores[index].chatId,
                                //               name: _stores[index].name,
                                //               storeId: _stores[index].storeId,
                                //               userFcmToken: _stores[index].userFcmToken,
                                //               userId: _stores[index].userId,
                                //             )));
                              },
                              child: buildNotificationListCard(context, notificationList[index]));
                        })
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                          child: Text('No Notifications'),
                        ),
                      )
                // : Align(
                //     alignment: Alignment.center,
                //     child: Text(locale.nohistoryfound),
                //   )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 0),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return buildNotificationSHCard();
                    }),
          ),
          //Positioned.directional(textDirection: Directionality.of(context), top: 130, start: 0, end: 0, child: (!isLoading) ? buildOrderCard(context, orderCount) : buildOrderSHCard()),
        ],
      ),
    );
  }

  Container buildOrderCard(BuildContext context, TopSellingRevenueOrdCount orderCount) {
    var locale = AppLocalizations.of(context);
    return Container(
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
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '${locale.orders}\n', style: Theme.of(context).textTheme.subtitle2),
                  TextSpan(text: (orderCount.totalOrders != null) ? '${orderCount.totalOrders}' : '', style: Theme.of(context).textTheme.subtitle1.copyWith(height: 2)),
                ])),
            VerticalDivider(
              color: Colors.grey[400],
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '${locale.revenue}\n', style: Theme.of(context).textTheme.subtitle2),
                  TextSpan(text: (orderCount.totalRevenue != null) ? '$apCurrency ${orderCount.totalRevenue}' : '$apCurrency 0.0', style: Theme.of(context).textTheme.subtitle1.copyWith(height: 2)),
                ])),
            VerticalDivider(
              color: Colors.grey[400],
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(text: '${locale.pending}\n', style: Theme.of(context).textTheme.subtitle2),
                  TextSpan(text: (orderCount.pendingOrders != null) ? '${orderCount.pendingOrders}' : '0', style: Theme.of(context).textTheme.subtitle1.copyWith(height: 2)),
                ])),
          ],
        ),
      ),
    );
  }

  Widget buildOrderSHCard() {
    return Shimmer(
      duration: Duration(seconds: 3),
      color: Colors.white,
      enabled: true,
      direction: ShimmerDirection.fromLTRB(),
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
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                ],
              ),
              VerticalDivider(
                color: Colors.grey[400],
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
                ],
              ),
              VerticalDivider(
                color: Colors.grey[400],
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNotificationListCard(BuildContext context, NotificationData notificationData) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      // color: Colors.yellow,
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(0),
          title: Row(
            children: [
              Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: notificationData.image != null
                      ? CachedNetworkImage(
                          width: 60,
                          height: 230,
                          imageUrl: baseUrl.imagebaseUrl + '${notificationData.image}',
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Align(
                            widthFactor: 50,
                            heightFactor: 50,
                            alignment: Alignment.center,
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            'assets/icon.png',
                            fit: BoxFit.fill,
                          ),
                        )
                      : Container(
                          child: Icon(
                          Icons.person,
                          color: Theme.of(context).textTheme.subtitle2.color,
                        ))),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  notificationData.notTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 08, right: 08),
              child: Text(
                '${notificationData.notMessage}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildNotificationSHCard() {
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
