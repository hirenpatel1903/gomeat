import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/models/addressModel.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/societyModel.dart';
import 'package:shimmer/shimmer.dart';

class AddAddressScreen extends BaseRoute {
  final Address address;
  AddAddressScreen(this.address, {a, o}) : super(a: a, o: o, r: 'AddAddressScreen');
  @override
  _AddAddressScreenState createState() => new _AddAddressScreenState(this.address);
}

class _AddAddressScreenState extends BaseRouteState {
  var _cAddress = new TextEditingController();
  var _cLandmark = new TextEditingController();
  var _cPincode = new TextEditingController();
  var _cState = new TextEditingController();
  var _cCity = new TextEditingController();
  var _cName = new TextEditingController();
  var _cPhone = new TextEditingController();
  var _cSociety = new TextEditingController();
  var _cSearchSociety = new TextEditingController();
  var _fSociety = new FocusNode();
  var _fName = new FocusNode();
  var _fPhone = new FocusNode();
  var _fAddress = new FocusNode();
  var _fLandmark = new FocusNode();
  var _fPincode = new FocusNode();
  var _fState = new FocusNode();
  var _fCity = new FocusNode();
  var _fDismiss = new FocusNode();
  GlobalKey<ScaffoldState> _scaffoldKey;
  Society _selectedSociety = new Society();
  String type = 'Home';
  Address address;
  bool _isDataLoaded = false;
  List<Society> _societyList = [];
  List<Society> _tSocietyList = [];
  var _fSearchSociety = new FocusNode();
  _AddAddressScreenState(this.address) : super();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: global.isDarkModeEnable ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).inputDecorationTheme.fillColor,
        appBar: AppBar(
          leadingWidth: 0,
          leading: SizedBox(),
          title: address.addressId != null ? Text(AppLocalizations.of(context).tle_add_new_address) : Text('${AppLocalizations.of(context).tle_edit_address}'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              icon: Icon(
                FontAwesomeIcons.windowClose,
                color: Theme.of(context).appBarTheme.actionsIconTheme.color,
              ),
            )
          ],
        ),
        body: _isDataLoaded
            ? SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: EdgeInsets.only(top: 15, left: 16, right: 16),
                      padding: EdgeInsets.only(),
                      child: TextFormField(
                        controller: _cName,
                        focusNode: _fName,
                        textCapitalization: TextCapitalization.words,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                        decoration: InputDecoration(
                          fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                          hintText: '${AppLocalizations.of(context).lbl_name}',
                          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        ),
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(_fPhone);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: EdgeInsets.only(top: 15, left: 16, right: 16),
                      padding: EdgeInsets.only(),
                      child: TextFormField(
                        controller: _cPhone,
                        focusNode: _fPhone,
                        keyboardType: TextInputType.phone,
                        maxLength: global.appInfo.phoneNumberLength,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                        decoration: InputDecoration(
                          counterText: '',
                          fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                          hintText: '${AppLocalizations.of(context).lbl_phone_number}',
                          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        ),
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(_fAddress);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: EdgeInsets.only(top: 15, left: 16, right: 16),
                      padding: EdgeInsets.only(),
                      child: TextFormField(
                        controller: _cAddress,
                        focusNode: _fAddress,
                        textCapitalization: TextCapitalization.words,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                        decoration: InputDecoration(
                          fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                          hintText: '${AppLocalizations.of(context).hnt_address}',
                          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        ),
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(_fLandmark);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: EdgeInsets.only(top: 15, left: 16, right: 16),
                      padding: EdgeInsets.only(),
                      child: TextFormField(
                        controller: _cLandmark,
                        focusNode: _fLandmark,
                        textCapitalization: TextCapitalization.words,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                        decoration: InputDecoration(
                          fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                          hintText: '${AppLocalizations.of(context).hnt_near_landmark}',
                          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        ),
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(_fPincode);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: EdgeInsets.only(top: 15, left: 16, right: 16),
                      padding: EdgeInsets.only(),
                      child: TextFormField(
                        controller: _cPincode,
                        focusNode: _fPincode,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                        decoration: InputDecoration(
                          fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                          hintText: '${AppLocalizations.of(context).hnt_pincode}',
                          counterText: '',
                          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        ),
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(_fSociety);
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: EdgeInsets.only(top: 15, left: 16, right: 16),
                      padding: EdgeInsets.only(),
                      child: TextFormField(
                        controller: _cSociety,
                        focusNode: _fSociety,
                        readOnly: true,
                        maxLines: 3,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                        decoration: InputDecoration(
                          fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                          hintText: '${AppLocalizations.of(context).lbl_society}',
                          contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        ),
                        onFieldSubmitted: (val) {
                          FocusScope.of(context).requestFocus(_fCity);
                        },
                        onTap: () {
                          _showSocietySelectDialog();
                        },
                      ),
                    ),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                            margin: EdgeInsets.only(top: 15, left: 16, right: 8),
                            padding: EdgeInsets.only(),
                            child: TextFormField(
                              controller: _cCity,
                              focusNode: _fCity,
                              readOnly: true,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              decoration: InputDecoration(
                                fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                hintText: '${AppLocalizations.of(context).hnt_city_district}',
                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                              ),
                              onFieldSubmitted: (val) {
                                FocusScope.of(context).requestFocus(_fState);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                            margin: EdgeInsets.only(top: 15, left: 8, right: 16),
                            padding: EdgeInsets.only(),
                            child: TextFormField(
                              controller: _cState,
                              focusNode: _fState,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              decoration: InputDecoration(
                                fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                hintText: '${AppLocalizations.of(context).hnt_state}',
                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                              ),
                              onFieldSubmitted: (val) {
                                FocusScope.of(context).requestFocus(_fDismiss);
                              },
                            ),
                          ),
                        ),
                  
                      ],
                    ),
                    ListTile(
                      title: Text(
                        '${AppLocalizations.of(context).lbl_save_address}',
                        style: Theme.of(context).primaryTextTheme.headline6,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: InkWell(
                              onTap: () {
                                type = 'Home';
                                setState(() {});
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      color: type == 'Home'
                                          ? Theme.of(context).primaryColorLight
                                          : global.isDarkModeEnable
                                              ? Theme.of(context).inputDecorationTheme.fillColor
                                              : Theme.of(context).scaffoldBackgroundColor),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${AppLocalizations.of(context).txt_home}",
                                    style: Theme.of(context).inputDecorationTheme.hintStyle,
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              type = 'Office';
                              setState(() {});
                            },
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                    color: type == 'Office'
                                        ? Theme.of(context).primaryColorLight
                                        : global.isDarkModeEnable
                                            ? Theme.of(context).inputDecorationTheme.fillColor
                                            : Theme.of(context).scaffoldBackgroundColor),
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                alignment: Alignment.center,
                                child: Text(
                                  "${AppLocalizations.of(context).txt_office}",
                                  style: Theme.of(context).inputDecorationTheme.hintStyle,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: InkWell(
                              onTap: () {
                                type = 'Others';
                                setState(() {});
                              },
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      color: type == 'Others'
                                          ? Theme.of(context).primaryColorLight
                                          : global.isDarkModeEnable
                                              ? Theme.of(context).inputDecorationTheme.fillColor
                                              : Theme.of(context).scaffoldBackgroundColor),
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${AppLocalizations.of(context).txt_others}",
                                    style: Theme.of(context).inputDecorationTheme.hintStyle,
                                  )),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                    
                  ],
                ),
              )
            : _shimmerList(),
        bottomNavigationBar: _isDataLoaded
            ? Row(
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
                          onPressed: () {
                            _save();
                          },
                          child: Text('${AppLocalizations.of(context).btn_save_address}')),
                    ),
                  ),
                ],
              )
            : null,
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

  _fillData() {
    try {
      _cName.text = address.receiverName;
      _cPhone.text = address.receiverPhone;
      _cPincode.text = address.pincode;
      _cAddress.text = address.houseNo;
      _cSociety.text = address.society;
      _cState.text = address.state;
      _cCity.text = address.city;
      _cLandmark.text = address.landmark;
    } catch (e) {
      print("Excetion - addAddessScreen.dart - _fillData():" + e.toString());
    }
  }

  _getSocietyList() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getSocietyForAddress().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _societyList = result.data;
              _tSocietyList.addAll(_societyList);
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - addAddressScreen.dart -  _getSocietyList():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getSocietyList();
      if (address.addressId != null) {
        _fillData();
      } else {
        _cCity.text = global.nearStoreModel.city;
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - addAddressScreen.dart -  _init():" + e.toString());
    }
  }

  _save() async {
    try {
      if (_cName != null &&
          _cName.text.isNotEmpty &&
          _cPhone.text != null &&
          _cPhone.text.isNotEmpty &&
          _cPhone.text.length == global.appInfo.phoneNumberLength &&
          _cPincode.text != null &&
          _cPincode.text.isNotEmpty &&
          _cAddress.text != null &&
          _cAddress.text.isNotEmpty &&
          _cLandmark.text != null &&
          _cLandmark.text.isNotEmpty &&
          _cSociety.text.isNotEmpty &&
          _cCity.text.isNotEmpty &&
          type != null) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          address.receiverName = _cName.text;
          address.receiverPhone = _cPhone.text;
          address.houseNo = _cAddress.text;
          address.landmark = _cLandmark.text;
          address.pincode = _cPincode.text;
          address.society = _cSociety.text;
          address.state = _cState.text;
          address.city = _cCity.text;
          address.type = type;
          print("Adddre  ${_cAddress.text}, ${_cLandmark.text}, ${_cSociety.text} ");
          String latlng = await getLocationFromAddress('${_cAddress.text}, ${_cLandmark.text}, ${_cSociety.text}');
          List<String> _tList = latlng.split("|");
          address.lat = _tList[0];
          address.lng = _tList[1];
          if (address.addressId != null) {
            address.addressId = address.addressId;
            await apiHelper.editAddress(address).then((result) async {
              if (result != null) {
                if (result.status == "1") {
                  hideLoader();
                  Navigator.of(context).pop(true);
                } else {
                  hideLoader();
                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
                }
              }
            });
          } else {
            await apiHelper.addAddress(address).then((result) async {
              if (result != null) {
                if (result.status == "1") {
                  hideLoader();
                  Navigator.of(context).pop(true);
                }
              }
            });
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cName.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_your_name);
      } else if (_cPhone.text.isEmpty || (_cPhone.text.isNotEmpty && _cPhone.text.trim().length != global.appInfo.phoneNumberLength)) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_enter_valid_mobile_number);
      } else if (_cAddress.text.trim().isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enter house no, building, area etc.');
      } else if (_cLandmark.text.trim().isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enter nearest landmark.');
      } else if (_cPincode.text.trim().isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enter pincode.');
      } else if (_selectedSociety.societyId == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_select_society);
      } else if (_cCity.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enter city');
      } else if (_cState.text.isEmpty) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: 'Please enter state');
      }
    } catch (e) {
      print("Excetion - addAddessScreen.dart - _save():" + e.toString());
    }
  }

  Widget _shimmerList() {
    try {
      return ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 15, left: 16, right: 16),
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
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: Card(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print("Exception - addAddressScreen.dart - _shimmerList():" + e.toString());
      return SizedBox();
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
                              hintText: 'Search society here...',
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
                                      List<String> _listString = _selectedSociety.societyName.split(",");

                                      _cState.text = _listString[_listString.length - 2];

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
      print("Exception - addAddressScreen.dart - _showSocietySelectDialog():" + e.toString());
    }
  }
}
