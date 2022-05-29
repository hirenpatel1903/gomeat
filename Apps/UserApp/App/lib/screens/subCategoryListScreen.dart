import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/models/categoryModel.dart';
import 'package:gomeat/models/subcategoryModel.dart';
import 'package:gomeat/screens/productListScreen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SubcategoryListScreen extends BaseRoute {
  final Category category;
  SubcategoryListScreen(this.category, {a, o}) : super(a: a, o: o, r: 'SubcategoryListScreen');
  @override
  _SubcategoryListScreenState createState() => new _SubcategoryListScreenState(this.category);
}

class _SubcategoryListScreenState extends BaseRouteState {
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<Subcategory> _subCategoryList = [];

  bool _isDataLoaded = false;
  int page = 1;
  Category category;
  _SubcategoryListScreenState(this.category) : super();
  bool _isRecordPending = true;
  bool _isMoreDataLoaded = false;
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    print("width  ${MediaQuery.of(context).size.width} - height ${MediaQuery.of(context).size.height}");
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
            title: Text("${category.title}"),
          ),
          body: _categoryWidget()),
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
      print("Exception - subcategoryListScreen.dart - _init():" + e.toString());
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
          if (_subCategoryList.isEmpty) {
            page = 1;
          } else {
            page++;
          }
          await apiHelper.getSubCategoryList(page, category.catId).then((result) async {
            if (result != null) {
              if (result.status == "1") {
                List<Subcategory> _tList = result.data;
                if (_tList.isEmpty) {
                  _isRecordPending = false;
                }
                _subCategoryList.addAll(_tList);
                setState(() {
                  _isMoreDataLoaded = false;
                });
              } else {
                _isRecordPending = false;
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
      print("Exception - subcategoryListScreen.dart - _init():" + e.toString());
    }
  }

  List<Widget> _subCategoryListWidget() {
    List<Widget> productList = [];

    for (int i = 0; i < _subCategoryList.length; i++) {
      productList.add(
        InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductListScreen(1, _subCategoryList[i].title, subcategoryId: _subCategoryList[i].catId, a: widget.analytics, o: widget.observer),
              ),
            );
          },
          child: Container(
            height: 140,
            margin: EdgeInsets.only(top: 30, left: 4, right: 4),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  width: (MediaQuery.of(context).size.width / 3) - 11,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 78, left: 7, right: 7),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_subCategoryList[i].title}',
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${_subCategoryList[i].productCount}+ items',
                                style: Theme.of(context).primaryTextTheme.headline2,
                              ),
                            
                              Image.asset('assets/orange_next.png'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: -30,
                  child: Container(
                   
                    child: CachedNetworkImage(
                      imageUrl: global.appInfo.imageUrl + _subCategoryList[i].image,
                      imageBuilder: (context, imageProvider) => Container(
                     
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
                    height: 90,
                    width: 110,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    if (_isMoreDataLoaded) {
      productList.add(Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          strokeWidth: 2,
        ),
      ));
    }

    return productList;
  }

  _categoryWidget() {
    return RefreshIndicator(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      color: Theme.of(context).primaryColor,
      onRefresh: () async {
        _isDataLoaded = false;
        _isRecordPending = true;
        setState(() {});
        _subCategoryList.clear();
        await _init();
        return null;
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4, top: 10),
          child: _isDataLoaded
              ? _subCategoryList.isNotEmpty
                  ? Wrap(
                      spacing: 0,
                      runSpacing: 10,
                      children: _subCategoryListWidget(),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height - 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${AppLocalizations.of(context).txt_nothing_to_show}",
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
              : Wrap(
                  spacing: 0,
                  runSpacing: 10,
                  children: catgoryShimmer(),
                ),
        ),
      ),
    );
  }

  
}
