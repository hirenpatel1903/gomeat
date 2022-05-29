import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/Components/drawer.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Pages/Chat/chat_info.dart';
import 'package:vendor/Pages/Chat/local_notification_model.dart';
import 'package:vendor/Pages/orderpage/todayorder.dart';
import 'package:vendor/Pages/orderpage/tomorroworder.dart';
import 'package:vendor/beanmodel/chatmodel/global.dart' as global;

FirebaseMessaging messaging = FirebaseMessaging.instance;
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   '2121', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  // if (message != null) {
  //   RemoteNotification notification = message.notification;
  //   if (notification != null) {
  //     _showNotification(
  //         notification.title, notification.body, notification.android.imageUrl);
  //   }
  // }
}

class NewOrdersDrawer extends StatefulWidget {
  @override
  _NewOrdersDrawerState createState() => _NewOrdersDrawerState();
}

class _NewOrdersDrawerState extends State<NewOrdersDrawer> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  int pageIndex = 0;
  TabController tabController;
  bool enteredFirst = true;
  bool _isInForeground = true;
  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(_tabControllerListener);
    setFirebase();
  }

  void _tabControllerListener() {
    setState(() {
      currentTabIndex = tabController.index;
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('islogin')) {
      if (global.localNotificationModel.chatId != null && !global.isChatNotTapped) {
        if (global.localNotificationModel.route == 'chatlist_screen') {
          if (state == AppLifecycleState.resumed) {
            setState(() {
              global.isChatNotTapped = true;
            });
            // Get.to(() => ChatScreen(a: widget.analytics, o: widget.observer));
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatInfo(
                      chatId: global.localNotificationModel.chatId,
                      name: global.localNotificationModel.firstName,
                      storeId: global.localNotificationModel.storeId,
                      userFcmToken: global.localNotificationModel.fcmToken,
                      userId: global.localNotificationModel.userId,
                    )));
          }
        }
      }
    } else {
      // if (state == AppLifecycleState.resumed) {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => LoginScreen(
      //             a: widget.analytics,
      //             o: widget.observer,
      //           )));
      // }
    }
  }

  void setFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('FIR -> $e');
    }
    messaging = FirebaseMessaging.instance;
    iosPermission(messaging);
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {
        RemoteNotification notification = message.notification;
        if (notification != null) {
          _showNotification(notification.title, notification.body, notification.android.imageUrl);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message != null) {
        LocalNotification _notificationModel = LocalNotification.fromJson(message.data);
        global.localNotificationModel = _notificationModel;
        setState(() {
          global.isChatNotTapped = false;
        });
        RemoteNotification notification = message.notification;
        if (notification != null && _isInForeground) {
          _showNotification(notification.title, notification.body, notification.android.imageUrl);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // if (message != null) {
      //   RemoteNotification notification = message.notification;
      //   if (notification != null) {
      //     _showNotification(notification.title, notification.body,
      //         notification.android.imageUrl);
      //   }
      // }
    });
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: buildDrawer(context),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            locale.newOrders,
            style: TextStyle(
              color: Theme.of(context).backgroundColor,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TabBar(
              tabs: [
                Card(
                  color: currentTabIndex == 0 ? Colors.white : Colors.grey[200],
                  elevation: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      locale.todayOrd,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Card(
                  color: currentTabIndex == 1 ? Colors.white : Colors.grey[200],
                  elevation: 3,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Text(
                      locale.nextDayOrder,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              ],
              isScrollable: false,
              controller: tabController,
              indicatorWeight: 1,
              indicatorColor: Colors.transparent,
              labelPadding: EdgeInsets.all(0),
              onTap: (int index) {
                setState(() {
                  currentTabIndex = index;
                });
              },
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  TodayOrder(),
                  TomorrowOrder(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {}

  Future selectNotification(String payload) async {}

  void iosPermission(FirebaseMessaging firebaseMessaging) {
    if (Platform.isIOS) {
      firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
}

Future<void> _showNotification(dynamic title, dynamic body, dynamic imageUrl) async {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    } else {
      if (imageUrl != null && '$imageUrl'.toUpperCase() != 'NUll' && '$imageUrl'.toUpperCase() != 'N/A') {
        AwesomeNotifications().createNotification(
            content: NotificationContent(
          id: 10,
          channelKey: '2121',
          title: '$title',
          body: '$body',
          icon: 'resource://drawable/icon',
          bigPicture: '$imageUrl',
          largeIcon: '$imageUrl',
          notificationLayout: NotificationLayout.BigPicture,
        ));
      } else {
        AwesomeNotifications().createNotification(content: NotificationContent(id: 10, channelKey: '2121', title: '$title', body: '$body', icon: 'resource://drawable/icon'));
      }
    }
  });
}
