import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/userModel.dart';
import 'package:gomeat/screens/forgotPasswordScreen.dart';
import 'package:gomeat/screens/otpVerificationScreen.dart';
import 'package:gomeat/screens/signUpScreen.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends BaseRoute {
  LoginScreen({a, o}) : super(a: a, o: o, r: 'LoginScreen');
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _cPhone = new TextEditingController();
  TextEditingController _cEmail = new TextEditingController();
  TextEditingController _cPassword = new TextEditingController();
  var _fPhone = new FocusNode();
  var _fEmail = new FocusNode();
  var _fPassword = new FocusNode();
  var _dismiss = new FocusNode();
  bool isLoginWithEmail = false;
  List<SimCard> _simCard = <SimCard>[];
  bool isloading = true;
  bool _isPasswordVisible = true;
  _LoginScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          exitAppDialog();
          return null;
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            decoration: global.isDarkModeEnable
                ? BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0, 0.65],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF50546F), Color(0xFF8085A3)],
                    ),
                  )
                : BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0, 0.65],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                    ),
                  ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height * 0.50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/login_signup.png'),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: global.isRTL ? null : 10,
                  right: global.isRTL ? 10 : null,
                  child: IconButton(
                    onPressed: () {
                      exitAppDialog();
                    },
                    icon: Icon(MdiIcons.arrowLeft, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 22,//MediaQuery.of(context).size.height * 0.07,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '${AppLocalizations.of(context).tle_login_signup}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 35),
                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45 - 20),
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(isLoginWithEmail ? '${AppLocalizations.of(context).tle_login_with}' : '${AppLocalizations.of(context).txt_provide_number_desc}', style: Theme.of(context).primaryTextTheme.bodyText1),
                        Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 20),
                          child: Text(isLoginWithEmail ? '${AppLocalizations.of(context).txt_email_password}' : '${AppLocalizations.of(context).txt_otp_verification_desc}', style: Theme.of(context).primaryTextTheme.bodyText1),
                        ),
                        isLoginWithEmail
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                  padding: EdgeInsets.only(),
                                  child: TextFormField(
                                    controller: _cEmail,
                                    focusNode: _fEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.done,
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(_fPassword);
                                    },
                                    decoration: InputDecoration(
                                      hintText: '${AppLocalizations.of(context).lbl_email}',
                                      counterText: '',
                                      contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 50,
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                padding: EdgeInsets.only(),
                                child: TextFormField(
                                  controller: _cPhone,
                                  focusNode: _fPhone,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                  maxLength: global.appInfo.phoneNumberLength,
                                  style: Theme.of(context).primaryTextTheme.bodyText1,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(_dismiss);
                                  },
                                  decoration: InputDecoration(
                                    hintText: '${AppLocalizations.of(context).lbl_phone_number}',
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Theme.of(context).inputDecorationTheme.hintStyle.color,
                                    ),
                                    prefixText: '+${global.appInfo.countryCode} ',
                                    prefixStyle: Theme.of(context).primaryTextTheme.bodyText1,
                                    counterText: '',
                                    contentPadding: EdgeInsets.only(top: 10),
                                  ),
                                ),
                              ),
                        isLoginWithEmail
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                                  padding: EdgeInsets.only(),
                                  child: TextFormField(
                                    controller: _cPassword,
                                    focusNode: _fPassword,
                                    obscureText: _isPasswordVisible,
                                    textInputAction: TextInputAction.done,
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context).requestFocus(_dismiss);
                                    },
                                    decoration: InputDecoration(
                                      hintText: '${AppLocalizations.of(context).lbl_password}',
                                      suffixIcon: IconButton(
                                        icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: IconTheme.of(context).color),
                                        onPressed: () {
                                          _isPasswordVisible = !_isPasswordVisible;
                                          setState(() {});
                                        },
                                      ),
                                      counterText: '',
                                      contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        isLoginWithEmail
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => ForgotPasswordScreen(
                                                  a: widget.analytics,
                                                  o: widget.observer,
                                                )),
                                      );
                                    },
                                    child: Text(
                                      "${AppLocalizations.of(context).lbl_forgot_password} ?",
                                      textAlign: TextAlign.right,
                                      style: Theme.of(context).primaryTextTheme.headline1,
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), gradient: LinearGradient(stops: [0, .90], begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor])),
                          margin: EdgeInsets.only(top: 20),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              onPressed: () async {
                                if (isLoginWithEmail) {
                                  await loginWithEmail();
                                } else {
                                  await login(_cPhone.text.trim());
                                }
                              },
                              child: Text(isLoginWithEmail ? '${AppLocalizations.of(context).btn_login}' : '${AppLocalizations.of(context).btn_send_otp}')),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Theme.of(context).primaryTextTheme.bodyText1.color,
                                  thickness: 2,
                                ),
                              ),
                              Text('  ${AppLocalizations.of(context).txt_login_signup_using}  ', style: Theme.of(context).primaryTextTheme.bodyText1),
                              Expanded(
                                  child: Divider(
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                                thickness: 2,
                              ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await signInWithGoogle(_scaffoldKey);
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFEC5F60),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(45),
                                      )),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    FontAwesomeIcons.google,
                                    size: 25,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await signInWithFacebook(_scaffoldKey);
                                },
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF4C87D0),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(45),
                                      )),
                                  alignment: Alignment.center,
                                  child: Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Platform.isIOS
                                  ? InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      onTap: () async {
                                        await _signInWithApple();
                                      },
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        margin: EdgeInsets.only(right: 20),
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(45),
                                            )),
                                        child: Icon(
                                          FontAwesomeIcons.apple,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              InkWell(
                                onTap: () {
                                  if (isLoginWithEmail) {
                                    _cEmail.clear();
                                    _cPassword.clear();
                                  } else {
                                    _cPhone.clear();
                                  }
                                  isLoginWithEmail = !isLoginWithEmail;
                                  setState(() {});
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColorLight,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(45),
                                      )),
                                  child: isLoginWithEmail
                                      ? Icon(
                                          Icons.call,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          size: 25,
                                        )
                                      : Icon(
                                          Icons.mail_outline,
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          size: 25,
                                        ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: InkWell(
            onTap: () async {
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => BottomNavigationWidget(
                          a: widget.analytics,
                          o: widget.observer,
                        )),
              );
            },
            child: Text(
              "${AppLocalizations.of(context).btn_skip_now}",
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.headline1,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initMobileNumberState() async {
    String mobileNumber = '';
    try {
      _simCard = (await MobileNumber.getSimCards);
      _simCard.removeWhere((e) => e.number == '' || e.number == null || e.number.contains(RegExp(r'[A-Z]')));
      if (_simCard.length > 1) {
        await _selectPhoneNumber();
      } else if (_simCard.length > 0) {
        mobileNumber = _simCard[0].number.substring(_simCard[0].number.length - 10);
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    if (!mounted) return;

    setState(() {
      _cPhone.text = mobileNumber;
    });
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  login(String userPhone) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_cPhone.text != null && _cPhone.text.trim().isNotEmpty && _cPhone.text.trim().length == global.appInfo.phoneNumberLength) {
          showOnlyLoaderDialog();
          await apiHelper.login(_cPhone.text).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                if (global.appInfo.firebase != 'off') {
                  // if firebase is enabled then only we need to send OTP through firebase.
                  await sendOTP(_cPhone.text.trim(), _scaffoldKey, 1);
                } else {
                  hideLoader();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => OtpVerificationScreen(screenId: 1, phoneNumber: _cPhone.text.trim(), a: widget.analytics, o: widget.observer),
                    ),
                  );
                }
              } else {
                hideLoader();
                CurrentUser _currentUser = new CurrentUser();
                _currentUser.userPhone = _cPhone.text.trim();
                // registration required
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(user: _currentUser, a: widget.analytics, o: widget.observer),
                  ),
                );
              }
            }
          });
        } else if (_cPhone.text.trim().isEmpty || (_cPhone.text.trim().length != global.appInfo.phoneNumberLength)) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_please_enter_valid_mobile_number}');
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - loginScreen.dart - login():" + e.toString());
    }
  }

  loginWithEmail() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_cEmail.text != null && _cEmail.text.trim().isNotEmpty && EmailValidator.validate(_cEmail.text) && _cPassword != null && _cPassword.text.trim().isNotEmpty) {
          showOnlyLoaderDialog();
          await apiHelper.loginWithEmail(_cEmail.text.trim(), _cPassword.text.trim()).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                global.currentUser = result.data;
                global.sp.setString('currentUser', json.encode(global.currentUser.toJson()));

                hideLoader();
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(
                            a: widget.analytics,
                            o: widget.observer,
                          )),
                );
              } else if (result.status == '0') {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              } else {
                hideLoader();
                // registration required

                CurrentUser _currentUser = new CurrentUser();
                _currentUser.email = _cEmail.text;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(user: _currentUser, a: widget.analytics, o: widget.observer),
                  ),
                );
              }
            }
          });
        } else if (_cEmail.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_email);
        } else if (_cEmail.text.isNotEmpty && !EmailValidator.validate(_cEmail.text)) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_valid_email);
        } else if (_cPassword.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_password);
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - loginScreen.dart - loginWithEmail():" + e.toString());
    }
  }

  _init() async {
    try {
      PermissionStatus permissionStatus = await Permission.phone.status;
      if (Platform.isAndroid && permissionStatus.isGranted) {
        await initMobileNumberState();
      }
    } catch (e) {
      print("Exception - loginScreen.dart - _init():" + e.toString());
    }
  }

  _selectPhoneNumber() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context).txt_select_phonenumber),
          actions: _simCard
              .map((e) => CupertinoActionSheetAction(
                    child: Text('${e.number.substring(e.number.length - 10)}'),
                    onPressed: () async {
                      setState(() {
                        _cPhone.text = e.number.substring(e.number.length - 10);
                      });
                      Navigator.pop(context);
                    },
                  ))
              .toList(),
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context).lbl_cancel),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - loginScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }

  _signInWithApple() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();

        final _firebaseAuth = FirebaseAuth.instance;

        String generateNonce([int length = 32]) {
          final charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
          final random = Random.secure();
          return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
        }

        String sha256ofString(String input) {
          final bytes = utf8.encode(input);
          final digest = sha256.convert(bytes);
          return digest.toString();
        }

        final rawNonce = generateNonce();
        final nonce = sha256ofString(rawNonce);
        final credential = await SignInWithApple.getAppleIDCredential(
          scopes: [
            AppleIDAuthorizationScopes.email,
            AppleIDAuthorizationScopes.fullName,
          ],
          nonce: nonce,
        ).catchError((e) {
          hideLoader();
          print("error");
        });
        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: credential.identityToken,
          rawNonce: rawNonce,
        );
        final authResult = await _firebaseAuth.signInWithCredential(oauthCredential).onError((error, stackTrace) {
          hideLoader();
          print("error ${error.toString()}");
          return null;
        }).catchError((e) {
          hideLoader();
          print("error ${e.toString()}");
        });
        print('outh cred ${authResult.user.uid}');
        print('--------------------------------------------------------------------------------');
        print('cred authCode ${credential.authorizationCode} email ${credential.email} givenName ${credential.givenName}  familyname ${credential.familyName} identytToken ${credential.identityToken}');
        await apiHelper.socialLogin(userEmail: credential.email != null ? credential.email : null, type: "apple", appleId: authResult.user.uid).then((result) async {
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
            } else if (result.status == "2") {
              CurrentUser user = new CurrentUser();
              user.email = credential.email;
              user.appleId = authResult.user.uid;
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SignUpScreen(
                          user: user,
                          a: widget.analytics,
                          o: widget.observer,
                        )),
              );
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - signInScreen.dart - _signinWithApple():" + e.toString());
    }
  }
}
