import 'dart:convert';

import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/baseurl/baseurlg.dart';
import 'package:driver/beanmodel/appinfo.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDrawer extends StatelessWidget {
  BuildContext _buildContext;

  AccountDrawer(this._buildContext);

  Future getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // hitAppInfo();
    return prefs.getString('boy_name');
  }

  void hitAppInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var http = Client();
    http.post(appInfoUri, body: {'user_id': ''}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        AppInfoModel data1 = AppInfoModel.fromJson(jsonDecode(value.body));
        if (data1.status == "1" || data1.status == 1) {
          prefs.setString('app_currency', '${data1.currencySign}');
          prefs.setString('app_referaltext', '${data1.refertext}');
          prefs.setString('numberlimit', '${data1.phoneNumberLength}');
          prefs.setString('imagebaseurl', '${data1.imageUrl}');
          getImageBaseUrl();
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/menubg.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                alignment: Alignment.centerLeft,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      hitAppInfo();
                    }
                    return Text((snapshot.hasData != null) ? locale.hey + ', ' + '${snapshot.data}' : '${locale.hey}\, User', textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline5);
                  },
                  future: getSharedValue(),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  buildListTile(context, Icons.home, locale.home, () => Navigator.popAndPushNamed(context, PageRoutes.homePage)),
                  // buildListTile(
                  //     context,
                  //     Icons.account_balance_wallet,
                  //     locale.wallet,
                  //         () =>
                  //         Navigator.popAndPushNamed(context, PageRoutes.walletPage)),
                  buildListTile(context, Icons.account_box, locale.myAccount, () => Navigator.popAndPushNamed(context, PageRoutes.editProfilePage)),
                  buildListTile(context, Icons.insert_chart, locale.insight, () => Navigator.popAndPushNamed(context, PageRoutes.insightPage)),
                  buildListTile(context, Icons.food_bank_sharp, locale.sendToBank, () => Navigator.popAndPushNamed(context, PageRoutes.addToBank)),
                  buildListTile(context, Icons.view_list, locale.aboutUs, () => Navigator.popAndPushNamed(context, PageRoutes.aboutus)),
                  buildListTile(context, Icons.notifications_active, 'NOTIFICATION', () => Navigator.popAndPushNamed(context, PageRoutes.notificationList)),
                  buildListTile(context, Icons.admin_panel_settings_rounded, locale.tnc, () => Navigator.popAndPushNamed(context, PageRoutes.tnc)),
                  buildListTile(context, Icons.chat, locale.helpCenter, () => Navigator.popAndPushNamed(context, PageRoutes.contactUs)),
                  buildListTile(context, Icons.language, locale.language, () => Navigator.popAndPushNamed(context, PageRoutes.languagePage)),
                  LogoutTile(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ListTile buildListTile(BuildContext context, IconData icon, String text, Function onTap) {
    var theme = Theme.of(context);

    return ListTile(
      leading: Icon(icon, color: theme.primaryColor),
      title: Text(text.toUpperCase(), style: theme.textTheme.headline6.copyWith(fontSize: 18, letterSpacing: 0.8).copyWith(color: theme.scaffoldBackgroundColor)),
      onTap: onTap,
    );
  }
}

class LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    var theme = Theme.of(context);
    return ListTile(
      leading: Icon(Icons.exit_to_app, color: kMainColor),
      title: Text(locale.logout.toUpperCase(), style: theme.textTheme.headline6.copyWith(fontSize: 18, letterSpacing: 0.8).copyWith(color: theme.scaffoldBackgroundColor)),
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Logging out'),
                content: Text('Are you sure?'),
                actions: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                      shadowColor: MaterialStateProperty.all(Colors.transparent),
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: Text(
                      'No',
                      style: TextStyle(color: kMainColor),
                    ),
                    //textColor: kMainColor,
                    //shape: RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        foregroundColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        'Yes',
                        style: TextStyle(color: kMainColor),
                      ),
                      // shape: RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
                      // textColor: kMainColor,
                      onPressed: () async {
                        SharedPreferences pref = await SharedPreferences.getInstance();
                        pref.clear().then((value) {
                          if (value) {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                              return DeliveryBoyLogin();
                            }), (Route<dynamic> route) => false);
                          }
                        });
                      })
                ],
              );
            });
      },
    );
    //   buildListTile(context, Icons.exit_to_app, locale.logout,
    //         () async {
    //   SharedPreferences.getInstance().then((prefs) {
    //     prefs.clear().then((value) {
    //       // Phoenix.rebirth(context);
    //       Navigator.pushAndRemoveUntil(context,
    //           MaterialPageRoute(builder: (context) {
    //             return DeliveryBoyHome(false);
    //           }), (Route<dynamic> route) => false);
    //     });
    //   });
    // });
  }
}
