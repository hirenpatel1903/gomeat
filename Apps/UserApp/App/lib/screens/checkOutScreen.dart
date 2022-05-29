import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/models/addressModel.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/cartModel.dart';
import 'package:gomeat/models/membershipStatusModel.dart';
import 'package:gomeat/models/orderModel.dart';
import 'package:gomeat/models/timeSlotModel.dart';
import 'package:gomeat/screens/addAddressScreen.dart';
import 'package:gomeat/screens/couponListScreen.dart';
import 'package:gomeat/screens/loginScreen.dart';
import 'package:gomeat/screens/memberShipScreen.dart';
import 'package:gomeat/screens/paymentGatewayScreen.dart';
import 'package:gomeat/screens/productDetailScreen.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:table_calendar/table_calendar.dart';

class CheckoutScreen extends BaseRoute {
  CheckoutScreen({a, o}) : super(a: a, o: o, r: 'CheckoutScreen');
  @override
  _CheckoutScreenState createState() => new _CheckoutScreenState();
}

class _CheckoutScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  String selectedCouponCode;
  int vendorId;
  String selectedTimeSlot = '';
  String barberName;
  int _selectedAddress = 0;
  int _currentIndex = 0;
  int selectedCoupon;
  DateTime _focusedDay = DateTime.now().add(Duration(days: 1));
  PageController _pageController;
  ScrollController _scrollController;

  DateTime selectedDate;
  bool step1Done = false;
  bool step2Done = false;
  bool step3Done = false;
  bool step4Done = false;
  String _rewardLines;
  bool _isDataLoaded = false;

  var _openingTime;
  var _closingTime;
  bool _isClosingTime = false;

  Cart _cart = new Cart();

  List<Address> _addressList = [];

  List<TimeSlot> _timeSlot = [];

  String _selectedTimeSlot;

  Order _order = new Order();

  MembershipStatus _membershipStatus = new MembershipStatus();

  _CheckoutScreenState() : super();
  @override
  Widget build(BuildContext context) {
    List<String> _orderProcess = ['${AppLocalizations.of(context).txt_cart}', '${AppLocalizations.of(context).txt_address}', '${AppLocalizations.of(context).txt_time}', '${AppLocalizations.of(context).txt_payment}'];
    List<String> _orderProcessText = ['${AppLocalizations.of(context).txt_shopping_cart}', '${AppLocalizations.of(context).txt_address}', '${AppLocalizations.of(context).txt_time}', '${AppLocalizations.of(context).txt_payment}'];

    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return null;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              _orderProcessText[_currentIndex],
            ),
            leading: IconButton(
                onPressed: () {
                  if (_currentIndex == 0) {
                    Navigator.of(context).pop();
                  } else {
                    _pageController.animateToPage(_currentIndex - 1, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                    if (_currentIndex == 0) {
                      step1Done = false;
                    } else if (_currentIndex == 1) {
                      step2Done = false;
                    } else if (_currentIndex == 2) {
                      step3Done = false;
                    } else {}

                    setState(() {});
                  }
                },
                icon: Icon(MdiIcons.arrowLeft)),
            automaticallyImplyLeading: _currentIndex == 0 ? true : false,
          ),
          body: _isDataLoaded
              ? Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                      margin: EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 10),
                      child: Center(
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: _orderProcess.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int i) {
                              return global.isDarkModeEnable
                                  ? Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: _currentIndex >= i ? Colors.black : Color(0xFF505266),
                                                  border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.5,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(left: 25, right: 10),
                                                child: Text(
                                                  _orderProcess[i],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                )),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: _currentIndex >= i ? Colors.white : Colors.black,
                                                border: Border.all(color: _currentIndex == i ? Colors.black : Color(0xFF505266), width: 1.5),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.circle,
                                                size: 8,
                                                color: _currentIndex >= i ? Colors.black : Color(0xFF505266),
                                              ),
                                            ),
                                          ],
                                        ),
                                        i == 3
                                            ? SizedBox()
                                            : Container(
                                                height: 2,
                                                color: _currentIndex >= i ? Colors.black : Color(0xFF505266),
                                                width: 20,
                                                margin: EdgeInsets.all(0),
                                              ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.centerLeft,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: _currentIndex >= i ? Color(0xFF4A4352) : Color(0xFFBcc8d2),
                                                  border: Border.all(
                                                    color: _currentIndex >= i ? Color(0xFF4A4352) : Color(0xFFBcc8d2),
                                                    width: 1.5,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.only(left: 25, right: 10),
                                                child: Text(
                                                  _orderProcess[i],
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                )),
                                            Container(
                                              height: 20,
                                              width: 20,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(color: _currentIndex >= i ? Color(0xFF4A4352) : Color(0xFFBcc8d2), width: 1.5),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.circle,
                                                size: 8,
                                                color: _currentIndex >= i ? Color(0xFF4A4352) : Color(0xFFBcc8d2),
                                              ),
                                            ),
                                          ],
                                        ),
                                        i == 3
                                            ? SizedBox()
                                            : Container(
                                                height: 2,
                                                color: _currentIndex >= i ? Color(0xFF4A4352) : Color(0xFFBcc8d2),
                                                width: 20,
                                                margin: EdgeInsets.all(0),
                                              ),
                                      ],
                                    );
                            }),
                      ),
                    ),
                    Expanded(
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          _currentIndex = index;
                          double currentIndex = _currentIndex.toDouble();
                          _scrollController.animateTo(currentIndex, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                          setState(() {});
                        },
                        children: [
                          _cartWidget(),
                          _addressWidget(),
                          _timeWidget(),
                          _payment(),
                        ],
                      ),
                    ),
                  ],
                )
              : _shimmerWidget(),
          bottomNavigationBar: _isDataLoaded
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
                              if (_currentIndex == 3) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => PaymentGatewayScreen(
                                      screenId: 1,
                                      totalAmount: _order.remPrice,
                                      order: _order,
                                      a: widget.analytics,
                                      o: widget.observer,
                                    ),
                                  ),
                                );
                              } else if (_currentIndex == 1) {
                                if (_selectedAddress != null) {
                                  await _selectAddress();
                                  _pageController.animateToPage(_currentIndex + 1, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                                } else {
                                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_select_deluvery_address}');
                                }
                              } else if (_currentIndex == 2) {
                                if (_selectedTimeSlot != null && _selectedTimeSlot == 'instant') {
                                  bool isdone = await _makeOrder();
                                  if (isdone) {
                                    _pageController.animateToPage(_currentIndex + 1, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                                  }
                                } else if (selectedDate != null && _selectedTimeSlot != null) {
                                  bool isdone = await _makeOrder();
                                  if (isdone) {
                                    _pageController.animateToPage(_currentIndex + 1, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                                  }
                                } else if (selectedDate == null) {
                                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_select_date}');
                                } else if (_selectedTimeSlot == null) {
                                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_select_time_slot}');
                                }
                              } else if (_currentIndex == 0) {
                                if (_cart.productList.length > 0 && global.nearStoreModel.id != null) {
                                  _pageController.animateToPage(_currentIndex + 1, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                                } else if (_cart.productList.length == 0) {
                                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_add_product_in_cart}');
                                } else if (global.nearStoreModel.id == null) {
                                  showSnackBar(key: _scaffoldKey, snackBarMessage: '${global.locationMessage}');
                                }
                              }
                            },
                            child: Text(_currentIndex == 0
                                ? '${AppLocalizations.of(context).btn_proceed_to_checkout}'
                                : _currentIndex == 1
                                    ? '${AppLocalizations.of(context).btn_proceed_to_select_time}'
                                    : _currentIndex == 2
                                        ? '${AppLocalizations.of(context).txt_proceed_to_pay}'
                                        : '${AppLocalizations.of(context).btn_make_payment}')),
                      ),
                    ),
                  ],
                )
              : null,
        ),
      ),
    );
  }

  Future deleteConfirmationDialog(int index) async {
    try {
      await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => Theme(
          data: ThemeData(dialogBackgroundColor: Colors.white),
          child: CupertinoAlertDialog(
            title: Text(
              "${AppLocalizations.of(context).tle_delete_address}",
            ),
            content: Text(
              "${AppLocalizations.of(context).lbl_delete_address_desc}",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  '${AppLocalizations.of(context).btn_yes}',
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _removeAddress(index);
                },
              ),
              CupertinoDialogAction(
                child: Text("${AppLocalizations.of(context).lbl_cancel}"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      print("Exception - checkOutScreen.dart - deleteConfirmationDialog():" + e.toString());
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
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
    if (global.nearStoreModel.storeOpeningTime != null && global.nearStoreModel.storeOpeningTime != '' && global.nearStoreModel.storeClosingTime != null && global.nearStoreModel.storeClosingTime != '') {
      _openingTime = DateFormat('yyyy-MM-dd hh:mm a').parse((global.nearStoreModel.storeOpeningTime).toUpperCase());
       _closingTime = DateFormat('yyyy-MM-dd hh:mm a').parse((global.nearStoreModel.storeClosingTime).toUpperCase());
    }
    _scrollController = new ScrollController(initialScrollOffset: _currentIndex.toDouble());
    _pageController = new PageController(initialPage: _currentIndex);
    _pageController.addListener(() {});
    _init();
  }

  Widget _addressWidget() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => AddAddressScreen(new Address(), a: widget.analytics, o: widget.observer),
                ),
              )
                  .then((value) async {
                if (value != null) {
                  showOnlyLoaderDialog();
                  await _getAddressList();
                  hideLoader();
                }
              });
            },
            child: Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              padding: EdgeInsets.all(2),
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                  decoration: BoxDecoration(
                    color: global.isDarkModeEnable ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text(
                    "${AppLocalizations.of(context).btn_add_new_address}",
                    style: TextStyle(fontSize: 16, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                  )),
            ),
          ),
          ListView.builder(
            itemCount: _addressList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    groupValue: _selectedAddress,
                    contentPadding: EdgeInsets.zero,
                    value: index,
                    title: Text(
                      _addressList[index].type,
                      style: _selectedAddress == index ? Theme.of(context).primaryTextTheme.bodyText1 : Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Theme.of(context).primaryTextTheme.headline2.color),
                    ),
                    onChanged: (val) {
                      _selectedAddress = val;
                      setState(() {});
                    },
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_addressList[index].houseNo}, ${_addressList[index].landmark}, ${_addressList[index].society}",
                          style: _selectedAddress == index ? Theme.of(context).primaryTextTheme.headline2.copyWith(color: Theme.of(context).primaryTextTheme.bodyText1.color) : Theme.of(context).primaryTextTheme.headline2,
                        ),
                        _selectedAddress == index
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => AddAddressScreen(_addressList[index], a: widget.analytics, o: widget.observer),
                                          ),
                                        );
                                      },
                                      icon: Image.asset('assets/edit.png')),
                                  IconButton(
                                      onPressed: () async {
                                        await deleteConfirmationDialog(index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Theme.of(context).primaryColor,
                                      )),
                                ],
                              )
                            : SizedBox()
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          )
        ],
      ),
    ));
  }

  Future<bool> _addToCart(int qty, int varientId, int special, GlobalKey<ScaffoldState> scaffoldKey) async {
    bool _isAddedSuccesFully = false;
    try {
      showOnlyLoaderDialog();
      await apiHelper.addToCart(qty, varientId, special).then((result) async {
        if (result != null) {
          if (result.status == "1") {
            if (qty == 0 && global.currentUser.cartCount > 0) {
              global.currentUser.cartCount = global.currentUser.cartCount - 1;
            }

            _cart = result.data;
            _isAddedSuccesFully = true;
            hideLoader();
          } else {
            hideLoader();
            _isAddedSuccesFully = false;
            showSnackBar(key: scaffoldKey, snackBarMessage: AppLocalizations.of(context).txt_please_try_again_after_sometime);
          }
        }
      });
      return _isAddedSuccesFully;
    } catch (e) {
      print("Exception - checkOutScreen.dart - addToCart():" + e.toString());
      return _isAddedSuccesFully;
    }
  }

  Widget _cartWidget() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.44,
            child: _cart.productList.length > 0
                ? ListView.builder(
                    itemCount: _cart.productList.length,
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
                                builder: (context) => ProductDetailScreen(productId: _cart.productList[index].productId, a: widget.analytics, o: widget.observer),
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
                                          '${_cart.productList[index].productName}',
                                          style: Theme.of(context).primaryTextTheme.bodyText1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          '${_cart.productList[index].type}',
                                          style: Theme.of(context).primaryTextTheme.headline2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        RichText(
                                            text: TextSpan(text: "${global.appInfo.currencySign} ", style: Theme.of(context).primaryTextTheme.headline2, children: [
                                          TextSpan(
                                            text: '${_cart.productList[index].price}',
                                            style: Theme.of(context).primaryTextTheme.bodyText1,
                                          ),
                                          TextSpan(
                                            text: ' / ${_cart.productList[index].quantity} ${_cart.productList[index].unit}',
                                            style: Theme.of(context).primaryTextTheme.headline2,
                                          )
                                        ])),
                                        _cart.productList[index].rating != null && _cart.productList[index].rating > 0
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
                                                        text: "${_cart.productList[index].rating} ",
                                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                                        children: [
                                                          TextSpan(
                                                            text: '|',
                                                            style: Theme.of(context).primaryTextTheme.headline2,
                                                          ),
                                                          TextSpan(
                                                            text: ' ${_cart.productList[index].ratingCount} ${AppLocalizations.of(context).txt_ratings}',
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
                                    _cart.productList[index].discount != null && _cart.productList[index].discount > 0
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
                                              "${_cart.productList[index].discount}% ${AppLocalizations.of(context).txt_off}",
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
                                        bool _isAdded = await addRemoveWishList(_cart.productList[index].varientId, _scaffoldKey);
                                        if (_isAdded) {
                                          _cart.productList[index].isFavourite = !_cart.productList[index].isFavourite;
                                        }

                                        setState(() {});
                                      },
                                      icon: _cart.productList[index].isFavourite
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
                              _cart.productList[index].stock > 0
                                  ? _cart.productList[index].cartQty == null || (_cart.productList[index].cartQty != null && _cart.productList[index].cartQty == 0)
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
                                                await _addToCart(1, _cart.productList[index].varientId, 0, _scaffoldKey);

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
                                                      await _addToCart(_cart.productList[index].cartQty - 1, _cart.productList[index].varientId, 0, _scaffoldKey);

                                                      setState(() {});
                                                    },
                                                    icon: Icon(
                                                      FontAwesomeIcons.minus,
                                                      size: 11,
                                                      color: Theme.of(context).primaryTextTheme.caption.color,
                                                    )),
                                                Text(
                                                  "${_cart.productList[index].cartQty}",
                                                  style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(color: Theme.of(context).primaryTextTheme.caption.color),
                                                ),
                                                IconButton(
                                                    padding: EdgeInsets.all(0),
                                                    visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                                    onPressed: () async {
                                                      await _addToCart(_cart.productList[index].cartQty + 1, _cart.productList[index].varientId, 0, _scaffoldKey);
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
                                    imageUrl: global.appInfo.imageUrl + _cart.productList[index].productImage,
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
                                        visible: _cart.productList[index].stock > 0 ? false : true,
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
                                        visible: _cart.productList[index].stock > 0 ? false : true,
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
                : Center(
                    child: Text(
                      "${AppLocalizations.of(context).txt_nothing_to_show}",
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            contentPadding: EdgeInsets.all(0),
            title: Text(
              "${AppLocalizations.of(context).lbl_price_details}",
              style: Theme.of(context).primaryTextTheme.headline5,
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
                "${global.appInfo.currencySign} ${_cart.totalMrp}",
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
                  " - ${global.appInfo.currencySign} ${_cart.discountonmrp}",
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
                  "${AppLocalizations.of(context).txt_tax}",
                  style: Theme.of(context).primaryTextTheme.overline,
                ),
                Text(
                  "${global.appInfo.currencySign} ${_cart.totalTax}",
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
              "${global.appInfo.currencySign} ${_cart.totalPrice}",
              style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          global.isDarkModeEnable
              ? Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/checkout_cart_dark.png',
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              : Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/checkout_cart_light.png',
                      ),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
        ],
      ),
    ));
  }

  _checkMembershipStatus() async {
    try {
      _membershipStatus = await checkMemberShipStatus(_scaffoldKey);
      if (_membershipStatus.status == 'running') {
        _selectedTimeSlot = 'instant';
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MemberShipScreen(a: widget.analytics, o: widget.observer),
          ),
        );
      }
      setState(() {});
    } catch (e) {
      print("Exception - checkOutScreen.dart - _checkMembershipStatus():" + e.toString());
    }
  }

  _getAddressList() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getAddressList().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _addressList = result.data;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - checkOutScreen.dart - _getAddressList():" + e.toString());
    }
  }

  _getCart() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getCartList().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _cart = result.data;
              global.currentUser.cartCount = _cart.productList.length;
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - checkOutScreen.dart - _getCart():" + e.toString());
    }
  }

  _getRewardLines(String cartId) async {
    try {
      await apiHelper.getRewardLines(cartId).then((result) async {
        if (result != null) {
          if (result.status == "1") {
            _rewardLines = result.data;
          }
        }
      });
    } catch (e) {
      print("Exception - checkOutScreen.dart - _getRewardLines():  " + e.toString());
    }
  }

  _getTimeSlot() async {
    try {
      showOnlyLoaderDialog();
      String _selectedDate = selectedDate.toString().substring(0, 10);

      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getTimeSlot(_selectedDate).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _timeSlot = result.data;
              setState(() {});
              hideLoader();
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - checkOutScreen.dart - _getTimeSlot():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getCart();
      await _getAddressList();
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - checkOutScreen.dart - _init():" + e.toString());
    }
  }

  Future<bool> _makeOrder() async {
    bool _isSuccessfull = false;
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        String _selectedDate = selectedDate != null ? selectedDate.toString().substring(0, 10) : null;
        await apiHelper.makeOrder(_selectedDate, _selectedTimeSlot).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              _order = result.data;
              await _getRewardLines(_order.cartId);
              hideLoader();
              _isSuccessfull = true;
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      return _isSuccessfull;
    } catch (e) {
      print("Exception - checkOutScreen.dart - _makeOrder():  " + e.toString());

      return _isSuccessfull;
    }
  }

  Widget _payment() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _rewardLines != null
                ? Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 7,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${AppLocalizations.of(context).lbl_reward}',
                        style: Theme.of(context).primaryTextTheme.headline5,
                      ),
                    ),
                  )
                : SizedBox(),
            _rewardLines != null
                ? ListTile(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    minLeadingWidth: 30,
                    contentPadding: EdgeInsets.all(0),
                    leading: Icon(
                      MdiIcons.brightnessPercent,
                      size: 20,
                      color: Theme.of(context).primaryColorLight,
                    ),
                    title: Text(
                      _rewardLines != null ? "$_rewardLines" : '',
                      style: Theme.of(context).primaryTextTheme.overline,
                    ),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListTile(
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "${AppLocalizations.of(context).txt_delivery_details}",
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${AppLocalizations.of(context).lbl_date}",
                  style: Theme.of(context).primaryTextTheme.overline,
                ),
                Text(
                  selectedDate != null ? "${selectedDate.toString().substring(0, 10)}" : 'instant',
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
                    "${AppLocalizations.of(context).txt_time}",
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                  Text(
                    _selectedTimeSlot != null ? "$_selectedTimeSlot" : '',
                    style: Theme.of(context).primaryTextTheme.overline,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
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
                  "${global.appInfo.currencySign} ${_order.totalProductMrp}",
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
                    " - ${global.appInfo.currencySign} ${_order.discountonmrp}",
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
                  _order.couponDiscount != null && _order.couponDiscount > 0
                      ? Text(
                          " - ${_order.couponDiscount}",
                          style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Theme.of(context).primaryColorLight),
                        )
                      : InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => CouponListScreen(
                                  a: widget.analytics,
                                  o: widget.observer,
                                  cartId: _order.cartId,
                                ),
                              ),
                            )
                                .then((value) {
                              if (value != null) {
                                _order = value;
                              }
                              setState(() {});
                            });
                          },
                          child: Text(
                            "${AppLocalizations.of(context).txt_apply_coupon}",
                            style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Theme.of(context).primaryColorLight),
                          ),
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${AppLocalizations.of(context).txt_delivery_charges}",
                        style: Theme.of(context).primaryTextTheme.overline,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Icon(
                          Icons.error_outline,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "${global.appInfo.currencySign} ${_order.deliveryCharge}",
                    style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Colors.blue),
                  )
                ],
              ),
            ),
            _order.totaltaxprice != null && _order.totaltaxprice > 0
                ? Padding(
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
                          "${global.appInfo.currencySign} ${_order.totaltaxprice}",
                          style: Theme.of(context).primaryTextTheme.headline2.copyWith(color: Colors.blue),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
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
                "${global.appInfo.currencySign} ${_order.remPrice}",
                style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _removeAddress(int index) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.removeAddress(_addressList[index].addressId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              _addressList.removeAt(index);
              setState(() {});
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - checkOutScreen.dart - _removeAddress():" + e.toString());
    }
  }

  _selectAddress() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.selectAddress(_addressList[_selectedAddress].addressId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - checkOutScreen.dart - _selectAddress(): " + e.toString());
    }
  }

  Widget _shimmerWidget() {
    try {
      return Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 10),
        child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          height: 20,
                          width: MediaQuery.of(context).size.width / 4 - 20,
                          child: Card(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width / 4 - 20,
                          child: Card(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width / 4 - 20,
                          child: Card(),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor: Colors.grey[100],
                        child: SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width / 4 - 20,
                          child: Card(),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Card(),
                    ),
                  ),
                ),
                Container(
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
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: Card(),
                    ),
                  ),
                ),
                Container(
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
                      height: 20,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Card(),
                    ),
                  ),
                ),
                Container(
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
                ),
                Container(
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
                ),
                Container(
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
                ),
              ],
            );
          },
        ),
      );
    } catch (e) {
      print("Exception - checkOutScreen.dart - _shimmerWidget():" + e.toString());
      return SizedBox();
    }
  }

  List<Widget> _timeSlotWidget() {
    List<Widget> _widgetList = [];
    try {
      for (int i = 0; i < _timeSlot.length; i++) {
        if (_timeSlot[i].timeslot == _selectedTimeSlot) {
          _widgetList.add(Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2 - 20,
                decoration: BoxDecoration(
                  color: global.isDarkModeEnable ? Colors.black : Colors.white,
                  border: Border.all(color: global.isDarkModeEnable ? Colors.transparent : Colors.blue),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.all(4),
                child: Text(
                  "${_timeSlot[i].timeslot}",
                  style: Theme.of(context).primaryTextTheme.headline2.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  height: 15,
                  width: 22,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(4),
                  child: Icon(
                    Icons.check,
                    size: 10,
                    color: Colors.white,
                  )),
            ],
          ));
        } else {
          _widgetList.add(InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onTap: () {
              if (_timeSlot[i].availibility) {
                _selectedTimeSlot = _timeSlot[i].timeslot;
                setState(() {});
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width / 2 - 20,
              decoration: BoxDecoration(
                color: _timeSlot[i].availibility ? Theme.of(context).cardTheme.color : Theme.of(context).primaryColorLight.withOpacity(0.2),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.all(4),
              child: Text(
                "${_timeSlot[i].timeslot}",
                style: Theme.of(context).primaryTextTheme.headline2,
              ),
            ),
          ));
        }
      }
      return _widgetList;
    } catch (e) {
      _widgetList.add(SizedBox());
      print("Exception - checkOutScreen.dart - _timeSlotWidget():" + e.toString());
      return _widgetList;
    }
  }

  Widget _timeWidget() {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          _membershipStatus != null && _membershipStatus.status != 'running'
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 7,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${AppLocalizations.of(context).lbl_select_date}',
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                  ),
                )
              : SizedBox(),
          _membershipStatus != null && _membershipStatus.status != 'running'
              ? global.isDarkModeEnable
                  ? Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TableCalendar(
                        firstDay: DateTime.now().add(Duration(days: 1)),
                        lastDay: DateTime.now().add(Duration(days: 10)),
                        focusedDay: _focusedDay,
                        calendarFormat: CalendarFormat.month,
                        availableCalendarFormats: {CalendarFormat.month: 'Month'},
                        daysOfWeekHeight: 40,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: Colors.white60),
                          weekendStyle: TextStyle(color: Colors.white60),
                        ),
                        rowHeight: 35,
                        calendarStyle: CalendarStyle(
                            todayTextStyle: TextStyle(color: Colors.white),
                            todayDecoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            selectedTextStyle: TextStyle(color: Colors.white),
                            selectedDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            rangeStartTextStyle: TextStyle(color: Colors.white60),
                            rangeEndTextStyle: TextStyle(color: Colors.white60),
                            disabledTextStyle: TextStyle(color: Colors.red),
                            defaultTextStyle: TextStyle(color: Colors.white60),
                            outsideTextStyle: TextStyle(color: Colors.white60),
                            holidayTextStyle: TextStyle(color: Colors.white60),
                            withinRangeTextStyle: TextStyle(color: Colors.white60),
                            weekendTextStyle: TextStyle(color: Colors.white60)),
                        headerStyle: HeaderStyle(
                          formatButtonTextStyle: TextStyle(color: Colors.white60),
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          headerPadding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedDate, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(selectedDate, selectedDay)) {
                            setState(() {
                              selectedDate = selectedDay;
                              _focusedDay = focusedDay;
                            });
                            _getTimeSlot();
                          }
                        },
                        onFormatChanged: (format) {},
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: TableCalendar(
                        firstDay: DateTime.now().add(Duration(days: 1)),
                        lastDay: DateTime.now().add(Duration(days: 10)),
                        focusedDay: _focusedDay,
                        calendarFormat: CalendarFormat.month,
                        availableCalendarFormats: {CalendarFormat.month: 'Month'},
                        daysOfWeekHeight: 40,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(color: Colors.black87),
                          weekendStyle: TextStyle(color: Colors.black87),
                        ),
                        rowHeight: 50,
                        calendarStyle: CalendarStyle(
                            todayTextStyle: TextStyle(color: Colors.blue),
                            todayDecoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            selectedTextStyle: TextStyle(color: Colors.white),
                            selectedDecoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                            ),
                            rangeStartTextStyle: TextStyle(color: Colors.black87),
                            rangeEndTextStyle: TextStyle(color: Colors.black87),
                            disabledTextStyle: TextStyle(color: Colors.red),
                            defaultTextStyle: TextStyle(color: Colors.black87),
                            outsideTextStyle: TextStyle(color: Colors.black87),
                            holidayTextStyle: TextStyle(color: Colors.black87),
                            withinRangeTextStyle: TextStyle(color: Colors.black87),
                            weekendTextStyle: TextStyle(color: Colors.black87)),
                        headerStyle: HeaderStyle(
                          formatButtonTextStyle: TextStyle(color: Colors.black87),
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            color: Colors.white,
                          ),
                          leftChevronIcon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                          rightChevronIcon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                          headerPadding: EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedDate, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(selectedDate, selectedDay)) {
                            setState(() {
                              selectedDate = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }

                          _getTimeSlot();
                        },
                        onFormatChanged: (format) {},
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      ),
                    )
              : SizedBox(),
          _timeSlot.length > 0 && _membershipStatus != null && _membershipStatus.status != 'running'
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 5,
                    bottom: 7,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${AppLocalizations.of(context).lbl_select_time_slot}',
                      style: Theme.of(context).primaryTextTheme.headline5,
                    ),
                  ),
                )
              : SizedBox(),
          _membershipStatus != null && _membershipStatus.status != 'running'
              ? Wrap(
                  children: _timeSlotWidget(),
                )
              : SizedBox(),
          Padding(
            padding: EdgeInsets.only(
              top: 5,
              bottom: 7,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${AppLocalizations.of(context).txt_instant_delivery}',
                style: Theme.of(context).primaryTextTheme.headline5,
              ),
            ),
          ),
          _isClosingTime == false && global.nearStoreModel.storeOpeningTime != null && global.nearStoreModel.storeOpeningTime != '' && global.nearStoreModel.storeClosingTime != null && global.nearStoreModel.storeClosingTime != '' && DateTime.now().isAfter(_openingTime) && DateTime.now().isBefore(_closingTime.subtract(Duration(hours: 1)))
              ? _membershipStatus.status != 'running'
                  ? InkWell(
                      onTap: () async {
                        if (_isClosingTime == false && global.nearStoreModel.storeOpeningTime != null && global.nearStoreModel.storeOpeningTime != '' && global.nearStoreModel.storeClosingTime != null && global.nearStoreModel.storeClosingTime != '' && DateTime.now().isAfter(_openingTime) && DateTime.now().isBefore(_closingTime.subtract(Duration(hours: 1)))) {
                          if (_membershipStatus.status != 'running') {
                            await _checkMembershipStatus();
                          }
                        } else {
                          _isClosingTime = true;
                        }
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 0),
                        padding: EdgeInsets.all(2),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                              color: global.isDarkModeEnable ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              _membershipStatus.status != 'running' ? "${AppLocalizations.of(context).btn_req_instant_delivery}" : '${AppLocalizations.of(context).btn_instant_delivery}',
                              style: TextStyle(fontSize: 14, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                            )),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.all(2),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            color: global.isDarkModeEnable ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                child: Text(
                                  '${AppLocalizations.of(context).btn_instant_delivery}',
                                  style: TextStyle(fontSize: 14, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    if (_isClosingTime == false && global.nearStoreModel.storeOpeningTime != null && global.nearStoreModel.storeOpeningTime != '' && global.nearStoreModel.storeClosingTime != null && global.nearStoreModel.storeClosingTime != '' && DateTime.now().isAfter(_openingTime) && DateTime.now().isBefore(_closingTime.subtract(Duration(hours: 1)))) {
                                      _membershipStatus.status = 'Pending';
                                    } else {
                                      _isClosingTime = true;
                                    }
                                    setState(() {});
                                  })
                            ],
                          )),
                    )
              : Container(
                  margin: EdgeInsets.only(top: 0),
                  padding: EdgeInsets.all(2),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        color: global.isDarkModeEnable ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'Instant delivery not available as store closing time is near.',
                          style: TextStyle(fontSize: 14, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
        ],
      ),
    ));
  }
}
