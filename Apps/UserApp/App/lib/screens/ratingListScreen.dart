import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/rateModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RatingListScreen extends BaseRoute {
  final int varientId;
  RatingListScreen(this.varientId, {a, o}) : super(a: a, o: o, r: 'RatingListScreen');
  @override
  _RatingListScreenState createState() => new _RatingListScreenState(this.varientId);
}

class _RatingListScreenState extends BaseRouteState {
  int varientId;
  List<Rate> _ratingList = [];
  bool _isDataLoaded = false;
  int page = 1;
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  GlobalKey<ScaffoldState> _scaffoldKey;
  ScrollController _scrollController = ScrollController();
  _RatingListScreenState(this.varientId) : super();

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
          title: Text("${AppLocalizations.of(context).tle_product_rating}"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RefreshIndicator(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            color: Theme.of(context).primaryColor,
            onRefresh: () async {
              _isDataLoaded = false;
              _isRecordPending = true;
              _ratingList.clear();
              setState(() {});
              await _init();
            },
            child: _isDataLoaded
                ? _ratingList.length > 0
                    ? SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _ratingList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(0),
                                      title: Text(
                                        _ratingList[index].userName,
                                        style: Theme.of(context).primaryTextTheme.bodyText1,
                                      ),
                                      subtitle: Text('${_ratingList[index].description}', style: Theme.of(context).primaryTextTheme.overline),
                                      trailing: RatingBar.builder(
                                        initialRating: _ratingList[index].rating,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 25,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Theme.of(context).primaryColorLight,
                                        ),
                                        ignoreGestures: true,
                                        updateOnDrag: false,
                                        onRatingUpdate: (val) {},
                                        tapOnlyMode: false,
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
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        if (_isRecordPending) {
          setState(() {
            _isMoreDataLoaded = true;
          });
          if (_ratingList.isEmpty) {
            page = 1;
          } else {
            page++;
          }
          await apiHelper.getProductRating(page, varientId).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                List<Rate> _tList = result.data;
                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }
                _ratingList.addAll(_tList);
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
      print("Exception - RatingListScreen.dart - _getData():" + e.toString());
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
      print("Exception - RatingListScreen.dart - _init():" + e.toString());
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
      print("Exception - RatingListScreen.dart - _shimmerWidget():" + e.toString());
      return SizedBox();
    }
  }
}
