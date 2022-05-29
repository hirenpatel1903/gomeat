import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/cityModel.dart';
import 'package:gomeat/models/societyModel.dart';
import 'package:gomeat/models/userModel.dart';
import 'package:gomeat/screens/otpVerificationScreen.dart';

class SignUpScreen extends BaseRoute {
  final CurrentUser user;
  SignUpScreen({this.user, a, o}) : super(a: a, o: o, r: 'SignUpScreen');
  @override
  _SignUpScreenState createState() => new _SignUpScreenState(this.user);
}

class _SignUpScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  var _cName = new TextEditingController();
  var _cPhone = new TextEditingController();
  var _cEmail = new TextEditingController();
  var _cPassword = new TextEditingController();
  var _cConfirmPassword = new TextEditingController();
  var _cCity = new TextEditingController();
  var _cSociety = new TextEditingController();
  var _cReferral = new TextEditingController();
  var _cSearchCity = new TextEditingController();
  var _cSearchSociety = new TextEditingController();

  var _fName = new FocusNode();
  var _fPhone = new FocusNode();
  var _fEmail = new FocusNode();
  var _fCity = new FocusNode();
  var _fSociety = new FocusNode();
  var _fReferral = new FocusNode();
  var _fPassword = new FocusNode();
  var _fConfirmPassword = new FocusNode();
  var _fSearchCity = new FocusNode();
  var _fSearchSociety = new FocusNode();
  var _fDismiss = new FocusNode();

  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  File _tImage;
  bool _isDataLoaded = false;
  List<City> _citiesList = [];
  List<Society> _societyList = [];
  List<City> _tCityList = [];
  List<Society> _tSocietyList = [];
  City _selectedCity = new City();
  Society _selectedSociety = new Society();

  CurrentUser user;
  _SignUpScreenState(this.user) : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: global.isDarkModeEnable ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).inputDecorationTheme.fillColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("${AppLocalizations.of(context).btn_signup}"),
        ),
        body: _isDataLoaded
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 240,
                    color: Colors.transparent,
                    alignment: Alignment.topCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 240,
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/profile_edit.png'),
                              ),
                            ),
                            alignment: Alignment.topCenter,
                            child: Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: _tImage != null
                                    ? CircleAvatar(
                                        radius: 53,
                                        backgroundImage: FileImage(File(_tImage.path)),
                                      )
                                    : CircleAvatar(
                                        radius: 53,
                                        child: Icon(
                                          Icons.person,
                                          size: 53,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          child: TextButton(
                            onPressed: () {
                              _showCupertinoModalSheet();
                            },
                            child: Text(
                              '${AppLocalizations.of(context).btn_add_profile_picture}',
                              style: Theme.of(context).primaryTextTheme.headline1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context).lbl_name}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cName,
                                focusNode: _fName,
                                textCapitalization: TextCapitalization.words,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: 'Daniala Escobe',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(_fPhone);
                                },
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_phone_number}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cPhone,
                                focusNode: _fPhone,
                                readOnly: user.userPhone != null ? true : false,
                                keyboardType: TextInputType.phone,
                                maxLength: global.appInfo.phoneNumberLength,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '9876543211',
                                  alignLabelWithHint: true,
                                  counterText: '',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(_fEmail);
                                },
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_email}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cEmail,
                                focusNode: _fEmail,
                                readOnly: user.email != null ? true : false,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: 'd.escober@gmail.com',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(_fPassword);
                                },
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_password}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cPassword,
                                focusNode: _fPassword,
                                maxLength: 8,
                                obscureText: _isPasswordVisible,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '********',
                                  counterText: '',
                                  suffixIcon: IconButton(
                                    icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: IconTheme.of(context).color),
                                    onPressed: () {
                                      _isPasswordVisible = !_isPasswordVisible;
                                      setState(() {});
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(_fConfirmPassword);
                                },
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_confirm_password}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cConfirmPassword,
                                focusNode: _fConfirmPassword,
                                maxLength: 8,
                                obscureText: _isConfirmPasswordVisible,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '********',
                                  counterText: '',
                                  suffixIcon: IconButton(
                                    icon: Icon(_isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: IconTheme.of(context).color),
                                    onPressed: () {
                                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                      setState(() {});
                                    },
                                  ),
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(_fCity);
                                },
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_city}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cCity,
                                focusNode: _fCity,
                                readOnly: true,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '${AppLocalizations.of(context).hnt_select_city}',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onTap: () {
                                  if (_citiesList != null && _citiesList.length > 0) {
                                    _cCity.clear();
                                    _cSociety.clear();
                                    _cSearchCity.clear();
                                    _cSearchSociety.clear();
                                    _selectedCity = new City();
                                    _selectedSociety = new Society();
                                    _showCitySelectDialog();
                                  } else {
                                    showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_no_city}');
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_society}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cSociety,
                                focusNode: _fSociety,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '${AppLocalizations.of(context).hnt_select_society}',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(_fReferral);
                                },
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_referal_code}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cReferral,
                                focusNode: _fReferral,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  hintStyle: Theme.of(context).primaryTextTheme.headline2,
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: 'GOMEAT',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).requestFocus(_fDismiss);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Center(child: CircularProgressIndicator()),
        bottomNavigationBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  gradient: LinearGradient(
                    stops: [0, .90],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                  ),
                ),
                margin: EdgeInsets.all(8.0),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: () async {
                      await _onSignUp();
                    },
                    child: Text('${AppLocalizations.of(context).btn_signup}')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    try {
      _filldata();
      await _getCities();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - SignUpScreen.dart - _init():" + e.toString());
    }
  }

  _filldata() {
    try {
      _cPhone.text = user.userPhone;
      _cEmail.text = user.email;
      _cName.text = user.name;
    } catch (e) {
      print("Exception - signUpScreen.dart - _filldata():" + e.toString());
    }
  }

  _getCities() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getCity().then((result) {
          if (result != null && result.statusCode == 200 && result.status == '1') {
            _citiesList = result.data;
            _tCityList.addAll(_citiesList);
          } else {
            _citiesList = [];
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - SignUpScreen.dart - _getCities():" + e.toString());
    }
  }

  _getSociety() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getSociety(_selectedCity.cityId).then((result) {
          if (result != null && result.statusCode == 200 && result.status == '1') {
            _societyList = result.data;
            _tSocietyList.addAll(_societyList);
            Navigator.of(context).pop();
            _cSearchCity.clear();
            _showSocietySelectDialog();
            setState(() {});
          } else {
            Navigator.of(context).pop();
            _cSearchCity.clear();
            _societyList = [];

            showSnackBar(key: _scaffoldKey, snackBarMessage: result.message);
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - SignUpScreen.dart - _getSociety():" + e.toString());
    }
  }

  _onSignUp() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_cName.text.isNotEmpty &&
            EmailValidator.validate(_cEmail.text) &&
            _cEmail.text.isNotEmpty &&
            _cPhone.text.isNotEmpty &&
            _cPhone.text.trim().length == global.appInfo.phoneNumberLength &&
            _cPassword.text.isNotEmpty &&
            _cPassword.text.trim().length >= 8 &&
            _cConfirmPassword.text.isNotEmpty &&
            _cPassword.text.trim().length == _cConfirmPassword.text.trim().length &&
            _cPassword.text.trim() == _cConfirmPassword.text.trim() &&
            _selectedCity != null &&
            _selectedCity.cityId != null) {
          CurrentUser _user = new CurrentUser();

          _user.name = _cName.text.trim();
          _user.email = _cEmail.text.trim();
          _user.userPhone = _cPhone.text.trim();
          _user.password = _cPassword.text.trim();
          _user.userImage = _tImage != null ? _tImage.path : null;
          _user.referralCode = _cReferral.text.trim();
          _user.userCity = _selectedCity.cityId;
          _user.userArea = _selectedSociety.societyId;
          _user.facebookId = user.facebookId;
          showOnlyLoaderDialog();
          await apiHelper.signUp(_user).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                global.currentUser = result.data;
                if (global.appInfo.firebase != 'off') {
                  // if firebase is enabled then only we need to send OTP through firebase.
                  await sendOTP(_cPhone.text.trim(), _scaffoldKey, 1);
                } else {
                  MaterialPageRoute(
                      builder: (context) => OtpVerificationScreen(
                            screenId: 1,
                            a: widget.analytics,
                            o: widget.observer,
                            referalCode: _cReferral.text.trim(),
                            phoneNumber: _cPhone.text.trim(),
                          ));
                }
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: result.message.toString());
              }
            }
          });
        } else if (_cName.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_name);
        } else if (_cEmail.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_email);
        } else if (_cEmail.text.isNotEmpty && !EmailValidator.validate(_cEmail.text)) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_valid_email);
        } else if (_cPhone.text.isEmpty || (_cPhone.text.isNotEmpty && _cPhone.text.trim().length != global.appInfo.phoneNumberLength)) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_valid_mobile_number);
        } else if (_cPassword.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_password);
        } else if (_cPassword.text.isNotEmpty && _cPassword.text.trim().length < 8) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_password_should_be_of_minimum_8_character);
        } else if (_cConfirmPassword.text.isEmpty && _cPassword.text.isNotEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_reEnter_your_password);
        } else if (_cConfirmPassword.text.isNotEmpty && _cPassword.text.isNotEmpty && (_cConfirmPassword.text.trim() != _cPassword.text.trim())) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_password_do_not_match);
        } else if (_selectedCity.cityId == null) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_select_city);
        } else if (_selectedSociety.societyId == null) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_select_society);
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - SignUpScreen.dart - _onSignUp():" + e.toString());
    }
  }

  _showCitySelectDialog() {
    try {
      showDialog(
          context: context,
          barrierColor: Colors.black38,
          builder: (BuildContext context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) => Container(
                  child: AlertDialog(
                    elevation: 2,
                    scrollable: false,
                    contentPadding: EdgeInsets.zero,
                    backgroundColor: global.isDarkModeEnable ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).inputDecorationTheme.fillColor,
                    title: Column(
                      children: [
                        Text(
                          '${AppLocalizations.of(context).hnt_select_city}',
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          padding: EdgeInsets.only(),
                          child: TextFormField(
                            controller: _cSearchCity,
                            focusNode: _fSearchCity,
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context).primaryTextTheme.headline2,
                              fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                              hintText: '${AppLocalizations.of(context).hnt_search_city}',
                              contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            ),
                            onChanged: (val) {
                              _citiesList.clear();
                              if (val.isNotEmpty && val.length > 2) {
                                _citiesList.addAll(_tCityList.where((e) => e.cityName.toLowerCase().contains(val.toLowerCase())));
                              } else {
                                _citiesList.addAll(_tCityList);
                              }

                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: _citiesList != null && _citiesList.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: _citiesList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RadioListTile(
                                    title: Text(
                                      '${_citiesList[index].cityName}',
                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                    ),
                                    value: _citiesList[index],
                                    groupValue: _selectedCity,
                                    onChanged: (value) async {
                                      _selectedCity = value;
                                      _cCity.text = _selectedCity.cityName;
                                      _selectedSociety.cityId = _selectedCity.cityId;
                                      _cSociety.clear();
                                      await _getSociety();
                                      setState(() {});
                                    });
                              })
                          : Center(
                              child: Text(
                                '${AppLocalizations.of(context).txt_no_city}',
                                textAlign: TextAlign.center,
                              ),
                            ),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: Text('${AppLocalizations.of(context).btn_close}'))
                    ],
                  ),
                ),
              ));
    } catch (e) {
      print("Exception - SignUpScreen.dart - _showCitySelectDialog():" + e.toString());
    }
  }

  _showSocietySelectDialog() {
    try {
      showDialog(
          context: context,
          useRootNavigator: true,
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) => Container(
                  child: AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    backgroundColor: global.isDarkModeEnable ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).inputDecorationTheme.fillColor,
                    title: Column(
                      children: [
                        Text(
                          '${AppLocalizations.of(context).hnt_select_society}',
                          style: Theme.of(context).appBarTheme.titleTextStyle,
                        ),
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          padding: EdgeInsets.only(),
                          child: TextFormField(
                            controller: _cSearchSociety,
                            focusNode: _fSearchSociety,
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context).primaryTextTheme.headline2,
                              fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                              hintText: '${AppLocalizations.of(context).htn_search_society}',
                              contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                            ),
                            onChanged: (val) {
                              _societyList.clear();
                              if (val.isNotEmpty && val.length > 2) {
                                _societyList.addAll(_tSocietyList.where((e) => e.societyName.toLowerCase().contains(val.toLowerCase())));
                              } else {
                                _societyList.addAll(_tSocietyList);
                              }
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    content: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: _societyList != null && _societyList.length > 0
                          ? ListView.builder(
                              itemCount: _cSearchSociety.text.isNotEmpty && _tSocietyList != null && _tSocietyList.length > 0 ? _tSocietyList.length : _societyList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return RadioListTile(
                                    title: Text(
                                      _cSearchSociety.text.isNotEmpty && _tSocietyList != null && _tSocietyList.length > 0 ? '${_tSocietyList[index].societyName}' : '${_societyList[index].societyName}',
                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                    ),
                                    value: _cSearchSociety.text.isNotEmpty && _tSocietyList != null && _tSocietyList.length > 0 ? _tSocietyList[index] : _societyList[index],
                                    groupValue: _selectedSociety,
                                    onChanged: (value) async {
                                      _selectedSociety = value;
                                      _cSociety.text = _selectedSociety.societyName;
                                      Navigator.of(context).pop();

                                      setState(() {});
                                    });
                              })
                          : Center(
                              child: Text(
                              '${AppLocalizations.of(context).txt_no_society}',
                              textAlign: TextAlign.center,
                            )),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {});
                          },
                          child: Text('${AppLocalizations.of(context).btn_close}'))
                    ],
                  ),
                ),
              ));
    } catch (e) {
      print("Exception - SignUpScreen.dart - _showSocietySelectDialog():" + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context).lbl_actions),
          actions: [
            CupertinoActionSheetAction(
              child: Text('${AppLocalizations.of(context).lbl_take_picture}', style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_choose_from_library, style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
                hideLoader();

                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context).lbl_cancel, style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - SignUpScreen.dart - _showCupertinoModalSheet():" + e.toString());
    }
  }
}
