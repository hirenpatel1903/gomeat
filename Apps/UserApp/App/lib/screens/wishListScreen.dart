import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/productFilterModel.dart';
import 'package:gomeat/models/productModel.dart';
import 'package:gomeat/screens/checkOutScreen.dart';
import 'package:gomeat/screens/filterScreen.dart';
import 'package:gomeat/screens/productDetailScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class WishListScreen extends BaseRoute {
  WishListScreen({a, o}) : super(a: a, o: o, r: 'WishListScreen');
  @override
  _WishListScreenState createState() => new _WishListScreenState();
}

class _WishListScreenState extends BaseRouteState {
  bool _isDataLoaded = false;
  int page = 1;
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ProductFilter _productFilter = new ProductFilter();
  List<Product> _wishListProductList = [];
  List<Product> _wishListOutOfStockProductList = [];
  GlobalKey<ScaffoldState> _scaffoldKey;
  ScrollController _scrollController = ScrollController();

  _WishListScreenState() : super();
  @override
  Widget build(BuildContext context) {
    if (_wishListOutOfStockProductList != null && _wishListOutOfStockProductList.length > 0) {
      _wishListOutOfStockProductList.clear();
    }
    _wishListOutOfStockProductList.addAll(_wishListProductList.where((e) => e.stock == 0));
    print(_wishListOutOfStockProductList.length);
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
          title: Text("${AppLocalizations.of(context).btn_wishlist}"),
          actions: [
            global.currentUser.cartCount != null && global.currentUser.cartCount > 0
                ? FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    heroTag: null,
                    child: Badge(
                      badgeContent: Text(
                        "${global.currentUser.cartCount}",
                        style: TextStyle(color: Colors.white, fontSize: 08),
                      ),
                      padding: EdgeInsets.all(6),
                      badgeColor: Colors.red,
                      child: Icon(
                        MdiIcons.shoppingOutline,
                        color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                      ),
                    ),
                    mini: true,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(a: widget.analytics, o: widget.observer),
                        ),
                      );
                    },
                  )
                : FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    heroTag: null,
                    child: Icon(
                      MdiIcons.shoppingOutline,
                      color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                    ),
                    mini: true,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(a: widget.analytics, o: widget.observer),
                        ),
                      );
                    },
                  ),
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => FilterScreen(_productFilter, a: widget.analytics, o: widget.observer),
                  ),
                )
                    .then((value) async {
                  if (value != null) {
                    _isDataLoaded = false;
                    setState(() {});
                    _wishListProductList.clear();
                    _isRecordPending = true;
                    await _init();
                    _productFilter = value;
                  }
                });
              },
              icon: Icon(MdiIcons.tuneVerticalVariant),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              _isDataLoaded = false;
              _isRecordPending = true;
              _wishListProductList.clear();
              setState(() {});
              await _init();
            },
            child: _isDataLoaded
                ? global.nearStoreModel.id != null
                    ? _wishListProductList.length > 0
                        ? SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: _wishListProductList.length,
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
                                              builder: (context) => ProductDetailScreen(productId: _wishListProductList[index].productId, a: widget.analytics, o: widget.observer),
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
                                                  padding: const EdgeInsets.only(top: 15, left: 130),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: global.isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        '${_wishListProductList[index].productName}',
                                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Text(
                                                        '${_wishListProductList[index].type}',
                                                        style: Theme.of(context).primaryTextTheme.headline2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      RichText(
                                                          text: TextSpan(text: "${global.appInfo.currencySign} ", style: Theme.of(context).primaryTextTheme.headline2, children: [
                                                        TextSpan(
                                                          text: '${_wishListProductList[index].price}',
                                                          style: Theme.of(context).primaryTextTheme.bodyText1,
                                                        ),
                                                        TextSpan(
                                                          text: ' / ${_wishListProductList[index].quantity} ${_wishListProductList[index].unit}',
                                                          style: Theme.of(context).primaryTextTheme.headline2,
                                                        )
                                                      ])),
                                                      _wishListProductList[index].rating != null && _wishListProductList[index].ratingCount != null && _wishListProductList[index].rating > 0
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
                                                                      text: "${_wishListProductList[index].rating} ",
                                                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                                                      children: [
                                                                        TextSpan(
                                                                          text: '|',
                                                                          style: Theme.of(context).primaryTextTheme.headline2,
                                                                        ),
                                                                        TextSpan(
                                                                          text: ' ${_wishListProductList[index].ratingCount} ${AppLocalizations.of(context).txt_ratings}',
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
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  _wishListProductList[index].discount != null
                                                      ? Container(
                                                          height: 20,
                                                          width: 70,
                                                          decoration: BoxDecoration(
                                                            color: Colors.lightBlue,
                                                            borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(10),
                                                              bottomLeft: Radius.circular(10),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "${_wishListProductList[index].discount}% ${AppLocalizations.of(context).txt_off}",
                                                            textAlign: TextAlign.center,
                                                            style: Theme.of(context).primaryTextTheme.caption,
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: 20,
                                                          width: 60,
                                                        ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      bool _isAdded = await addRemoveWishList(_wishListProductList[index].varientId, _scaffoldKey);
                                                      if (_isAdded) {
                                                        _wishListProductList.removeAt(index);
                                                      }

                                                      setState(() {});
                                                    },
                                                    icon: _wishListProductList[index].isFavourite
                                                        ? Icon(
                                                            MdiIcons.heart,
                                                            size: 20,
                                                            color: Color(0xFFEF5656),
                                                          )
                                                        : Icon(
                                                            MdiIcons.heart,
                                                            size: 20,
                                                            color: Color(0xFF4A4352),
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            _wishListProductList[index].stock > 0
                                                ? _wishListProductList[index].cartQty == null || (_wishListProductList[index].cartQty != null && _wishListProductList[index].cartQty == 0)
                                                    ? Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Container(
                                                          height: 30,
                                                          width: 30,
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context).iconTheme.color,
                                                            borderRadius: BorderRadius.only(
                                                              bottomRight: Radius.circular(10),
                                                              topLeft: Radius.circular(10),
                                                            ),
                                                          ),
                                                          child: IconButton(
                                                            padding: EdgeInsets.all(0),
                                                            visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                                            onPressed: () async {
                                                              bool isAdded = await addToCart(1, _wishListProductList[index].varientId, 0, _scaffoldKey, true);
                                                              if (isAdded) {
                                                                _wishListProductList[index].cartQty = _wishListProductList[index].cartQty + 1;
                                                              }
                                                              setState(() {});
                                                            },
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: Theme.of(context).primaryTextTheme.caption.color,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Positioned(
                                                        bottom: 0,
                                                        right: 0,
                                                        child: Container(
                                                          height: 28,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                            gradient: LinearGradient(
                                                              stops: [0, .90],
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight,
                                                              colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColorLight],
                                                            ),
                                                            borderRadius: BorderRadius.only(
                                                              bottomRight: Radius.circular(10),
                                                              topLeft: Radius.circular(10),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              IconButton(
                                                                  padding: EdgeInsets.all(0),
                                                                  visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                                                  onPressed: () async {
                                                                    bool isAdded = await addToCart(_wishListProductList[index].cartQty - 1, _wishListProductList[index].varientId, 0, _scaffoldKey, false);
                                                                    if (isAdded) {
                                                                      _wishListProductList[index].cartQty = _wishListProductList[index].cartQty - 1;
                                                                    }
                                                                    setState(() {});
                                                                  },
                                                                  icon: Icon(
                                                                    FontAwesomeIcons.minus,
                                                                    size: 11,
                                                                    color: Theme.of(context).primaryTextTheme.caption.color,
                                                                  )),
                                                              Text(
                                                                "${_wishListProductList[index].cartQty}",
                                                                style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Theme.of(context).primaryTextTheme.caption.color),
                                                              ),
                                                              IconButton(
                                                                  padding: EdgeInsets.all(0),
                                                                  visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                                                  onPressed: () async {
                                                                    bool isAdded = await addToCart(_wishListProductList[index].cartQty + 1, _wishListProductList[index].varientId, 0, _scaffoldKey, false);
                                                                    if (isAdded) {
                                                                      _wishListProductList[index].cartQty = _wishListProductList[index].cartQty + 1;
                                                                    }
                                                                    setState(() {});
                                                                  },
                                                                  icon: Icon(
                                                                    FontAwesomeIcons.plus,
                                                                    size: 11,
                                                                    color: Theme.of(context).primaryTextTheme.caption.color,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                : SizedBox(),
                                            Positioned(
                                              left: 0,
                                              top: -10,
                                              child: Container(
                                                child: CachedNetworkImage(
                                                  imageUrl: global.appInfo.imageUrl + _wishListProductList[index].productImage,
                                                  imageBuilder: (context, imageProvider) => Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Visibility(
                                                      visible: _wishListProductList[index].stock > 0 ? false : true,
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
                                                      visible: _wishListProductList[index].stock > 0 ? false : true,
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
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                _isMoreDataLoaded
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
        bottomNavigationBar: _isDataLoaded && _wishListProductList.length > 0 && _wishListOutOfStockProductList.length != _wishListProductList.length
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
                            await _addAllProductToCart();
                          },
                          child: Text(_wishListOutOfStockProductList != null && _wishListOutOfStockProductList.length > 0 ? '${AppLocalizations.of(context).txt_add_all_instock_items}' : '${AppLocalizations.of(context).btn_add_all_to_cart}')),
                    ),
                  ),
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

  @override
  void initState() {
    super.initState();
    _init();
  }

  _addAllProductToCart() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.addWishListToCart().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.currentUser.cartCount = global.currentUser.cartCount + _wishListProductList.length;
              _wishListProductList.clear();
              hideLoader();

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(a: widget.analytics, o: widget.observer),
                ),
              );
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_try_again_after_sometime);
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - wishListScreen.dart - _addAllProductToCart():" + e.toString());
    }
  }

  _getWishListProduct() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          if (_wishListProductList.isEmpty) {
            page = 1;
          } else {
            page++;
          }
          await apiHelper.getWishListProduct(page, _productFilter).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                List<Product> _tList = result.data;
                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }
                _wishListProductList.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              }
              _productFilter.maxPriceValue = _wishListProductList.length > 0 ? _wishListProductList[0].maxPrice : 0;
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - wishListScreen.dart - _getWishListProduct():" + e.toString());
    }
  }

  _init() async {
    try {
      if (global.nearStoreModel.id != null) {
        await _getWishListProduct();
        _scrollController.addListener(() async {
          if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
            setState(() {
              _isMoreDataLoaded = true;
            });
            await _getWishListProduct();
            setState(() {
              _isMoreDataLoaded = false;
            });
          }
        });
      }

      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - wishListScreen.dart - _init():" + e.toString());
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
}
