import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/cancelReasonModel.dart';
import 'package:gomeat/models/orderModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;

class CancelOrderScreen extends BaseRoute {
  final Order order;

  CancelOrderScreen({
    a,
    o,
    this.order,
  }) : super(a: a, o: o, r: 'CancelOrderScreen');
  @override
  _CancelOrderScreenState createState() => _CancelOrderScreenState(order: order);
}

class _CancelOrderScreenState extends BaseRouteState {
  Order order;

  List<CancelReason> _cancelReasonsList = [];
  bool _isDataLoaded = false;
  CancelReason _selectedReason;
  GlobalKey<ScaffoldState> _scaffoldKey;
  _CancelOrderScreenState({
    this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: Text(
          "${AppLocalizations.of(context).tle_cancel_order}",
        ),
      ),
      body: _isDataLoaded
          ? ListView.builder(
              itemCount: _cancelReasonsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile(
                    value: _cancelReasonsList[index],
                    groupValue: _selectedReason,
                    onChanged: (val) {
                      _selectedReason = val;
                      setState(() {});
                    },
                    title: Text(
                      _cancelReasonsList[index].reason,
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                );
              })
          : _shimmer(),
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
                    if (_selectedReason != null && _selectedReason.reason != null && _selectedReason.reason.isNotEmpty) {
                      await _cancelConfirmationDialog();
                    } else {
                      showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_select_cancel_reason}');
                    }
                  },
                  child: Text(
                    '${AppLocalizations.of(context).tle_cancel_order}',
                  )),
            ),
          ),
        ],
      ),
    );
  }

  deleteOrder() async {
    try {
      showOnlyLoaderDialog();
      await apiHelper.deleteOrder(order.cartId, _selectedReason.reason).then((result) async {
        if (result != null) {
          if (result.status == "1") {
            order.orderStatus = 'Cancelled';
            showSnackBar(key: _scaffoldKey, snackBarMessage: result.message);
            if (order.paidByWallet != null) {
              global.currentUser.wallet = global.currentUser.wallet + order.paidByWallet;
            }
            hideLoader();
            hideLoader();
          } else {
            hideLoader();
            showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
          }
        }
      });
    } catch (e) {
      print("Exception -  OrderController.dart - deleteOrder():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _cancelConfirmationDialog() async {
    try {
      await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => Theme(
          data: ThemeData(dialogBackgroundColor: Colors.white),
          child: CupertinoAlertDialog(
            title: Text(
              "${AppLocalizations.of(context).tle_cancel_order}",
            ),
            content: Text(
              "${AppLocalizations.of(context).txt_cancel_order_message}",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  '${AppLocalizations.of(context).btn_yes}',
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await deleteOrder();
                },
              ),
              CupertinoDialogAction(
                child: Text("${AppLocalizations.of(context).btn_no}"),
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

  _getCancelReasons() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getCancelReason().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _cancelReasonsList = result.data;
            } else {
              _cancelReasonsList = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception -  CancelOrderScreen.dart - _getCancelReasons():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getCancelReasons();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception -  CancelOrderScreen.dart - _init():" + e.toString());
    }
  }

  Widget _shimmer() {
    try {
      return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
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
                    height: 90,
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
      print("Exception - wishlistScreen.dart - _productShimmer():" + e.toString());
      return SizedBox();
    }
  }
}
