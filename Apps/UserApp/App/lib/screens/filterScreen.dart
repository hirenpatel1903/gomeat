import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/productFilterModel.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FilterScreen extends BaseRoute {
  final ProductFilter productFilter;
  FilterScreen(this.productFilter, {a, o}) : super(a: a, o: o, r: 'FilterScreen');
  @override
  _FilterScreenState createState() => new _FilterScreenState(this.productFilter);
}

class _FilterScreenState extends BaseRouteState {
  ProductFilter productFilter;
  int _selectedName = 0;
  int _selectedRating;
  int _selectedDiscount;
  bool _isInStock = false;
  bool _isOutOfStock = false;
  RangeValues _currentRangeValues = RangeValues(0,0);
  _FilterScreenState(this.productFilter) : super();
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
                  productFilter.maxPrice = productFilter.minPrice = productFilter.maxDiscount = productFilter.minDiscount = productFilter.minRating = productFilter.maxRating = productFilter.stock = productFilter.byname = null;
                  Navigator.of(context).pop(productFilter);
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0, top: 10),
                    child: Text(
                      '${AppLocalizations.of(context).lbl_sort_by_rating}',
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
                      groupValue: _selectedRating,
                      onChanged: (val) {
                        _selectedRating = val;
                        setState(() {});
                      },
                    ),
                    Text(
                      "${AppLocalizations.of(context).txt_1_2_stars}",
                      style: _selectedRating == 3
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
                          groupValue: _selectedRating,
                          onChanged: (val) {
                            _selectedRating = val;
                            setState(() {});
                          }),
                    ),
                    Text(
                      "${AppLocalizations.of(context).txt_2_3_stars}",
                      style: _selectedRating == 4
                          ? Theme.of(context).primaryTextTheme.headline2.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PoppinsMedium',
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                              )
                          : Theme.of(context).primaryTextTheme.headline2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                        value: 5,
                        groupValue: _selectedRating,
                        onChanged: (val) {
                          _selectedRating = val;
                          setState(() {});
                        }),
                    Text(
                      "${AppLocalizations.of(context).txt_3_4_stars}",
                      style: _selectedRating == 5
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
                          value: 6,
                          groupValue: _selectedRating,
                          onChanged: (val) {
                            _selectedRating = val;
                            setState(() {});
                          }),
                    ),
                    Text(
                      "${AppLocalizations.of(context).txt_4_5_stars}",
                      style: _selectedRating == 6
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      '${AppLocalizations.of(context).lbl_sort_by_price}',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                ),
               
                RangeSlider(
                  values: _currentRangeValues,
                  min: 0,
                  max: double.parse(productFilter.maxPriceValue.toString()),
                  activeColor: Theme.of(context).primaryColorLight,
                  inactiveColor: Theme.of(context).primaryColor,
                  divisions: (productFilter.maxPriceValue.round() - 0),
                  labels: RangeLabels(
                    _currentRangeValues.start.round().toString(),
                    _currentRangeValues.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                    });
                  },
                ),
                Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      '${AppLocalizations.of(context).lbl_sort_by_discount}',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      value: 7,
                      groupValue: _selectedDiscount,
                      onChanged: (val) {
                        _selectedDiscount = val;
                        setState(() {});
                      },
                    ),
                    Text(
                      "${AppLocalizations.of(context).lbl_10_25_percent}",
                      style: _selectedDiscount == 7
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
                          value: 8,
                          groupValue: _selectedDiscount,
                          onChanged: (val) {
                            _selectedDiscount = val;
                            setState(() {});
                          }),
                    ),
                    Text(
                      "${AppLocalizations.of(context).lbl_25_50_percent}",
                      style: _selectedDiscount == 8
                          ? Theme.of(context).primaryTextTheme.headline2.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PoppinsMedium',
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                              )
                          : Theme.of(context).primaryTextTheme.headline2,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      value: 9,
                      groupValue: _selectedDiscount,
                      onChanged: (val) {
                        _selectedDiscount = val;
                        setState(() {});
                      },
                    ),
                    Text(
                      "${AppLocalizations.of(context).lbl_50_75_percent}",
                      style: _selectedDiscount == 9
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
                          value: 10,
                          groupValue: _selectedDiscount,
                          onChanged: (val) {
                            _selectedDiscount = val;
                            setState(() {});
                          }),
                    ),
                    Text(
                      "${AppLocalizations.of(context).lbl_above_70_percent}",
                      style: _selectedDiscount == 10
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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      '${AppLocalizations.of(context).lbl_sort_by_availability}',
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                        value: _isInStock,
                        onChanged: (val) {
                          _isInStock = val;
                          setState(() {});
                        }),
                    Text(
                      "${AppLocalizations.of(context).txt_in_stock}",
                      style: _isInStock
                          ? Theme.of(context).primaryTextTheme.headline2.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'PoppinsMedium',
                                color: Theme.of(context).primaryTextTheme.bodyText1.color,
                              )
                          : Theme.of(context).primaryTextTheme.headline2,
                    ),
                    Checkbox(
                        value: _isOutOfStock,
                        onChanged: (val) {
                          _isOutOfStock = val;
                          setState(() {});
                        }),
                    Text(
                      "${AppLocalizations.of(context).txt_out_of_stock}",
                      style: _isOutOfStock
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
                      _apply();
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
    _init();
  }

  _apply() {
    try {
      if (_selectedName != null) {
        if (_selectedName == 1) {
          productFilter.byname = 'ASC';
        } else {
          productFilter.byname = 'DESC';
        }
      }
      if (_selectedRating != null) {
        if (_selectedRating == 3) {
          productFilter.minRating = 1;
          productFilter.maxRating = 2;
        } else if (_selectedRating == 4) {
          productFilter.minRating = 2;
          productFilter.maxRating = 3;
        } else if (_selectedRating == 5) {
          productFilter.minRating = 3;
          productFilter.maxRating = 4;
        } else if (_selectedRating == 6) {
          productFilter.minRating = 4;
          productFilter.maxRating = 5;
        }
      }
      if (_selectedDiscount != null) {
        if (_selectedDiscount == 7) {
          productFilter.minDiscount = 10;
          productFilter.maxDiscount = 25;
        } else if (_selectedDiscount == 8) {
          productFilter.minDiscount = 25;
          productFilter.maxDiscount = 50;
        } else if (_selectedDiscount == 9) {
          productFilter.minDiscount = 50;
          productFilter.maxDiscount = 70;
        } else if (_selectedDiscount == 10) {
          productFilter.minDiscount = 70;
          productFilter.maxDiscount = 100;
        }
      }

      if (_isInStock != null && _isInStock == true && _isOutOfStock != null && _isOutOfStock == true) {
        productFilter.stock = 'all';
      } else if (_isInStock != null && _isInStock) {
        productFilter.stock = 'in';
      } else if (_isOutOfStock != null && _isOutOfStock) {
        productFilter.stock = 'out';
      }
      productFilter.minPrice = _currentRangeValues.start.round();
      productFilter.maxPrice = _currentRangeValues.end.round();
      Navigator.of(context).pop(productFilter);
    } catch (e) {
      print("Exception - filterScreen.dart- _apply():" + e.toString());
    }
  }

  _init() {
    try {
      if (productFilter.byname != null) {
        if (productFilter.byname == 'ASC') {
          _selectedName = 1;
        } else {
          _selectedName = 2;
        }
      }
      if (productFilter.minRating != null) {
        if (productFilter.minRating == 1 && productFilter.maxRating == 2) {
          _selectedRating = 3;
        } else if (productFilter.minRating == 2 && productFilter.maxRating == 3) {
          _selectedRating = 4;
        } else if (productFilter.minRating == 3 && productFilter.maxRating == 4) {
          _selectedRating = 5;
        } else if (productFilter.minRating == 4 && productFilter.maxRating == 5) {
          _selectedRating = 6;
        }
      }

      if (productFilter.minDiscount != null) {
        if (productFilter.minDiscount == 10 && productFilter.maxDiscount == 25) {
          _selectedDiscount = 7;
        } else if (productFilter.minDiscount == 25 && productFilter.maxDiscount == 50) {
          _selectedDiscount = 8;
        } else if (productFilter.minDiscount == 50 && productFilter.maxDiscount == 70) {
          _selectedDiscount = 9;
        } else if (productFilter.minDiscount == 70 && productFilter.minDiscount == 100) {
          _selectedDiscount = 10;
        }
      }
      if (productFilter.stock != null) {
        if (productFilter.stock == 'all') {
          _isInStock = _isOutOfStock = true;
        } else if (productFilter.stock == 'in') {
          _isInStock = true;
        } else if (productFilter.stock == 'out') {
          _isOutOfStock = true;
        }
      }
      if (productFilter.maxPriceValue != null) {
        _currentRangeValues = RangeValues(0, double.parse(productFilter.maxPriceValue.toString()));
      }
      if (productFilter.minPrice != null && productFilter.maxPrice != null) {
        _currentRangeValues = RangeValues(
          double.parse(productFilter.minPrice.toString()),
          double.parse(productFilter.maxPrice.toString()),
        );
      }
    } catch (e) {
      print("Exception - filterScreen.dart- _init():" + e.toString());
    }
  }
}
