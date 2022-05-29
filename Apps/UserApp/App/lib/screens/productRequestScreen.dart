import 'dart:async';
import 'dart:io';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gomeat/models/addressModel.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductRequestScreen extends BaseRoute {
  ProductRequestScreen({a, o}) : super(a: a, o: o, r: 'ProductRequestScreen');

  @override
  _ProductRequestScreenState createState() => _ProductRequestScreenState();
}

class _ProductRequestScreenState extends BaseRouteState {
  File _tImage;
  bool _isDataLoaded = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<Address> _addressList = [];
  int _selectedAddress = 0;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${AppLocalizations.of(context).lbl_make_product_request}',
          ),
        ),
        body: global.nearStoreModel.id != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ListTile(
                        onTap: () async {
                          await _showCupertinoModalSheet();
                        },
                        title: Text(
                          "${AppLocalizations.of(context).lbl_upload_image}",
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                        subtitle: Text(
                          "${AppLocalizations.of(context).txt_upload_image_desc}",
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: _tImage != null
                          ? Container(
                              height: 220,
                              width: 250,
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).dividerTheme.color),
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: FileImage(
                                    File(_tImage.path),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              height: 220,
                              width: 250,
                              decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerTheme.color), borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                onTap: () async {
                                  await _showCupertinoModalSheet();
                                },
                                child: Center(
                                    child: Icon(
                                  Icons.file_upload,
                                  size: 50,
                                )),
                              ),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ListTile(
                        title: Text(
                          "${AppLocalizations.of(context).lbl_select_address}",
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                      ),
                    ),
                    _isDataLoaded
                        ? ListView.builder(
                            itemCount: _addressList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  RadioListTile(
                                    groupValue: _selectedAddress,
                                    contentPadding: EdgeInsets.zero,
                                    value: index,
                                    title: Text(
                                      _addressList[index].type,
                                      style: _selectedAddress == index ? Theme.of(context).primaryTextTheme.bodyText1 : Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Theme.of(context).primaryTextTheme.headline2.color),
                                    ),
                                    onChanged: (val) {
                                      _selectedAddress = val;
                                      setState(() {});
                                    },
                                    subtitle: Text(
                                      "${_addressList[index].houseNo}, ${_addressList[index].landmark}, ${_addressList[index].society}",
                                      style: _selectedAddress == index ? Theme.of(context).primaryTextTheme.headline2.copyWith(color: Theme.of(context).primaryTextTheme.bodyText1.color) : Theme.of(context).primaryTextTheme.headline2,
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          )
                        : _shimmerList(),
                  ],
                ),
              )
            : Center(
                child: Text(
                  "${global.locationMessage}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
              ),
        bottomNavigationBar: global.nearStoreModel.id != null
            ? Padding(
                padding: EdgeInsets.all(8),
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
                        await _makeProductRequest();
                      },
                      child: Text(
                        '${AppLocalizations.of(context).btn_submit}',
                      )),
                ),
              )
            : null,
      ),
    );
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
        if (global.nearStoreModel.id != null) {
          await apiHelper.getAddressList().then((result) async {
            if (result != null) {
              if (result.status == "1") {
                _addressList = result.data;
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - productRequestScreen.dart - _init():" + e.toString());
    }
  }

  _makeProductRequest() async {
    try {
      if (_selectedAddress != null && _tImage != null) {
        await apiHelper.makeProductRequest(_addressList[_selectedAddress].addressId, _tImage).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _showProductRequestConfirmationDialog(result.message);
            } else if (result.status == '2') {
              _showProductRequestConfirmationDialog(result.message);
            } else {
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_something_went_wrong}');
            }
          }
        });
      } else if (_selectedAddress == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_select_deluvery_address}');
      } else if (_tImage == null) {
        showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_upload_product_image}');
      }
    } catch (e) {
      print("Exception -  productRequestScreen.dart - _makeProductRequest():" + e.toString());
    }
  }

  Widget _shimmerList() {
    try {
      return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(
              top: 8,
            ),
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
                    height: 112,
                    width: MediaQuery.of(context).size.width,
                    child: Card(),
                  ),
                  Divider(),
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

  _showProductRequestConfirmationDialog(String message) {
    return showDialog(
        context: context,
        barrierColor: Colors.grey[300].withOpacity(0.5),
        builder: (BuildContext context) {
          _timer = Timer(Duration(seconds: 5), () {
            Navigator.of(context).pop();
          });
          return SimpleDialog(
            backgroundColor: global.isDarkModeEnable ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).inputDecorationTheme.fillColor,
            children: [
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      message,
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  )))
            ],
          );
        }).then((val) {
      if (_timer.isActive) {
        _timer.cancel();
      }
    });
  }
}
