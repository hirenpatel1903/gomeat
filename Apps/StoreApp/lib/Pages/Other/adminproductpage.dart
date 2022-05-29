import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/Components/grid_view.dart';
import 'package:vendor/Locale/locales.dart';
import 'package:vendor/Routes/routes.dart';
import 'package:vendor/baseurl/baseurlg.dart';
import 'package:vendor/beanmodel/productmodel/adminprodcut.dart';
import 'package:vendor/beanmodel/productmodel/storeprodcut.dart';

class MyAdminProduct extends StatefulWidget {
  @override
  MyAdminProductState createState() => MyAdminProductState();
}

class MyAdminProductState extends State<MyAdminProduct> {
  String adminProductSearch;
  List<StoreProductM> adminproductData = [];
  TextEditingController searchC = new TextEditingController();
  bool isLoading = false;
  bool isDelete = false;
  int pageIndex = 0;
  var http = Client();

  @override
  void initState() {
    super.initState();
    getAllAdminProductInfo();
  }

  @override
  void dispose() {
    http.close();
    super.dispose();
  }

  void getAllAdminProductInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
    });
    http.post(storeProductsAdminUri, body: {'store_id': '${prefs.getInt('store_id')}', 'searchstring': (adminProductSearch != null && adminProductSearch != '') ? adminProductSearch : ''}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        StoreAdminProduct productMain = StoreAdminProduct.fromJson(jsonDecode(value.body));
        if ('${productMain.status}' == '1') {
          setState(() {
            adminproductData.clear();
            adminproductData = List.from(productMain.data);
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
      adminproductData.clear();
      adminProductSearch = searchString != null && searchString.isNotEmpty ? searchString : null;

      getAllAdminProductInfo();
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
        Container(
            height: MediaQuery.of(context).size.height - 221,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5.0),
            child: (isLoading || (adminproductData != null && adminproductData.length > 0))
                ? (adminproductData != null && adminproductData.length > 0)
                    ? buildGridAdminView(adminproductData, callBack: (id, type) {
                        if (type == 'product') {
                          deleteProductById(id);
                        } else if (type == 'variant') {
                          deleteVarientById(id);
                        }
                      }, update: (pData, type, pvid) {
                        StoreProductData productM = StoreProductData(
                            productId: pData.productId,
                            productName: pData.productName,
                            productImage: pData.productImage,
                            catId: pData.catId,
                            varients: <Varients>[Varients(varientId: pData.varientId, varientImage: pData.varientImage, description: pData.description, unit: pData.unit, quantity: pData.quantity, price: pData.price, ean: pData.ean)]);
                        if (type == 'product') {
                          Navigator.pushNamed(context, PageRoutes.updateitem, arguments: {
                            'pData': pData,
                          }).then((value) {
                            getAllAdminProductInfo();
                          }).catchError((e) {
                            print(e);
                          });
                        } else if (type == 'variant') {
                          Navigator.pushNamed(context, PageRoutes.editItem, arguments: {
                            'pData': pData,
                            'vid': pvid,
                          }).then((value) {
                            getAllAdminProductInfo();
                          }).catchError((e) {
                            print(e);
                          });
                        }
                      })
                    : buildGridSHView()
                : Align(
                    alignment: Alignment.center,
                    child: Text(locale.itempagenomore),
                  )),
      ],
    );
  }

  void deleteVarientById(dynamic id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    http.post(storeProductsDeleteUri, body: {'varient_id': '$id', 'store_id': '${prefs.getInt('store_id')}'}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {}
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
    http.post(storeProductsDeleteUri, body: {'product_id': '$id'}).then((value) {
      print(value.body);
      if (value.statusCode == 200) {}
      setState(() {
        isDelete = false;
      });
    }).catchError((e) {
      setState(() {
        isDelete = false;
      });
    });
  }
}
