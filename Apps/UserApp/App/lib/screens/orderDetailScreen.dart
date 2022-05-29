import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/orderModel.dart';
import 'package:gomeat/screens/cancelOrderScreen.dart';
import 'package:gomeat/screens/checkOutScreen.dart';
import 'package:gomeat/screens/mapScreen.dart';
import 'package:gomeat/screens/productDetailScreen.dart';
import 'package:gomeat/screens/rateOrderScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrderDetailScreen extends BaseRoute {
  final Order order;
  OrderDetailScreen(this.order, {a, o}) : super(a: a, o: o, r: 'OrderDetailScreen');
  @override
  _OrderDetailScreenState createState() => new _OrderDetailScreenState(this.order);
}

class _OrderDetailScreenState extends BaseRouteState {
  Order order;

  GlobalKey<ScaffoldState> _scaffoldKey;
  _OrderDetailScreenState(this.order) : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
          title: Text("#${order.cartId} - ${AppLocalizations.of(context).tle_order_details}"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.44,
                  child: ListView.builder(
                    itemCount: order.productList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProductDetailScreen(varientId: order.productList[index].varientId, a: widget.analytics, o: widget.observer),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 110,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardTheme.color,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20, left: 130),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: global.isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            '${order.productList[index].productName}',
                                            style: Theme.of(context).primaryTextTheme.bodyText1,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '${order.productList[index].type}',
                                          style: Theme.of(context).primaryTextTheme.headline2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        RichText(
                                            text: TextSpan(text: "${global.appInfo.currencySign} ", style: Theme.of(context).primaryTextTheme.headline2, children: [
                                          TextSpan(
                                            text: '${order.productList[index].price}',
                                            style: Theme.of(context).primaryTextTheme.bodyText1,
                                          ),
                                          TextSpan(
                                            text: ' / ${order.productList[index].quantity} ${order.productList[index].unit}',
                                            style: Theme.of(context).primaryTextTheme.headline2,
                                          )
                                        ])),
                                        order.productList[index].rating != null && order.productList[index].rating > 0
                                            ? Padding(
                                                padding: EdgeInsets.only(top: 4.0),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Theme.of(context).primaryColorLight,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: "${order.productList[index].rating} ",
                                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                                        children: [
                                                          TextSpan(
                                                            text: '|',
                                                            style: Theme.of(context).primaryTextTheme.headline2,
                                                          ),
                                                          TextSpan(
                                                            text: ' ${order.productList[index].ratingCount} ${AppLocalizations.of(context).txt_ratings}',
                                                            style: Theme.of(context).primaryTextTheme.headline1,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              order.orderStatus == 'Completed'
                                  ? Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => RateOrderScreen(order, index, a: widget.analytics, o: widget.observer),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              // width: 60,
                                              height: 25,
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
                                                  // width: 60,
                                                  height: 25,
                                                  alignment: Alignment.center,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 5, right: 5),
                                                    child: Text(
                                                      order.productList[index].userRating != null && order.productList[index].userRating.toDouble() > 0.0 ? "Edit Rating" : "Add Rating",
                                                      style: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                                    ),
                                                  )),
                                            ),
                                          ),
                                          order.productList[index].userRating != null && order.productList[index].userRating.toDouble() > 0.0
                                              ? Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Theme.of(context).primaryColorLight,
                                                    ),
                                                    Text(
                                                      "${order.productList[index].userRating} ",
                                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                                    ),
                                                  ],
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                    )
                                  : SizedBox(),
                              Positioned(
                                left: 0,
                                top: -10,
                                child: order.productList[index].varientImage != null
                                    ? Container(
                                        child: CachedNetworkImage(
                                          imageUrl: global.appInfo.imageUrl + order.productList[index].varientImage,
                                          imageBuilder: (context, imageProvider) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Visibility(
                                              visible: false,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(color: Theme.of(context).primaryColorLight.withOpacity(0.5), borderRadius: BorderRadius.circular(15)),
                                                child: Container(
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  child: Text(
                                                    '${AppLocalizations.of(context).txt_out_of_stock}',
                                                    style: Theme.of(context).primaryTextTheme.headline2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => Container(
                                            child: Visibility(
                                              visible: false,
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(color: Theme.of(context).primaryColorLight.withOpacity(0.5), borderRadius: BorderRadius.circular(15)),
                                                child: Container(
                                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  child: Text(
                                                    '${AppLocalizations.of(context).txt_out_of_stock}',
                                                    style: Theme.of(context).primaryTextTheme.headline2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: AssetImage('${global.defaultImage}'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        height: 100,
                                        width: 120,
                                      )
                                    : Container(
                                        height: 100,
                                        width: 120,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          image: DecorationImage(
                                            image: AssetImage('${global.defaultImage}'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                    height: 30,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        stops: [0, .90],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${order.productList[index].cartQty}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Theme.of(context).primaryTextTheme.caption.color),
                                    )),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "${AppLocalizations.of(context).lbl_payment_method}",
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  trailing: Text(
                    "${order.paymentMethod}",
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "${AppLocalizations.of(context).txt_delivery_details}",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "${AppLocalizations.of(context).lbl_date}",
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                  trailing: Text(
                    "${order.deliveryDate}",
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                ),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "${AppLocalizations.of(context).txt_time}",
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                  trailing: Text(
                    "${order.timeSlot}",
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                ),
                Divider(),
                ListTile(
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "${AppLocalizations.of(context).lbl_delivery_address}",
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                ),
                Text(
                  "${order.deliveryAddress}",
                  style: Theme.of(context).primaryTextTheme.overline,
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "${AppLocalizations.of(context).lbl_price_details}",
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context).txt_total_price}",
                      style: Theme.of(context).primaryTextTheme.overline,
                    ),
                    Text(
                      "${global.appInfo.currencySign} ${order.totalProductMrp}",
                      style: Theme.of(context).primaryTextTheme.overline,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${AppLocalizations.of(context).txt_discount_price}",
                        style: Theme.of(context).primaryTextTheme.overline,
                      ),
                      Text(
                        " - ${global.appInfo.currencySign} ${order.discountonmrp}",
                        style: Theme.of(context).primaryTextTheme.headline2.copyWith(color: Colors.blue),
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
                        "${AppLocalizations.of(context).txt_coupon_discount}",
                        style: Theme.of(context).primaryTextTheme.overline,
                      ),
                      Text(
                        " - ${order.couponDiscount}",
                        style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Theme.of(context).primaryColorLight),
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
                        "${AppLocalizations.of(context).txt_delivery_charges}",
                        style: Theme.of(context).primaryTextTheme.overline,
                      ),
                      Text(
                        "${global.appInfo.currencySign} ${order.deliveryCharge}",
                        style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Colors.blue),
                      )
                    ],
                  ),
                ),
                order.paidByWallet > 0
                    ? Padding(
                        padding: EdgeInsets.only(top: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${AppLocalizations.of(context).lbl_paid_by_wallet}",
                              style: Theme.of(context).primaryTextTheme.overline,
                            ),
                            Text(
                              "${global.appInfo.currencySign} ${order.paidByWallet}",
                              style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Colors.blue),
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${AppLocalizations.of(context).txt_tax}",
                        style: Theme.of(context).primaryTextTheme.overline,
                      ),
                      Text(
                        "${global.appInfo.currencySign} ${order.totaltaxprice}",
                        style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Colors.blue),
                      )
                    ],
                  ),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 0,
                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  minLeadingWidth: 30,
                  contentPadding: EdgeInsets.all(0),
                  leading: Text(
                    "${AppLocalizations.of(context).lbl_total_amount}",
                    style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
                  ),
                  trailing: Text(
                    "${global.appInfo.currencySign} ${order.remPrice}",
                    style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context).txt_status}",
                      style: Theme.of(context).primaryTextTheme.overline,
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      order.orderStatus == 'Cancelled' ? MdiIcons.closeOctagon : MdiIcons.checkDecagram,
                      size: 20,
                      color: order.orderStatus == 'Cancelled'
                          ? Colors.red
                          : order.orderStatus == 'Completed'
                              ? Colors.greenAccent
                              : order.orderStatus == 'Confirmed'
                                  ? Colors.blue
                                  : order.orderStatus == 'Pending'
                                      ? Colors.yellow
                                      : Theme.of(context).primaryColorLight,
                    ),
                    Text(
                      order.orderStatus,
                      style: Theme.of(context).primaryTextTheme.overline,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
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
                          await _trackOrder();
                        },
                        child: Text(
                          '${AppLocalizations.of(context).tle_track_order}',
                        )),
                  ),
                ),
              ],
            ),
            order.orderStatus == 'Pending' || order.orderStatus == 'Completed' || order.orderStatus == 'Confirmed'
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
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
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
  }

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
              Navigator.of(context).push(
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
