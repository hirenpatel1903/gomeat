import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:vendor/Components/grid_view.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/productmodel/storeprodcut.dart';

class MyStoreProduct extends StatefulWidget {
  @override
  MyStoreProductState createState() => MyStoreProductState();
}

class MyStoreProductState extends State<MyStoreProduct> {
  List<StoreProductData> productData = [];
  TextEditingController searchC = new TextEditingController();
  String _productStoreSearch;
  bool isLoading = false;
  bool isDelete = false;
  int pageIndex = 0;
  var http = Client();

  @override
  void initState() {
    super.initState();
    getAllProductInfo();
  }

  @override
  void dispose() {
    http.close();
    super.dispose();
  }

  void getAllProductInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      productData.clear();
      isLoading = true;
    });
    http.post(storeProductsUri, body: {'store_id': '${prefs.getInt('store_id')}', 'searchstring': (_productStoreSearch != null && _productStoreSearch != '') ? _productStoreSearch : ''}).then((value) {
      print('pp - ${value.body}');
      if (value.statusCode == 200) {
        print('data 1');
        StoreProductMain productMain = StoreProductMain.fromJson(jsonDecode(value.body));
        print('data 0');
        if ('${productMain.status}' == '1') {
          print('in data');
          setState(() {
            productData.clear();
            productData = List.from(productMain.data);
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future _search(String searchString) async {
    try {
      productData.clear();
      _productStoreSearch = searchString != null && searchString.isNotEmpty ? searchString : null;

      getAllProductInfo();
    } catch (e) {
      print('Exception: storeproductpage.dart _search(): ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          height: 42,
          decoration: BoxDecoration(border: Border.all(width: 1, color: Theme.of(context).textTheme.subtitle2.color), borderRadius: BorderRadius.all(Radius.circular(5))),
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            controller: searchC,
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(Icons.search),
              ),
              hintText: 'Search',
              contentPadding: EdgeInsets.only(top: 5, left: 10),
            ),
            onChanged: (val) async {
              await _search(val.trim());
            },
            onFieldSubmitted: (val) async {
              // await _search(val.trim());
            },
          ),
        ),
        SingleChildScrollView(
          child: Container(

              // color: Colors.red,
              height: MediaQuery.of(context).size.height - 221,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              child: (isLoading || (productData != null && productData.length > 0))
                  ? (productData != null && productData.length > 0)
                      ? buildGridView(productData, callBack: (id, type) {
                          if (type == 'product') {
                            deleteProductById(id);
                          } else if (type == 'variant') {
                            deleteVarientById(id);
                          }
                        }, update: (pData, type, pvid) {
                          if (type == 'product') {
                            Navigator.pushNamed(context, PageRoutes.updateitem, arguments: {
                              'pData': pData,
                            }).then((value) {
                              getAllProductInfo();
                            }).catchError((e) {
                              print(e);
                            });
                          } else if (type == 'variant') {
                            Navigator.pushNamed(context, PageRoutes.editItem, arguments: {
                              'pData': pData,
                              'vid': pvid,
                            }).then((value) {
                              getAllProductInfo();
                            }).catchError((e) {
                              print(e);
                            });
                          }
                        }, addVaraient: (id) {
                          Navigator.pushNamed(context, PageRoutes.add_varinet_page, arguments: {
                            'pId': id,
                          }).then((value) {
                            getAllProductInfo();
                          }).catchError((e) {
                            print(e);
                          });
                        }, updateStock: (pData, type, pvid) {
                          updateStockById(pData.productId, pvid);
                        })
                      : buildGridSHView()
                  : Align(
                      alignment: Alignment.center,
                      child: Text(locale.itempagenomore),
                    )),
        ),
      ],
    );
  }

  void deleteVarientById(dynamic id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.post(storeVarientsDeleteUri, body: {'varient_id': '$id', 'store_id': '${prefs.getInt('store_id')}'}).then((value) {
      print('dv - ${value.body}');
      var js = jsonDecode(value.body);
      if ('${js['status']}' == '1') {
        Toast.show(js['message'], context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
      setState(() {
        isDelete = false;
      });
      getAllProductInfo();
    }).catchError((e) {
      setState(() {
        isDelete = false;
        getAllProductInfo();
      });
    });
  }

  void updateStockById(dynamic id, dynamic stock) async {
    http.post(storeStockUpdateUri, body: {'p_id': '$id', 'stock': '$stock'}).then((value) {
      print('dv - ${value.body}');
      var js = jsonDecode(value.body);
      if ('${js['status']}' == '1') {
        Toast.show(js['message'], context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      }
      setState(() {
        isDelete = false;
      });
    }).catchError((e) {
      setState(() {
        isDelete = false;
      });
    });
  }

  void deleteProductById(dynamic id) async {
    setState(() {
      productData.clear();
      isLoading = true;
    });
    http.post(storeProductsDeleteUri, body: {'product_id': '$id'}).then((value) {
      print('dp - ${value.body}');
      if (value.statusCode == 200) {
        var js = jsonDecode(value.body);
        if ('${js['status']}' == '1') {
          Toast.show(js['message'], context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
        }
      }
      getAllProductInfo();
    }).catchError((e) {
      getAllProductInfo();
    });
  }
}
