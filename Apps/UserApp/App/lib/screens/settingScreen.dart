import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/appSettingModel.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class SettingScreen extends BaseRoute {
  SettingScreen({a, o}) : super(a: a, o: o, r: 'SettingScreen');
  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends BaseRouteState {
  bool isFavourite = false;
  bool isSmsEnable = true;
  bool isInAppEnable = true;
  bool isEmailEnable = true;
  bool _isDataLoaded = false;
  int selectedLanguage = 0;
  GlobalKey<ScaffoldState> _scaffoldKey;
  AppSetting _appSetting = new AppSetting();

  _SettingScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("${AppLocalizations.of(context).btn_app_setting}"),
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.center,
              child: Icon(MdiIcons.arrowLeft),
            ),
          ),
        ),
        body: _isDataLoaded
            ? SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child: SwitchListTile(
                          value: _appSetting.sms,
                          onChanged: (val) async {
                            _appSetting.sms = val;
                            bool _isSuccessfull = await updateAppSetting();
                            hideLoader();
                            if (!_isSuccessfull) {
                              _appSetting.sms = !_appSetting.sms;
                              showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_something_went_wrong}');
                            }

                            setState(() {});
                          },
                          title: Text(
                            "${AppLocalizations.of(context).lbl_sms}",
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Card(
                          child: SwitchListTile(
                            value: _appSetting.app,
                            onChanged: (val) async {
                              _appSetting.app = val;
                              bool _isSuccessfull = await updateAppSetting();
                              hideLoader();
                              if (!_isSuccessfull) {
                                _appSetting.app = !_appSetting.app;
                                showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_something_went_wrong}');
                              }

                              setState(() {});
                            },
                            title: Text(
                              "${AppLocalizations.of(context).lbl_inapp}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Card(
                          child: SwitchListTile(
                            value: _appSetting.email,
                            onChanged: (val) async {
                              _appSetting.email = val;
                              bool _isSuccessfull = await updateAppSetting();
                              hideLoader();
                              if (!_isSuccessfull) {
                                _appSetting.email = !_appSetting.email;
                                showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_something_went_wrong}');
                              }
                              setState(() {});
                            },
                            title: Text(
                              "${AppLocalizations.of(context).lbl_email}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : _shimmerWidget(),
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
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getAppSetting().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _appSetting = result.data;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - settingScreen.dart- _init():" + e.toString());
    }
  }

  Future<bool> updateAppSetting() async {
    bool _isSuccessFullyUpdated = false;
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.updateAppSetting(_appSetting).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _isSuccessFullyUpdated = true;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      return _isSuccessFullyUpdated;
    } catch (e) {
      print("Exception -  settingScreen.dart - updateAppSetting()" + e.toString());
      return _isSuccessFullyUpdated;
    }
  }

  Widget _shimmerWidget() {
    try {
      return ListView.builder(
        itemCount: 3,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 8, bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
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
      print("Exception - settingScreen.dart - _shimmerWidget():" + e.toString());
      return SizedBox();
    }
  }
}
