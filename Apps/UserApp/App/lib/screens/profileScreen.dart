import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/userModel.dart';
import 'package:gomeat/screens/aboutUsAndTermsOfServiceScreen.dart';
import 'package:gomeat/screens/addressListScreen.dart';
import 'package:gomeat/screens/chatScreen.dart';
import 'package:gomeat/screens/chooseLanguageScreen.dart';
import 'package:gomeat/screens/contactUsScreen.dart';
import 'package:gomeat/screens/loginScreen.dart';
import 'package:gomeat/screens/memberShipScreen.dart';
import 'package:gomeat/screens/notificationScreen.dart';
import 'package:gomeat/screens/orderListScreen.dart';
import 'package:gomeat/screens/productRequestScreen.dart';
import 'package:gomeat/screens/profileEditScreen.dart';
import 'package:gomeat/screens/referAndEarnScreen.dart';
import 'package:gomeat/screens/rewardScreen.dart';
import 'package:gomeat/screens/settingScreen.dart';
import 'package:gomeat/screens/walletScreen.dart';
import 'package:gomeat/screens/wishListScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends BaseRoute {
  ProfileScreen({a, o}) : super(a: a, o: o, r: 'ProfileScreen');
  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends BaseRouteState {
  _ProfileScreenState() : super();
  bool _isDataLoaded = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Column(
          children: [
            _isDataLoaded
                ? Container(
                    height: 240,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(45),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor],
                      ),
                    ),
                    alignment: Alignment.topCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          height: 240,
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/myprofile.png'),
                              ),
                            ),
                            alignment: Alignment.topCenter,
                            child: Center(
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                child: global.currentUser.userImage != null
                                    ? CachedNetworkImage(
                                        imageUrl: global.appInfo.imageUrl + global.currentUser.userImage,
                                        imageBuilder: (context, imageProvider) => Container(
                                          height: 106,
                                          width: 106,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardTheme.color,
                                            borderRadius: new BorderRadius.all(
                                              new Radius.circular(106),
                                            ),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      )
                                    : CircleAvatar(
                                        radius: 53,
                                        child: Icon(
                                          Icons.person,
                                          size: 53,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 45,
                          child: Text(
                            "${global.currentUser.name}",
                            style: Theme.of(context).primaryTextTheme.headline6.copyWith(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: 25,
                          child: Text(
                            "+${global.appInfo.countryCode} ${global.currentUser.userPhone} | ${global.currentUser.email}",
                            style: Theme.of(context).primaryTextTheme.headline2.copyWith(color: Colors.white),
                          ),
                        ),
                        Positioned(
                          bottom: -20,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileEditScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                              child: Image.asset('assets/edit.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    child: Column(
                      children: [
                        SizedBox(
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          child: Card(),
                        ),
                      ],
                    ),
                  ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isDataLoaded
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OrderListScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.shoppingOutline,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 20,
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_my_orders}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AddressListScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.mapMarkerOutline,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 20,
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_manage_orders}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WalletScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.walletOutline,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 20,
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_my_wallet}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => WishListScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.heartOutline,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 20,
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_wishlist}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NotificationScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.bellOutline,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 20,
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_notification}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MemberShipScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.walletMembership,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 20,
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_membership}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RewardScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.walletMembership,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                              size: 20,
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_reward}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ReferAndEarnScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.accountConvert,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_refer_earn}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChooseLanguageScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.translate,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).tle_languages}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          Divider(),
                          global.nearStoreModel.id != null && global.appInfo.liveChat != null && global.appInfo.liveChat == 1
                              ? ListTile(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          a: widget.analytics,
                                          o: widget.observer,
                                        ),
                                      ),
                                    );
                                  },
                                  visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                                  minLeadingWidth: 30,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                                  leading: Icon(
                                    MdiIcons.comment,
                                    size: 20,
                                    color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                                  ),
                                  title: Text(
                                    "Live Chat",
                                    style: Theme.of(context).primaryTextTheme.bodyText1,
                                  ),
                                )
                              : SizedBox(),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductRequestScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.comment,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).lbl_make_product_request}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              global.isDarkModeEnable = !global.isDarkModeEnable;
                              Phoenix.rebirth(context);
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: global.isDarkModeEnable
                                ? Icon(
                                    Icons.dark_mode_outlined,
                                    color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                                  )
                                : Icon(
                                    Icons.light_mode,
                                    color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                                  ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_mode}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ContactUsScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              Icons.feedback_outlined,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).tle_contact_us}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AboutUsAndTermsOfServiceScreen(true, a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.textBox,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_about_app}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AboutUsAndTermsOfServiceScreen(false, a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.textBox,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).tle_term_of_service}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SettingScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.cogOutline,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_app_setting}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              global.sp.remove('currentUser');
                              global.currentUser = new CurrentUser();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(a: widget.analytics, o: widget.observer),
                                ),
                              );
                            },
                            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                            minLeadingWidth: 30,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0),
                            leading: Icon(
                              MdiIcons.logout,
                              size: 20,
                              color: Theme.of(context).primaryIconTheme.color.withOpacity(0.7),
                            ),
                            title: Text(
                              "${AppLocalizations.of(context).btn_logout}",
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                            ),
                          ),
                          SizedBox(
                            height: 70,
                          )
                        ],
                      ),
                    )
                  : _similarProductShimmer(),
            ))
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _similarProductShimmer() {
    try {
      return ListView.builder(
        itemCount: 10,
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
                    height: 56,
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
      print("Exception - profileScreen.dart - _similarProductShimmer():" + e.toString());
      return SizedBox();
    }
  }

  bool isloading = true;

  @override
  void initState() {
    super.initState();

    print("device id ${global.appDeviceId}");
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

  _init() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.myProfile().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              global.currentUser = result.data;
              global.sp.setString('currentUser', json.encode(global.currentUser.toJson()));
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
      _isDataLoaded = true;
      setState(() {});
    } catch (e) {
      print("Exception - profileScreen.dart - _init():" + e.toString());
    }
  }
}
