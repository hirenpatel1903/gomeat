import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/couponModel.dart';
import 'package:gomeat/models/orderModel.dart';
import 'package:shimmer/shimmer.dart';

class CouponListScreen extends BaseRoute {
  final String cartId;
  final Order order;
  CouponListScreen({
    a,
    o,
    this.order,
    this.cartId,
  }) : super(a: a, o: o, r: 'CouponListScreen');

  @override
  _CouponListScreenState createState() => _CouponListScreenState(
        cartId: cartId,
        order: order,
      );
}

class _CouponListScreenState extends BaseRouteState {
  List<Coupon> _couponList = [];
  bool _isDataLoaded = false;

  final Color color = const Color(0xffdd2e45);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String cartId;
  String _selectedCouponCode;
  Order order;
  int screenId;
  _CouponListScreenState({
    this.cartId,
    this.order,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${AppLocalizations.of(context).lbl_coupons}",
        ),
      ),
      body: _isDataLoaded
          ? _couponList != null && _couponList.length > 0
              ? RefreshIndicator(
                  onRefresh: () async {
                    await _onRefresh();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: _couponList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${_couponList[index].couponName}',
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: 70,
                                            height: 30,
                                            child: Center(
                                                child: Text(
                                              "${_couponList[index].couponCode}",
                                              style: TextStyle(color: Colors.grey),
                                            )),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () => onRedeem(index),
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              width: 60,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              alignment: Alignment.center,
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    color: global.isDarkModeEnable ? Colors.black : Colors.white,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  width: 60.5,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${AppLocalizations.of(context).btn_apply}",
                                                    style: TextStyle(fontSize: 16, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _couponList[index].couponDescription,
                                    style: Theme.of(context).primaryTextTheme.headline2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  RichText(
                                      text: TextSpan(text: "Min. Order of ", style: Theme.of(context).primaryTextTheme.bodyText1, children: [
                                    TextSpan(
                                      text: '${global.appInfo.currencySign}',
                                      style: Theme.of(context).primaryTextTheme.headline2,
                                    ),
                                    TextSpan(
                                      text: ' ${_couponList[index].cartValue}',
                                      style: Theme.of(context).primaryTextTheme.headline2,
                                    )
                                  ])),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              : Center(
                  child: Text('${AppLocalizations.of(context).txt_no_coupon_msg}'),
                )
          : _shimmer(),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  onRedeem(int index) async {
    _selectedCouponCode = _couponList[index].couponCode;
    setState(() {});
    await _applyCoupon();
  }

  _applyCoupon() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.applyCoupon(cartId: cartId, couponCode: _selectedCouponCode).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              order = result.data;
              hideLoader();
              Navigator.of(context).pop(order);
            } else {
              hideLoader();
              order = null;
              showSnackBar(key: _scaffoldKey, snackBarMessage: result.message);
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }

      setState(() {});
    } catch (e) {
      print("Exception - couponListScreen.dart - _applyCoupon():" + e.toString());
    }
  }

  _getCouponsList() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getCoupons(cartId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _couponList = result.data;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }

      setState(() {});
    } catch (e) {
      print("Exception - couponListScreen.dart - _getCouponsList():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getCouponsList();

      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception -  couponListScreen.dart - _init():" + e.toString());
    }
  }

  _onRefresh() async {
    try {
      _isDataLoaded = false;
      setState(() {});
      await _init();
    } catch (e) {
      print("Exception - couponListScreen.dart - _onRefresh():" + e.toString());
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
                    height: 110,
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
      print("Exception - couponListScreen.dart - _shimmer():" + e.toString());
      return SizedBox();
    }
  }
}
