import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gomeat/dialogs/openImageDialog.dart';
import 'package:gomeat/models/businessLayer/apiHelper.dart';
import 'package:gomeat/models/businessLayer/businessRule.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/imageModel.dart';
import 'package:gomeat/models/membershipStatusModel.dart';
import 'package:gomeat/models/productModel.dart';
import 'package:gomeat/models/userModel.dart';
import 'package:gomeat/screens/chatScreen.dart';
import 'package:gomeat/screens/loginScreen.dart';
import 'package:gomeat/screens/otpVerificationScreen.dart';
import 'package:gomeat/screens/productDetailScreen.dart';
import 'package:gomeat/screens/signUpScreen.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Base extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  final String routeName;

  Base({this.analytics, this.observer, this.routeName});

  @override
  BaseState createState() => BaseState();
}

class BaseState extends State<Base> with TickerProviderStateMixin, WidgetsBindingObserver {
  bool bannerAdLoaded = false;

  APIHelper apiHelper;
  BusinessRule br;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  BaseState() {
    apiHelper = new APIHelper();
    br = new BusinessRule(apiHelper);
  }

  Future<bool> addRemoveWishList(int varientId, GlobalKey<ScaffoldState> scaffoldKey) async {
    bool _isAddedSuccesFully = false;
    try {
      showOnlyLoaderDialog();
      await apiHelper.addRemoveWishList(varientId).then((result) async {
        if (result != null) {
          if (result.status == "1" || result.status == "2") {
            _isAddedSuccesFully = true;
            hideLoader();
          } else {
            _isAddedSuccesFully = false;
            hideLoader();

            showSnackBar(key: scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_try_again_after_sometime);
          }
        }
      });
      return _isAddedSuccesFully;
    } catch (e) {
      print("Exception - base.dart - addRemoveWishList():" + e.toString());
      return _isAddedSuccesFully;
    }
  }

  Future<bool> addToCart(int qty, int varientId, int special, GlobalKey<ScaffoldState> scaffoldKey, bool isAdd) async {
    bool _isAddedSuccesFully = false;
    try {
      showOnlyLoaderDialog();
      await apiHelper.addToCart(qty, varientId, special).then((result) async {
        if (result != null) {
          if (result.status == "1") {
            if (qty == 1 && isAdd) {
              global.currentUser.cartCount = global.currentUser.cartCount + 1;
            } else if (qty == 0 && global.currentUser.cartCount > 0) {
              global.currentUser.cartCount = global.currentUser.cartCount - 1;
            }
            _isAddedSuccesFully = true;
            hideLoader();
          } else {
            hideLoader();
            _isAddedSuccesFully = false;
            showSnackBar(key: scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_try_again_after_sometime);
          }
        }
      });
      return _isAddedSuccesFully;
    } catch (e) {
      print("Exception - base.dart - addToCart():" + e.toString());
      return _isAddedSuccesFully;
    }
  }

