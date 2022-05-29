import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaymentSuccessScreen extends BaseRoute {
  final String text;
  PaymentSuccessScreen(this.text, {a, o}) : super(a: a, o: o, r: 'PaymentSuccessScreen');
  @override
  _PaymentSuccessScreenState createState() => new _PaymentSuccessScreenState(this.text);
}

class _PaymentSuccessScreenState extends BaseRouteState {
  String text;
  _PaymentSuccessScreenState(this.text) : super();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavigationWidget(a: widget.analytics, o: widget.observer)));
        return null;
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/orderSuccessScreen.png'),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
              ),
              Text(
                "${AppLocalizations.of(context).tle_congrates}",
                style: Theme.of(context).primaryTextTheme.headline3.copyWith(color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Text(
                  "$text",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Colors.white, letterSpacing: 0.0),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.35),
              TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavigationWidget(a: widget.analytics, o: widget.observer)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${AppLocalizations.of(context).btn_browse_more}',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        MdiIcons.arrowRight,
                        color: Colors.white,
                        size: 20,
                      ),
                    )
                  ],
                ),
              ),
            ],
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
  }
}
