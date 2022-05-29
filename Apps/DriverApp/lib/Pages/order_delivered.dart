import 'package:driver/beanmodel/orderhistory.dart';
import 'package:driver/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:driver/Components/custom_button.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Routes/routes.dart';

class OrderDeliveredPage extends StatefulWidget {
  @override
  _OrderDeliveredPageState createState() => _OrderDeliveredPageState();
}

class _OrderDeliveredPageState extends State<OrderDeliveredPage> {
  OrderHistory orderDetaials;
  bool enterFirst = false;
  bool isLoading = false;
  dynamic apCurency;
  dynamic distance;
  dynamic time;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final Map<String, Object> dataObject = ModalRoute.of(context).settings.arguments;
    if (!enterFirst) {
      setState(() {
        enterFirst = true;
        orderDetaials = dataObject['OrderDetail'];
        distance = dataObject['dis'];
        time = dataObject['time'];
        print('$distance');
        print('$time');
      });
    }
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          return DeliveryBoyHome();
        }), (Route<dynamic> route) => false);
      },
      child: Scaffold(
        body: Column(
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset(
              'assets/delivery completed.png',
              scale: 3,
            ),
            Spacer(),
            Text(locale.deliveredSuccessfully, style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 20)),
            SizedBox(
              height: 6,
            ),
            Text(locale.thankYouForDelivering),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(text: locale.youDrove + '\n', style: Theme.of(context).textTheme.subtitle2),
                    TextSpan(text: '$time ($distance km)\n', style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16, height: 1.7)),
                    TextSpan(
                      text: locale.viewOrderInfo,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor,
                            height: 1.5,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, PageRoutes.orderHistoryPage, arguments: {
                            'OrderDetail': orderDetaials,
                          });
                        },
                    ),
                  ])),
                  // Spacer(),
                  // RichText(text: TextSpan(children: <TextSpan>[
                  //   TextSpan(text:locale.yourEarning+'\n',style: Theme.of(context).textTheme.subtitle2),
                  //   TextSpan(text: '\$ 8.50\n',style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16,height: 1.7)),
                  //   TextSpan(text: locale.viewEarnings,style: Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 17,color: Theme.of(context).primaryColor,height: 1.5)),
                  // ])),
                ],
              ),
            ),
            Spacer(),
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
