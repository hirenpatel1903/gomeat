import 'package:flutter/material.dart';
import 'package:vendor/Drawer/insight.dart';
import 'package:vendor/Drawer/my_earnings.dart';
import 'package:vendor/Drawer/my_items.dart';
import 'package:vendor/Drawer/new_orders_drawer.dart';
import 'package:vendor/Drawer/profile.dart';
import 'package:vendor/Drawer/select_language.dart';
import 'package:vendor/Pages/About/about_us.dart';
import 'package:vendor/Pages/About/contact_us.dart';
import 'package:vendor/Pages/Chat/chat_list.dart';
import 'package:vendor/Pages/Login/lang_selection.dart';
import 'package:vendor/Pages/Login/sign_in.dart';
import 'package:vendor/Pages/Login/sign_up.dart';
import 'package:vendor/Pages/Login/verification.dart';
import 'package:vendor/Pages/Other/add_address.dart';
import 'package:vendor/Pages/Other/add_item.dart';
import 'package:vendor/Pages/Other/add_varient.dart';
import 'package:vendor/Pages/Other/edit_item.dart';
import 'package:vendor/Pages/Other/notification_list.dart';
import 'package:vendor/Pages/Other/reviews.dart';
import 'package:vendor/Pages/Other/send_to_bank.dart';
import 'package:vendor/Pages/Other/updateproductonly.dart';
import 'package:vendor/Pages/locationsearchpage/locationsearch.dart';
import 'package:vendor/Pages/tncpage/tnc_page.dart';

class PageRoutes {
  // static const String signUp = 'sign_up';
  static const String newOrdersDrawer = 'new_orders_drawer';
  static const String editItem = 'edit_item';
  static const String addItem = 'add_item';
  static const String reviewsPage = 'reviews_page';
  static const String sendToBank = 'send_to_bank';
  static const String addAddress = 'add_address';
  static const String insight = 'insight';
  static const String myItemsPage = 'my_item_page';
  static const String myEarnings = 'my_earnings';
  static const String myProfile = 'my_profile';
  static const String contactUs = 'contact_us';
  static const String chooseLanguage = 'choose_language';
  static const String aboutus = 'aboutus';
  static const String chatList = 'chat_list';
  static const String notificationList = 'notification_list';
  static const String tnc = 'tnc';
  static const String updateitem = 'updateitem';
  static const String add_varinet_page = 'add_varinet_page';
  static const String signInRoot = 'signIn/';
  static const String signUp = 'signUp';
  static const String verification = 'verification';
  static const String locSearch = '/locSearch';
  static const String langnew = '/langnew';

  Map<String, WidgetBuilder> routes() {
    return {
      // signUp: (context) => SignUp((){
      //
      // }),
      newOrdersDrawer: (context) => NewOrdersDrawer(),
      editItem: (context) => EditItemPage(),
      addItem: (context) => AddItemPage(),
      updateitem: (context) => UpdateProductPage(),
      reviewsPage: (context) => Reviews(),
      sendToBank: (context) => SendToBank(),
      addAddress: (context) => AddAddress(),
      insight: (context) => InsightPage(),
      myItemsPage: (context) => MyItemsPage(),
      myEarnings: (context) => MyEarningsPage(),
      myProfile: (context) => MyProfile(),
      contactUs: (context) => ContactUsPage(),
      chooseLanguage: (context) => ChooseLanguage(),
      chatList: (context) => ChatListPage(),
      notificationList: (context) => NotificationListPage(),
      aboutus: (context) => AboutUsPage(),
      tnc: (context) => TNCPage(),
      add_varinet_page: (context) => AddVarientPage(),
      signInRoot: (context) => SignIn(),
      signUp: (context) => SignUp(),
      verification: (context) => VerificationPage(),
      locSearch: (context) => SearchLocation(),
      langnew: (context) => ChooseLanguageNew(),
    };
  }
}
