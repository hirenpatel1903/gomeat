import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/cityModel.dart';
import 'package:gomeat/models/societyModel.dart';
import 'package:gomeat/models/userModel.dart';
import 'package:shimmer/shimmer.dart';

class ProfileEditScreen extends BaseRoute {
  ProfileEditScreen({a, o}) : super(a: a, o: o, r: 'ProfileEditScreen');
  @override
  _ProfileEditScreenState createState() => new _ProfileEditScreenState();
}

class _ProfileEditScreenState extends BaseRouteState {
  var _cName = new TextEditingController();
  var _cPhone = new TextEditingController();
  var _cEmail = new TextEditingController();
  var _fName = new FocusNode();
  GlobalKey<ScaffoldState> _scaffoldKey;
  var _fPhone = new FocusNode();
  var _fEmail = new FocusNode();
  var _cSearchCity = new TextEditingController();
  var _fSearchCity = new FocusNode();
  var _fSearchSociety = new FocusNode();
  var _cSearchSociety = new TextEditingController();
  List<City> _citiesList = [];
  List<Society> _societyList = [];
  List<City> _tCityList = [];
  List<Society> _tSocietyList = [];
  City _selectedCity = new City();
  Society _selectedSociety = new Society();
  var _cCity = new TextEditingController();
  var _cSociety = new TextEditingController();
  File _tImage;
  var _fCity = new FocusNode();
  var _fSociety = new FocusNode();
  bool _isDataLoaded = false;
  _ProfileEditScreenState() : super();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: global.isDarkModeEnable ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).inputDecorationTheme.fillColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("${AppLocalizations.of(context).tle_edit_profile}"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _isDataLoaded
                ? Container(
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
                                    : global.currentUser.userImage != null
                                        ? CachedNetworkImage(
                                            imageUrl: global.appInfo.imageUrl + global.currentUser.userImage,
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: 106,
                                              width: 106,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).cardTheme.color,
                                                borderRadius: new BorderRadius.all(
                                                  new Radius.circular(106),
                                                ),
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
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
                            onPressed: () async {
                              await _showCupertinoModalSheet();
                            },
                            child: Text(
                              '${AppLocalizations.of(context).btn_update_profile_picture}',
                              style: Theme.of(context).primaryTextTheme.headline1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 16,
                          child: Card(),
                        ),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 16,
                        ),
                      ],
                    ),
                  ),
            Expanded(
              child: _isDataLoaded
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppLocalizations.of(context).lbl_edit_name}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cName,
                                focusNode: _fName,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: 'Daniala Escobe',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_edit_phone_number}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cPhone,
                                focusNode: _fPhone,
                                readOnly: true,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '+91 9007210595',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                              ),
                            ),
                            Text(
                              "${AppLocalizations.of(context).lbl_edit_email}",
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                              margin: EdgeInsets.only(top: 5, bottom: 15),
                              padding: EdgeInsets.only(),
                              child: TextFormField(
                                controller: _cEmail,
                                focusNode: _fEmail,
                                readOnly: true,
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: 'd.escober@gmail.com',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
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
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  _showCitySelectDialog();

                                  setState(() {});
                                },
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '${AppLocalizations.of(context).hnt_select_city}',
                                  counterText: '',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
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
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                onTap: () {
                                  _showSocietySelectDialog();

                                  setState(() {});
                                },
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                decoration: InputDecoration(
                                  fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                  hintText: '${AppLocalizations.of(context).hnt_select_society}',
                                  counterText: '',
                                  contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : _shimmerList(),
            ),
          ],
        ),
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
                      await _save();
                    },
                    child: Text('${AppLocalizations.of(context).btn_save_update}')),
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

  _save() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_cName.text.isNotEmpty && _selectedCity != null && _selectedCity.cityId != null && _selectedSociety != null && _selectedSociety.societyId != null) {
          showOnlyLoaderDialog();
          CurrentUser _user = new CurrentUser();

          _user.name = _cName.text;
          if (_tImage != null) {
            _user.userImageFile = _tImage;
          }
          _user.userCity = _selectedCity.cityId;
          _user.userArea = _selectedSociety.societyId;
          await apiHelper.updateProfile(_user).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                global.currentUser = result.data;
                global.sp.setString('currentUser', json.encode(global.currentUser.toJson()));
                hideLoader();

                showSnackBar(key: _scaffoldKey, snackBarMessage: "${AppLocalizations.of(context).txt_profile_updated_successfully}");
                hideLoader();
              } else {
                hideLoader();
                showSnackBar(key: _scaffoldKey, snackBarMessage: result.message.toString());
              }
            }
          });
        } else if (_cName.text.isEmpty) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_name);
        } else if (_selectedCity.cityId == null) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_select_city);
        } else if (_selectedSociety.societyId == null) {
          showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_select_society);
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - profileEditScreen.dart - _save():" + e.toString());
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
      print("Exception - profileEditScreen.dart - _getCities():" + e.toString());
    }
  }

  _getSociety(int cityId, bool openDialog) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getSociety(cityId).then((result) {
          if (result != null && result.statusCode == 200 && result.status == '1') {
            _societyList = result.data;

            if (openDialog) {
              _tSocietyList.addAll(_societyList);
              Navigator.of(context).pop();
              _cSearchCity.clear();
              _showSocietySelectDialog();
            }

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
      print("Exception - profileEditScreen.dart - _getSociety():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getCities();
      await _getSociety(global.currentUser.userCity, false);
      _selectedCity = _citiesList.firstWhere((e) => e.cityId == global.currentUser.userCity);
      _cCity.text = _selectedCity.cityName;
      _selectedSociety = _societyList.firstWhere((e) => e.societyId == global.currentUser.userArea);
      _cSociety.text = _selectedSociety.societyName;
      _cName.text = global.currentUser.name;
      _cEmail.text = global.currentUser.email;
      _cPhone.text = global.currentUser.userPhone;
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - profileScreen.dart - _init(): " + e.toString());
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
                                      _cSociety.clear();
                                      _selectedSociety.societyId = null;
                                      await _getSociety(_selectedCity.cityId, true);
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
      print("Exception - profileEditScreen.dart - _showCitySelectDialog():" + e.toString());
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
      print("Exception - profileEditScreen.dart - _showCupertinoModalSheet():" + e.toString());
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
      print("Exception - profileEditScreen.dart - _showSocietySelectDialog():" + e.toString());
    }
  }

  Widget _shimmerList() {
    try {
      return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 10, left: 16, right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width / 2,
                    child: Card(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: Card(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print("Exception - profileEdiScreen.dart - _shimmerList():" + e.toString());
      return SizedBox();
    }
  }
}
