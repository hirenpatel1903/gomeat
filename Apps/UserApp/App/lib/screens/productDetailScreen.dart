import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/productDetailModel.dart';
import 'package:gomeat/screens/checkOutScreen.dart';
import 'package:gomeat/screens/productListScreen.dart';
import 'package:gomeat/screens/ratingListScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailScreen extends BaseRoute {
  final int productId;
  final int varientId;
  final ProductDetail productDetail;
  ProductDetailScreen({a, o, this.productDetail, this.productId, this.varientId}) : super(a: a, o: o, r: 'ProductDetailScreen');
  @override
  _ProductDetailScreenState createState() => new _ProductDetailScreenState(this.productId, this.varientId, this.productDetail);
}

class _ProductDetailScreenState extends BaseRouteState {
  int productId;
  int varientId;
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool _isDataLoaded = false;
  ProductDetail productDetail;
  ProductDetail _productDetail = new ProductDetail();
  _ProductDetailScreenState(this.productId, this.varientId, this.productDetail) : super();
  PageController pageController = new PageController(initialPage: 0);
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("${AppLocalizations.of(context).tle_product_details}"),
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
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: RefreshIndicator(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              color: Theme.of(context).primaryColor,
              onRefresh: () async {
                _isDataLoaded = false;
                setState(() {});
                await _init();
              },
              child: Column(
                children: [
                  _isDataLoaded
                      ? _productDetail != null && _productDetail.productDetail != null
                          ? Container(
                              height: 310,
                              margin: EdgeInsets.only(top: 25),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: global.isDarkModeEnable
                                        ? BoxDecoration(
                                            gradient: LinearGradient(
                                              stops: [0, .90],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [Color(0xFF545975).withOpacity(0.44), Color(0xFF333550).withOpacity(0.22)],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          )
                                        : BoxDecoration(
                                            gradient: LinearGradient(
                                              stops: [0, .90],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [Color(0xFF7C96AA).withOpacity(0.33), Color(0xFFA6C1D6).withOpacity(0.07)],
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 75),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            '${_productDetail.productDetail.productName}',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 6),
                                            child: Text(
                                              '${_productDetail.productDetail.type}',
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context).primaryTextTheme.button,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8, left: 16, right: 16),
                                            child: Text(
                                              '${_productDetail.productDetail.description}',
                                              style: Theme.of(context).primaryTextTheme.button,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        text: "${global.appInfo.currencySign} ",
                                                        style: Theme.of(context).primaryTextTheme.headline2,
                                                        children: [
                                                          TextSpan(
                                                            text: '${_productDetail.productDetail.price}',
                                                            style: Theme.of(context).primaryTextTheme.bodyText1,
                                                          ),
                                                          TextSpan(
                                                            text: ' / ${_productDetail.productDetail.quantity} ${_productDetail.productDetail.unit}',
                                                            style: Theme.of(context).primaryTextTheme.headline2,
                                                          ),
                                                          TextSpan(
                                                            text: '    ${global.appInfo.currencySign} ',
                                                            style: Theme.of(context).primaryTextTheme.headline2,
                                                          ),
                                                          TextSpan(
                                                            text: ' ${_productDetail.productDetail.mrp}',
                                                            style: Theme.of(context).primaryTextTheme.headline2.copyWith(decoration: TextDecoration.lineThrough),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    _productDetail.productDetail.rating != null && _productDetail.productDetail.rating > 0
                                                        ? Icon(
                                                            Icons.star,
                                                            size: 18,
                                                            color: Theme.of(context).primaryColorLight,
                                                          )
                                                        : SizedBox(),
                                                    _productDetail.productDetail.rating != null && _productDetail.productDetail.rating > 0
                                                        ? InkWell(
                                                            onTap: () {
                                                              Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) => RatingListScreen(_productDetail.productDetail.varientId, a: widget.analytics, o: widget.observer),
                                                                ),
                                                              );
                                                            },
                                                            child: RichText(
                                                              text: TextSpan(
                                                                text: "${_productDetail.productDetail.rating} ",
                                                                style: Theme.of(context).primaryTextTheme.bodyText1,
                                                                children: [
                                                                  TextSpan(
                                                                    text: '|',
                                                                    style: Theme.of(context).primaryTextTheme.headline2,
                                                                  ),
                                                                  TextSpan(
                                                                    text: ' ${_productDetail.productDetail.ratingCount} ${AppLocalizations.of(context).txt_ratings}',
                                                                    style: Theme.of(context).primaryTextTheme.headline1,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox(),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Wrap(
                                            alignment: WrapAlignment.center,
                                            runAlignment: WrapAlignment.center,
                                            runSpacing: 0,
                                            spacing: 10,
                                            children: _tagWidgetList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: (MediaQuery.of(context).size.width - 231) / 2,
                                    top: -35,
                                    child: Builder(builder: (context) {
                                      return InkWell(
                                        onTap: () {
                                          if (_productDetail.productDetail.images != null && _productDetail.productDetail.images.isNotEmpty) {
                                            dialogToOpenImage(_productDetail.productDetail.productName, _productDetail.productDetail.images, 0);
                                          }
                                        },
                                        child: Container(
                                          child: CachedNetworkImage(
                                            imageUrl: global.appInfo.imageUrl + _productDetail.productDetail.productImage,
                                            imageBuilder: (context, imageProvider) => Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                              ),
                                              alignment: Alignment.center,
                                              child: Visibility(
                                                visible: _productDetail.productDetail.stock > 0 ? false : true,
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
                                                visible: _productDetail.productDetail.stock > 0 ? false : true,
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
                                          height: 140,
                                          width: 215,
                                        ),
                                      );
                                    }),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: _productDetail.productDetail.stock > 0
                                          ? InkWell(
                                              onTap: () async {
                                                await addToCartShowModalBottomSheet(_productDetail.productDetail, _scaffoldKey);
                                              },
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
                                                child: Icon(
                                                  Icons.add,
                                                  color: Theme.of(context).primaryTextTheme.caption.color,
                                                ),
                                              ),
                                            )
                                          : SizedBox()),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        _productDetail.productDetail.discount != null && _productDetail.productDetail.discount > 0
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
                                                  "${_productDetail.productDetail.discount}% ${AppLocalizations.of(context).txt_off}",
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
                                              bool _isAdded = await addRemoveWishList(_productDetail.productDetail.varientId, _scaffoldKey);
                                              if (_isAdded) {
                                                _productDetail.productDetail.isFavourite = !_productDetail.productDetail.isFavourite;
                                              }

                                              setState(() {});
                                            },
                                            icon: _productDetail.productDetail.isFavourite
                                                ? Icon(
                                                    MdiIcons.heart,
                                                    size: 20,
                                                    color: Color(0xFFEF5656),
                                                  )
                                                : Icon(
                                                    MdiIcons.heart,
                                                    size: 20,
                                                    color: Color(0xFF4A4352),
                                                  )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text('No Product Found')
                      : Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor: Colors.grey[100],
                          child: Column(
                            children: [
                              SizedBox(
                                height: 285,
                                width: MediaQuery.of(context).size.width,
                                child: Card(),
                              ),
                            ],
                          ),
                        ),
                 
                 _isDataLoaded
                        && _productDetail.similarProductList != null && _productDetail.similarProductList.length > 0
                            ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "${AppLocalizations.of(context).lbl_similar_products}",
                        style: Theme.of(context).primaryTextTheme.headline5,
                      ),
                    ),
                  ) : SizedBox(),
                  Expanded(
                    child: _isDataLoaded
                        ? _productDetail.similarProductList != null && _productDetail.similarProductList.length > 0
                            ? ListView.builder(
                                itemCount: _productDetail.similarProductList.length,
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
                                            builder: (context) => ProductDetailScreen(productId: _productDetail.similarProductList[index].productId, a: widget.analytics, o: widget.observer),
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
                                                      '${_productDetail.similarProductList[index].productName}',
                                                      style: Theme.of(context).primaryTextTheme.bodyText1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      '${_productDetail.similarProductList[index].type}',
                                                      style: Theme.of(context).primaryTextTheme.headline2,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    RichText(
                                                        text: TextSpan(text: "${global.appInfo.currencySign} ", style: Theme.of(context).primaryTextTheme.headline2, children: [
                                                      TextSpan(
                                                        text: '${_productDetail.similarProductList[index].price}',
                                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                                      ),
                                                      TextSpan(
                                                        text: ' / ${_productDetail.similarProductList[index].quantity} ${_productDetail.similarProductList[index].unit}',
                                                        style: Theme.of(context).primaryTextTheme.headline2,
                                                      )
                                                    ])),
                                                    _productDetail.productDetail.rating != null && _productDetail.productDetail.rating > 0
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
                                                                    text: "${_productDetail.productDetail.rating} ",
                                                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                                                    children: [
                                                                      TextSpan(
                                                                        text: '|',
                                                                        style: Theme.of(context).primaryTextTheme.headline2,
                                                                      ),
                                                                      TextSpan(
                                                                        text: ' ${_productDetail.productDetail.ratingCount} ${AppLocalizations.of(context).txt_ratings}',
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
                                                _productDetail.similarProductList[index].discount != null && _productDetail.similarProductList[index].discount > 0
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
                                                          "${_productDetail.similarProductList[index].discount}% ${AppLocalizations.of(context).txt_off}",
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
                                                      bool _isAdded = await addRemoveWishList(_productDetail.similarProductList[index].varientId, _scaffoldKey);
                                                      if (_isAdded) {
                                                        _productDetail.similarProductList[index].isFavourite = !_productDetail.similarProductList[index].isFavourite;
                                                      }

                                                      setState(() {});
                                                    },
                                                    icon: _productDetail.similarProductList[index].isFavourite
                                                        ? Icon(
                                                            MdiIcons.heart,
                                                            size: 20,
                                                            color: Color(0xFFEF5656),
                                                          )
                                                        : Icon(
                                                            MdiIcons.heart,
                                                            size: 20,
                                                            color: Color(0xFF4A4352),
                                                          ))
                                              ],
                                            ),
                                          ),
                                          _productDetail.similarProductList[index].stock > 0
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
                                                        await addToCartShowModalBottomSheet(_productDetail.similarProductList[index], _scaffoldKey);
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
                                                imageUrl: global.appInfo.imageUrl + _productDetail.similarProductList[index].productImage,
                                                imageBuilder: (context, imageProvider) => Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Visibility(
                                                    visible: _productDetail.similarProductList[index].stock > 0 ? false : true,
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
                                                    visible: _productDetail.similarProductList[index].stock > 0 ? false : true,
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
                              )
                            : SizedBox()
                        : _similarProductShimmer(),
                  )
                ],
              ),
            ),
          )),
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
        if (varientId != null) {
          await apiHelper.getBannerVarient(varientId).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                _productDetail = result.data;
              } else if (result.status == "0") {
                _productDetail = null;
              }
            }
          });
        } else if (productDetail != null) {
          _productDetail = productDetail;
        } else {
          await apiHelper.getProductDetail(productId).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                _productDetail = result.data;
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - productDetailScreen.dart- _init():" + e.toString());
    }
  }

  Widget _similarProductShimmer() {
    try {
      return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(top: 10),
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
      print("Exception - productDetailScreen.dart - _similarProductShimmer():" + e.toString());
      return SizedBox();
    }
  }

  List<Widget> _tagWidgetList() {
    List<Widget> _widgetList = [];
    try {
      for (int i = 0; i < _productDetail.productDetail.tags.length; i++) {
        _widgetList.add(
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(8, _productDetail.productDetail.tags[i].tag, a: widget.analytics, o: widget.observer),
                ),
              );
            },
            child: Chip(
              padding: EdgeInsets.zero,
              backgroundColor: Theme.of(context).iconTheme.color,
              label: Text(
                '${_productDetail.productDetail.tags[i].tag}',
                style: TextStyle(fontSize: 13, color: Theme.of(context).primaryTextTheme.caption.color, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }

      return _widgetList;
    } catch (e) {
      print("Exception - productDetailScreen.dart -  _tagWidgetList():" + e.toString());
      _widgetList.add(SizedBox());
      return _widgetList;
    }
  }
}
