import 'dart:math';

import 'package:driver/Theme/colors.dart';
import 'package:driver/beanmodel/orderhistory.dart';
import 'package:driver/main.dart';
import 'package:flutter/material.dart';
import 'package:driver/Components/custom_button.dart';
import 'package:driver/Locale/locales.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  OrderHistory orderDetaials;
  List<ItemsDetails> order_details = [];
  bool enterFirst = false;
  bool isLoading = false;
  dynamic distance;
  dynamic time;
  dynamic apCurency;

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p) / 2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  String calculateTime(lat1, lon1, lat2, lon2) {
    double kms = calculateDistance(lat1, lon1, lat2, lon2);
    double kms_per_min = 0.5;
    double mins_taken = kms / kms_per_min;
    double min = mins_taken;
    if (min < 60) {
      return "" + '${min.toInt()}' + " mins";
    } else {
      double tt = min % 60;
      String minutes = '${tt.toInt()}';
      minutes = minutes.length == 1 ? "0" + minutes : minutes;
      return '${(min.toInt() / 60).toStringAsFixed(2)}' + " hour " + minutes + " mins";
    }
  }

  @override
  void initState() {
    super.initState();
    getSharedValue();
  }

  void getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      apCurency = prefs.getString('app_currency');
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final Map<String, Object> dataObject = ModalRoute.of(context).settings.arguments;
    if (!enterFirst) {
      setState(() {
        enterFirst = true;
        orderDetaials = dataObject['OrderDetail'];
        order_details = orderDetaials.items;
        distance = calculateDistance(double.parse('${orderDetaials.userLat}'), double.parse('${orderDetaials.userLng}'), double.parse('${orderDetaials.storeLat}'), double.parse('${orderDetaials.storeLng}')).toStringAsFixed(2);
        time = calculateTime(double.parse('${orderDetaials.userLat}'), double.parse('${orderDetaials.userLng}'), double.parse('${orderDetaials.storeLat}'), double.parse('${orderDetaials.storeLng}'));
        print('$distance');
        print('$time');
      });
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('${locale.order} - #${orderDetaials.cartId}\n${locale.deliveryDate} ${orderDetaials.deliveryDate}'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    (order_details != null && order_details.length > 0)
                        ? ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            primary: false,
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
                                                '${locale.invoice3h} - $apCurency ${(double.parse('${order_details[index].price}') / double.parse('${order_details[index].qty}'))}',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                              Text(
                                                '${locale.invoice4h} ${locale.invoice3h} - $apCurency ${order_details[index].price}',
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
                    Divider(
                      height: 5,
                      thickness: 0.8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      color: Color(0xffF4F7FA),
                      child: Row(
                        children: [
                          Text('${locale.paymentmode} \n${orderDetaials.paymentMethod}',
                              style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    fontSize: 16,
                                    color: Color(0xFF39c526),
                                  )),
                          Spacer(),
                          Text(
                            '${locale.invoice4h} ${locale.invoice3h} \n$apCurency ${orderDetaials.remainingPrice}',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                  fontSize: 16,
                                  color: Color(0xFF39c526),
                                ),
                          )
                        ],
                      ),
                    ),
                    // Expanded(child: Container(color: Colors.grey[100],)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                      child: Row(
                        children: [
                          RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(text: locale.distance + '\n', style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(text: '$distance km', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.green, height: 1.5)),
                            TextSpan(text: ' ($time)', style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w300)),
                          ])),
                          Spacer(
                            flex: 2,
                          ),
                          // RichText(text: TextSpan(children: <TextSpan>[
                          //   TextSpan(text: locale.earnings+'\n',style: Theme.of(context).textTheme.bodyText1),
                          //   TextSpan(text: '\$ 5.20',style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.green,height: 1.5)),
                          // ])),
                          // Spacer(),
                        ],
                      ),
                    ),
                    Divider(
                      height: 5,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 24,
                      ),
                      title: Text(
                        '${orderDetaials.storeName}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
                      ),
                      subtitle: Text(
                        '${orderDetaials.storeAddress}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.navigation,
                        color: Colors.green,
                        size: 24,
                      ),
                      title: Text(
                        '${orderDetaials.userName}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
                      ),
                      subtitle: Text(
                        '${orderDetaials.userAddress}',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 60),
                  ],
                ),
              ),
            ),
            CustomButton(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                  return DeliveryBoyHome();
                }), (Route<dynamic> route) => false);
              },
              label: locale.backToHome,
            ),
          ],
        ),
      ),
    );
  }
}
