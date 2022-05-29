import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/membershipModel.dart';
import 'package:gomeat/screens/subscriptionDetailScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class MemberShipScreen extends BaseRoute {
  MemberShipScreen({a, o}) : super(a: a, o: o, r: 'MemberShipScreen');
  @override
  _MemberShipScreenState createState() => new _MemberShipScreenState();
}

class _MemberShipScreenState extends BaseRouteState {
  bool isloading = true;

  List<MembershipModel> _memberShipList = [];

  GlobalKey<ScaffoldState> _scaffoldKey;

  bool _isDataLoaded = false;
  _MemberShipScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return null;
      },
      child: Scaffold(
          key: _scaffoldKey,
          body: Container(
            decoration: global.isDarkModeEnable
                ? BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0, 0.65],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF50546F), Color(0xFF8085A3)],
                    ),
                  )
                : BoxDecoration(
                    gradient: LinearGradient(
                      stops: [0, 0.65],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF3E434F), Color(0xFF3E434F)],
                    ),
                  ),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height * 0.46,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/membership.png'),
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
                    height: MediaQuery.of(context).size.height * 0.46,
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      '${AppLocalizations.of(context).tle_membership}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).primaryTextTheme.headline3,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 35),
                  decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(40))),
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height * 0.46 + 50)),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text('${AppLocalizations.of(context).lbl_choose_plan}', style: Theme.of(context).primaryTextTheme.bodyText1),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 35, right: 35, bottom: 5),
                        child: Text(
                          '${AppLocalizations.of(context).txt_membership_desc}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.headline2,
                        ),
                      ),
                      Expanded(
                          child: _isDataLoaded
                              ? _memberShipList.length > 0
                                  ? ListView.builder(
                                      itemCount: _memberShipList.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => SubscriptionDetailScreen(_memberShipList[index], a: widget.analytics, o: widget.observer),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: CachedNetworkImage(
                                              imageUrl: global.appInfo.imageUrl + _memberShipList[index].image,
                                              imageBuilder: (context, imageProvider) => Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                                                ),
                                              ),
                                              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                              errorWidget: (context, url, error) => Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15),
                                                  image: DecorationImage(image: AssetImage('${global.defaultImage}'), fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            margin: EdgeInsets.only(left: 10, bottom: 10),
                                            width: MediaQuery.of(context).size.width,
                                            height: 100,
                                          ),
                                        );
                                      })
                                  : Center(
                                      child: Text(
                                        "${AppLocalizations.of(context).txt_nothing_to_show}",
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                    )
                              : _shimmerWidget()

                         
                          ),
                    ],
                  ),
                )
              ],
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
    _getData();
  }

  _getData() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getMembershipList().then((result) {
          if (result != null && result.statusCode == 200 && result.status == '1') {
            _memberShipList = result.data;
          }
        });
        _isDataLoaded = true;
        setState(() {});
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - membershipscreen.dart - _getData():" + e.toString());
    }
  }

  Widget _shimmerWidget() {
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
                    height: 100,
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
      print("Exception - memberShipScreen.dart - _shimmerWidget():" + e.toString());
      return SizedBox();
    }
  }
}
