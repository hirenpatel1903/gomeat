import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/screens/resetPasswordScreen.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerificationScreen extends BaseRoute {
  final String phoneNumber;
  final String verificationCode;
  final String referalCode;
  final int screenId;
  OtpVerificationScreen({
    a,
    o,
    this.screenId,
    this.referalCode,
    this.phoneNumber,
    this.verificationCode,
  }) : super(a: a, o: o, r: 'OtpVerificationScreen');
  @override
  _OtpVerificationScreenState createState() => new _OtpVerificationScreenState(this.screenId, this.phoneNumber, this.verificationCode, this.referalCode);
}

class _OtpVerificationScreenState extends BaseRouteState {
  int _seconds = 60;
  Timer _countDown;
  String phoneNumber;
  String verificationCode;
  String referalCode;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String status;
  // BoxDecoration get _pinPutDecoration {
  //   return BoxDecoration(
  //     color: Theme.of(context).inputDecorationTheme.fillColor,
  //     border: Border.all(color: Colors.grey),
  //     borderRadius: BorderRadius.circular(5.0),
  //   );
  // }
  int screenId;
  final FocusNode _fOtp = FocusNode();
  var _cOtp = TextEditingController();

  bool isloading = true;

  _OtpVerificationScreenState(this.screenId, this.phoneNumber, this.verificationCode, this.referalCode) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Container(
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
                  top: 30,
                  left: global.isRTL ? null : 10,
                  right: global.isRTL ? 10 : null,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(MdiIcons.arrowLeft, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.07,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '${AppLocalizations.of(context).tle_verify_number}',
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
                  child: Column(
                    children: [
                      Text(
                        '${AppLocalizations.of(context).txt_otp_sent_desc}',
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2),
                        child: Text(
                          '${AppLocalizations.of(context).txt_otp_verify_desc}',
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                        child: Text(
                          '${AppLocalizations.of(context).txt_enter_otp}',
                          style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20, bottom: 10),
                          width: 315,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          alignment: Alignment.center,
                          child: PinFieldAutoFill(
                            key: Key("1"),
                            focusNode: _fOtp,
                            decoration: BoxLooseDecoration(
                              textStyle: TextStyle(fontSize: 20, color: Colors.black),
                              strokeColorBuilder: FixedColorBuilder(Colors.transparent),
                              bgColorBuilder: FixedColorBuilder(Theme.of(context).inputDecorationTheme.fillColor),
                              hintText: '••••••',
                              hintTextStyle: TextStyle(fontSize: 70, color: Colors.black),
                            ),
                            currentCode: _cOtp.text,
                            controller: _cOtp,
                            codeLength: 6,
                            keyboardType: TextInputType.number,
                            onCodeSubmitted: (code) {
                              setState(() {
                                _cOtp.text = code;
                              });
                            },
                            onCodeChanged: (code) async {
                              if (code.length == 6) {
                                _cOtp.text = code;
                                setState(() {});
                                await _checkOTP(_cOtp.text);
                                FocusScope.of(context).requestFocus(FocusNode());
                              }
                            },
                          )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            stops: [0, .90],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                          ),
                        ),
                        margin: EdgeInsets.only(top: 5),
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton(
                            onPressed: () async {
                              if (_cOtp.text.length == 6) {
                                await _checkOTP(_cOtp.text);
                              } else {
                                showSnackBar(snackBarMessage: '${AppLocalizations.of(context).txt_6_digit_msg}', key: _scaffoldKey);
                              }
                            },
                            child: Text('${AppLocalizations.of(context).btn_submit_login}')),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Text(
                          "${AppLocalizations.of(context).txt_didnt_receive_otp}",
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                      _seconds != 0
                          ? Text(
                              "Wait 00:$_seconds",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            )
                          : InkWell(
                              onTap: () async {
                                await _resendOTP();
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  '${AppLocalizations.of(context).btn_resend_otp}',
                                  style: Theme.of(context).primaryTextTheme.headline1.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    // SmsAutoFill().unregisterListener();
    // _cOtp.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // _init(); otp auto fetch
    startTimer();
  }

  Future startTimer() async {
    setState(() {});
    const oneSec = const Duration(seconds: 1);
    _countDown = new Timer.periodic(
      oneSec,
      (timer) {
        if (_seconds == 0) {
          setState(() {
            _countDown.cancel();
            timer.cancel();
          });
        } else {
          setState(() {
            _seconds--;
          });
        }
      },
    );

    setState(() {});
  }

//   _init() async {
//     try {
// // need to change design as well

//       OTPInteractor.getAppSignature().then((value) => print('signature - $value'));
//       _cOtp = OTPTextEditController(
//         codeLength: 6,
//         onCodeReceive: (code) {
//           print("code  1 $code");
//           setState(() {
//             _cOtp.text = code;
//           });
//         },
//       )..startListenUserConsent(
//           (code) {
//             print("code   $code");
//             final exp = RegExp(r'(\d{6})');
//             return exp.stringMatch(code ?? '') ?? '';
//           },
//           strategies: [],
//         );

//       await SmsAutoFill().listenForCode;
//     } catch (e) {
//       print("Exception - verifyOtpScreen.dart - _init():" + e.toString());
//     }
//   }

  Future _checkOTP(String otp) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (global.appInfo.firebase != 'off') {
          FirebaseAuth auth = FirebaseAuth.instance;
          var _credential = PhoneAuthProvider.credential(verificationId: verificationCode, smsCode: otp.trim());
          showOnlyLoaderDialog();
          await auth.signInWithCredential(_credential).then((result) {
            status = 'success';
            hideLoader();
            if (screenId != null && screenId == 0) {
//screenId ==0 -> Forgot Password
              _firebaseOtpVerification(status);
            } else {
              _verifyViaFirebase(status);
            }
          }).catchError((e) {
            status = 'failed';
            hideLoader();

            if (screenId != null && screenId == 0) {
//screenId ==0 -> Forgot Password
              _firebaseOtpVerification(status);
            } else {
              _verifyViaFirebase(status);
            }
          }).onError((error, stackTrace) {
            hideLoader();
          });
        } else {
          if (screenId != null && screenId == 0) {
            showOnlyLoaderDialog();
            await apiHelper.verifyOTP(phoneNumber, _cOtp.text).then((result) async {
              // forgot password

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
               
                } else {
                  hideLoader();
                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
                }
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: 'Something went wrong, please try again later.');
              }
            });
          } else {
            showOnlyLoaderDialog();
            await apiHelper.verifyPhone(phoneNumber, _cOtp.text, referalCode).then((result) async {
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
                  
                } else {
                  hideLoader();
                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
                }
              } else {
                hideLoader();
              }
            });
          }
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _checkOTP():" + e.toString());
    }
  }

  _firebaseOtpVerification(String _status) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.firebaseOTPVerification(phoneNumber, _status).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ResetPasswordScreen(
                          phoneNumber,
                          a: widget.analytics,
                          o: widget.observer,
                        )),
              );
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          } else {
            hideLoader();
          }
        }).catchError((e) {});
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _verifyOtp():" + e.toString());
    }
  }

  Future _getOTP(String mobileNumber) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.verifyPhoneNumber(
        phoneNumber: '+' + global.appInfo.countryCode.toString() + mobileNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          // var a = authCredential.providerId;
          setState(() {});
        },
        verificationFailed: (authException) {},
        codeSent: (String verificationId, [int forceResendingToken]) async {
          _cOtp.clear();
          _seconds = 60;
          startTimer();
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationId = verificationId;
        },
      );
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _getOTP():" + e.toString());
      return null;
    }
  }

  _resendOTP() async {
    try {
      if (global.appInfo.firebase != 'off') {
        // firebase resend OTP
        await _getOTP(phoneNumber);
      } else {
// resend API
        showOnlyLoaderDialog();
        await apiHelper.resendOTP(phoneNumber).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              _cOtp.clear();
              _seconds = 60;
              startTimer();
              setState(() {});
            } else {
              hideLoader();
            }
          }
        });
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _resendOTP():" + e.toString());
    }
  }

  _verifyViaFirebase(String _status) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.verifyViaFirebase(phoneNumber, _status, referalCode).then((result) async {
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
           
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          } else {
            hideLoader();
          }
        }).catchError((e) {});
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - otpVerificationScreen.dart - _verifyOtp():" + e.toString());
    }
  }
}
