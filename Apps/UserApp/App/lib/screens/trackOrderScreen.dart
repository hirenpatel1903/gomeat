import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/orderModel.dart';
import 'package:gomeat/screens/mapScreen.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

class StatusList {
  String orderStatus;
  String message;
  DateTime time;
  StatusList({
    this.orderStatus,
    this.message,
    this.time,
  });
}

class TrackOrderScreen extends BaseRoute {
  final int screenId;
  final String cartId;
  TrackOrderScreen(this.cartId, this.screenId, {a, o}) : super(a: a, o: o, r: 'TrackOrderScreen');
  @override
  _TrackOrderScreenState createState() => new _TrackOrderScreenState(this.cartId, this.screenId);
}

class _TrackOrderScreenState extends BaseRouteState {
  String cartId;
  int screenId;
  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;

  Order order = new Order();

  int _processIndex = 0;
  Color completeColor = Color(0xff5e6172);
  Color inProgressColor = Color(0xff5ec792);
  Color todoColor = Color(0xffd1d2d7);
  List<StatusList> _statusList = [];
  _TrackOrderScreenState(this.cartId, this.screenId) : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          if (screenId == 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BottomNavigationWidget(a: widget.analytics, o: widget.observer),
              ),
            );
          } else {
            Navigator.of(context).pop();
          }

          return null;
        },
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: _isDataLoaded ? Color(0xFF5c7de0) : null,
          appBar: AppBar(
            leading: InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onTap: () {
                if (screenId == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => BottomNavigationWidget(a: widget.analytics, o: widget.observer),
                    ),
                  );
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Icon(MdiIcons.arrowLeft),
              ),
            ),
            backgroundColor: global.isDarkModeEnable ? Color(0xFF2A2D3F) : Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            title: Text("${AppLocalizations.of(context).tle_track_order} "),
          ),
          body: _isDataLoaded
              ? Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MapScreen(
                                  order,
                                  a: widget.analytics,
                                  o: widget.observer,
                                )));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height - 180,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30)),
                            image: DecorationImage(
                              image: AssetImage('assets/mapScreen.png'),
                              colorFilter: const ColorFilter.mode(
                                Colors.black54,
                                BlendMode.saturation,
                              ),
                              fit: BoxFit.fill,
                            )),
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.navigate_next),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 280,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(8),
                      decoration: global.isDarkModeEnable
                          ? BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                              ),
                              gradient: LinearGradient(
                                stops: [0, 0.65],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFF2A2D3F), Color(0xFF111127)],
                              ),
                            )
                          : BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(40),
                              ),
                            ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            order.esimateTime != null
                                ? Text(
                                    "${AppLocalizations.of(context).txt_estimate_time}: ${order.esimateTime}",
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  )
                                : SizedBox(),
                            order.esimateTime != null
                                ? Divider(
                                    color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color : Color(0xFFDFE8EF),
                                  )
                                : SizedBox(),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context).lbl_order_id}",
                                    style: Theme.of(context).primaryTextTheme.headline2,
                                  ),
                                  Text(
                                    "#${order.cartId}",
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context).lbl_order_place_on}",
                                    style: Theme.of(context).primaryTextTheme.headline2,
                                  ),
                                  Text(
                                    "${order.orderDate}",
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context).txt_date_of_delivery}",
                                    style: Theme.of(context).primaryTextTheme.headline2,
                                  ),
                                  Text(
                                    "${order.deliveryDate},${order.timeSlot}",
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0, bottom: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${AppLocalizations.of(context).lbl_total_amount}",
                                    style: Theme.of(context).primaryTextTheme.headline2,
                                  ),
                                  Text(
                                    "${global.appInfo.currencySign} ${order.remPrice}",
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color : Color(0xFFDFE8EF),
                            ),
                            FixedTimeline.tileBuilder(
                              theme: TimelineThemeData(
                                direction: Axis.vertical,
                                nodePosition: 0.1,
                                color: Color(0xff989898),
                                indicatorTheme: IndicatorThemeData(
                                  position: 0.5,
                                  size: 18.0,
                                ),
                                connectorTheme: ConnectorThemeData(
                                  thickness: 2.5,
                                ),
                              ),
                              builder: TimelineTileBuilder.connected(
                                itemExtentBuilder: (_, index) => 50.0,
                                connectionDirection: ConnectionDirection.before,
                                itemCount: _statusList.length,
                                contentsAlign: ContentsAlign.basic,
                                contentsBuilder: (_, index) {
                                  return Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${_statusList[index].message}",
                                              textAlign: TextAlign.left,
                                              style: order.orderStatus == _statusList[index].orderStatus ? Theme.of(context).primaryTextTheme.bodyText1 : Theme.of(context).primaryTextTheme.headline2,
                                            ),
                                          ),
                                          _statusList[index].time != null
                                              ? Text("${DateFormat('hh.mm a').format(_statusList[index].time)} \n${DateFormat('dd.MM.yyyy').format(_statusList[index].time)}",
                                                  textAlign: TextAlign.right, style: order.orderStatus == _statusList[index].orderStatus ? Theme.of(context).primaryTextTheme.bodyText1 : Theme.of(context).primaryTextTheme.headline2)
                                              : SizedBox(),
                                        ],
                                      ));
                                },
                                indicatorBuilder: (_, index) {
                                  if (order.orderStatus == _statusList[index].orderStatus) {
                                    return DotIndicator(
                                      color: order.orderStatus == "Cancelled" ? Colors.red : Colors.green,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12.0,
                                      ),
                                    );
                                  } else if (index < _statusList.indexWhere((e) => e.orderStatus == order.orderStatus)) {
                                    return DotIndicator(
                                      color: Colors.black,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12.0,
                                      ),
                                    );
                                  } else {
                                    return DotIndicator(
                                      color: Theme.of(context).primaryTextTheme.headline2.color,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12.0,
                                      ),
                                    );
                                  }
                                },
                                connectorBuilder: (_, index, ___) => DashedLineConnector(
                                  dash: 5,
                                  color: order.orderStatus == _statusList[index].orderStatus
                                      ? order.orderStatus == "Cancelled"
                                          ? Colors.red
                                          : Colors.green
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: (MediaQuery.of(context).size.height - 180 - 30 - (MediaQuery.of(context).size.height - 280)) * 0.5,
                      right: 20,
                      child: Container(
                        height: 28,
                        width: 28,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)), color: Theme.of(context).primaryColor),
                        child: Icon(
                          FontAwesomeIcons.locationArrow,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                    ),
                  ],
                )
              : _shimmerList(),
          bottomNavigationBar: _isDataLoaded
              ? Container(
                  height: 85,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            bottom: 25,
                            left: 5,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 41,
                              child: Center(
                                child: Icon(
                                  MdiIcons.bike,
                                  size: 41,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(left: 80.0, bottom: 10),
                              child: ListTile(
                                minLeadingWidth: 2,
                                title: Text(
                                  "${order.dboyName != null ? order.dboyName : 'Delivery Boy'}",
                                  style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Colors.white),
                                ),
                                subtitle: Text(
                                  "${order.dboyPhone != null ? order.dboyPhone : 'No Contact Available'}",
                                  style: Theme.of(context).primaryTextTheme.headline2.copyWith(color: Colors.white),
                                ),
                                trailing: order.dboyPhone != null
                                    ? Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () async {
                                                await _launchCaller(order.dboyPhone);
                                              },
                                              icon: Icon(Icons.call, color: Colors.white)),
                                          IconButton(
                                            onPressed: () async {
                                              await textMe(order.dboyPhone);
                                            },
                                            icon: Icon(Icons.message_outlined, color: Colors.white),
                                          ),
                                        ],
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    try {
      await _trackOrder();

      if (order.orderStatus == "Cancelled") {
        _statusList.add(StatusList(
          orderStatus: 'Cancelled',
          time: order.cancelledTime,
          message: 'Cancelled',
        ));
        _statusList.add(StatusList(
          orderStatus: 'Pending',
          time: order.placingTime,
          message: '${AppLocalizations.of(context).lbl_order_added_to_cart}',
        ));
      } else {
        _statusList.add(StatusList(
          orderStatus: 'Completed',
          time: order.completedTime,
          message: '${AppLocalizations.of(context).lbl_order_deliver}',
        ));
        _statusList.add(StatusList(
          orderStatus: 'Out_For_Delivery',
          time: order.outOfDeliveryTime,
          message: '${AppLocalizations.of(context).lbl_out_of_delivery}',
        ));

        _statusList.add(StatusList(
          orderStatus: 'Confirmed',
          time: order.confirmTime,
          message: '${AppLocalizations.of(context).lbl_order_confirmed}',
        ));
        _statusList.add(StatusList(
          orderStatus: 'Pending',
          time: order.placingTime,
          message: '${AppLocalizations.of(context).lbl_order_added_to_cart}',
        ));
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception -  TrackOrderScreen.dart - _init():" + e.toString());
    }
  }

  _launchCaller(String phone) async {
    String url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _shimmerList() {
    try {
      return ListView.builder(
        itemCount: 1,
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
                    height: MediaQuery.of(context).size.height - 280,
                    width: MediaQuery.of(context).size.width,
                    child: Card(),
                  ),
                  Divider(),
                  SizedBox(
                    height: 105,
                    width: MediaQuery.of(context).size.width,
                    child: Card(),
                  ),
                  Divider(),
                  SizedBox(
                    height: 85,
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
      print("Exception - aboutUsAndTermsOfServiceScreen.dart - _shimmerList():" + e.toString());
      return SizedBox();
    }
  }

  _trackOrder() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.trackOrder(cartId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              order = result.data;
            } else {
              showSnackBar(key: _scaffoldKey, snackBarMessage: result.message);
              order = null;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception -  TrackOrderScreen.dart - _trackOrder():" + e.toString());
    }
  }
}
