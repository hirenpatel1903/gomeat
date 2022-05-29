import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/notificationModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends BaseRoute {
  NotificationScreen({a, o}) : super(a: a, o: o, r: 'NotificationScreen');
  @override
  _NotificationScreenState createState() => new _NotificationScreenState();
}

class _NotificationScreenState extends BaseRouteState {
  List<NotificationModel> _notificationList = [];
  bool _isDataLoaded = false;
  int page = 1;
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  ScrollController _scrollController = ScrollController();
  _NotificationScreenState() : super();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          title: Text("${AppLocalizations.of(context).tle_notification}"),
          actions: [
            _notificationList.length > 0
                ? IconButton(
                    onPressed: () async {
                      await deleteConfirmationDialog();
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).primaryColor,
                    ))
                : SizedBox()
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              _isDataLoaded = false;
              _isRecordPending = true;
              _notificationList.clear();
              setState(() {});
              await _init();
            },
            child: _isDataLoaded
                ? _notificationList.length > 0
                    ? SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _notificationList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      leading: Container(
                                          height: 50,
                                          width: 50,
                                          alignment: Alignment.center,
                                          child: _notificationList[index].image != null
                                              ? CachedNetworkImage(
                                                  imageUrl: global.appInfo.imageUrl + _notificationList[index].image,
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
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(image: AssetImage('${global.defaultImage}'), fit: BoxFit.cover),
                                                  ),
                                                )),
                                      title: Text(
                                        _notificationList[index].notiTitle,
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                      subtitle: RichText(
                                        text: TextSpan(
                                          text: "${_notificationList[index].notiMessage}",
                                          style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Theme.of(context).primaryTextTheme.overline.color.withOpacity(0.6), letterSpacing: 0.1),
                                          children: [
                                            TextSpan(
                                              text: '\n${br.timeString(_notificationList[index].createdAt)}',
                                              style: Theme.of(context).primaryTextTheme.button.copyWith(color: Theme.of(context).primaryTextTheme.button.color.withOpacity(0.4)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color : Color(0xFFDFE8EF),
                                    ),
                                  ],
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
                : _shimmerWidget(),
          ),
        ),
      ),
    );
  }

  Future deleteConfirmationDialog() async {
    try {
      await showCupertinoDialog<bool>(
        context: context,
        builder: (context) => Theme(
          data: ThemeData(dialogBackgroundColor: Colors.white),
          child: CupertinoAlertDialog(
            title: Text(
              "${AppLocalizations.of(context).lbl_delete_notification}",
            ),
            content: Text(
              "${AppLocalizations.of(context).txt_delete_notification_desc}",
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  '${AppLocalizations.of(context).btn_ok}',
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _deleteAllNotification();
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
      print("Exception - notificationScreen.dart - deleteConfirmationDialog():" + e.toString());
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
    _init();
  }

  _deleteAllNotification() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        showOnlyLoaderDialog();
        await apiHelper.deleteAllNotification().then((result) async {
          if (result != null) {
            if (result.status == "1") {
              hideLoader();
              _notificationList.clear();
              setState(() {});
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - notificationScreen.dart - _deleteAllNotification():" + e.toString());
    }
  }

  _getData() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          if (_notificationList.isEmpty) {
            page = 1;
          } else {
            page++;
          }
          await apiHelper.getAllNotification(page).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                List<NotificationModel> _tList = result.data;
                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }
                _notificationList.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              }
            }
          });
        }
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print("Exception - notificationScreen.dart - _getData():" + e.toString());
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
      print("Exception - notificationScreen.dart - _init():" + e.toString());
    }
  }

  Widget _shimmerWidget() {
    try {
      return ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
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
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Card(),
                  ),
                  Divider(
                    color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color : Color(0xFFDFE8EF),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print("Exception - notificationScreen.dart - _shimmerWidget():" + e.toString());
      return SizedBox();
    }
  }
}
