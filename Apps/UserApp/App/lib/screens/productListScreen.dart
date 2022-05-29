import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/productFilterModel.dart';
import 'package:gomeat/models/productModel.dart';
import 'package:gomeat/screens/checkOutScreen.dart';
import 'package:gomeat/screens/filterScreen.dart';
import 'package:gomeat/screens/productDetailScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class ProductListScreen extends BaseRoute {
  final int subcategoryId;
  final int screenId;
  final String title;
  ProductListScreen(this.screenId, this.title, {this.subcategoryId, a, o}) : super(a: a, o: o, r: 'ProductListScreen');
  @override
  _ProductListScreenState createState() => new _ProductListScreenState(this.screenId, this.title, this.subcategoryId);
}

class _ProductListScreenState extends BaseRouteState {
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ProductFilter _productFilter = new ProductFilter();
  ScrollController _scrollController = ScrollController();
  bool _isDataLoaded = false;

  List<Product> _productList = [];
  int page = 1;
  int subcategoryId;
  int screenId;
  GlobalKey<ScaffoldState> _scaffoldKey;
  String title;
  _ProductListScreenState(this.screenId, this.title, this.subcategoryId) : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Text(title),
          actions: [
            IconButton(
                onPressed: () async {
                  await openBarcodeScanner(_scaffoldKey);
                },
                icon: Icon(
                  MdiIcons.barcode,
                  color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                )),
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
                    _isRecordPending = true;
                    _productList.clear();
                    setState(() {});
                    _productFilter = value;
                    print("screen id $screenId");
                    await _init();
                  }
                });
              },
              icon: Icon(
                MdiIcons.tuneVerticalVariant,
                color: Theme.of(context).appBarTheme.actionsIconTheme.color,
              ),
            )
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
              setState(() {});
              _productList.clear();
              await _init();
              return null;
            },
            child: _isDataLoaded
                ? _productList.isNotEmpty
                    ? SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _productList.length,
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
                                          builder: (context) => ProductDetailScreen(productId: _productList[index].productId, a: widget.analytics, o: widget.observer),
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
                                                    '${_productList[index].productName}',
                                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    '${_productList[index].type}',
                                                    style: Theme.of(context).primaryTextTheme.headline2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: "${global.appInfo.currencySign} ",
                                                      style: Theme.of(context).primaryTextTheme.headline2,
                                                      children: [
                                                        TextSpan(
                                                          text: '${_productList[index].price}',
                                                          style: Theme.of(context).primaryTextTheme.bodyText1,
                                                        ),
                                                        TextSpan(
                                                          text: ' / ${_productList[index].quantity} ${_productList[index].unit}',
                                                          style: Theme.of(context).primaryTextTheme.headline2,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  _productList[index].rating != null && _productList[index].rating > 0
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
                                                                  text: "${_productList[index].rating} ",
                                                                  style: Theme.of(context).primaryTextTheme.bodyText1,
                                                                  children: [
                                                                    TextSpan(
                                                                      text: '|',
                                                                      style: Theme.of(context).primaryTextTheme.headline2,
                                                                    ),
                                                                    TextSpan(
                                                                      text: ' ${_productList[index].ratingCount} ${AppLocalizations.of(context).txt_ratings}',
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
                                              _productList[index].discount != null && _productList[index].discount > 0
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
                                                        "${_productList[index].discount} ${AppLocalizations.of(context).txt_off}",
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
                                                  bool _isAdded = await addRemoveWishList(_productList[index].varientId, _scaffoldKey);
                                                  if (_isAdded) {
                                                    _productList[index].isFavourite = !_productList[index].isFavourite;
                                                  }

                                                  setState(() {});
                                                },
                                                icon: _productList[index].isFavourite
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
                                        _productList[index].stock > 0
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
                                                      await addToCartShowModalBottomSheet(_productList[index], _scaffoldKey);
                                                    },
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: Theme.of(context).primaryTextTheme.caption.color,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : SizedBox(),
                                        Positioned(
                                          left: 0,
                                          top: -10,
                                          child: Container(
                                            child: CachedNetworkImage(
                                              imageUrl: global.appInfo.imageUrl + _productList[index].productImage,
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
                                                  visible: _productList[index].stock > 0 ? false : true,
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
                                                  visible: _productList[index].stock > 0 ? false : true,
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
                : _productShimmer(),
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

  _getData() async {
    try {
      if (screenId == 1 && subcategoryId != null) {
        await _getSubcategoryProduct();
      } else if (screenId == 2) {
        await _getTopSellingProduct();
      } else if (screenId == 3) {
        await _getSpotLightProduct();
      } else if (screenId == 4) {
        await _getRecentSellingProduct();
      } else if (screenId == 5) {
        await _getWhatsNewProduct();
      } else if (screenId == 6) {
        await _getDealProduct();
      } else if (screenId == 7) {
        _productFilter.keyword = title;
        // Search product
        await _getSearchedProduct();
      } else if (screenId == 8) {
        _productFilter.keyword = title;
        // tag product
        await _getTagProduct();
      }
      _productFilter.maxPriceValue = _productList.length > 0 ? _productList[0].maxPrice : 0;
    } catch (e) {
      print("Exception - productListScreen.dart - _init():" + e.toString());
    }
  }

  _getTopSellingProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.topSellingProduct(page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getTopSellingProduct():" + e.toString());
    }
  }

  _getRecentSellingProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.recentSellingProduct(page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getRecentSellingProduct():" + e.toString());
    }
  }

  _getWhatsNewProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.whatsnewProduct(page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getWhatsNewProduct():" + e.toString());
    }
  }

  _getDealProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.dealProduct(page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getDealProduct():" + e.toString());
    }
  }

  _getSearchedProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.getproductSearchResult(page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getDealProduct():" + e.toString());
    }
  }

  _getTagProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.getTagProduct(page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getTagProduct():" + e.toString());
    }
  }

  _getSpotLightProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.spotLightProduct(page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getSpotLightProduct():" + e.toString());
    }
  }

  _getSubcategoryProduct() async {
    try {
      if (_isRecordPending) {
        setState(() {
          _isMoreDataLoaded = true;
        });
        if (_productList.isEmpty) {
          page = 1;
        } else {
          page++;
        }
        await apiHelper.getSubcategoryProduct(subcategoryId, page, _productFilter).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Product> _tList = result.data;
              if (_tList.isEmpty) {
                _isRecordPending = false;
              }
              _productList.addAll(_tList);
              setState(() {
                _isMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - productListScreen.dart - _getSubcategoryProduct():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getData();
      _scrollController.addListener(() async {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isMoreDataLoaded) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          await _getData();
          setState(() {
            _isMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - categoryListScreen.dart - _init():" + e.toString());
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