  Future addToCartShowModalBottomSheet(Product product, GlobalKey<ScaffoldState> _scaffoldKey) {
    try {
      return showModalBottomSheet(
          context: context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
          builder: (context) {
            return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return WillPopScope(
                onWillPop: () {
                  Navigator.of(context).pop();
                  return null;
                },
                child: Container(
                  height: 450,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text(
                            "${product.productName}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          )),
                      Divider(),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: product.varient.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: EdgeInsets.only(top: 10, bottom: 10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardTheme.color,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    ReadMoreText(
                                                      '${product.varient[index].description}',
                                                      trimLines: 2,
                                                      trimMode: TrimMode.Line,
                                                      trimCollapsedText: 'Show more',
                                                      trimExpandedText: 'Show less',
                                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                                      lessStyle: Theme.of(context).primaryTextTheme.bodyText1,
                                                      moreStyle: Theme.of(context).primaryTextTheme.bodyText1,
                                                    ),
                                                    RichText(
                                                        text: TextSpan(text: "${global.appInfo.currencySign} ", style: Theme.of(context).primaryTextTheme.headline2, children: [
                                                      TextSpan(
                                                        text: '${product.varient[index].price}',
                                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                                      ),
                                                      TextSpan(
                                                        text: ' / ${product.varient[index].quantity} ${product.varient[index].unit}',
                                                        style: Theme.of(context).primaryTextTheme.headline2,
                                                      ),
                                                      TextSpan(
                                                        text: '    ${global.appInfo.currencySign} ',
                                                        style: Theme.of(context).primaryTextTheme.headline2,
                                                      ),
                                                      TextSpan(
                                                        text: ' ${product.varient[index].mrp}',
                                                        style: Theme.of(context).primaryTextTheme.headline2.copyWith(decoration: TextDecoration.lineThrough),
                                                      ),
                                                    ])),
                                                    product.varient[index].rating != null && product.varient[index].rating > 0
                                                        ? Padding(
                                                            padding: EdgeInsets.only(top: 4.0),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Icon(
                                                                  Icons.star,
                                                                  size: 18,
                                                                  color: Theme.of(context).primaryColorLight,
                                                                ),
                                                                RichText(
                                                                  text: TextSpan(
                                                                    text: "${product.varient[index].rating} ",
                                                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                                                    children: [
                                                                      TextSpan(
                                                                        text: '|',
                                                                        style: Theme.of(context).primaryTextTheme.headline2,
                                                                      ),
                                                                      TextSpan(
                                                                        text: ' ${product.varient[index].ratingCount} ${AppLocalizations.of(context).txt_ratings}',
                                                                        style: Theme.of(context).primaryTextTheme.headline1,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : SizedBox()
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                product.varient[index].discount != null && product.varient[index].discount > 0
                                                    ? Container(
                                                        height: 20,
                                                        width: 70,
                                                        decoration: BoxDecoration(
                                                          color: Colors.lightBlue,
                                                          borderRadius: BorderRadius.only(
                                                            topRight: Radius.circular(10),
                                                            bottomLeft: Radius.circular(10),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "${product.varient[index].discount}% ${AppLocalizations.of(context).txt_off}",
                                                          textAlign: TextAlign.center,
                                                          style: Theme.of(context).primaryTextTheme.caption,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 20,
                                                        width: 60,
                                                      ),
                                                IconButton(
                                                    onPressed: () async {
                                                      if (global.currentUser.id == null) {
                                                        Future.delayed(Duration.zero, () {
                                                          Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) => LoginScreen(
                                                                      a: widget.analytics,
                                                                      o: widget.observer,
                                                                    )),
                                                          );
                                                        });
                                                      } else {
                                                        bool _isAdded = await addRemoveWishList(product.varient[index].varientId, _scaffoldKey);
                                                        if (_isAdded) {
                                                          if (product.varient[index].varientId == product.varientId) {
                                                            product.isFavourite = !product.varient[index].isFavourite;
                                                          }
                                                          product.varient[index].isFavourite = !product.varient[index].isFavourite;
                                                        }

                                                        setState(() {});
                                                      }
                                                    },
                                                    icon: product.varient[index].isFavourite
                                                        ? Icon(
                                                            MdiIcons.heart,
                                                            size: 20,
                                                            color: Color(0xFFEF5656),
                                                          )
                                                        : Icon(
                                                            MdiIcons.heart,
                                                            size: 20,
                                                            color: Color(0xFF4A4352),
                                                          )),
                                                product.varient[index].stock > 0
                                                    ? product.varient[index].cartQty == null || (product.varient[index].cartQty != null && product.varient[index].cartQty == 0)
                                                        ? Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration: BoxDecoration(
                                                              color: Theme.of(context).iconTheme.color,
                                                              borderRadius: BorderRadius.only(
                                                                bottomRight: Radius.circular(10),
                                                                topLeft: Radius.circular(10),
                                                              ),
                                                            ),
                                                            child: IconButton(
                                                              padding: EdgeInsets.all(0),
                                                              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                                              onPressed: () async {
                                                                if (global.currentUser.id == null) {
                                                                  Future.delayed(Duration.zero, () {
                                                                    Navigator.of(context).push(
                                                                      MaterialPageRoute(
                                                                          builder: (context) => LoginScreen(
                                                                                a: widget.analytics,
                                                                                o: widget.observer,
                                                                              )),
                                                                    );
                                                                  });
                                                                } else {
                                                                  bool isAdded = await addToCart(1, product.varient[index].varientId, 0, _scaffoldKey, true);
                                                                  if (isAdded) {
                                                                    product.varient[index].cartQty = product.varient[index].cartQty + 1;
                                                                  }
                                                                  setState(() {});
                                                                }
                                                              },
                                                              icon: Icon(
                                                                Icons.add,
                                                                color: Theme.of(context).primaryTextTheme.caption.color,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 28,
                                                            width: 80,
                                                            decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                stops: [0, .90],
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight,
                                                                colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                                                              ),
                                                              borderRadius: BorderRadius.only(
                                                                bottomRight: Radius.circular(10),
                                                                topLeft: Radius.circular(10),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize: MainAxisSize.min,
                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                IconButton(
                                                                    padding: EdgeInsets.all(0),
                                                                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                                                    onPressed: () async {
                                                                      bool isAdded = await addToCart(product.varient[index].cartQty - 1, product.varient[index].varientId, 0, _scaffoldKey, false);
                                                                      if (isAdded) {
                                                                        product.varient[index].cartQty = product.varient[index].cartQty - 1;
                                                                      }
                                                                      setState(() {});
                                                                    },
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.minus,
                                                                      size: 11,
                                                                      color: Theme.of(context).primaryTextTheme.caption.color,
                                                                    )),
                                                                Text(
                                                                  "${product.varient[index].cartQty}",
                                                                  style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Theme.of(context).primaryTextTheme.caption.color),
                                                                ),
                                                                IconButton(
                                                                    padding: EdgeInsets.all(0),
                                                                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                                                    onPressed: () async {
                                                                      bool isAdded = await addToCart(product.varient[index].cartQty + 1, product.varient[index].varientId, 0, _scaffoldKey, false);
                                                                      if (isAdded) {
                                                                        product.varient[index].cartQty = product.varient[index].cartQty + 1;
                                                                      }
                                                                      setState(() {});
                                                                    },
                                                                    icon: Icon(
                                                                      FontAwesomeIcons.plus,
                                                                      size: 11,
                                                                      color: Theme.of(context).primaryTextTheme.caption.color,
                                                                    )),
                                                              ],
                                                            ),
                                                          )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                              }),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 10),
                          padding: EdgeInsets.all(2),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                color: global.isDarkModeEnable ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                "Done",
                                style: TextStyle(fontSize: 16, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          }).then((val) {
        setState(() {});
      });
    } catch (e) {
      print("Exception  - productListScreen.dart - _newProductAddToCartChoiceDialog(): " + e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }

  List<Widget> catgoryShimmer() {
    List<Widget> _widgetList = [];
    for (int i = 0; i < 12; i++) {
      _widgetList.add(Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30, left: 4, right: 4),
              child: SizedBox(
                height: 160,
                width: (MediaQuery.of(context).size.width / 3) - 11,
                child: Card(),
              ),
            ),
          ],
        ),
      ));
    }
    return _widgetList;
  }

