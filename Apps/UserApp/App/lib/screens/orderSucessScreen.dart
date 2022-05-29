import 'package:flutter/material.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/screens/trackOrderScreen.dart';
import 'package:gomeat/widgets/bottomNavigationWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrderSuccessScreen extends BaseRoute {
  final String cartId;
  OrderSuccessScreen(this.cartId, {a, o}) : super(a: a, o: o, r: 'OrderSuccessScreen');
  @override
  _OrderSuccessScreenState createState() => new _OrderSuccessScreenState(this.cartId);
}

class _OrderSuccessScreenState extends BaseRouteState {
  String cartId;
  _OrderSuccessScreenState(this.cartId) : super();

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
                height: MediaQuery.of(context).size.height * 0.44,
              ),
              Text(
                "${AppLocalizations.of(context).tle_congrates}",
                style: Theme.of(context).primaryTextTheme.headline3.copyWith(color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Text(
                  "${AppLocalizations.of(context).txt_order_success_description}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.overline.copyWith(color: Colors.white, letterSpacing: 0.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TrackOrderScreen(cartId, 0,a: widget.analytics, o: widget.observer),
                        ),
                      );
                    },
                    child: Text('${AppLocalizations.of(context).btn_track_order}', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold))),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
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
