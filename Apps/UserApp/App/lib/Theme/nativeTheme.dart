import 'package:flutter/material.dart';

ThemeData nativeTheme({bool isDarkModeEnable}) {
  if (isDarkModeEnable) {
    Map<int, Color> color = {
      50: Color.fromRGBO(244, 105, 74, .1),
      100: Color.fromRGBO(244, 105, 74, .2),
      200: Color.fromRGBO(244, 105, 74, .3),
      300: Color.fromRGBO(244, 105, 74, .4),
      400: Color.fromRGBO(244, 105, 74, .5),
      500: Color.fromRGBO(244, 105, 74, .6),
      600: Color.fromRGBO(244, 105, 74, .7),
      700: Color.fromRGBO(244, 105, 74, .8),
      800: Color.fromRGBO(244, 105, 74, .9),
      900: Color.fromRGBO(244, 105, 74, 1),
    };
    return ThemeData(
      indicatorColor: Colors.green,
      canvasColor: Colors.grey,
      primaryColor: Color(0xFFF4694A),
      primaryColorLight: Color(0xFFF6A643), // Color(0xFF66d5ff),
      primaryColorDark: Color(0xFFF4694A),
      primarySwatch: MaterialColor(0xFFF4694A, color),
      primaryIconTheme: IconThemeData(color: Colors.white),
      //iconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Color(0xFF9EA5A8)), //Color(0xFF9EA5A8)),
      primaryTextTheme: TextTheme(
        headline1: TextStyle(fontSize: 13, color: Color(0xFFFCB140), letterSpacing: 0.5, fontWeight: FontWeight.w500, fontFamily: 'PoppinsMedium'), // homescreen explore all
        headline2: TextStyle(fontSize: 12, color: Color(0xFF9EA5A8), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'),
        //  headline2: TextStyle(fontSize: 13, color: Colors.white30), //home subtitle
        headline3: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5), // title
        headline4: TextStyle(color: Colors.white70, fontSize: 17), //login,otp subtitle
        headline5: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.3, fontFamily: 'PoppinsMedium'), //home titles
        headline6: TextStyle(fontSize: 18, color: Colors.white), // home's card title
        button: TextStyle(fontSize: 10, color: Color(0xFF9EA5A8), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'),
        subtitle1: TextStyle(fontSize: 14, color: Color(0xFF332E38), fontWeight: FontWeight.w500, fontFamily: 'PoppinsMedium'), //home screen
        subtitle2: TextStyle(fontSize: 12, color: Color(0xFF332E38), fontWeight: FontWeight.w300, fontFamily: 'PoppinsLight'), //home screen
        bodyText1: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.3, fontFamily: 'PoppinsMedium'), // home's card title,
        overline: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'),
        caption: TextStyle(color: Colors.white, fontSize: 12), // Home screen
      ),
      textTheme: TextTheme(
        caption: TextStyle(fontSize: 12, color: Color(0xFF9EA5A8), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'),
        subtitle1: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 0.3, fontFamily: 'PoppinsMedium'), // home's card title,
      ),
      scaffoldBackgroundColor: Color(0xFF242639),
      tabBarTheme: TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white,
        labelStyle: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w400),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.only(top: 10, bottom: 10)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
      )),
      fontFamily: 'PoppinsMedium',
      dividerColor: Colors.transparent,
      dividerTheme: DividerThemeData(color: Color(0xFFEDF2F6).withOpacity(0.5), thickness: 1.5),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(Color(0xFFF4694A)),
      ),
      cardTheme: CardTheme(
        elevation: 0.5,
        margin: EdgeInsets.all(0),
        color: Color(0xFF2D2F41),
        shadowColor: Color(0xFF2D2F41),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),

      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide.none),
        filled: true,
        fillColor: Color(0xFF4B4F68),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF404058),
        selectedIconTheme: IconThemeData(color: Color(0xFFF6A643), size: 26),
        unselectedIconTheme: IconThemeData(color: Colors.white, size: 24),
      ),
      appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        color: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(
          Color(0xFFF4694A),
        ),
      ),
    );
  } else {
    Map<int, Color> color = {
      50: Color.fromRGBO(244, 105, 74, .1),
      100: Color.fromRGBO(244, 105, 74, .2),
      200: Color.fromRGBO(244, 105, 74, .3),
      300: Color.fromRGBO(244, 105, 74, .4),
      400: Color.fromRGBO(244, 105, 74, .5),
      500: Color.fromRGBO(244, 105, 74, .6),
      600: Color.fromRGBO(244, 105, 74, .7),
      700: Color.fromRGBO(244, 105, 74, .8),
      800: Color.fromRGBO(244, 105, 74, .9),
      900: Color.fromRGBO(244, 105, 74, 1),
    };
    return ThemeData(
      indicatorColor: Colors.green,
      canvasColor: Colors.grey,
      primaryColor: Color(0xFFF4694A),
      primaryColorLight: Color(0xFFF6A643), // Color(0xFF66d5ff),
      primaryColorDark: Color(0xFFF4694A),
      primarySwatch: MaterialColor(0xFFF4694A, color),
      primaryIconTheme: IconThemeData(color: Color(0xFF332E38)),
      iconTheme: IconThemeData(color: Color(0xFF738899)),
      primaryTextTheme: TextTheme(
        headline1: TextStyle(fontSize: 13, color: Color(0xFFEF5656), letterSpacing: 0.5, fontWeight: FontWeight.w500, fontFamily: 'PoppinsMedium'), // homescreen explore all
        headline2: TextStyle(fontSize: 12, color: Color(0xFF9EA5A8), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'), //home subtitle
        headline3: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.5), // title
        headline4: TextStyle(color: Colors.white70, fontSize: 17), //login,otp subtitle
        headline5: TextStyle(color: Color(0xFF332E38), fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.3, fontFamily: 'PoppinsMedium'), //home titles
        headline6: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600), // home's card title
        button: TextStyle(fontSize: 10, color: Color(0xFF41505B), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'),
        subtitle1: TextStyle(fontSize: 14, color: Color(0xFF332E38), fontWeight: FontWeight.w500, fontFamily: 'PoppinsMedium'), //home screen
        subtitle2: TextStyle(fontSize: 12, color: Color(0xFF332E38), fontWeight: FontWeight.w300, fontFamily: 'PoppinsLight'), //home screen
        bodyText1: TextStyle(fontSize: 14, color: Color(0xFF332E38), fontWeight: FontWeight.w500, letterSpacing: 0.3, fontFamily: 'PoppinsMedium'), // home's card title,
        overline: TextStyle(fontSize: 14, color: Color(0xFF332E38), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'),
        caption: TextStyle(color: Colors.white, fontSize: 12), // Home screen
      ),

      textTheme: TextTheme(
        caption: TextStyle(fontSize: 12, color: Color(0xFF9EA5A8), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'), //home subtitle
        subtitle1: TextStyle(fontSize: 14, color: Color(0xFF332E38), fontWeight: FontWeight.w500, letterSpacing: 0.3, fontFamily: 'PoppinsMedium'),
      ),
      scaffoldBackgroundColor: Colors.white, // Color(0xFFEDF2F6),

      tabBarTheme: TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        labelStyle: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.w400),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.only(top: 10, bottom: 10)),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        shadowColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
      )),
      fontFamily: 'PoppinsMedium',
      dividerColor: Colors.transparent, //Color(0xFF4B4F68),

      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(Color(0xFFF4694A)),
      ),
      bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xFF5c7de0)),
      cardTheme: CardTheme(
        elevation: 0.5,
        margin: EdgeInsets.all(0),
        color: Color(0xFFedf2f6),
        shadowColor: Color(0xFFedf2f6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      dividerTheme: DividerThemeData(
        color: Color(0xFFEDF2F6),
        thickness: 1.5,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(fontSize: 14, color: Color(0xFF6E7A82), fontWeight: FontWeight.w400, fontFamily: 'PoppinsRegular'), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)), borderSide: BorderSide.none), filled: true,
        fillColor: Color(0xFFEDF2F6), //Colors.blue[100].withOpacity(0.3),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFFAF9F9), // Color(0xFF404058),
        selectedIconTheme: IconThemeData(color: Color(0xFFF6A643), size: 26),
        unselectedIconTheme: IconThemeData(color: Color(0xFF4A4352), size: 24),
      ),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Color(0xFF4A4352)),
        color: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(
          Color(0xFFF4694A),
        ),
      ),
    );
  }
}
