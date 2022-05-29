import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/userModel.dart';
import 'package:gomeat/provider/local_provider.dart';
import 'package:gomeat/screens/introScreen.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class SplashScreen extends BaseRoute {
  SplashScreen({a, o}) : super(a: a, o: o, r: 'SplashScreen');
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends BaseRouteState {
  bool isloading = true;

  _SplashScreenState() : super();
  GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(32),
          child: Center(
            child: Image.asset(
              'assets/appicon_512x512.png',
              fit: BoxFit.cover,
              scale: 3,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  _getMapByFlag() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getMapByFlag().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.mapby = result.data;
            } else {
              hideLoader();
              global.mapby = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - splashScreen.dart - _getMapByFlag():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  void _init() async {
    await br.getSharedPreferences();
    var duration = Duration(seconds: 3);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LocaleProvider>(context, listen: false);
      if (global.languageCode == null) {
        var locale = provider.locale ?? Locale('en');
        global.languageCode = locale.languageCode;
      } else {
        provider.setLocale(Locale(global.languageCode));
      }
      if (global.rtlLanguageCodeLList.contains(global.languageCode)) {
        global.isRTL = true;
      } else {
        global.isRTL = false;
      }
    });

    Timer(duration, () async {
      global.appDeviceId = await FirebaseMessaging.instance.getToken();
      PermissionStatus permissionStatus = await Permission.phone.status;
      if (!permissionStatus.isGranted) {
        permissionStatus = await Permission.phone.request();
      }
      bool isConnected = await br.checkConnectivity();

      if (isConnected) {
        await _getMapByFlag();
        await _getMapBoxApiKey();
        await _getGoogleMapApiKey();
        await _getAppNotice();
        if (global.sp.getString('currentUser') != null) {
          global.currentUser = CurrentUser.fromJson(json.decode(global.sp.getString("currentUser")));
          await _getAppInfo();

          if (global.sp.getString('lastloc') != null) {
            List<String> _tlist = global.sp.getString('lastloc').split("|");
            global.lat = double.parse(_tlist[0]);
            global.lng = double.parse(_tlist[1]);
            await getAddressFromLatLng();
            await getNearByStore();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          }
        } else {
          await _getAppInfo();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => IntroScreen(
                    a: widget.analytics,
                    o: widget.observer,
                  )));
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    });
  }

  _getAppInfo() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getAppInfo().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.appInfo = result.data;
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - splashScreen.dart - _getAppInfo():" + e.toString());
    }
  }

  _getAppNotice() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getAppNotice().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.appNotice = result.data;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - splashScreen.dart - _getAppNotice():" + e.toString());
    }
  }

  _getGoogleMapApiKey() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getGoogleMapApiKey().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.googleMap = result.data;
            } else {
              global.googleMap = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - SplashScreen.dart - _getGoogleMapApiKey():" + e.toString());
    }
  }

  _getMapBoxApiKey() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getMapBoxApiKey().then((result) {
          if (result != null) {
            if (result.status == "1") {
              global.mapBox = result.data;

              setState(() {});
            } else {
              print(result.message.toString());
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - SplashScreen.dart - _getMapBoxApiKey():" + e.toString());
    }
  }
}
