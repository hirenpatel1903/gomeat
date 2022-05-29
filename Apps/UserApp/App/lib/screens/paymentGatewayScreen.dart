import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/inputFormaters/cardMonthInputFormatter.dart';
import 'package:gomeat/inputFormaters/cardNumberInputFormatter.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/cardModel.dart';
import 'package:gomeat/models/membershipModel.dart';
import 'package:gomeat/models/orderModel.dart';
import 'package:gomeat/screens/orderSucessScreen.dart';
import 'package:gomeat/screens/paymentSucessScreen.dart';
import 'package:gomeat/screens/stripePaymentScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shimmer/shimmer.dart';

class PaymentGatewayScreen extends BaseRoute {
  final int screenId;
  final int totalAmount;
  final MembershipModel membershipModel;
  final Order order;
  PaymentGatewayScreen({
    a,
    o,
    this.screenId,
    this.totalAmount,
    this.membershipModel,
    this.order,
  }) : super(a: a, o: o, r: 'PaymentGatewayScreen');
  @override
  _PaymentGatewayScreenState createState() => new _PaymentGatewayScreenState(screenId, totalAmount, membershipModel, order);
}

class _PaymentGatewayScreenState extends BaseRouteState {
  int screenId;

  int totalAmount;
  GlobalKey<ScaffoldState> _scaffoldKey;

  Razorpay _razorpay;
  bool _isDataLoaded = false;
  var payPlugin = PaystackPlugin();
  TextEditingController _cCardNumber = new TextEditingController();
  TextEditingController _cExpiry = new TextEditingController();
  TextEditingController _cCvv = new TextEditingController();
  TextEditingController _cName = new TextEditingController();

