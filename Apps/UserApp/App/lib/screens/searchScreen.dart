import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/productModel.dart';
import 'package:gomeat/models/recentSearchModel.dart';
import 'package:gomeat/screens/loginScreen.dart';
import 'package:gomeat/screens/productDetailScreen.dart';
import 'package:gomeat/screens/productListScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends BaseRoute {
  SearchScreen({a, o}) : super(a: a, o: o, r: 'SearchScreen');
  @override
  _SearchScreenState createState() => new _SearchScreenState();
}

class _SearchScreenState extends BaseRouteState {
  List<RecentSearch> _recentSearchList = [];

  List<Product> _trendingSearchProducts = [];

  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;

  _SearchScreenState() : super();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: RefreshIndicator(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          color: Theme.of(context).primaryColor,
          onRefresh: () => _onRefresh(),
          child: _isDataLoaded
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(),
                      child: TextFormField(
                        style: Theme.of(context).primaryTextTheme.bodyText1,
                        decoration: InputDecoration(
                          hintText: '${AppLocalizations.of(context).hnt_search_for_products}',
                          prefixIcon: Icon(
                            MdiIcons.magnify,
                            color: Theme.of(context).inputDecorationTheme.hintStyle.color,
                          ),
                          contentPadding: EdgeInsets.only(top: 10),
                        ),
                        onFieldSubmitted: (val) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductListScreen(7, val, a: widget.analytics, o: widget.observer),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${AppLocalizations.of(context).lbl_recent_search}',
                                style: Theme.of(context).primaryTextTheme.headline5,
                              ),
                            ),
                          ),

                          Wrap(
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            runSpacing: 0,
                            spacing: 10,
                            children: _recentSearchWidget(),
                          ),

                         
                        ],
                      ),
                    ),
                  ],
                )
              : _productShimmer(),
        ),
        bottomNavigationBar: _isDataLoaded
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context).lbl_trending_products}',
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      height: 220,
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: global.nearStoreModel.id != null
                          ? _trendingSearchProducts.length > 0
                              ? ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: _trendingProductWidgetList(),
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
                            )),
                ],
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _recentSearchWidget() {
    List<Widget> _widgetList = [];
    try {
      for (int i = 0; i < _recentSearchList.length; i++) {
        _widgetList.add(
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(7, _recentSearchList[i].keyword, a: widget.analytics, o: widget.observer),
                ),
              );
            },
            child: Chip(
              padding: EdgeInsets.zero,
              backgroundColor: Theme.of(context).iconTheme.color,
              label: Text(
                '${_recentSearchList[i].keyword}',
                style: TextStyle(fontSize: 13, color: Theme.of(context).primaryTextTheme.caption.color, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }

      return _widgetList;
    } catch (e) {
      print("Exception - searchScreen.dart -  _recentSearchWidget():" + e.toString());
      _widgetList.add(SizedBox());
      return _widgetList;
    }
  }

  @override
  void initState() {
    super.initState();
    if (global.currentUser.id == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => LoginScreen(
                    a: widget.analytics,
                    o: widget.observer,
                  )),
        );
      });
    }
    _init();
  }

  _getRecentSearchData() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getRecentSearch().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _recentSearchList = result.data;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception -  SearchScreen.dart - _getRecentSearchData():" + e.toString());
    }
  }

  Widget _productShimmer() {
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
      print("Exception - wishlistScreen.dart - _productShimmer():" + e.toString());
      return SizedBox();
    }
  }

  _init() async {
    try {
      await _getRecentSearchData();
      await _showTrendingSearchProducts();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception -  SearchScreen.dart - _init():" + e.toString());
    }
  }

  _onRefresh() async {
    try {
      _isDataLoaded = false;
      setState(() {});
      _recentSearchList.clear();
      _trendingSearchProducts.clear();
      await _init();
    } catch (e) {
      print("Exception -  SearchScreen.dart - _onRefresh():" + e.toString());
    }
  }

  _showTrendingSearchProducts() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getTrendingProduct().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _trendingSearchProducts = result.data;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception -  searchScreen.dart - _showTrendingSearchProducts():" + e.toString());
    }
  }

  Widget recentSearchShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Card(
                  margin: EdgeInsets.only(left: 5, right: 5),
                ),
              );
            }));
  }

  List<Widget> _trendingProductWidgetList() {
    List<Widget> _widgetList = [];
    try {
      for (int i = 0; i < _trendingSearchProducts.length; i++) {
        _widgetList.add(
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    a: widget.analytics,
                    o: widget.observer,
                    productId: _trendingSearchProducts[i].productId,
                  ),
                ),
              );
            },
            child: Container(
              height: 210,
              margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: Stack(
                children: [
                  Container(
                    height: 160,
                    width: 140,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: i % 3 == 1
                            ? LinearGradient(
                                stops: [0, .90],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0XFF9EEEFF), Color(0XFFC0F4FF)],
                              )
                            : i % 3 == 2
                                ? LinearGradient(
                                    stops: [0, .90],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0XFFFFF1C0), Color(0XFFFFF1C0)],
                                  )
                                : LinearGradient(
                                    stops: [0, .90],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0XFFFFD4D7), Color(0XFFFFD4D7)],
                                  ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(17),
                          bottomLeft: Radius.circular(17),
                          bottomRight: Radius.circular(17),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 27, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${_trendingSearchProducts[i].productName}',
                              style: Theme.of(context).primaryTextTheme.subtitle1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${_trendingSearchProducts[i].type}',
                              style: Theme.of(context).primaryTextTheme.subtitle2,
                            ),
                            Container(
                              width: 130,
                              padding: const EdgeInsets.only(top: 2),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${global.appInfo.currencySign} ",
                                        style: Theme.of(context).primaryTextTheme.subtitle2,
                                      ),
                                      Text(
                                        '${_trendingSearchProducts[i].price} ',
                                        style: Theme.of(context).primaryTextTheme.subtitle1,
                                      ),
                                      Text(
                                        '/ ${_trendingSearchProducts[i].quantity}${_trendingSearchProducts[i].unit}',
                                        style: Theme.of(context).primaryTextTheme.subtitle2,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: global.isDarkModeEnable
                            ? Theme.of(context).scaffoldBackgroundColor
                            : i % 3 == 1
                                ? Color(0XFF9EEEFF)
                                : i % 3 == 2
                                    ? Color(0XFFFFF1C0)
                                    : Color(0XFFFFD4D7),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        child: CachedNetworkImage(
                          imageUrl: global.appInfo.imageUrl + _trendingSearchProducts[i].productImage,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                            ),
                            alignment: Alignment.center,
                            child: Visibility(
                              visible: _trendingSearchProducts[i].stock > 0 ? false : true,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(image: AssetImage('${global.defaultImage}'), fit: BoxFit.cover),
                            ),
                            alignment: Alignment.center,
                            child: Visibility(
                              visible: _trendingSearchProducts[i].stock > 0 ? false : true,
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
                        ),
                        height: 100,
                        width: 130,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
      return _widgetList;
    } catch (e) {
      _widgetList.add(SizedBox());
      print("Exception - homeScreen.dart - _trendingProductWidgetList():" + e.toString());
      return _widgetList;
    }
  }
}
