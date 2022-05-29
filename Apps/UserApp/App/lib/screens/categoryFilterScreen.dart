import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/categoryFilterModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CategoryFilterScreen extends BaseRoute {
  final CatgoryFilter categoryFiter;
  CategoryFilterScreen(this.categoryFiter, {a, o}) : super(a: a, o: o, r: 'CategoryFilterScreen');
  @override
  _CategoryFilterScreenState createState() => new _CategoryFilterScreenState(this.categoryFiter);
}

class _CategoryFilterScreenState extends BaseRouteState {
  CatgoryFilter categoryFiter;
  int _selectedName;
  int _selectedSorting;
  _CategoryFilterScreenState(this.categoryFiter) : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${AppLocalizations.of(context).tle_filter_option}"),
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.center,
              child: Icon(FontAwesomeIcons.windowClose),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _selectedSorting = null;
                  _selectedName = null;
                  categoryFiter.byname = null;
                  categoryFiter.latest = null;
                  Navigator.of(context).pop(categoryFiter);
                },
                icon: Icon(
                  MdiIcons.syncIcon,
                  color: Theme.of(context).appBarTheme.actionsIconTheme.color,
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 10),
                    child: Text(
                      '${AppLocalizations.of(context).lbl_sort_by_name}',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _selectedName,
                      onChanged: (val) {
                        _selectedName = val;
                        setState(() {});
                      },
                    ),
                    Text(
                      "${AppLocalizations.of(context).txt_A_Z}",
                      style: _selectedName == 1
                          ? Theme.of(context).primaryTextTheme.headline2.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PoppinsMedium',
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                              )
                          : Theme.of(context).primaryTextTheme.headline2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Radio(
                          value: 2,
                          groupValue: _selectedName,
                          onChanged: (val) {
                            _selectedName = val;
                            setState(() {});
                          }),
                    ),
                    Text(
                      "${AppLocalizations.of(context).txt_Z_A}",
                      style: _selectedName == 2
                          ? Theme.of(context).primaryTextTheme.headline2.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PoppinsMedium',
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                              )
                          : Theme.of(context).primaryTextTheme.headline2,
                    ),
                  ],
                ),
                Divider(),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      '${AppLocalizations.of(context).lbl_sort_by}',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _selectedSorting,
                      onChanged: (val) {
                        _selectedSorting = val;
                        setState(() {});
                      },
                    ),
                    Text(
                      "${AppLocalizations.of(context).lbl_latest}",
                      style: _selectedSorting == 3
                          ? Theme.of(context).primaryTextTheme.headline2.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PoppinsMedium',
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                              )
                          : Theme.of(context).primaryTextTheme.headline2,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Radio(
                          value: 4,
                          groupValue: _selectedSorting,
                          onChanged: (val) {
                            _selectedSorting = val;
                            setState(() {});
                          }),
                    ),
                    Text(
                      "${AppLocalizations.of(context).lbl_old}",
                      style: _selectedSorting == 4
                          ? Theme.of(context).primaryTextTheme.headline2.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PoppinsMedium',
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                              )
                          : Theme.of(context).primaryTextTheme.headline2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), gradient: LinearGradient(stops: [0, .90], begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Theme.of(context).primaryColorLight, Theme.of(context).primaryColor])),
                margin: EdgeInsets.all(15.0),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: () {
                      if (_selectedName != null) {
                        if (_selectedName == 1) {
                          categoryFiter.byname = 'ASC';
                        } else {
                          categoryFiter.byname = 'DESC';
                        }
                      }
                      if (_selectedSorting != null) {
                        if (_selectedSorting == 3) {
                          categoryFiter.latest = 'ASC';
                        } else {
                          categoryFiter.latest = 'DESC';
                        }
                      }

                      Navigator.of(context).pop(categoryFiter);
                    },
                    child: Text('${AppLocalizations.of(context).btn_apply_filter}')),
              ),
            ),
          ],
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
    if (categoryFiter.byname != null) {
      if (categoryFiter.byname == 'ASC') {
        _selectedName = 1;
      } else {
        _selectedName = 2;
      }
    }
    if (categoryFiter.latest != null) {
      if (categoryFiter.latest == 'ASC') {
        _selectedSorting = 3;
      } else {
        _selectedSorting = 4;
      }
    }
  }
}
