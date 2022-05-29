import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/walletModel.dart';
import 'package:gomeat/screens/paymentGatewayScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class WalletScreen extends BaseRoute {
  WalletScreen({a, o}) : super(a: a, o: o, r: 'WalletScreen');
  @override
  _WalletScreenState createState() => new _WalletScreenState();
}

class _WalletScreenState extends BaseRouteState {
  ScrollController _rechargeHistoryScrollController = ScrollController();
  ScrollController _walletSpentScrollController = ScrollController();
  TextEditingController _cAmount = new TextEditingController();
  int rechargeHistoryPage = 1;
  int walletSpentPage = 1;
  bool _isDataLoaded = false;
  bool _isRechargeHistoryPending = true;
  bool _isSpentHistoryPending = true;
  bool _isRechargeHistoryMoreDataLoaded = false;
  bool _isSpentHistoryMoreDataLoaded = false;
  List<Wallet> _walletRechargeHistoryList = [];
  List<Wallet> _walletSpentHistoryList = [];
  GlobalKey<ScaffoldState> _scaffoldKey;
  _WalletScreenState() : super();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
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
            centerTitle: true,
            title: Text("${AppLocalizations.of(context).btn_my_wallet}"),
          ),
          body: _isDataLoaded
              ? Column(
                  children: [
                    Text(
                      "${AppLocalizations.of(context).lbl_available_balance}",
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text("${global.appInfo.currencySign} ${global.currentUser.wallet}", style: Theme.of(context).primaryTextTheme.bodyText1.copyWith(fontWeight: FontWeight.w700)),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 80,
                          child: AppBar(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            backgroundColor: global.isDarkModeEnable ? Color(0xFF435276) : Color(0xFFEDF2F6),
                            bottom: TabBar(
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  width: 3.0,
                                  color: global.isDarkModeEnable ? Theme.of(context).primaryColor : Color(0xFFEF5656),
                                ),
                                insets: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              labelColor: global.isDarkModeEnable ? Colors.white : Colors.black,
                              indicatorWeight: 4,
                              unselectedLabelStyle: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.w400),
                              labelStyle: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: global.isDarkModeEnable ? Theme.of(context).primaryColor : Color(0xFFEF5656),
                              tabs: [
                                Tab(
                                    icon: Icon(
                                      MdiIcons.wallet,
                                      size: 18,
                                    ),
                                    child: Text(
                                      '${AppLocalizations.of(context).lbl_recharge_history}',
                                      textAlign: TextAlign.center,
                                    )),
                                Tab(
                                    icon: Icon(
                                      MdiIcons.walletPlus,
                                      size: 18,
                                    ),
                                    child: Text(
                                      '${AppLocalizations.of(context).lbl_wallet_recharge}',
                                      textAlign: TextAlign.center,
                                    )),
                                Tab(
                                    icon: Icon(
                                      MdiIcons.currencyInr,
                                      size: 18,
                                    ),
                                    child: Text(
                                      '${AppLocalizations.of(context).lbl_spent_analysis}',
                                      textAlign: TextAlign.center,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: TabBarView(
                          children: [
                            _rechargeHistoryWidget(),
                            _rechargeWallet(),
                            _spentAnalysis(),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : _shimmerWidget(),
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

  _getWalletRechargeHistory() async {
    try {
      if (_isRechargeHistoryPending) {
        setState(() {
          _isRechargeHistoryMoreDataLoaded = true;
        });
        if (_walletRechargeHistoryList.isEmpty) {
          rechargeHistoryPage = 1;
        } else {
          rechargeHistoryPage++;
        }
        await apiHelper.getWalletRechargeHistory(rechargeHistoryPage).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Wallet> _tList = result.data;
              if (_tList.isEmpty) {
                _isRechargeHistoryPending = false;
              }
              _walletRechargeHistoryList.addAll(_tList);
              setState(() {
                _isRechargeHistoryMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - walletScreen.dart  - _getWalletRechargeHistory():" + e.toString());
    }
  }

  _getWalletSpentHistory() async {
    try {
      if (_isSpentHistoryPending) {
        setState(() {
          _isSpentHistoryMoreDataLoaded = true;
        });
        if (_walletSpentHistoryList.isEmpty) {
          walletSpentPage = 1;
        } else {
          walletSpentPage++;
        }
        await apiHelper.getWalletSpentHistory(walletSpentPage).then((result) async {
          if (result != null) {
            if (result.status == "1") {
              List<Wallet> _tList = result.data;
              if (_tList.isEmpty) {
                _isSpentHistoryPending = false;
              }
              _walletSpentHistoryList.addAll(_tList);
              setState(() {
                _isSpentHistoryMoreDataLoaded = false;
              });
            }
          }
        });
      }
    } catch (e) {
      print("Exception - walletScreen.dart  - _getWalletSpentHistory():" + e.toString());
    }
  }

  _init() async {
    try {
      await _getWalletRechargeHistory();
      await _getWalletSpentHistory();
      _rechargeHistoryScrollController.addListener(() async {
        if (_rechargeHistoryScrollController.position.pixels == _rechargeHistoryScrollController.position.maxScrollExtent && !_isRechargeHistoryMoreDataLoaded) {
          setState(() {
            _isRechargeHistoryMoreDataLoaded = true;
          });
          await _getWalletRechargeHistory();
          setState(() {
            _isRechargeHistoryMoreDataLoaded = false;
          });
        }
      });

      _walletSpentScrollController.addListener(() async {
        if (_walletSpentScrollController.position.pixels == _walletSpentScrollController.position.maxScrollExtent && !_isSpentHistoryMoreDataLoaded) {
          setState(() {
            _isSpentHistoryMoreDataLoaded = true;
          });
          await _getWalletSpentHistory();
          setState(() {
            _isSpentHistoryMoreDataLoaded = false;
          });
        }
      });
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - walletScreen.dart - _init():" + e.toString());
    }
  }

  Widget _rechargeHistoryWidget() {
    return _walletRechargeHistoryList.length > 0
        ? SingleChildScrollView(
            controller: _rechargeHistoryScrollController,
            child: Column(
              children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _walletRechargeHistoryList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 6.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      color: global.isDarkModeEnable ? Color(0xFF373C58) : Color(0xFFF2F5F8),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                    child: Text(
                                      '${_walletRechargeHistoryList[index].paymentGateway}',
                                      style: Theme.of(context).primaryTextTheme.headline2,
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                  Icon(
                                    MdiIcons.checkDecagram,
                                    size: 20,
                                    color: _walletRechargeHistoryList[index].rechargeStatus == 'success' ? Colors.greenAccent : Colors.red,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      '${_walletRechargeHistoryList[index].rechargeStatus}',
                                      style: Theme.of(context).primaryTextTheme.headline2,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            ListTile(
                              visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                              contentPadding: EdgeInsets.all(0),
                              minLeadingWidth: 0,
                              title: Text(
                                '${_walletRechargeHistoryList[index].dateOfRecharge}',
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                              ),
                              trailing: Text(
                                "${global.appInfo.currencySign} ${_walletRechargeHistoryList[index].amount}",
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                              ),
                            ),
                            Divider(
                              color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color.withOpacity(0.05) : Theme.of(context).dividerTheme.color,
                            ),
                          ],
                        ),
                      );
                    }),
                _isRechargeHistoryMoreDataLoaded
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
          );
  }

  Widget _rechargeWallet() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(0.0))),
            child: TextFormField(
              controller: _cAmount,
              keyboardType: TextInputType.number,
              style: Theme.of(context).primaryTextTheme.bodyText1,
              inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: '${AppLocalizations.of(context).hnt_enter_amount}',
                prefixIcon: Icon(
                  MdiIcons.currencyInr,
                  color: Theme.of(context).inputDecorationTheme.hintStyle.color,
                ),
                contentPadding: EdgeInsets.only(top: 10),
              ),
            ),
          ),
          Divider(
            color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color.withOpacity(0.05) : Theme.of(context).dividerTheme.color,
          ),
          Container(
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
                  if (_cAmount.text.trim().isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentGatewayScreen(screenId: 3, totalAmount: int.parse(_cAmount.text.trim()), a: widget.analytics, o: widget.observer),
                      ),
                    );
                  } else
                    showSnackBar(key: _scaffoldKey, snackBarMessage: '${AppLocalizations.of(context).txt_enter_amount}');
                },
                child: Text('${AppLocalizations.of(context).btn_make_payment}')),
          )
        ],
      ),
    );
  }

  Widget _shimmerWidget() {
    try {
      return Padding(
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 0, top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: SizedBox(
                  height: 80,
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  child: Card(),
                ),
              ),
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
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Card(),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Card(),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      width: 20,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      child: SizedBox(
                        height: 80,
                        width: MediaQuery.of(context).size.width / 3 - 20,
                        child: Card(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
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
                          child: SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Card(),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ));
    } catch (e) {
      print("Exception - walletScreen.dart - _shimmerWidget():" + e.toString());
      return SizedBox();
    }
  }

  Widget _spentAnalysis() {
    return _walletSpentHistoryList.length > 0
        ? SingleChildScrollView(
            controller: _walletSpentScrollController,
            child: Column(
              children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _walletSpentHistoryList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: global.isDarkModeEnable ? Color(0xFF373C58) : Color(0xFFF2F5F8),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                child: Text(
                                  '#${_walletSpentHistoryList[index].cartId}',
                                  style: Theme.of(context).primaryTextTheme.bodyText1,
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Text(
                                "${global.appInfo.currencySign} ${_walletSpentHistoryList[index].paidbywallet}",
                                style: Theme.of(context).primaryTextTheme.bodyText1,
                              )
                            ],
                          ),
                          Divider(
                            color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color.withOpacity(0.05) : Theme.of(context).dividerTheme.color,
                          ),
                        ],
                      );
                    }),
                _isRechargeHistoryMoreDataLoaded
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
          );
  }
}
