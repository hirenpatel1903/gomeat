import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/addressModel.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/screens/addAddressScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class AddressListScreen extends BaseRoute {
  AddressListScreen({a, o}) : super(a: a, o: o, r: 'AddressListScreen');
  @override
  _AddressListScreenState createState() => new _AddressListScreenState();
}

class _AddressListScreenState extends BaseRouteState {
  bool _isDataLoaded = false;

  List<Address> _addressList = [];
  GlobalKey<ScaffoldState> _scaffoldKey;

  _AddressListScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
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
          centerTitle: true,
          title: Text("${AppLocalizations.of(context).tle_my_address}"),
         
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isDataLoaded
              ? RefreshIndicator(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  color: Theme.of(context).primaryColor,
                  onRefresh: () async {
                    _isDataLoaded = false;
                    setState(() {});
                    await _init();
                  },
                  child: global.nearStoreModel.id != null
                      ? _addressList.length > 0
                          ? ListView.builder(
                              itemCount: _addressList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        _addressList[index].type,
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                      subtitle: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_addressList[index].houseNo}, ${_addressList[index].landmark}, ${_addressList[index].society}",
                                            style: Theme.of(context).primaryTextTheme.headline2,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .push(
                                                      MaterialPageRoute(
                                                        builder: (context) => AddAddressScreen(_addressList[index], a: widget.analytics, o: widget.observer),
                                                      ),
                                                    )
                                                        .then((value) async {
                                                      if (value != null && value) {
                                                        _isDataLoaded = false;
                                                        setState(() {});
                                                        await _init();
                                                      }
                                                    });
                                                  },
                                                  icon: Image.asset('assets/edit.png')),
                                              IconButton(
                                                  onPressed: () async {
                                                    await deleteConfirmationDialog(index);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Theme.of(context).primaryColor,
                                                  )),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                "${AppLocalizations.of(context).txt_nothing_to_show}",
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                              ),
                            )
                      : Center(
                          child: Text(
                            "${global.locationMessage}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        ),
                )
              : _shimmerList(),
        ),
      ),
    );
  }

  Future deleteConfirmationDialog(int index) async {
    try {
      await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => Theme(
          data: ThemeData(dialogBackgroundColor: Colors.white),
          child: CupertinoAlertDialog(
            title: Text(
              "${AppLocalizations.of(context).tle_delete_address}",
            ),
            content: Text(
              "${AppLocalizations.of(context).lbl_delete_address_desc}",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  '${AppLocalizations.of(context).btn_ok}',
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _removeAddress(index);
                },
              ),
              CupertinoDialogAction(
                child: Text("${AppLocalizations.of(context).lbl_cancel}"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print("Exception - addressListScreen.dart - deleteConfirmationDialog():" + e.toString());
      return false;
    }
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
      print("Exception - addressListScreen.dart - _init():" + e.toString());
    }
  }

  _removeAddress(int index) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.removeAddress(_addressList[index].addressId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              _addressList.removeAt(index);
              setState(() {});
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - addressListScreen.dart - _removeAddress():" + e.toString());
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
}
