import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/orderModel.dart';
import 'package:gomeat/screens/orderDetailScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class OrderListScreen extends BaseRoute {
  OrderListScreen({a, o}) : super(a: a, o: o, r: 'OrderListScreen');
  @override
  _OrderListScreenState createState() => new _OrderListScreenState();
}

class _OrderListScreenState extends BaseRouteState {
  bool _isDataLoaded = false;

  List<Order> _allOrderList = [];
  List<Order> _onGoingOrderList = [];
  List<Order> _completedOrdeList = [];

  bool _isAllOrderPending = true;
  bool _isOngoingOrderPending = true;
  bool _isCompletedOrderPending = true;

  bool _isAllOrderMoreDataLoaded = false;
  bool _isOngoingOrderMoreDataLoaded = false;
  bool _isCompletedOrderMoreDataLoaded = false;

  int _allOrderPage = 1;
  int _onGoingOrderPage = 1;
  int _completedOrderPage = 1;

  ScrollController _allOrderScrollController = ScrollController();
  ScrollController _ongoingScrollController = ScrollController();
  ScrollController _completedScrollController = ScrollController();

  _OrderListScreenState() : super();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
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
            title: Text("${AppLocalizations.of(context).tle_my_order}"),
          ),
          body: RefreshIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              _isDataLoaded = false;
              _isAllOrderPending = true;
              _isOngoingOrderPending = true;
              _isCompletedOrderPending = true;
              setState(() {});
              _allOrderList.clear();
              _onGoingOrderList.clear();
              _completedOrdeList.clear();

              await _init();
              return null;
            },
            child: _isDataLoaded
                ? Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 50,
                            child: AppBar(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              backgroundColor: global.isDarkModeEnable ? Color(0xFF435276) : Color(0xFFEDF2F6),
                              bottom: TabBar(
                                indicator: UnderlineTabIndicator(
                                  borderSide: BorderSide(
                                    width: 3.0,
                                    color: global.isDarkModeEnable ? Theme.of(context).primaryColor : Color(0xFFEF5656),
                                  ),
                                  insets: EdgeInsets.symmetric(horizontal: 8.0),
                                ),
                                labelColor: global.isDarkModeEnable ? Colors.white : Colors.black,
                                indicatorWeight: 4,
                                unselectedLabelStyle: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.w400),
                                labelStyle: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorColor: global.isDarkModeEnable ? Theme.of(context).primaryColor : Color(0xFFEF5656),
                                tabs: [
                                  Tab(
                                      child: Text(
                                    '${AppLocalizations.of(context).lbl_all_orders}',
                                  )),
                                  Tab(
                                      child: Text(
                                    '${AppLocalizations.of(context).lbl_scheduled}',
                                  )),
                                  Tab(
                                      child: Text(
                                    '${AppLocalizations.of(context).lbl_previous}',
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            _allOrders(),
                            _onGoingOrder(),
                            _completedOrder(),
                          ],
                        ),
                      ),
                    ],
                  )
                : _shimmerWidget(),
          ),
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

  Widget _allOrders() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _allOrderList.length > 0
          ? SingleChildScrollView(
              controller: _allOrderScrollController,
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _allOrderList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OrderDetailScreen(_allOrderList[index], a: widget.analytics, o: widget.observer),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        color: global.isDarkModeEnable ? Color(0xFF373C58) : Color(0xFFF2F5F8),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      child: Text(
                                        _allOrderList[index].cartId,
                                        style: Theme.of(context).primaryTextTheme.headline2,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Icon(
                                      _allOrderList[index].orderStatus == 'Cancelled' ? MdiIcons.closeOctagon : MdiIcons.checkDecagram,
                                      size: 20,
                                      color: _allOrderList[index].orderStatus == 'Cancelled'
                                          ? Colors.red
                                          : _allOrderList[index].orderStatus == 'Completed'
                                              ? Colors.greenAccent
                                              : _allOrderList[index].orderStatus == 'Confirmed'
                                                  ? Colors.blue
                                                  : _allOrderList[index].orderStatus == 'Pending'
                                                      ? Colors.yellow
                                                      : Theme.of(context).primaryColorLight,
                                    ),
                                    Padding(
                                      padding: global.isRTL ? EdgeInsets.only(right: 8) : EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _allOrderList[index].orderStatus,
                                        style: Theme.of(context).primaryTextTheme.headline2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -3, horizontal: -4),
                                contentPadding: EdgeInsets.all(0),
                                minLeadingWidth: 0,
                                title: Text(
                                  _allOrderList[index].userName,
                                  style: Theme.of(context).primaryTextTheme.bodyText1,
                                ),
                                subtitle: Text(
                                  _allOrderList[index].timeSlot + ' | ' + _allOrderList[index].deliveryDate,
                                  style: Theme.of(context).primaryTextTheme.headline2,
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${global.appInfo.currencySign} ${_allOrderList[index].remPrice > 0 ? _allOrderList[index].remPrice : _allOrderList[index].paidByWallet}",
                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                    ),
                                    Text(
                                      "${_allOrderList[index].paymentMethod}",
                                      style: Theme.of(context).primaryTextTheme.headline2.copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color.withOpacity(0.05) : Theme.of(context).dividerTheme.color,
                              ),
                            ],
                          ),
                        );
                      }),
                  _isAllOrderMoreDataLoaded
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : SizedBox()
                ],
              ),
            )
          : Center(
              child: Text(
                "${AppLocalizations.of(context).txt_nothing_to_show}",
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
    );
  }

  Widget _completedOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _completedOrdeList.length > 0
          ? SingleChildScrollView(
              controller: _completedScrollController,
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _completedOrdeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OrderDetailScreen(_completedOrdeList[index], a: widget.analytics, o: widget.observer),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        color: global.isDarkModeEnable ? Color(0xFF373C58) : Color(0xFFF2F5F8),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      child: Text(
                                        _completedOrdeList[index].cartId,
                                        style: Theme.of(context).primaryTextTheme.headline2,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Icon(
                                      _completedOrdeList[index].orderStatus == 'Cancelled' ? MdiIcons.closeOctagon : MdiIcons.checkDecagram,
                                      size: 20,
                                      color: _completedOrdeList[index].orderStatus == 'Cancelled'
                                          ? Colors.red
                                          : _completedOrdeList[index].orderStatus == 'Completed'
                                              ? Colors.greenAccent
                                              : _completedOrdeList[index].orderStatus == 'Confirmed'
                                                  ? Colors.blue
                                                  : _completedOrdeList[index].orderStatus == 'Pending'
                                                      ? Colors.yellow
                                                      : Theme.of(context).primaryColorLight,
                                    ),
                                    Padding(
                                      padding: global.isRTL ? EdgeInsets.only(right: 8) : EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _completedOrdeList[index].orderStatus,
                                        style: Theme.of(context).primaryTextTheme.headline2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -3, horizontal: -4),
                                contentPadding: EdgeInsets.all(0),
                                minLeadingWidth: 0,
                                title: Text(
                                  _completedOrdeList[index].userName,
                                  style: Theme.of(context).primaryTextTheme.bodyText1,
                                ),
                                subtitle: Text(
                                  _completedOrdeList[index].timeSlot + ' | ' + _completedOrdeList[index].deliveryDate,
                                  style: Theme.of(context).primaryTextTheme.headline2,
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${global.appInfo.currencySign} ${_completedOrdeList[index].remPrice > 0 ? _completedOrdeList[index].remPrice : _completedOrdeList[index].paidByWallet}",
                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                    ),
                                    Text(
                                      "${_completedOrdeList[index].paymentMethod}",
                                      style: Theme.of(context).primaryTextTheme.headline2.copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color.withOpacity(0.05) : Theme.of(context).dividerTheme.color,
                              ),
                            ],
                          ),
                        );
                      }),
                  _isCompletedOrderMoreDataLoaded
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : SizedBox()
                ],
              ),
            )
          : Center(
              child: Text(
                "${AppLocalizations.of(context).txt_nothing_to_show}",
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
    );
  }

  _init() async {
    try {
      await _getAllOrder();
      await _getOnGoingOrder();
      await _getCompletedOrder();
      _allOrderScrollController.addListener(() async {
        if (_allOrderScrollController.position.pixels == _allOrderScrollController.position.maxScrollExtent && !_isAllOrderMoreDataLoaded) {
          setState(() {
            _isAllOrderMoreDataLoaded = true;
          });
          await _getAllOrder();
          setState(() {
            _isAllOrderMoreDataLoaded = false;
          });
        }
      });

      _ongoingScrollController.addListener(() async {
        if (_ongoingScrollController.position.pixels == _ongoingScrollController.position.maxScrollExtent && !_isOngoingOrderMoreDataLoaded) {
          setState(() {
            _isOngoingOrderMoreDataLoaded = true;
          });
          await _getOnGoingOrder();
          setState(() {
            _isOngoingOrderMoreDataLoaded = false;
          });
        }
      });

      _completedScrollController.addListener(() async {
        if (_completedScrollController.position.pixels == _completedScrollController.position.maxScrollExtent && !_isCompletedOrderMoreDataLoaded) {
          setState(() {
            _isCompletedOrderMoreDataLoaded = true;
          });
          await _getCompletedOrder();
          setState(() {
            _isCompletedOrderMoreDataLoaded = false;
          });
        }
      });

      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - orderListScreen.dart - _init(): " + e.toString());
    }
  }

  _getAllOrder() async {
    try {
      if (_isAllOrderPending) {
        setState(() {
          _isAllOrderMoreDataLoaded = true;
        });
        if (_allOrderList.isEmpty) {
          _allOrderPage = 1;
        } else {
          _allOrderPage++;
        }
        await apiHelper.myOrders(_allOrderPage).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Order> _tList = result.data;
              if (_tList.isEmpty) {
                _isAllOrderPending = false;
              }
              _allOrderList.addAll(_tList);
              setState(() {
                _isAllOrderMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - orderListScreen.dart - _getAllOrder():" + e.toString());
    }
  }

  _getOnGoingOrder() async {
    try {
      if (_isOngoingOrderPending) {
        setState(() {
          _isOngoingOrderMoreDataLoaded = true;
        });
        if (_onGoingOrderList.isEmpty) {
          _onGoingOrderPage = 1;
        } else {
          _onGoingOrderPage++;
        }
        await apiHelper.ongoingOrder(_onGoingOrderPage).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Order> _tList = result.data;
              if (_tList.isEmpty) {
                _isOngoingOrderPending = false;
              }
              _onGoingOrderList.addAll(_tList);
              setState(() {
                _isOngoingOrderMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - orderListScreen.dart - _getOnGoingOrder():" + e.toString());
    }
  }

  _getCompletedOrder() async {
    try {
      if (_isCompletedOrderPending) {
        setState(() {
          _isCompletedOrderMoreDataLoaded = true;
        });
        if (_completedOrdeList.isEmpty) {
          _completedOrderPage = 1;
        } else {
          _completedOrderPage++;
        }
        await apiHelper.completedOrder(_completedOrderPage).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Order> _tList = result.data;
              if (_tList.isEmpty) {
                _isCompletedOrderPending = false;
              }
              _completedOrdeList.addAll(_tList);
              setState(() {
                _isCompletedOrderMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getSubcategoryProduct():" + e.toString());
    }
  }

  Widget _onGoingOrder() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _onGoingOrderList.length > 0
          ? SingleChildScrollView(
              controller: _ongoingScrollController,
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _onGoingOrderList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => OrderDetailScreen(_onGoingOrderList[index], a: widget.analytics, o: widget.observer),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 0.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                        color: global.isDarkModeEnable ? Color(0xFF373C58) : Color(0xFFF2F5F8),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      child: Text(
                                        _onGoingOrderList[index].cartId,
                                        style: Theme.of(context).primaryTextTheme.headline2,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Icon(
                                      _onGoingOrderList[index].orderStatus == 'Cancelled' ? MdiIcons.closeOctagon : MdiIcons.checkDecagram,
                                      size: 20,
                                      color: _onGoingOrderList[index].orderStatus == 'Cancelled'
                                          ? Colors.red
                                          : _onGoingOrderList[index].orderStatus == 'Completed'
                                              ? Colors.greenAccent
                                              : _onGoingOrderList[index].orderStatus == 'Confirmed'
                                                  ? Colors.blue
                                                  : _onGoingOrderList[index].orderStatus == 'Pending'
                                                      ? Colors.yellow
                                                      : Theme.of(context).primaryColorLight,
                                    ),
                                    Padding(
                                      padding: global.isRTL ? EdgeInsets.only(right: 8) : EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        _onGoingOrderList[index].orderStatus,
                                        style: Theme.of(context).primaryTextTheme.headline2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -3, horizontal: -4),
                                contentPadding: EdgeInsets.all(0),
                                minLeadingWidth: 0,
                                title: Text(
                                  _onGoingOrderList[index].userName,
                                  style: Theme.of(context).primaryTextTheme.bodyText1,
                                ),
                                subtitle: Text(
                                  _onGoingOrderList[index].timeSlot + ' | ' + _onGoingOrderList[index].deliveryDate,
                                  style: Theme.of(context).primaryTextTheme.headline2,
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "${global.appInfo.currencySign} ${_onGoingOrderList[index].remPrice > 0 ? _onGoingOrderList[index].remPrice : _onGoingOrderList[index].paidByWallet}",
                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                    ),
                                    Text(
                                      "${_onGoingOrderList[index].paymentMethod}",
                                      style: Theme.of(context).primaryTextTheme.headline2.copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color.withOpacity(0.05) : Theme.of(context).dividerTheme.color,
                              ),
                            ],
                          ),
                        );
                      }),
                  _isOngoingOrderMoreDataLoaded
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : SizedBox()
                ],
              ),
            )
          : Center(
              child: Text(
                "${AppLocalizations.of(context).txt_nothing_to_show}",
                style: Theme.of(context).primaryTextTheme.bodyText1,
              ),
            ),
    );
  }

  Widget _shimmerWidget() {
    try {
      return Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Card(),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Card(),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Card(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
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
                          child: SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Card(),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ));
    } catch (e) {
      print("Exception - walletScreen.dart - _shimmerWidget():" + e.toString());
      return SizedBox();
    }
  }
}