  int _month;
  int _year;
  String number;
  CardType cardType;
  int _isWallet = 0;
  final _formKey = new GlobalKey<FormState>();
  bool _autovalidate = false;
  bool isLoading = false;
  MembershipModel membershipModel;
  Order order;
  _PaymentGatewayScreenState(
    this.screenId,
    this.totalAmount,
    this.membershipModel,
    this.order,
  ) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exitAppDialog();
        return null;
      },
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
          title: Text(
            AppLocalizations.of(context).lbl_payment_method,
          ),
          centerTitle: true,
        ),
        body: _isDataLoaded
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    global.currentUser.wallet > 0 && screenId != 3
                        ? RadioListTile(
                            controlAffinity: ListTileControlAffinity.trailing,
                            value: 1,
                            groupValue: _isWallet,
                            title: Text(
                              AppLocalizations.of(context).lbl_wallet,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                            subtitle: Text(
                              '${global.appInfo.currencySign} ${global.currentUser.wallet}',
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                            secondary: Icon(
                              MdiIcons.walletOutline,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 25,
                            ),
                            onChanged: (val) async {
                              _isWallet = val;

                              if (global.currentUser.wallet >= totalAmount) {
                                if (screenId == 2 && membershipModel != null) {
                                  showOnlyLoaderDialog();
                                  await _buyMemberShip('wallet', 'wallet', null);
                                } else if (screenId == 1 && order != null) {
                                  showOnlyLoaderDialog();
                                  await _orderCheckOut('success', 'wallet', null, null);
                                }
                              } else {
                                totalAmount = totalAmount - global.currentUser.wallet;
                                setState(() {});
                              }
                            })
                        : SizedBox(),
                    screenId > 1
                        ? SizedBox()
                        : ListTile(
                            contentPadding: EdgeInsets.only(left: 10, right: 10),
                            title: Text(
                              AppLocalizations.of(context).txt_pay_on_delivery,
                              style: Theme.of(context).primaryTextTheme.headline5,
                            ),
                          ),
                    screenId > 1
                        ? SizedBox()
                        : ListTile(
                            onTap: () async {
                              if (screenId == 1 && order != null) {
                                showOnlyLoaderDialog();
                                await _orderCheckOut('success', 'COD', null, null);
                              }

                              setState(() {});
                            },
                            leading: Icon(
                              FontAwesomeIcons.wallet,
                              size: 25,
                              color: Colors.green[500],
                            ),
                            title: Text(
                              AppLocalizations.of(context).lbl_cash,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                            subtitle: Text(
                              AppLocalizations.of(context).txt_pay_through_cash,
                              style: Theme.of(context).primaryTextTheme.headline2,
                            ),
                          ),
                    screenId > 1
                        ? SizedBox()
                        : ListTile(
                            title: Text(AppLocalizations.of(context).lbl_other_methods, style: Theme.of(context).primaryTextTheme.headline5),
                          ),
                    global.paymentGateway.razorpay.razorpayStatus == 'Yes'
                        ? ListTile(
                            onTap: () {
                              showOnlyLoaderDialog();
                              openCheckout();
                            },
                            leading: Image.asset(
                              'assets/razorpay.png',
                              height: 25,
                            ),
                            title: Text(
                              AppLocalizations.of(context).lbl_rezorpay,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )
                        : SizedBox(),
                    global.paymentGateway.stripe.stripeStatus == 'Yes'
                        ? ListTile(
                            onTap: () {
                              _cardDialog(0);
                            },
                            leading: Image.asset(
                              'assets/stripe.png',
                              height: 20,
                            ),
                            title: Text(
                              AppLocalizations.of(context).lbl_stripe,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )
                        : SizedBox(),
                    global.paymentGateway.paystack.paystackStatus == 'Yes'
                        ? ListTile(
                            onTap: () {
                              _cardDialog(1);
                            },
                            leading: Image.asset(
                              'assets/paystack.png',
                              height: 25,
                            ),
                            title: Text(
                              AppLocalizations.of(context).lbl_paystack,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          )
                        : SizedBox()
                  ],
                ),
              )
            : _productShimmer(),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: SizedBox(
              height: 60,
              width: double.infinity,
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    style: Theme.of(context).primaryTextTheme.headline5,
                    children: [
                      TextSpan(text: AppLocalizations.of(context).lbl_total_amount),
                      TextSpan(
                        text: ' ${global.appInfo.currencySign} $totalAmount',
                        style: Theme.of(context).primaryTextTheme.headline5.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void openCheckout() async {
    var options;

    options = {
      'key': global.paymentGateway.razorpay.razorpayKey,
      'amount': _amountInPaise(totalAmount),
      'name': "${global.currentUser.name}",
      'prefill': {'contact': global.currentUser.userPhone, 'email': global.currentUser.email},
      'currency': 'INR'
    };

    try {
      hideLoader();
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void payStack(String key) async {
    try {
      payPlugin.initialize(publicKey: global.paymentGateway.paystack.paystackPublicKey).then((value) {
        _startAfreshCharge(totalAmount.toInt() * 100);
      }).catchError((e) {
        print("Exception - internal error - paymentGatewaysScreen.dart - payStatck(): " + e.toString());
      });
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart - payStatck(): " + e.toString());
    }
  }

  _orderCheckOut(String paymentStatus, String paymentMethod, String paymentId, String paymentGateway) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.checkout(order.cartId, paymentStatus, paymentMethod, _isWallet == 1 ? 'yes' : 'no', paymentId, paymentGateway).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              if (_isWallet == 1) {
                if (global.currentUser.wallet >= totalAmount) {
                  global.currentUser.wallet = global.currentUser.wallet - totalAmount;
                } else {
                  global.currentUser.wallet = 0;
                }
                if (paymentStatus == 'success') {
                  global.currentUser.cartCount = 0;
                }
              }

              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => OrderSuccessScreen(
                          order.cartId,
                          a: widget.analytics,
                          o: widget.observer,
                        )),
              );
            } else {
              hideLoader();
              showSnackBar(key: _scaffoldKey, snackBarMessage: '${result.message}');
            }
          } else {
            hideLoader();
            showSnackBar(key: _scaffoldKey, snackBarMessage: 'Something went wrong. Please try again later.');
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - paymentGatewayScreen.dart - _orderCheckOut():" + e.toString());
    }
  }

  stripe({int amount, CardModel card, String currency}) async {
    var customers;
    try {
      customers = await StripeService.createCustomer(email: global.currentUser.email);

      var paymentMethodsObject = await StripeService.createPaymentMethod(card);

      var paymentIntent = await StripeService.createPaymentIntent(amount, currency, customerId: customers["id"]);
      var response = await StripeService.confirmPaymentIntent(paymentIntent["id"], paymentMethodsObject["id"]);
      if (response["status"] == 'succeeded') {
        if (screenId == 2 && membershipModel != null) {
          await _buyMemberShip('success', 'stripe', '${response["id"]}');
        } else if (screenId == 1 && order != null) {
          await _orderCheckOut('success', 'stripe', '${response["id"]}', 'stripe');
        } else if (screenId == 3) {
          await _rechargeWallet('success', 'stripe', '${response["id"]}');
        }
      } else {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          if (screenId == 2 && membershipModel != null) {
            await _buyMemberShip('failed', 'stripe', null);
          } else if (screenId == 1 && order != null) {
            await _orderCheckOut('failed', 'stripe', null, 'stripe');
          } else if (screenId == 3) {
            await _rechargeWallet('failed', 'stripe', null);
          }
          _tryAgainDialog(stripe);
          setState(() {});
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      }
    } on PlatformException catch (err) {
      print('Platfrom Exception: paymentGatewaysScreen.dart -  stripe() : ${err.toString()}');
    } catch (err) {
      print('Exception: paymentGatewaysScreen.dart -  stripe() : ${err.toString()}');
      return new StripeTransactionResponse(message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  String _amountInPaise(int amount) {
    try {
      int x = amount * 100;
      return x.toString();
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart - _amountInPaise():" + e.toString());
      return '0';
    }
  }

  _buyMemberShip(String buyStatus, String paymentGateway, String transactionId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.buyMembership(buyStatus, paymentGateway, transactionId, membershipModel.planId).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              if (_isWallet == 1) {
                if (global.currentUser.wallet >= totalAmount) {
                  global.currentUser.wallet = global.currentUser.wallet - totalAmount;
                } else {
                  global.currentUser.wallet = 0;
                }
              }
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(
                          'Payment Successfull, Enjoy your journey.',
                          a: widget.analytics,
                          o: widget.observer,
                        )),
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
      print("Exception - paymentGatewayScreen.dart - _buyMemberShip():" + e.toString());
    }
  }

  _rechargeWallet(String rechargeStatus, String paymentGateway, String paymentId) async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.rechargeWallet(rechargeStatus, totalAmount, paymentId, paymentGateway).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.currentUser.wallet = global.currentUser.wallet + totalAmount;
              hideLoader();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => PaymentSuccessScreen(
                          'Wallet recharged successfully. Enjoy your journey.',
                          a: widget.analytics,
                          o: widget.observer,
                        )),
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
      print("Exception - paymentGatewayScreen.dart - _rechargeWallet():" + e.toString());
    }
  }

  _cardDialog(int paymentCallId) {
    showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => AlertDialog(
                    backgroundColor: global.isDarkModeEnable ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).inputDecorationTheme.fillColor,
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      AppLocalizations.of(context).lbl_card_Details,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                              child: Text('${AppLocalizations.of(context).btn_close}')),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  _save(paymentCallId);
                                },
                                child: Text('${AppLocalizations.of(context).lbl_pay}')),
                          )
                        ],
                      )
                    ],
                    content: Form(
                      key: _formKey,
                      autovalidateMode: _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              controller: _cCardNumber,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                new LengthLimitingTextInputFormatter(16),
                                new CardNumberInputFormatter(),
                              ],
                              textInputAction: TextInputAction.next,
                              decoration: new InputDecoration(
                                fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                hintText: AppLocalizations.of(context).lbl_card_number,
                                prefixIcon: Icon(Icons.credit_card),
                              ),
                              textCapitalization: TextCapitalization.none,
                              keyboardType: TextInputType.number,
                              onSaved: (String value) {
                                number = br.getCleanedNumber(value);
                              },
                              // ignore: missing_return
                              validator: (input) {
                                if (input.isEmpty) {
                                  return AppLocalizations.of(context).txt_enter_card_number;
                                }

                                input = br.getCleanedNumber(input);

                                if (input.length < 8) {
                                  return AppLocalizations.of(context).txt_enter_valid_card_number;
                                }

                                int sum = 0;
                                int length = input.length;
                                for (var i = 0; i < length; i++) {
                                  // get digits in reverse order
                                  int digit = int.parse(input[length - i - 1]);

                                  // every 2nd number multiply with 2
                                  if (i % 2 == 1) {
                                    digit *= 2;
                                  }
                                  sum += digit > 9 ? (digit - 9) : digit;
                                }

                                if (sum % 10 == 0) {
                                  return null;
                                }

                                return AppLocalizations.of(context).txt_enter_valid_card_number;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      new LengthLimitingTextInputFormatter(4),
                                      new CardMonthInputFormatter(),
                                    ],
                                    controller: _cExpiry,
                                    textInputAction: TextInputAction.next,
                                    decoration: new InputDecoration(
                                      fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                      contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                      prefixIcon: Icon(
                                        Icons.date_range,
                                      ),
                                      hintText: 'MM/YY',
                                    ),
                                    textCapitalization: TextCapitalization.sentences,
                                    keyboardType: TextInputType.number,
                                    onFieldSubmitted: (value) {
                                      List<int> expiryDate = br.getExpiryDate(value);
                                      _month = expiryDate[0];
                                      _year = expiryDate[1];
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context).txt_enter_expiry_date;
                                      }

                                      int year;
                                      int month;
                                      // The value contains a forward slash if the month and year has been
                                      // entered.
                                      if (value.contains(new RegExp(r'(\/)'))) {
                                        var split = value.split(new RegExp(r'(\/)'));
                                        // The value before the slash is the month while the value to right of
                                        // it is the year.
                                        month = int.parse(split[0]);
                                        year = int.parse(split[1]);
                                      } else {
                                        // Only the month was entered
                                        month = int.parse(value.substring(0, (value.length)));
                                        year = -1; // Lets use an invalid year intentionally
                                      }

                                      if ((month < 1) || (month > 12)) {
                                        // A valid month is between 1 (January) and 12 (December)
                                        return AppLocalizations.of(context).txt_expiry_month_is_invalid;
                                      }

                                      var fourDigitsYear = br.convertYearTo4Digits(year);
                                      if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
                                        // We are assuming a valid should be between 1 and 2099.
                                        // Note that, it's valid doesn't mean that it has not expired.
                                        return AppLocalizations.of(context).txt_expiry_year_is_invalid;
                                      }

                                      if (!br.hasDateExpired(month, year)) {
                                        return AppLocalizations.of(context).txt_card_has_expired;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                      new LengthLimitingTextInputFormatter(3),
                                    ],
                                    controller: _cCvv,
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    decoration: new InputDecoration(
                                      fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                      contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                      prefixIcon: Icon(
                                        MdiIcons.creditCard,
                                      ),
                                      hintText: AppLocalizations.of(context).lbl_cvv,
                                    ),
                                    textCapitalization: TextCapitalization.sentences,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context).lbl_enter_cvv;
                                      } else if (value.length < 3 || value.length > 4) {
                                        return AppLocalizations.of(context).txt_cvv_is_invalid;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              controller: _cName,
                              textInputAction: TextInputAction.next,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
                              ],
                              decoration: new InputDecoration(
                                fillColor: global.isDarkModeEnable ? Theme.of(context).inputDecorationTheme.fillColor : Theme.of(context).scaffoldBackgroundColor,
                                contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                hintText: AppLocalizations.of(context).txt_card_holder_name,
                              ),
                              textCapitalization: TextCapitalization.words,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
        });
  }

  _chargeCard(Charge charge) async {
    try {
      payPlugin.chargeCard(context, charge: charge).then((value) async {
        if (value.status && value.message == "Success") {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            if (screenId == 2 && membershipModel != null) {
              await _buyMemberShip('success', 'paystack', null);
            } else if (screenId == 1 && order != null) {
              await _orderCheckOut('success', 'paystack', null, 'paystack');
            } else if (screenId == 3) {
              await _rechargeWallet('sucess', 'paystack', null);
            }

            setState(() {});
          } else {
            showNetworkErrorSnackBar(_scaffoldKey);
          }
        } else {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            if (screenId == 2 && membershipModel != null) {
              await _buyMemberShip('failed', 'paystack', null);
            } else if (screenId == 1 && order != null) {
              await _orderCheckOut('failed', 'paystack', null, 'paystack');
            } else if (screenId == 3) {
              await _rechargeWallet('failed', 'paystack', null);
            }
            _tryAgainDialog(payStack);
            setState(() {});
          } else {
            showNetworkErrorSnackBar(_scaffoldKey);
          }
        }
      }).catchError((e) {
        print("Exception - inner error - paymentGatewaysScreen.dart - paystack - _chargeCard(): " + e.toString());
      });
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart - _chargeCard(): " + e.toString());
    }
  }

  PaymentCard _getCardFromUI() {
    return PaymentCard(
      number: _cCardNumber.text,
      cvc: _cCvv.text,
      expiryMonth: _month,
      expiryYear: _year,
    );
  }

  Future _getPaymentGateways() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getPaymentGateways().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.paymentGateway = result.data;
            } else {
              showSnackBar(key: _scaffoldKey, snackBarMessage: result.message.toString());
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart.dart - _getPaymentGateways():" + e.toString());
    }
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    try {
      print("_handlePaymentError ${response.code} ${response.message}");
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();

        if (response != null) {
          showOnlyLoaderDialog();
          if (screenId == 2 && membershipModel != null) {
            await _buyMemberShip('failed', 'razorpay', null);
          } else if (screenId == 1 && order != null) {
            await _orderCheckOut('failed', 'razorpay', null, 'razorpay');
          } else if (screenId == 3) {
            await _rechargeWallet('failed', 'razorpay', null);
          }
        }

        hideLoader();
        _tryAgainDialog(openCheckout);
        setState(() {});
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      showSnackBar(key: _scaffoldKey, snackBarMessage: AppLocalizations.of(context).lbl_transaction_failed);
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart -  _handlePaymentError" + e.toString());
    }
  }

  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      print("response   -  _handlePaymentSuccess   ${response.orderId} ${response.paymentId}");
      if (response != null && response.paymentId != null) {
        showOnlyLoaderDialog();

        if (screenId == 2 && membershipModel != null) {
          await _buyMemberShip('success', 'razorpay', '${response.paymentId}');
        } else if (screenId == 1 && order != null) {
          await _orderCheckOut('success', 'razorpay', '${response.paymentId}', 'razorpay');
        } else if (screenId == 3) {
          await _rechargeWallet('success', 'razorpay', '${response.paymentId}');
        }
      }
    } catch (e) {
      print("Exception - paymentGetwaysScreen.dart- _handlePaymentSuccess():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getPaymentGateways();
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
      if (totalAmount != null) {
        if (screenId == 2 && membershipModel != null) {
          totalAmount = membershipModel.price;
        }
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart.dart - _init():" + e.toString());
    }
  }

  Widget _productShimmer() {
    try {
      return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            //      margin: EdgeInsets.only(top: 15, bottom: 8),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: Card(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print("Exception - productDetailScreen.dart - _productShimmer():" + e.toString());
      return SizedBox();
    }
  }

  Future _save(int callId) async {
    try {
      if (_cCardNumber.text.trim().isNotEmpty && _cExpiry.text.trim().isNotEmpty && _cCvv.text.trim().isNotEmpty && _cName.text.trim().isNotEmpty) {
        if (_formKey.currentState.validate()) {
          bool isConnected = await br.checkConnectivity();
          if (isConnected) {
            showOnlyLoaderDialog();
            CardModel stripeCard = CardModel(
              number: _cCardNumber.text,
              expiryMonth: _month,
              expiryYear: _year,
              cvv: _cCvv.text,
            );

            if (callId == 1) {
              payStack(global.paymentGateway.paystack.paystackSeckeyKey);
            } else {
              await stripe(card: stripeCard, amount: totalAmount.toInt() * 100, currency: '${global.appInfo.paymentCurrency}');
            }
          }
        }
      }
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart - _save(): " + e.toString());
    }
  }

  _startAfreshCharge(int price) async {
    try {
      Charge charge = Charge()
        ..amount = price
        ..email = '${global.currentUser.email}'
        ..currency = '${global.appInfo.paymentCurrency}'
        ..card = _getCardFromUI()
        ..reference = _getReference();

      _chargeCard(charge);
    } catch (e) {
      print("Exception - paymentGatewaysScreen.dart - _startAfreshCharge(): " + e.toString());
    }
  }

  _tryAgainDialog(Function onClickAction) {
    try {
      showCupertinoDialog(
          context: context,
          builder: (BuildContext context) {
            return Theme(
              data: ThemeData(dialogBackgroundColor: Colors.white),
              child: CupertinoAlertDialog(
                title: Text(
                  AppLocalizations.of(context).lbl_transaction_failed,
                ),
                content: Text(
                  AppLocalizations.of(context).txt_please_try_again,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      AppLocalizations.of(context).lbl_cancel,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(AppLocalizations.of(context).lbl_try_again),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showOnlyLoaderDialog();
                      onClickAction();

                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          });
    } catch (e) {
      print('Exception - paymentGatewaysScreen.dart - _tryAgainDialog(): ' + e.toString());
    }
  }
}
