import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/screens/loginScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ResetPasswordScreen extends BaseRoute {
  final String phone;
  ResetPasswordScreen(this.phone, {a, o}) : super(a: a, o: o, r: 'ResetPasswordScreen');
  @override
  _ResetPasswordScreenState createState() => new _ResetPasswordScreenState(this.phone);
}

class _ResetPasswordScreenState extends BaseRouteState {
  String phone;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _cPassword = new TextEditingController();
  TextEditingController _cConfirmPassword = new TextEditingController();
  var _fPassword = new FocusNode();
  var _fConfirmPassword = new FocusNode();
  var _dismiss = new FocusNode();
  bool isloading = true;
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  _ResetPasswordScreenState(this.phone) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                  top: 30,
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
                  top: MediaQuery.of(context).size.height * 0.07,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '${AppLocalizations.of(context).lbl_reset_password}',
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
                        Text('${AppLocalizations.of(context).lbl_reset_password}', style: Theme.of(context).primaryTextTheme.bodyText1),
                        Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 20),
                          child: Text('$phone', style: Theme.of(context).primaryTextTheme.bodyText1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                            padding: EdgeInsets.only(),
                            child: TextFormField(
                              controller: _cPassword,
                              focusNode: _fPassword,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                              obscureText: _isPasswordVisible,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(_fConfirmPassword);
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: IconTheme.of(context).color),
                                  onPressed: () {
                                    _isPasswordVisible = !_isPasswordVisible;
                                    setState(() {});
                                  },
                                ),
                                hintText: '${AppLocalizations.of(context).lbl_password}',
                                counterText: '',
                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                            padding: EdgeInsets.only(),
                            child: TextFormField(
                              controller: _cConfirmPassword,
                              focusNode: _fConfirmPassword,
                              obscureText: _isConfirmPasswordVisible,
                              textInputAction: TextInputAction.done,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(_dismiss);
                              },
                              decoration: InputDecoration(
                                hintText: '${AppLocalizations.of(context).lbl_confirm_password}',
                                suffixIcon: IconButton(
                                  icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: IconTheme.of(context).color),
                                  onPressed: () {
                                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                    setState(() {});
                                  },
                                ),
                                counterText: '',
                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), gradient: LinearGradient(stops: [0, .90], begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor])),
                          margin: EdgeInsets.only(top: 20),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                              onPressed: () async {
                                await _changePassword();
                              },
                              child: Text('${AppLocalizations.of(context).lbl_reset_password}')),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  _changePassword() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_cPassword.text.trim().isNotEmpty && _cConfirmPassword.text.trim().isNotEmpty && _cPassword.text.trim() == _cConfirmPassword.text.trim()) {
          showOnlyLoaderDialog();
          await apiHelper.changePassword(phone, _cConfirmPassword.text.trim()).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                hideLoader();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(a: widget.analytics, o: widget.observer),
                  ),
                );
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            }
          });
        } else if (_cPassword.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_password);
        } else if (_cPassword.text.isNotEmpty && _cPassword.text.trim().length < 8) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_password_should_be_of_minimum_8_character);
        } else if (_cConfirmPassword.text.isEmpty && _cPassword.text.isNotEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_reEnter_your_password);
        } else if (_cConfirmPassword.text.isNotEmpty && _cPassword.text.isNotEmpty && (_cConfirmPassword.text.trim() != _cPassword.text.trim())) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_password_do_not_match);
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - resetPasswordScreen.dart - _changePassword():" + e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  login(String userPhone) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - resetPasswordScreen.dart - login():" + e.toString());
    }
  }
}
