import 'package:driver/Locale/locales.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/beanmodel/orderhistory.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemInformation extends StatefulWidget {
  @override
  ItemInformationState createState() {
    return ItemInformationState();
  }
}

class ItemInformationState extends State<ItemInformation> {
  List<ItemsDetails> order_details = [];

  var apCurrency;

  bool enterfirst = true;

  @override
  void initState() {
    super.initState();
    getSharedValue();
  }

  void getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      apCurrency = prefs.getString('app_currency');
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    Map<String, dynamic> receivedData = ModalRoute.of(context).settings.arguments;
    if (enterfirst) {
      setState(() {
        enterfirst = false;
        order_details = receivedData['details'];
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          locale.itemInfo,
          style: TextStyle(color: kMainTextColor),
        ),
      ),
      body: (order_details != null && order_details.length > 0)
          ? ListView.separated(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(borderRadius: BorderRadius.circular(5), child: Image.network('${order_details[index].varientImage}', fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${order_details[index].productName} (${order_details[index].quantity} ${order_details[index].unit})',
                              style: TextStyle(
                                fontSize: 16,
                                color: kWhiteColor,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${locale.invoice2h} - ${order_details[index].qty}',
                              style: TextStyle(
                                fontSize: 13,
                                color: kWhiteColor,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${locale.invoice3h} - $apCurrency ${double.parse((order_details[index].price / order_details[index].qty).toString()).round()}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  '${locale.invoice4h} ${locale.invoice3h} - $apCurrency ${order_details[index].price}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, indext) {
                return Divider(
                  thickness: 0.1,
                  color: Colors.transparent,
                );
              },
              itemCount: order_details.length)
          : SizedBox.shrink(),
    );
  }
}
