import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/couponModel.dart';
import 'package:shimmer/shimmer.dart';

class OfferListScreen extends BaseRoute {
  OfferListScreen({a, o}) : super(a: a, o: o, r: 'OfferListScreen');
  @override
  _OfferListScreenState createState() => new _OfferListScreenState();
}

class _OfferListScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool _isDataLoaded = false;
  List<Coupon> _couponList = [];

  _OfferListScreenState() : super();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          leading: SizedBox(),
          title: Text("${AppLocalizations.of(context).lbl_offer}"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isDataLoaded
              ? global.nearStoreModel.id != null
                  ? _couponList.length > 0
                      ? RefreshIndicator(
                          onRefresh: () async {
                            _isDataLoaded = false;
                            setState(() {});
                            await _init();
                          },
                          child: ListView.builder(
                              itemCount: _couponList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.only(top: 10, bottom: 10),
                                    padding: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardTheme.color,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              child: CachedNetworkImage(
                                                imageUrl: global.appInfo.imageUrl + _couponList[index].couponImage,
                                                imageBuilder: (context, imageProvider) => Container(
                                                
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
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
                                              height: 90,
                                              width: 90,
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 6, right: 6),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${_couponList[index].couponCode}",
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(fontSize: 16, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
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
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(2),
                                              width: 100,
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
                                                  width: 100,
                                                  height: 30,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "${_couponList[index].couponCode}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(fontSize: 16, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ));
                              }),
                        )
                      : Center(
                          child: Text(
                            "${AppLocalizations.of(context).txt_nothing_to_show}.",
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        )
                  : Center(
                      child: Text(
                        "${global.locationMessage}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                      ),
                    )
              : _productShimmer(),
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

  _init() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getStoreCoupons().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _couponList = result.data;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - offerScreen.dart - _init():" + e.toString());
    }
  }

  Widget _productShimmer() {
    try {
      return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 8, bottom: 8),
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
                    height: 120,
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
      print("Exception - offerScreen.dart - _productShimmer():" + e.toString());
      return SizedBox();
    }
  }
}
