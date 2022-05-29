import 'package:driver/Auth/Login/lang_selection.dart';
import 'package:driver/Pages/About/about_us.dart';
import 'package:driver/Pages/About/contact_us.dart';
import 'package:driver/Pages/accepted_order.dart';
import 'package:driver/Pages/addtobank_page.dart';
import 'package:driver/Pages/edit_profile.dart';
import 'package:driver/Pages/home_page.dart';
import 'package:driver/Pages/insight_page.dart';
import 'package:driver/Pages/iteminfopage.dart';
import 'package:driver/Pages/new_delivery_task.dart';
import 'package:driver/Pages/notification_list.dart';
import 'package:driver/Pages/order_delivered.dart';
import 'package:driver/Pages/order_history.dart';
import 'package:driver/Pages/select_languages.dart';
import 'package:driver/Pages/signature/signatureview.dart';
import 'package:driver/Pages/tncpage/tnc_page.dart';
import 'package:driver/Pages/wallet_page.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static const String homePage = 'home_page';
  static const String insightPage = 'insight_page';
  static const String languagePage = 'language_page';
  static const String walletPage = 'wallet_page';
  static const String addToBank = 'add_to_bank';
  static const String editProfilePage = 'edit_profile';
  static const String orderHistoryPage = 'order_history';
  static const String orderDeliveredPage = 'order_delivered';
  static const String newDeliveryPage = 'new_delivery';
  static const String contactUs = 'contact_us';
  static const String notificationList = 'notification_list';
  static const String orderAcceptedPage = 'order_accepted';

  // static const String onWayPage = 'on_way';
  static const String tnc = 'tnc';
  static const String aboutus = 'aboutus';
  static const String iteminfo = 'iteminfo';
  static const String signatureview = 'signatureview';
  static const String langnew = '/langnew';

  Map<String, WidgetBuilder> routes() {
    return {
      homePage: (context) => HomePage(),
      insightPage: (context) => InsightPage(),
      languagePage: (context) => ChooseLanguage(),
      walletPage: (context) => WalletPage(),
      addToBank: (context) => AddToBank(),
      editProfilePage: (context) => EditProfilePage(),
      orderHistoryPage: (context) => OrderHistoryPage(),
      orderDeliveredPage: (context) => OrderDeliveredPage(),
      newDeliveryPage: (context) => NewDeliveryPage(),
      contactUs: (context) => ContactUsPage(),
      notificationList: (context) => NotificationListPage(),
      orderAcceptedPage: (context) => OrderAcceptedPage(),
      // onWayPage: (context)=> OnWayPage(),
      tnc: (context) => TNCPage(),
      aboutus: (context) => AboutUsPage(),
      iteminfo: (context) => ItemInformation(),
      signatureview: (context) => SignatureView(),
      langnew: (context) => ChooseLanguageNew(),
    };
  }
}
