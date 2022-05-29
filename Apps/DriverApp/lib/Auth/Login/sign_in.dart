import 'dart:convert';

import 'package:driver/Routes/routes.dart';
import 'package:driver/beanmodel/appinfo.dart';
import 'package:driver/beanmodel/signinmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:driver/Components/custom_button.dart';
import 'package:driver/Components/entry_field.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/baseurl/baseurlg.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showProgress = false;
  int numberLimit = 10;
  var countryCodeController = TextEditingController();
  var phoneNumberController = TextEditingController();
  AppInfoModel appInfoModeld;
  int checkValue = -1;
  String appname = '--';
  var passwordController = TextEditingController();
  bool showPassword = true;

  FirebaseMessaging messaging;
  dynamic token;

  int count = 0;

  @override
  void initState() {
    super.initState();
    hitAsynInit();
    hitAppInfo();
  }

  void hitAsynInit() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      token = value;
    });
  }

  void hitAppInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showProgress = true;
    });
    var http = Client();
    http.post(appInfoUri, body: {'user_id': ''}).then((value) {
      // print(value.body);
      if (value.statusCode == 200) {
        AppInfoModel data1 = AppInfoModel.fromJson(jsonDecode(value.body));
        print('data - ${data1.toString()}');
        if (data1.status == "1" || data1.status == 1) {
          setState(() {
            appInfoModeld = data1;
            appname = '${appInfoModeld.appName}';
            countryCodeController.text = '${data1.countryCode}';
            numberLimit = int.parse('${data1.phoneNumberLength}');
            prefs.setString('app_currency', '${data1.currencySign}');
            prefs.setString('app_referaltext', '${data1.refertext}');
            prefs.setString('numberlimit', '$numberLimit');
            prefs.setString('numberlimit', '$numberLimit');
            prefs.setString('imagebaseurl', '${data1.imageUrl}');
            getImageBaseUrl();
            showProgress = false;
          });
        } else {
          setState(() {
            showProgress = false;
          });
        }
      } else {
        setState(() {
          showProgress = false;
        });
      }
    }).catchError((e) {
      setState(() {
        showProgress = false;
      });
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0, left: 0, right: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      locale.welcomeTo,
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Colors.transparent,
                    ),
                    Image.asset(
                      "assets/icon.png",
                      scale: 2.5,
                      height: 150,
                    ),
                    Divider(
                      thickness: 2.0,
                      color: Colors.transparent,
                    ),
                    Text(
                      appname,
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    ),
                    Divider(
                      thickness: 1.0,
                      color: Colors.transparent,
                    ),
                    EntryField(
                      label: locale.phoneNumber,
                      hint: locale.enterPhoneNumber,
                      controller: phoneNumberController,
                      maxLength: numberLimit,
                      keyboardType: TextInputType.number,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      child: Text(
                        locale.password1,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: Theme.of(context).backgroundColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 21.7,
                            ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                      child: TextField(
                        obscureText: showPassword,
                        obscuringCharacter: "*",

                        controller: passwordController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey[200]),
                          ),
                          hintText: locale.password2,
                          hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: kHintColor,
                                fontSize: 18.3,
                              ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility_off : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        // label: locale.password1,
                        // hint: locale.password2,

                        // inputAction: TextInputAction.done,
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(PageRoutes.langnew);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            locale.selectPreferredLanguage,
                            style: TextStyle(fontSize: 14, color: kMainColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              (showProgress)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Divider(
                          thickness: 1.0,
                          color: Colors.transparent,
                        ),
                        Container(alignment: Alignment.center, margin: EdgeInsets.only(top: 10, bottom: 10), child: CircularProgressIndicator()),
                        Divider(
                          thickness: 1.0,
                          color: Colors.transparent,
                        ),
                      ],
                    )
                  : CustomButton(
                      onTap: () {
                        if (!showProgress) {
                          setState(() {
                            showProgress = true;
                          });
                          if (phoneNumberController.text != null) {
                            if (passwordController.text != null && passwordController.text.length > 4) {
                              hitLoginUrl('${phoneNumberController.text}', passwordController.text, context);
                            } else {
                              Toast.show(locale.incorectPassword, context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                              setState(() {
                                showProgress = false;
                              });
                            }
                          } else {
                            Toast.show('${locale.incorectMobileNumber} $numberLimit', context, gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
                            setState(() {
                              showProgress = false;
                            });
                          }
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  bool emailValidator(email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  void hitLoginUrl(dynamic user_phone, dynamic user_password, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      print(token);
      var http = Client();
      http.post(loginUrl, body: {
        'phone': '$user_phone',
        'password': '$user_password',
        'device_id': '$token',
      }).then((value) {
        print('sign - ${value.body}');
        if (value.statusCode == 200) {
          DeliveryBoyLogin dbLogin = DeliveryBoyLogin.fromJson(jsonDecode(value.body));
          if ('${dbLogin.status}' == '1') {
            prefs.setInt('db_id', int.parse('${dbLogin.data.dboyId}'));
            // prefs.setInt('sn_db_id', int.parse('${dbLogin.data.storeDboyId}'));
            prefs.setString('boy_name', '${dbLogin.data.boyName}');
            prefs.setString('boy_phone', '${dbLogin.data.boyPhone}');
            prefs.setString('boy_city', '${dbLogin.data.boyCity}');
            prefs.setString('password', '${dbLogin.data.password}');
            prefs.setString('boy_loc', '${dbLogin.data.boyLoc}');
            prefs.setString('lat', '${dbLogin.data.lat}');
            prefs.setString('lng', '${dbLogin.data.lng}');
            prefs.setString('status', '${dbLogin.data.status}');
            prefs.setString('added_by', '${dbLogin.data.addedBy}');
            // prefs.setString('rem_by_admin', '${dbLogin.data.remByAdmin}');
            prefs.setString('ad_dboy_id', '${dbLogin.data.dboyId}');
            prefs.setBool('islogin', true);
            Navigator.pushNamedAndRemoveUntil(context, PageRoutes.homePage, (route) => false);
          } else {
            prefs.setBool('islogin', false);
          }
        } else {
          prefs.setBool('islogin', false);
        }
        setState(() {
          showProgress = false;
        });
      }).catchError((e) {
        prefs.setBool('islogin', false);
        setState(() {
          showProgress = false;
        });
        print(e);
      });
    } else {
      if (count == 0) {
        count = 1;
        messaging.getToken().then((value) {
          setState(() {
            token = value;
            hitLoginUrl(user_phone, user_password, context);
          });
        });
      } else {
        setState(() {
          showProgress = false;
        });
      }
    }
  }
}
