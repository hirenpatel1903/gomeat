import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gomeat/l10n/l10n.dart';
import 'package:gomeat/models/businessLayer/baseRoute.dart';
import 'package:gomeat/models/businessLayer/global.dart' as global;
import 'package:gomeat/provider/local_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ChooseLanguageScreen extends BaseRoute {
  ChooseLanguageScreen({a, o}) : super(a: a, o: o, r: 'ChooseLanguageScreen');
  @override
  _ChooseLanguageScreenState createState() => new _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends BaseRouteState {
  bool isFavourite = false;
  _ChooseLanguageScreenState() : super();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LocaleProvider>(context);
    var locale = provider.locale ?? Locale('en');
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${AppLocalizations.of(context).tle_languages}"),
          leading: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.center,
              child: Icon(MdiIcons.arrowLeft),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 180,
                  margin: EdgeInsets.only(top: 25),
                  width: 250,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: global.isDarkModeEnable
                            ? BoxDecoration(
                                gradient: LinearGradient(
                                  stops: [0, .90],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF545975).withOpacity(0.44), Color(0xFF333550).withOpacity(0.22)],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              )
                            : BoxDecoration(
                                gradient: LinearGradient(
                                  stops: [0, .90],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFF7C96AA).withOpacity(0.33), Color(0xFFA6C1D6).withOpacity(0.07)],
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                      ),
                   
                      Positioned(
                        top: -50,
                        child: Image.asset(
                          '${global.defaultImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "${AppLocalizations.of(context).lbl_select_language}",
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: L10n.languageListName.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile(
                          value: L10n.all[index].languageCode,
                          groupValue: global.languageCode,
                          onChanged: (val) {
                            global.languageCode = val;
                            final provider = Provider.of<LocaleProvider>(context, listen: false);
                            locale = Locale(L10n.all[index].languageCode);
                            provider.setLocale(locale);
                            global.languageCode = locale.languageCode;
                            if (global.rtlLanguageCodeLList.contains(locale.languageCode)) {
                              global.isRTL = true;
                            } else {
                              global.isRTL = false;
                            }
                            setState(() {});
                          },
                          title: Text(
                            L10n.languageListName[index],
                            style: Theme.of(context).primaryTextTheme.bodyText1,
                          ),
                        ),
                        index != L10n.languageListName.length - 1
                            ? Divider(
                                color: global.isDarkModeEnable ? Theme.of(context).dividerTheme.color : Color(0xFFDFE8EF),
                              )
                            : SizedBox(),
                      ],
                    );
                  },
                ),
              )
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
