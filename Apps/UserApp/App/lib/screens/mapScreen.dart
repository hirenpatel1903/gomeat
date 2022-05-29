import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/orderModel.dart';
import 'package:gomeat/screens/cancelOrderScreen.dart';
import 'package:gomeat/screens/checkOutScreen.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timelines/timelines.dart';

class BezierPainter extends CustomPainter {
  final Color color;

  final bool drawStart;
  final bool drawEnd;
  const BezierPainter({
    this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(BezierPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.drawStart != drawStart || oldDelegate.drawEnd != drawEnd;
  }

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }
}

class MapScreen extends BaseRoute {
  final Order order;

  MapScreen(this.order, {a, o}) : super(a: a, o: o, r: 'MapScreen');
  @override
  _MapScreenState createState() => new _MapScreenState(this.order);
}

class _MapScreenState extends BaseRouteState {
  GoogleMapController mapController;
  CameraPosition _initialLocation = CameraPosition(target: LatLng(global.lat, global.lng));

  Completer<GoogleMapController> _controller = Completer();

  Order order;

  String bicycleTime;
  String drivingTime;
  String trainTime;
  String walkingTime;
  Set<Marker> markers = {};
  bool _isDataLoaded = false;
  PolylinePoints polylinePoints;

  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> _processes = [];
  int _processIndex = 0;

  Color completeColor = Color(0xff5e6172);
  Color inProgressColor = Color(0xff5ec792);

  Color todoColor = Color(0xffd1d2d7);
  List<Circle> circleList = [];
  _MapScreenState(this.order) : super();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Container(
          height: height,
          width: width,
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
              backgroundColor: global.isDarkModeEnable ? Color(0xFF2A2D3F) : Theme.of(context).scaffoldBackgroundColor,
              centerTitle: true,
              title: Text("${AppLocalizations.of(context).lbl_map}"),
              actions: [
                IconButton(
                    onPressed: () async {
                      await _trackOrder();
                    },
                    icon: Icon(
                      MdiIcons.syncIcon,
                      color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                    )),
              ],
            ),
            body: _isDataLoaded
                ? Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      // Map View
                      GoogleMap(
                        markers: Set<Marker>.from(markers),
                        circles: Set<Circle>.from(circleList),
                        initialCameraPosition: _initialLocation,
                        myLocationEnabled: false,
                        myLocationButtonEnabled: false,
                        mapType: MapType.terrain,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        polylines: Set<Polyline>.of(polylines.values),
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);

