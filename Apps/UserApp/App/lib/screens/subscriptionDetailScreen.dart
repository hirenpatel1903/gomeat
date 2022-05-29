import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/membershipModel.dart';
import 'package:gomeat/screens/paymentGatewayScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SubscriptionDetailScreen extends BaseRoute {
  final MembershipModel membershipModel;
  SubscriptionDetailScreen(this.membershipModel, {a, o}) : super(a: a, o: o, r: 'SubscriptionDetailScreen');
  @override
  _SubscriptionDetailScreenState createState() => new _SubscriptionDetailScreenState(this.membershipModel);
}

class _SubscriptionDetailScreenState extends BaseRouteState {
  bool isloading = true;
  final MembershipModel membershipModel;
  _SubscriptionDetailScreenState(this.membershipModel) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF4179dd),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/subscription_detail.png'),
                ),
              ),
            ),
            Positioned(
              top: 30,
              left: global.isRTL ? null : 10,
              right: global.isRTL ? 10 : null,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(MdiIcons.arrowLeft, color: Colors.white),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.07,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.50,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  '${AppLocalizations.of(context).tle_platinum_pro}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.headline3,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.50 + 50)),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                    child: Text('${AppLocalizations.of(context).lbl_subscription_plan}', style: Theme.of(context).primaryTextTheme.bodyText1),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                              contentPadding: EdgeInsets.all(4),
                              title: Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                runSpacing: 0,
                                spacing: 10,
                                children: _wrapWidgetList(),
                              )),
                          Divider(),
                          ListTile(
                            contentPadding: EdgeInsets.all(4),
                            title: Html(
                              data: "${membershipModel.planDescription}",
                              style: {
                                "body": Style(
                                    color: Theme.of(context).primaryTextTheme.headline2.color,
                                    fontFamily: Theme.of(context).primaryTextTheme.headline2.fontFamily,
                                    fontSize: FontSize(Theme.of(context).primaryTextTheme.headline2.fontSize),
                                    fontWeight: Theme.of(context).primaryTextTheme.headline2.fontWeight),
                              },
                            ),
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
            margin: EdgeInsets.all(10.0),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentGatewayScreen(screenId: 2, membershipModel: membershipModel, totalAmount: membershipModel.price, a: widget.analytics, o: widget.observer),
                    ),
                  );
                },
                child: Text(
                  '${AppLocalizations.of(context).btn_subscribe_this_plan}',
                )),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.transparent,
            ),
            margin: EdgeInsets.all(8.0),
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '${AppLocalizations.of(context).btn_explore_other_plan}',
                  style: TextStyle(fontSize: 16, color: global.isDarkModeEnable ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor, fontWeight: FontWeight.w400),
                )),
          ),
        ],
      ),
    );
  }

  List<Widget> _wrapWidgetList() {
    List<Widget> _widgetList = [];
    try {
      if (membershipModel.freeDelivery != null && membershipModel.freeDelivery > 0) {
        _widgetList.add(
          Chip(
            padding: EdgeInsets.zero,
            backgroundColor: global.isDarkModeEnable ? Color(0xFF435276) : Color(0xFFEDF2F6),
            label: Text(
              'Free Delivery',
              style: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }

      if (membershipModel.instantDelivery != null && membershipModel.instantDelivery > 0) {
        _widgetList.add(
          Chip(
            padding: EdgeInsets.zero,
            backgroundColor: global.isDarkModeEnable ? Color(0xFF435276) : Color(0xFFEDF2F6),
            label: Text(
              'Instant Delivery',
              style: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }

      if (membershipModel.days != null && membershipModel.days > 0) {
        _widgetList.add(
          Chip(
            padding: EdgeInsets.zero,
            backgroundColor: global.isDarkModeEnable ? Color(0xFF435276) : Color(0xFFEDF2F6),
            label: Text(
              '${membershipModel.days} Days',
              style: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }

      if (membershipModel.reward != null && membershipModel.reward > 0) {
        _widgetList.add(
          Chip(
            padding: EdgeInsets.zero,
            backgroundColor: global.isDarkModeEnable ? Color(0xFF435276) : Color(0xFFEDF2F6),
            label: Text(
              '${membershipModel.reward}x Reward Points',
              style: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
      if (membershipModel.price != null && membershipModel.price > 0) {
        _widgetList.add(
          Chip(
            padding: EdgeInsets.zero,
            backgroundColor: global.isDarkModeEnable ? Color(0xFF435276) : Color(0xFFEDF2F6),
            label: Text(
              '${membershipModel.price} ${global.appInfo.currencySign}',
              style: TextStyle(fontSize: 13, color: global.isDarkModeEnable ? Colors.white : Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
      return _widgetList;
    } catch (e) {
      print("Exception - subscriptionDetailScreen.dart - _wrapWidgetList():   " + e.toString());
      _widgetList.add(SizedBox());
      return _widgetList;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