  Future<MembershipStatus> checkMemberShipStatus(GlobalKey<ScaffoldState> scaffoldKey) async {
    MembershipStatus _membershipStatus = MembershipStatus();
    try {
      bool _isConnected = await br.checkConnectivity();
      if (_isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.membershipStatus().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();

              _membershipStatus = result.data;
            } else {
              hideLoader();

              showSnackBar(key: scaffoldKey, snackBarMessage: '${result.message}');
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(scaffoldKey);
      }
      return _membershipStatus;
    } catch (e) {
      print("Exception - base.dart - checkMemberShipStatus():" + e.toString());
      return null;
    }
  }

  void closeDialog() {
    Navigator.of(context).pop();
  }

  dialogToOpenImage(String name, List<ImageModel> imageList, int index,{int screenId}) {
    try {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return OpenImageDialog(
              a: widget.analytics,
              o: widget.observer,
              imageList: imageList,
              index: index,
              name: name,
              screenId:screenId ,
            );
          });
    } catch (e) {
      print("Exception - base.dart - dialogToOpenImage() " + e.toString());
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    print('appLifeCycleState inactive');

    if (global.sp.getString("currentUser") != null) {
      if (global.localNotificationModel != null && !global.isChatNotTapped) {
        if (global.localNotificationModel.route == 'chatlist_screen') {
          if (state == AppLifecycleState.resumed) {
            setState(() {
              global.isChatNotTapped = true;
            });

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChatScreen(
                      a: widget.analytics,
                      o: widget.observer,
                    )));
          }
        }
      }
    } else if (global.localNotificationModel != null && global.localNotificationModel.chatId != null && !global.isChatNotTapped) {
      if (state == AppLifecycleState.resumed) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => LoginScreen(
                  a: widget.analytics,
                  o: widget.observer,
                )));
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> dontCloseDialog() async {
    return false;
  }

  Future exitAppDialog() async {
    try {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: CupertinoAlertDialog(
                title: Text(
                  "${AppLocalizations.of(context).lbl_exit_app}",
                ),
                content: Text(
                  "${AppLocalizations.of(context).txt_exit_app_msg}",
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      '${AppLocalizations.of(context).lbl_cancel}',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      // Dismiss the dialog but don't
                      // dismiss the swiped item
                      return Navigator.of(context).pop(false);
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text("${AppLocalizations.of(context).btn_exit}"),
                    onPressed: () async {
                      exit(0);
                    },
                  ),
                ],
              ),
            );
          });
    } catch (e) {
      print('Exception - base.dart - exitAppDialog(): ' + e.toString());
    }
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(global.lat, global.lng);

      Placemark place = placemarks[0];

      setState(() {
        global.currentLocation = "${place.name}, ${place.locality} ";
      });
    } catch (e) {
      print("Exception -  base.dart - getAddressFromLatLng():" + e.toString());
    }
  }

  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) async {
      setState(() {
        global.lat = position.latitude;
        global.lng = position.longitude;
      });
      await getAddressFromLatLng();
      await getNearByStore();
    }).catchError((e) {
      print("Exception -  base.dart - getCurrentLocation():" + e.toString());
    });
  }

  getCurrentPosition() async {
    try {
      if (Platform.isIOS) {
        LocationPermission s = await Geolocator.checkPermission();
        if (s == LocationPermission.denied || s == LocationPermission.deniedForever) {
          s = await Geolocator.requestPermission();
        }
        if (s != LocationPermission.denied || s != LocationPermission.deniedForever) {
          await getCurrentLocation();
        } else {
          global.locationMessage = 'Please enable location permission';
        }
      } else {
        PermissionStatus permissionStatus = await Permission.location.status;
        if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
          permissionStatus = await Permission.location.request();
        }
        if (permissionStatus.isGranted) {
          await getCurrentLocation();
        } else {
          global.locationMessage = 'Please enable location permission';
        }
      }
    } catch (e) {
      print("Exception -  base.dart - getCurrentPosition():" + e.toString());
    }
  }

  Future<String> getLocationFromAddress(String address) async {
    try {
      List<Location> _locationList = await locationFromAddress(address);
      print("${_locationList.length}  ${_locationList[0].latitude} - ${_locationList[0].longitude}");
      return '${_locationList[0].latitude}|${_locationList[0].longitude}';
    } catch (e) {
      print("Exception -  base.dart - getLocationFromAddress():" + e.toString());
      return null;
    }
  }

  getNearByStore() async {
    try {
      await apiHelper.getNearbyStore().then((result) async {
        if (result != null) {
          if (result.status == "1") {
            global.nearStoreModel = result.data;
            if (global.currentUser.id != null) {
              await apiHelper.updateFirebaseUserFcmToken(global.currentUser.id, global.appDeviceId);
            }

            if (global.appInfo.lastLoc == 1) {
              global.sp.setString("lastloc", '${global.lat}|${global.lng}');
            }
          } else {
            global.nearStoreModel.id = null;
            global.locationMessage = result.message;
          }
        }
      });
    } catch (e) {
      print("Exception -  base.dart - _getNearByStore():" + e.toString());
    }
  }

  void hideLoader() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
  }

  launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  openBarcodeScanner(GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      String barcodeScanRes;
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (barcodeScanRes != '-1') {
        await _getBarcodeResult(scaffoldKey, barcodeScanRes);
      }
    } catch (e) {
      print("Exception - businessRule.dart - openBarcodeScanner():" + e.toString());
    }
  }

  sendOTP(String phoneNumber, GlobalKey<ScaffoldState> scaffoldKey, int screenId) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+${global.appInfo.countryCode}$phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          hideLoader();
          showSnackBar(key: scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_try_again_after_sometime);
        },
        codeSent: (String verificationId, int resendToken) async {
          hideLoader();
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => OtpVerificationScreen(
                      screenId: screenId,
                      a: widget.analytics,
                      o: widget.observer,
                      verificationCode: verificationId,
                      phoneNumber: phoneNumber,
                    )),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      print("Exception - base.dart - _sendOTP():" + e.toString());
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  showNetworkErrorSnackBar(GlobalKey<ScaffoldState> scaffoldKey) {
    try {
      bool isConnected;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(days: 1),
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_wifi_off,
              color: Colors.white,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                ),
                child: Text(
                  'No internet available',
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
            textColor: Colors.white,
            label: 'RETRY',
            onPressed: () async {
              isConnected = await br.checkConnectivity();
              if (isConnected) {
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              } else {
                showNetworkErrorSnackBar(scaffoldKey);
              }
            }),
        backgroundColor: Colors.grey,
      ));
    } catch (e) {
      print("Exception -  base.dart - showNetworkErrorSnackBar():" + e.toString());
    }
  }

  showOnlyLoaderDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Center(child: new CircularProgressIndicator()),
        );
      },
    );
  }

  void showSnackBar({String snackBarMessage, Key key}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryTextTheme.headline5.color,
      key: key,
      content: Text(
        snackBarMessage,
        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
    ));
  }

  signInWithFacebook(GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        final LoginResult loginResult = await FacebookAuth.instance.login(permissions: ["email", "public_profile"]);
        if (loginResult.accessToken.token != null) {
          final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);
          var authCredentials = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
          if (authCredentials != null && authCredentials.user != null) {
            await apiHelper.socialLogin(userEmail: authCredentials.user.email, facebookId: authCredentials.user.uid, type: "facebook").then((result) async {
              if (result != null) {
                if (result.status == "1") {
                  global.currentUser = result.recordList;
                  global.sp.setString('currentUser', json.encode(global.currentUser.toJson()));

                  hideLoader();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => BottomNavigationWidget(
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                } else {
                  CurrentUser _currentuser = new CurrentUser();
                  _currentuser.email = authCredentials.user.email;
                  _currentuser.userPhone = authCredentials.user.phoneNumber;
                  _currentuser.name = authCredentials.user.displayName;
                  _currentuser.facebookId = authCredentials.user.uid;
                  hideLoader();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen(
                              user: _currentuser,
                              a: widget.analytics,
                              o: widget.observer,
                            )),
                  );
                }
              }
            });
          }
        }
      } else {
        showNetworkErrorSnackBar(scaffoldKey);
      }
    } catch (e) {
      print("Exception - loginScreen.dart - signInWithFacebook():" + e.toString());
    }
  }

  signInWithGoogle(GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      await _googleSignIn.signIn().then((result) {
        if (result != null) {
          result.authentication.then((googleKey) async {
            if (_googleSignIn.currentUser != null) {
              showOnlyLoaderDialog();
              await apiHelper.socialLogin(userEmail: _googleSignIn.currentUser.email, type: 'google').then((result) async {
                if (result != null) {
                  if (result.status == "1") {
                    global.currentUser = result.data;

                    hideLoader();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => BottomNavigationWidget(
                                a: widget.analytics,
                                o: widget.observer,
                              )),
                    );
                  } else {
                    CurrentUser _currentUser = new CurrentUser();
                    _currentUser.email = _googleSignIn.currentUser.email;
                    _currentUser.name = _googleSignIn.currentUser.displayName;

                    hideLoader();
                    // registration required
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(user: _currentUser, a: widget.analytics, o: widget.observer),
                      ),
                    );
                  }
                }
              });
            }
          });
        }
      });
    } catch (e) {
      print("Exception - loginScreen.dart - _signInWithGoogle():" + e.toString());
    }
  }

  textMe(String phone) async {
    // Android
    String uri = 'sms:$phone?body=hello%20there';
    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      // iOS
      String uri = 'sms:$phone?body=hello%20there';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  _getBarcodeResult(GlobalKey<ScaffoldState> scaffoldKey, String code) async {
    try {
      bool _isConnected = await br.checkConnectivity();
      if (_isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.barcodeScanResult(code).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(productDetail: result.data, a: widget.analytics, o: widget.observer),
                ),
              );
            } else {
              hideLoader();

              showSnackBar(key: scaffoldKey, snackBarMessage: '${result.message}');
            }
          } else {
            hideLoader();
          }
        });
      } else {
        showNetworkErrorSnackBar(scaffoldKey);
      }
    } catch (e) {
      print("Exception - businessRule.dart - _getBarcodeResult():" + e.toString());
    }
  }

  // ratingBuilderWidget(){
  //   return
  // }

}
