import 'dart:convert';
import 'dart:math';

import 'package:driver/Components/commonwidget.dart';
import 'package:driver/Components/custom_button.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/baseurl/baseurlg.dart';
import 'package:driver/beanmodel/orderhistory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderAcceptedPage extends StatefulWidget {
  @override
  _OrderAcceptedPageState createState() => _OrderAcceptedPageState();
}

class _OrderAcceptedPageState extends State<OrderAcceptedPage> {
  OrderHistory orderDetaials;
  bool enterFirst = false;
  bool isLoading = false;
  dynamic distance;
  dynamic time;

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
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    Map<String, dynamic> dataReced = ModalRoute.of(context).settings.arguments;
    if (!enterFirst) {
      setState(() {
        enterFirst = true;
        orderDetaials = dataReced['OrderDetail'];
        distance = calculateDistance(double.parse('${orderDetaials.userLat}'), double.parse('${orderDetaials.userLng}'), double.parse('${orderDetaials.storeLat}'), double.parse('${orderDetaials.storeLng}')).toStringAsFixed(2);
        time = calculateTime(double.parse('${orderDetaials.userLat}'), double.parse('${orderDetaials.userLng}'), double.parse('${orderDetaials.storeLat}'), double.parse('${orderDetaials.storeLng}'));
        print('$distance');
        print('$time');
      });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Text('${locale.order} - #${orderDetaials.cartId}', style: Theme.of(context).textTheme.headline4.copyWith(fontWeight: FontWeight.w500, color: kMainTextColor, fontSize: 13)),
          automaticallyImplyLeading: true,
          actions: [
            buildCircularButton(context, Icons.shopping_basket, locale.itemInfo, details: orderDetaials.items, type: 1),
          ],
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/Acceptedmap.png',
            width: 500,
            fit: BoxFit.fill,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    title: Text(
                      locale.distance,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 15),
                    ),
                    subtitle: RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(text: '$distance km ', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.green)),
                        TextSpan(text: '($time)', style: Theme.of(context).textTheme.subtitle2.copyWith(fontWeight: FontWeight.w300)),
                      ]),
                    ),
                    trailing: buildCircularButton(context, Icons.navigation, locale.direction, type: 2, url: 'https://maps.google.com/maps?daddr=${orderDetaials.userLat},${orderDetaials.userLng}'),
                  ),
                  Divider(
                    height: 5,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    title: Text(
                      '${orderDetaials.storeName}',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
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
                    ),
                    title: Text(
                      '${orderDetaials.userName}',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      '${orderDetaials.userAddress}',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
                    ),
                    trailing: IconButton(
                        icon: Icon(
                          Icons.call,
                          color: Theme.of(context).focusColor,
                          size: 18,
                        ),
                        onPressed: () {
                          _launchURL("tel:${orderDetaials.userPhone}");
                        }),
                  ),
                  isLoading
                      ? Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Align(
                            heightFactor: 40,
                            widthFactor: 40,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : CustomButton(
                          onTap: () {
                            if (!isLoading) {
                              setState(() {
                                isLoading = true;
                              });
                              outForDelivery(context, orderDetaials.cartId);
                            }
                          },
                          label: locale.acceptDelivery,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void outForDelivery(BuildContext context, dynamic cartid) async {
    var http = Client();
    http.post(outForDeliveryUri, body: {'cart_id': '$cartid'}).then((value) {
      print(value.body);
      var js = jsonDecode(value.body);
      if ('${js['status']}' == '1') {
        Navigator.of(context).pop(true);
      }
      Toast.show(js['message'], context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
