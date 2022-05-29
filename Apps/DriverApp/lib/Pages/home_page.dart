import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_location/background_location.dart' as back;
import 'package:driver/Locale/locales.dart';
import 'package:driver/Pages/drawer.dart';
import 'package:driver/Pages/orderpage/todayorder.dart';
import 'package:driver/Pages/orderpage/tomorroworder.dart';
import 'package:driver/baseurl/baseurlg.dart';
import 'package:driver/beanmodel/appinfo.dart';
import 'package:driver/beanmodel/driverstatus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wakelock/wakelock.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   '1232', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
// Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
//   if (message != null) {
//     RemoteNotification notification = message.notification;
//     if (notification != null) {
//       _showNotification(
//           notification.title, notification.body, notification.android.imageUrl);
//     }
//   }
// }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, WidgetsBindingObserver {
  static const LatLng _center = const LatLng(90.0, 90.0);
  CameraPosition kGooglePlex = CameraPosition(
    target: _center,
    zoom: 25.151926,
  );

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  Set<Marker> markers = {};
  dynamic lat;
  dynamic lng;
  bool isOffline = true;
  bool enteredFirst = false;
  bool _isInForeGround = true;
  var http = Client();
  int totalOrder = 0;
  double totalincentives = 0.0;
  dynamic apCurency;
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  var isRun = false;

  void updateStatus(int status) async {
    setState(() {
      isRun = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.post(updateStatusUri, body: {'dboy_id': '${prefs.getInt('db_id')}', 'status': '$status'}).then((value) {
      var js = jsonDecode(value.body);
      if ('${js['status']}' == '1') {
        prefs.setInt('online_status', status);
        if (status == 0) {
          setState(() {
            isOffline = true;
            isRun = false;
          });
        } else {
          setState(() {
            isOffline = false;
            isRun = false;
          });
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _init();

    WidgetsBinding.instance.addObserver(this);
    setFirebase();
    getDrierStatus();
    hitAppInfo();
  }

  _init() async {
    try {
      Wakelock.enable();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String lat1 = prefs.getString('lat');
      String lng1 = prefs.getString('lng');
      lat = double.parse(lat1);
      lng = double.parse(lng1);
      await _updateMarker(lat, lng);
    } catch (e) {
      print('MAP Exception - locationScreen.dart - _init():' + e.toString());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeGround = state == AppLifecycleState.resumed;
  }

  void setFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('FIR -> $e');
    }
    messaging = FirebaseMessaging.instance;
    iosPermission(messaging);
    // var initializationSettingsAndroid =
    // AndroidInitializationSettings('icon');
    // var initializationSettingsIOS = IOSInitializationSettings(
    //     onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onSelectNotification: selectNotification);
    messaging.getToken().then((value) {
      debugPrint('token: $value');
    });

    messaging.getInitialMessage().then((RemoteMessage message) {
      print('message done');
      if (message != null) {
        RemoteNotification notification = message.notification;
        if (notification != null && _isInForeGround) {
          _showNotification(notification.title, notification.body, notification.android.imageUrl);
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('message done');
      if (message != null) {
        RemoteNotification notification = message.notification;
        if (notification != null && _isInForeGround) {
          _showNotification(notification.title, notification.body, notification.android.imageUrl);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('message done');
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

  void hitAppInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var http = Client();
    http.post(appInfoUri, body: {'user_id': ''}).then((value) {
      // print(value.body);
      if (value.statusCode == 200) {
        AppInfoModel data1 = AppInfoModel.fromJson(jsonDecode(value.body));
        print('data - ${data1.toString()}');
        if (data1.status == "1" || data1.status == 1) {
          setState(() {
            prefs.setString('app_currency', '${data1.currencySign}');
            prefs.setString('app_referaltext', '${data1.refertext}');
            prefs.setString('numberlimit', '${data1.phoneNumberLength}');
            prefs.setString('imagebaseurl', '${data1.imageUrl}');
            getImageBaseUrl();
          });
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  void getDrierStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isRun = true;
      apCurency = prefs.getString('app_currency');
    });
    if (prefs.containsKey('online_status')) {
      if (prefs.getInt('online_status') == 1) {
        setState(() {
          isOffline = false;
        });
      } else {
        setState(() {
          isOffline = true;
        });
      }
    } else {
      setState(() {
        isOffline = true;
      });
    }
    http.post(driverStatusUri, body: {'dboy_id': '${prefs.getInt('db_id')}'}).then((value) {
      if (value.statusCode == 200) {
        DriverStatus dstatus = DriverStatus.fromJson(jsonDecode(value.body));
        if ('${dstatus.status}' == '1') {
          int onoff = int.parse('${dstatus.onlineStatus}');
          prefs.setInt('online_status', onoff);
          if (onoff == 1) {
            setState(() {
              isOffline = false;
            });
          } else {
            setState(() {
              isOffline = true;
            });
          }
          totalOrder = int.parse('${dstatus.totalOrders}');
          totalincentives = double.parse('${dstatus.totalIncentive}');
        }
      }
      setState(() {
        isRun = false;
      });
    }).catchError((e) {
      setState(() {
        isRun = false;
      });
      print(e);
    });
  }

  Future<bool> _updateMarker(_lat, _lng) async {
    try {
      // List<Placemark> placemarks = await placemarkFromCoordinates(_lat, _lng);
      // Placemark place = placemarks[0];
      String startCoordinatesString = '($_lat, $_lng)';
      Marker startMarker = Marker(
          markerId: MarkerId(startCoordinatesString),
          position: LatLng(_lat, _lng),
          // infoWindow: InfoWindow(
          //   title: 'samp ${place.name}, ${place.locality} ',
          // ),
          icon: BitmapDescriptor.defaultMarkerWithHue(0),
          onTap: () async {
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(_lat, _lng),
                  tilt: 50.0,
                  bearing: 45.0,
                  zoom: 20.0,
                ),
              ),
            );
          });
      mapController = await _controller.future;
      markers.add(startMarker);

      return true;
    } catch (e) {
      print('MAP Exception - locationScreen.dart - _updateMarker():' + e.toString());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    if (!enteredFirst) {
      setState(() {
        enteredFirst = true;
      });
      _getLocation(locale, context);
    }
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: AppBar(
              foregroundColor: Colors.black,
              title: Text(
                isOffline ? locale.youReOffline.toUpperCase() : locale.youReOnline.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              actions: <Widget>[
                isRun
                    ? CupertinoActivityIndicator(
                        radius: 15,
                      )
                    : Container(),
                Padding(
                    padding: EdgeInsets.all(12.0),
                    child: InkWell(
                      onTap: () {
                        // setState(() {
                        //   isOffline = !isOffline;
                        // });
                        if (isOffline) {
                          updateStatus(1);
                        } else {
                          updateStatus(0);
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 250),
                        width: 104,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          isOffline ? locale.goOnline.toUpperCase() : locale.goOffline.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.scaffoldBackgroundColor),
                        ),
                        decoration: BoxDecoration(
                          color: isOffline ? theme.primaryColor : Color(0xffff452c),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        drawer: AccountDrawer(context),
        body: Stack(
          children: <Widget>[
            Container(
              child: GoogleMap(
                mapType: MapType.normal,
                markers: markers,
                initialCameraPosition: kGooglePlex,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                compassEnabled: false,
                mapToolbarEnabled: false,
                buildingsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                },
              ),
            ),
            Positioned(
                bottom: 5,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return TodayOrder();
                              }));
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 3,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(
                                  'Today Order',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return TomorrowOrder();
                              }));
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Card(
                              color: Colors.grey[200],
                              elevation: 3,
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: Text(
                                  'Nextday Order',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor, boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          buildRowChild(theme, '$totalOrder', locale.orders),
                          // buildRowChild(theme, '68 km', locale.ride),
                          buildRowChild(theme, '$apCurency $totalincentives', locale.earnings),
                        ],
                      ),
                    ),
                  ],
                )),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Animated
            // )
          ],
        ),
      ),
    );
  }

  // void _getLocation(AppLocalizations locale, BuildContext context) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.whileInUse ||
  //       permission == LocationPermission.always) {
  //     bool isLocationServiceEnableds =
  //         await Geolocator.isLocationServiceEnabled();
  //     if (isLocationServiceEnableds) {
  //       await Geolocator.getCurrentPosition(
  //               desiredAccuracy: LocationAccuracy.high)
  //           .then((position) {
  //         Timer(Duration(seconds: 3), () async {
  //           double lat = position.latitude;
  //           double lng = position.longitude;
  //           setLocation(lat, lng);
  //         });
  //       });
  //
  //       Geolocator.getPositionStream(
  //               distanceFilter: 10, intervalDuration: Duration(seconds: 10))
  //           .listen((positionNew) {
  //         double lat = positionNew.latitude;
  //         double lng = positionNew.longitude;
  //         print('$lat - $lng');
  //         setLocation(lat, lng);
  //       });
  //     } else {
  //       await Geolocator.openLocationSettings().then((value) {
  //         if (value) {
  //           _getLocation(locale, context);
  //         } else {
  //           Toast.show(locale.locpermission, context,
  //               duration: Toast.LENGTH_SHORT);
  //         }
  //       }).catchError((e) {
  //         Toast.show(locale.locpermission, context,
  //             duration: Toast.LENGTH_SHORT);
  //       });
  //     }
  //   } else if (permission == LocationPermission.denied) {
  //     LocationPermission permissiond = await Geolocator.requestPermission();
  //     if (permissiond == LocationPermission.whileInUse ||
  //         permissiond == LocationPermission.always) {
  //       _getLocation(locale, context);
  //     } else {
  //       Toast.show(locale.locpermission, context, duration: Toast.LENGTH_SHORT);
  //     }
  //   } else if (permission == LocationPermission.deniedForever) {
  //     await Geolocator.openAppSettings().then((value) {
  //       _getLocation(locale, context);
  //     }).catchError((e) {
  //       Toast.show(locale.locpermission, context, duration: Toast.LENGTH_SHORT);
  //     });
  //   }
  // }

  void _getLocation(AppLocalizations locale, BuildContext context) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == PermissionStatus.granted) {
            getLatLng(context, locale);
            await _backLocationFetch();
            await _updateMarker(lat, lng);
          }
        } else if (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited) {
          getLatLng(context, locale);
          await _backLocationFetch();
          await _updateMarker(lat, lng);
        }
      }
    } else {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          print('this one');
          getLatLng(context, locale);
          await _backLocationFetch();
          await _updateMarker(lat, lng);
        }
      } else if (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited) {
        print('this one 2');
        getLatLng(context, locale);
        await _backLocationFetch();
        await _updateMarker(lat, lng);
      }
    }
  }

  Future _backLocationFetch() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // await BackgroundLocation.setAndroidNotification(
      //   title: 'Background service is running',
      //   message: 'Background location in progress',
      //   icon: '@mipmap/ic_launcher',
      // );
      //await BackgroundLocation.setAndroidConfiguration(1000);
      await back.BackgroundLocation.startLocationService(distanceFilter: 20);
      back.BackgroundLocation.getLocationUpdates((location) async {
        await back.BackgroundLocation.setAndroidNotification(
          title: 'Background service is running',
          message: '${lat.toString()} ${lng.toString()}',
          icon: '@mipmap/ic_launcher',
        );

        lat = location.latitude;
        lng = location.longitude;

        http.post(
          updatelatlng,
          body: {
            'dboy_id': '${prefs.getInt('db_id')}',
            'lat': lat.toString(),
            'lng': lng.toString(),
          },
        ).then((value) {
          print('dvd - ${value.body}');
          if (value.statusCode == 200) {
            print('success');
            prefs.setString('lat', lat.toString());
            prefs.setString('lng', lng.toString());
          }
          // setState(() {
          //   isLoading = false;
          // });
        }).catchError((e) {
          // setState(() {
          //   isLoading = false;
          // });
          print(e);
        });
      });
    } catch (e) {
      print("Exceptioin - accepted_order.dart - _backLocationFetch():" + e.toString());
    }
  }

  void getLatLng(BuildContext context, AppLocalizations locale) async {
    _locationData = await location.getLocation();
    if (_locationData != null) {
      double latt = _locationData.latitude;
      double lngt = _locationData.longitude;
      GoogleMapController controller = await _controller.future;
      setState(() {
        lat = latt;
        lng = lngt;
      });
      kGooglePlex = CameraPosition(
        target: LatLng(latt, lngt),
        zoom: 21.151926,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
    }
  }

  // setLocation(lats, lngs) async {
  //   // print('state - ${scfoldKey.currentState}');
  //
  // }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    // var message = jsonDecode('${payload}');
  }

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

Column buildRowChild(ThemeData theme, String text1, String text2, {CrossAxisAlignment alignment}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: alignment ?? CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        text1,
        style: theme.textTheme.headline6.copyWith(color: theme.backgroundColor),
      ),
      SizedBox(
        height: 8.0,
      ),
      Text(
        text2,
        style: theme.textTheme.subtitle2,
      ),
    ],
  );
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
          channelKey: 'basic_channel',
          title: '$title',
          body: '$body',
          icon: 'resource://drawable/icon',
          bigPicture: '$imageUrl',
          largeIcon: '$imageUrl',
          notificationLayout: NotificationLayout.BigPicture,
        ));
      } else {
        AwesomeNotifications().createNotification(content: NotificationContent(id: 10, channelKey: 'basic_channel', title: '$title', body: '$body', icon: 'resource://drawable/icon'));
      }
    }
  });
}