                          setState(() {});
                        },
                      ),

                      order.esimateTime != null
                          ? Container(
                              padding: EdgeInsets.all(2),
                              width: 100,
                              height: 25,
                              margin: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: global.isDarkModeEnable ? Colors.black : Colors.white,
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  width: 100,
                                  height: 25,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "ETA: ${order.esimateTime}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                  )),
                            )
                          : SizedBox()

                      //   showing the route
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            bottomNavigationBar: Container(
              width: width,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: 130,
                    child: Timeline.tileBuilder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      theme: TimelineThemeData(
                        direction: Axis.horizontal,
                        connectorTheme: ConnectorThemeData(
                          space: 30.0,
                          thickness: 5.0,
                        ),
                      ),
                      builder: TimelineTileBuilder.connected(
                        connectionDirection: ConnectionDirection.before,
                        itemExtentBuilder: (_, __) => MediaQuery.of(context).size.width / _processes.length,
                        contentsBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(_processes[index] == 'Out_For_Delivery' ? 'Out For\nDelivery' : _processes[index], style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: getColor(index))),
                          );
                        },
                        indicatorBuilder: (_, index) {
                          var color;
                          var child;
                          if (index == _processIndex) {
                            color = inProgressColor;
                            child = _processes[index] == 'Completed'
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 15.0,
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                      valueColor: AlwaysStoppedAnimation(Colors.white),
                                    ),
                                  );
                          } else if (index < _processIndex) {
                            color = completeColor;
                            child = Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15.0,
                            );
                          } else {
                            color = todoColor;
                          }

                          if (index <= _processIndex) {
                            return Stack(
                              children: [
                                CustomPaint(
                                  size: Size(25.0, 25.0),
                                  painter: BezierPainter(
                                    color: color,
                                    drawStart: index > 0,
                                    drawEnd: index < _processIndex,
                                  ),
                                ),
                                DotIndicator(
                                  size: 25.0,
                                  color: color,
                                  child: child,
                                ),
                              ],
                            );
                          } else {
                            return Stack(
                              children: [
                                CustomPaint(
                                  size: Size(15.0, 15.0),
                                  painter: BezierPainter(
                                    color: color,
                                    drawEnd: index < _processes.length - 1,
                                  ),
                                ),
                                OutlinedDotIndicator(
                                  borderWidth: 4.0,
                                  color: color,
                                ),
                              ],
                            );
                          }
                        },
                        connectorBuilder: (_, index, type) {
                          if (index > 0) {
                            if (index == _processIndex) {
                              final prevColor = getColor(index - 1);
                              final color = getColor(index);
                              List<Color> gradientColors;
                              if (type == ConnectorType.start) {
                                gradientColors = [Color.lerp(prevColor, color, 0.5), color];
                              } else {
                                gradientColors = [prevColor, Color.lerp(prevColor, color, 0.5)];
                              }
                              return DecoratedLineConnector(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradientColors,
                                  ),
                                ),
                              );
                            } else {
                              return SolidLineConnector(
                                color: getColor(index),
                              );
                            }
                          } else {
                            return null;
                          }
                        },
                        itemCount: _processes.length,
                      ),
                    ),
                  ),
                  order.orderStatus == 'Out_For_Delivery'
                      ? ListTile(
                          minLeadingWidth: 2,
                          title: Text(
                            "${order.dboyName != null ? order.dboyName : 'Delivery Boy'}",
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                          subtitle: Text(
                            "${order.dboyPhone != null ? order.dboyPhone : 'No Contact Available'}",
                            style: Theme.of(context).primaryTextTheme.headline2,
                          ),
                          trailing: order.dboyPhone != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await launchCaller(order.dboyPhone);
                                        },
                                        icon: Icon(Icons.call, color: Theme.of(context).primaryTextTheme.bodyText1.color)),
                                    IconButton(
                                      onPressed: () async {
                                        await textMe(order.dboyPhone);
                                      },
                                      icon: Icon(Icons.message_outlined, color: Theme.of(context).primaryTextTheme.bodyText1.color),
                                    ),
                                  ],
                                )
                              : null,
                        )
                      : order.orderStatus == 'Pending' || order.orderStatus == 'Confirmed' || order.orderStatus == 'Completed'
                          ? Container(
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
                                    if (order.orderStatus == 'Pending' || order.orderStatus == 'Confirmed') {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CancelOrderScreen(a: widget.analytics, o: widget.observer, order: order),
                                        ),
                                      );
                                    } else {
                                      // reorder
                                      await _reOrder();
                                    }
                                  },
                                  child: Text(
                                    order.orderStatus == 'Pending' || order.orderStatus == 'Confirmed' ? '${AppLocalizations.of(context).tle_cancel_order}' : '${AppLocalizations.of(context).btn_re_order}',
                                  )),
                            )
                          : Container(
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
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => BottomNavigationWidget(a: widget.analytics, o: widget.observer),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Browse More',
                                  )),
                            )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/scooter.png");
    return byteData.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();

    if (order.orderStatus == "Cancelled") {
      _processes.add('Pending');
      _processes.add('Cancelled');
    } else {
      _processes.add('Pending');
      _processes.add('Confirmed');
      _processes.add('Out_For_Delivery');
      _processes.add('Completed');
    }

    updateMarker();
    _processIndex = _processes.indexOf(order.orderStatus);
    _init();
  }

  Future<bool> updateMarker() async {
    try {
      if (markers.isNotEmpty) markers.clear();
      if (polylines.isNotEmpty) polylines.clear();
      if (polylineCoordinates.isNotEmpty) polylineCoordinates.clear();

      double startLatitude = order.storeLat;
      double startLongitude = order.storeLng;

      String destinationCoordinatesString = '(${order.userLat}, ${order.userLng})';
      String startCoordinatesString = '($startLatitude, $startLongitude)';

      // Start - Store Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(180),
      );
      mapController = await _controller.future;

      // Desitination - user  Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(order.userLat, order.userLng),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);

      if (order.currentLng != null && order.currentLat != null) {
        print("delivery boy location - ${order.currentLng} - ${order.currentLat}");
        markers.add(
          Marker(
            markerId: MarkerId("home"),
            position: LatLng(order.currentLat, order.currentLng),
            draggable: false,
            zIndex: 2,
            flat: true,
            anchor: Offset(0.5, 0.5),
            icon: BitmapDescriptor.fromBytes(
              await getMarker(),
            ),
          ),
        );
        circleList.add(
          Circle(
            circleId: CircleId("car"),
            zIndex: 1,
            strokeColor: Colors.blue,
            center: LatLng(order.currentLat, order.currentLng),
            fillColor: Colors.blue.withAlpha(70),
          ),
        );
      }
      markers.add(destinationMarker);

      double miny = (order.userLat <= startLatitude) ? order.userLat : startLatitude;
      double minx = (order.userLng <= startLongitude) ? order.userLng : startLongitude;
      double maxy = (order.userLat <= startLatitude) ? startLatitude : order.userLat;
      double maxx = (order.userLng <= startLongitude) ? startLongitude : order.userLng;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;
      Future.value(markers);
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          new LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          50.0,
        ),
      );

      try {
        await _createPolylines(order.userLat, order.userLng, startLatitude, startLongitude);
      } catch (e) {
        print("MAP Exeption - mapScreen.dart - updateMarker() - _createPolylines" + e.toString());
      }

      return true;
    } catch (e) {
      print('MAP Exception - mapScreen.dart - updateMarker():' + e.toString());
    }
    return false;
  }

  _createPolylines(double startLatitude, double startLongitude, double destinationLatitude, double destinationLongitude) async {
    try {
      polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        global.googleMap.mapApiKey, //Google Maps API Key

        PointLatLng(startLatitude, startLongitude),
        PointLatLng(destinationLatitude, destinationLongitude),
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        });
      }

      PolylineId id = PolylineId('poly1');
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );
      polylines[id] = polyline;
      setState(() {});
    } catch (e) {
      print("MAP Exception - mapScreen.dart - _createPolylines():" + e.toString());
    }
  }

  _init() async {
    try {
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("MAP Exception - mapScreen.dart - _init():" + e.toString());
    }
  }

  // Create the polylines for showing the route between two places
  _reOrder() async {
    try {
      bool _isConnected = await br.checkConnectivity();
      if (_isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.reorder(order.cartId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(a: widget.analytics, o: widget.observer),
                ),
              );
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - orderDetailScreen.dart - _reOrder():" + e.toString());
    }
  }

  _trackOrder() async {
    try {
      bool _isConnected = await br.checkConnectivity();
      if (_isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.trackOrder(order.cartId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              Order _tOrder = new Order();
              _tOrder = result.data;
              hideLoader();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MapScreen(_tOrder, a: widget.analytics, o: widget.observer),
                ),
              );
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: result.message);
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - orderDetailScreen.dart - _trackOrder(): " + e.toString());
    }
  }
}
