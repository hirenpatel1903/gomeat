import 'package:driver/Components/custom_button.dart';
import 'package:driver/Locale/locales.dart';
import 'package:driver/Theme/colors.dart';
import 'package:driver/language_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguageNew extends StatefulWidget {
  @override
  _ChooseLanguageNewState createState() => _ChooseLanguageNewState();
}

class _ChooseLanguageNewState extends State<ChooseLanguageNew> {
  LanguageCubit _languageCubit;
  List<int> radioButtons = [0, -1, -1, -1, -1];
  String selectedLanguage;
  List<String> languages = [];
  int selectedIndex = -1;
  bool enteredFirst = false;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  getAsyncValue(List<String> languagesd, AppLocalizations locale) async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('language') && prefs.getString('language').length > 0) {
        String langCode = prefs.getString('language');
        if (langCode == 'en') {
          selectedLanguage = locale.englishh;
        } else if (langCode == 'ar') {
          selectedLanguage = locale.arabicc;
        } else if (langCode == 'pt') {
          selectedLanguage = locale.portuguesee;
        } else if (langCode == 'fr') {
          selectedLanguage = locale.frenchh;
        } else if (langCode == 'id') {
          selectedLanguage = locale.indonesiann;
        } else if (langCode == 'es') {
          selectedLanguage = locale.spanishh;
        } else if (langCode == 'bg') {
          selectedLanguage = locale.bulgarian;
        }
        setState(() {
          selectedIndex = languages.indexOf(selectedLanguage);
        });
      } else {
        selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (!enteredFirst) {
      setState(() {
        enteredFirst = true;
      });
      languages = [
        locale.englishh,
        locale.spanishh,
        locale.portuguesee,
        locale.frenchh,
        locale.arabicc,
        locale.indonesiann,
      ];
      getAsyncValue(languages, locale);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.languages,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16, bottom: 16),
            child: Text(
              locale.selectPreferredLanguage,
              style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            primary: true,
            child: ListView.builder(
              itemCount: languages.length,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        print(selectedIndex);
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: [
                        Radio(
                          activeColor: kMainColor,
                          value: index,
                          groupValue: selectedIndex,
                          toggleable: false,
                          onChanged: (valse) {
                            setState(() {
                              selectedIndex = index;
                              print(selectedIndex);
                            });
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text('${languages[index]}')
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
          CustomButton(
            label: locale.continueText,
            onTap: () {
              if (selectedIndex >= 0) {
                setState(() {
                  selectedLanguage = languages[selectedIndex];
                });
                if (selectedLanguage == locale.englishh) {
                  _languageCubit.selectEngLanguage();
                } else if (selectedLanguage == locale.arabicc) {
                  _languageCubit.selectArabicLanguage();
                } else if (selectedLanguage == locale.portuguesee) {
                  _languageCubit.selectPortugueseLanguage();
                } else if (selectedLanguage == locale.frenchh) {
                  _languageCubit.selectFrenchLanguage();
                } else if (selectedLanguage == locale.spanishh) {
                  _languageCubit.selectSpanishLanguage();
                } else if (selectedLanguage == locale.indonesiann) {
                  _languageCubit.selectIndonesianLanguage();
                } else if (selectedLanguage == locale.bulgarian) {
                  _languageCubit.selectBulgarianLanguage();
                }
              }

//              else if (selectedLanguage == 'Indonesian') {
//                _languageCubit.selectIndonesianLanguage();
//              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
