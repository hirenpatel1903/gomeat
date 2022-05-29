import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart';
import 'package:vendor/Locale/languages.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static Languages languaged = Languages();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': languaged.english(),
    'ar': languaged.arabic(),
    'pt': languaged.portuguese(),
    'fr': languaged.french(),
    'id': languaged.indonesian(),
    'es': languaged.spanish(),
    'bg': languaged.bulgarianL(),
  };

  String get notuser1 {
    return _localizedValues[locale.languageCode]['notuser1'];
  }

  String get notuser2 {
    return _localizedValues[locale.languageCode]['notuser2'];
  }

  String get variant {
    return _localizedValues[locale.languageCode]['variant'];
  }

  String get updatestock {
    return _localizedValues[locale.languageCode]['updatestock'];
  }

  String get updateproduct {
    return _localizedValues[locale.languageCode]['updateproduct'];
  }

  String get product {
    return _localizedValues[locale.languageCode]['product'];
  }

  String get delete {
    return _localizedValues[locale.languageCode]['delete'];
  }

  String get continueText {
    return _localizedValues[locale.languageCode]['continueText'];
  }

  String get orderinfo {
    return _localizedValues[locale.languageCode]['orderinfo'];
  }

  String get welcomeTo {
    return _localizedValues[locale.languageCode]['welcomeTo'];
  }

  String get selectCountry {
    return _localizedValues[locale.languageCode]['selectCountry'];
  }

  String get phoneNumber {
    return _localizedValues[locale.languageCode]['phoneNumber'];
  }

  String get notifications {
    return _localizedValues[locale.languageCode]['notifications'];
  }

  String get chat {
    return _localizedValues[locale.languageCode]['chat'];
  }

  String get enterPhoneNumber {
    return _localizedValues[locale.languageCode]['enterPhoneNumber'];
  }

  String get wellSendOTPForVerification {
    return _localizedValues[locale.languageCode]['wellSendOTPForVerification'];
  }

  String get orContinueWith {
    return _localizedValues[locale.languageCode]['orContinueWith'];
  }

  String get fullName {
    return _localizedValues[locale.languageCode]['fullName'];
  }

  String get enterFullName {
    return _localizedValues[locale.languageCode]['enterFullName'];
  }

  String get emailAddress {
    return _localizedValues[locale.languageCode]['emailAddress'];
  }

  String get enterEmailAddress {
    return _localizedValues[locale.languageCode]['enterEmailAddress'];
  }

  String get verification {
    return _localizedValues[locale.languageCode]['verification'];
  }

  String get pleaseEnterVerificationCodeSentGivenNumber {
    return _localizedValues[locale.languageCode]['pleaseEnterVerificationCodeSentGivenNumber'];
  }

  String get enterVerificationCode {
    return _localizedValues[locale.languageCode]['enterVerificationCode'];
  }

  String get register {
    return _localizedValues[locale.languageCode]['register'];
  }

  String get freshredonion {
    return _localizedValues[locale.languageCode]['freshredonion'];
  }

  String get freshredtomatoes {
    return _localizedValues[locale.languageCode]['freshredtomatoes'];
  }

  String get mediumPotatoes {
    return _localizedValues[locale.languageCode]['mediumPotatoes'];
  }

  String get freshLadiesFinger {
    return _localizedValues[locale.languageCode]['freshLadiesFinger'];
  }

  String get freshgarlic {
    return _localizedValues[locale.languageCode]['freshgarlic'];
  }

  String get orderedOn {
    return _localizedValues[locale.languageCode]['orderedOn'];
  }

  String get orderID {
    return _localizedValues[locale.languageCode]['orderID'];
  }

  String get payment {
    return _localizedValues[locale.languageCode]['payment'];
  }

  String get paymentmode {
    return _localizedValues[locale.languageCode]['paymentmode'];
  }

  String get productID {
    return _localizedValues[locale.languageCode]['productID'];
  }

  String get orderStatus {
    return _localizedValues[locale.languageCode]['orderStatus'];
  }

  String get pending {
    return _localizedValues[locale.languageCode]['pending'];
  }

  String get newOrders {
    return _localizedValues[locale.languageCode]['newOrders'];
  }

  String get nextDayOrder {
    return _localizedValues[locale.languageCode]['nextDayOrder'];
  }

  String get hey {
    return _localizedValues[locale.languageCode]['hey'];
  }

  String get myOrders {
    return _localizedValues[locale.languageCode]['myOrders'];
  }

  String get insight {
    return _localizedValues[locale.languageCode]['insight'];
  }

  String get myItems {
    return _localizedValues[locale.languageCode]['myItems'];
  }

  String get myEarnings {
    return _localizedValues[locale.languageCode]['myEarnings'];
  }

  String get myProfile {
    return _localizedValues[locale.languageCode]['myProfile'];
  }

  String get helpCentre {
    return _localizedValues[locale.languageCode]['helpCentre'];
  }

  String get language {
    return _localizedValues[locale.languageCode]['language'];
  }

  String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }

  String get contactUs {
    return _localizedValues[locale.languageCode]['contactUs'];
  }

  String get letUsKnowYourFeedbackQueriesIssueRegardingAppFeatures {
    return _localizedValues[locale.languageCode]['letUsKnowYourFeedbackQueriesIssueRegardingAppFeatures'];
  }

  String get enterYourMessage {
    return _localizedValues[locale.languageCode]['enterYourMessage'];
  }

  String get yourFeedback {
    return _localizedValues[locale.languageCode]['yourFeedback'];
  }

  String get submit {
    return _localizedValues[locale.languageCode]['submit'];
  }

  String get topSellingItems {
    return _localizedValues[locale.languageCode]['topSellingItems'];
  }

  String get orders {
    return _localizedValues[locale.languageCode]['orders'];
  }

  String get revenue {
    return _localizedValues[locale.languageCode]['revenue'];
  }

  String get apparel {
    return _localizedValues[locale.languageCode]['apparel'];
  }

  String get vegetables {
    return _localizedValues[locale.languageCode]['vegetables'];
  }

  String get sold {
    return _localizedValues[locale.languageCode]['sold'];
  }

  String get sendToBank {
    return _localizedValues[locale.languageCode]['sendToBank'];
  }

  String get recentTransactions {
    return _localizedValues[locale.languageCode]['recentTransactions'];
  }

  String get sendTo {
    return _localizedValues[locale.languageCode]['sendTo'];
  }

  String get bank {
    return _localizedValues[locale.languageCode]['bank'];
  }

  String get balance {
    return _localizedValues[locale.languageCode]['balance'];
  }

  String get cauliFlower {
    return _localizedValues[locale.languageCode]['cauliFlower'];
  }

  String get changeCoverImage {
    return _localizedValues[locale.languageCode]['changeCoverImage'];
  }

  String get setProfileInfo {
    return _localizedValues[locale.languageCode]['setProfileInfo'];
  }

  String get sellerName {
    return _localizedValues[locale.languageCode]['sellerName'];
  }

  String get sellerName1 {
    return _localizedValues[locale.languageCode]['sellerName1'];
  }

  String get setSellerAddress {
    return _localizedValues[locale.languageCode]['setSellerAddress'];
  }

  String get selectOnMap {
    return _localizedValues[locale.languageCode]['selectOnMap'];
  }

  String get update {
    return _localizedValues[locale.languageCode]['update'];
  }

  String get addItem {
    return _localizedValues[locale.languageCode]['addItem'];
  }

  String get updateItem {
    return _localizedValues[locale.languageCode]['updateItem'];
  }

  String get englishh {
    return _localizedValues[locale.languageCode]['englishh'];
  }

  String get spanishh {
    return _localizedValues[locale.languageCode]['spanishh'];
  }

  String get portuguesee {
    return _localizedValues[locale.languageCode]['portuguesee'];
  }

  String get frenchh {
    return _localizedValues[locale.languageCode]['frenchh'];
  }

  String get arabicc {
    return _localizedValues[locale.languageCode]['arabicc'];
  }

  String get indonesiann {
    return _localizedValues[locale.languageCode]['indonesiann'];
  }

  String get languages {
    return _localizedValues[locale.languageCode]['languages'];
  }

  String get selectPreferredLanguage {
    return _localizedValues[locale.languageCode]['selectPreferredLanguage'];
  }

  String get save {
    return _localizedValues[locale.languageCode]['save'];
  }

  String get addAddress {
    return _localizedValues[locale.languageCode]['addAddress'];
  }

  String get saveAddress {
    return _localizedValues[locale.languageCode]['saveAddress'];
  }

  String get editItem {
    return _localizedValues[locale.languageCode]['editItem'];
  }

  String get itemInfo {
    return _localizedValues[locale.languageCode]['itemInfo'];
  }

  String get productTitle {
    return _localizedValues[locale.languageCode]['productTitle'];
  }

  String get itemCategory {
    return _localizedValues[locale.languageCode]['itemCategory'];
  }

  String get itemSubCategory {
    return _localizedValues[locale.languageCode]['itemSubCategory'];
  }

  String get freshvegetables {
    return _localizedValues[locale.languageCode]['freshvegetables'];
  }

  String get description {
    return _localizedValues[locale.languageCode]['description'];
  }

  String get briefYourProduct {
    return _localizedValues[locale.languageCode]['briefYourProduct'];
  }

  String get pricingStock {
    return _localizedValues[locale.languageCode]['pricingStock'];
  }

  String get productTag1 {
    return _localizedValues[locale.languageCode]['productTag1'];
  }

  String get productTag2 {
    return _localizedValues[locale.languageCode]['productTag2'];
  }

  String get ean1 {
    return _localizedValues[locale.languageCode]['ean1'];
  }

  String get ean2 {
    return _localizedValues[locale.languageCode]['ean2'];
  }

  String get sellProductPrice {
    return _localizedValues[locale.languageCode]['sellProductPrice'];
  }

  String get sellProductMrp {
    return _localizedValues[locale.languageCode]['sellProductMrp'];
  }

  String get stockAvailability {
    return _localizedValues[locale.languageCode]['stockAvailability'];
  }

  String get inStock {
    return _localizedValues[locale.languageCode]['inStock'];
  }

  String get itemID {
    return _localizedValues[locale.languageCode]['itemID'];
  }

  String get shippingAddress {
    return _localizedValues[locale.languageCode]['shippingAddress'];
  }

  String get readyDispatch {
    return _localizedValues[locale.languageCode]['readyDispatch'];
  }

  String get assignboy {
    return _localizedValues[locale.languageCode]['assignboy'];
  }

  String get cancelOrdr {
    return _localizedValues[locale.languageCode]['cancelOrdr'];
  }

  String get avgRatings {
    return _localizedValues[locale.languageCode]['avgRatings'];
  }

  String get ratings {
    return _localizedValues[locale.languageCode]['ratings'];
  }

  String get recentReviews {
    return _localizedValues[locale.languageCode]['recentReviews'];
  }

  String get balanceAvailable {
    return _localizedValues[locale.languageCode]['balanceAvailable'];
  }

  String get provideBankDetails {
    return _localizedValues[locale.languageCode]['provideBankDetails'];
  }

  String get bankName {
    return _localizedValues[locale.languageCode]['bankName'];
  }

  String get branchCode {
    return _localizedValues[locale.languageCode]['branchCode'];
  }

  String get accountNumber {
    return _localizedValues[locale.languageCode]['accountNumber'];
  }

  String get enterAmountToTransfer {
    return _localizedValues[locale.languageCode]['enterAmountToTransfer'];
  }

  String get sentOn {
    return _localizedValues[locale.languageCode]['sentOn'];
  }

  String get sentSuccessfully {
    return _localizedValues[locale.languageCode]['sentSuccessfully'];
  }

  String get password1 {
    return _localizedValues[locale.languageCode]['password1'];
  }

  String get password2 {
    return _localizedValues[locale.languageCode]['password2'];
  }

  String get storename1 {
    return _localizedValues[locale.languageCode]['storename1'];
  }

  String get storename2 {
    return _localizedValues[locale.languageCode]['storename2'];
  }

  String get storenumber1 {
    return _localizedValues[locale.languageCode]['storenumber1'];
  }

  String get storenumber2 {
    return _localizedValues[locale.languageCode]['storenumber2'];
  }

  String get ownerName1 {
    return _localizedValues[locale.languageCode]['ownerName1'];
  }

  String get ownerName2 {
    return _localizedValues[locale.languageCode]['ownerName2'];
  }

  String get adminshare1 {
    return _localizedValues[locale.languageCode]['adminshare1'];
  }

  String get adminshare2 {
    return _localizedValues[locale.languageCode]['adminshare2'];
  }

  String get deliveryrange1 {
    return _localizedValues[locale.languageCode]['deliveryrange1'];
  }

  String get deliveryrange2 {
    return _localizedValues[locale.languageCode]['deliveryrange2'];
  }

  String get storeaddress1 {
    return _localizedValues[locale.languageCode]['storeaddress1'];
  }

  String get storeaddress2 {
    return _localizedValues[locale.languageCode]['storeaddress2'];
  }

  String get storeimage {
    return _localizedValues[locale.languageCode]['storeimage'];
  }

  String get selectycity1 {
    return _localizedValues[locale.languageCode]['selectycity1'];
  }

  String get selectycity2 {
    return _localizedValues[locale.languageCode]['selectycity2'];
  }

  String get uploadpictext {
    return _localizedValues[locale.languageCode]['uploadpictext'];
  }

  String get incorectPassword {
    return _localizedValues[locale.languageCode]['incorectPassword'];
  }

  String get incorectEmail {
    return _localizedValues[locale.languageCode]['incorectEmail'];
  }

  String get incorectUserName {
    return _localizedValues[locale.languageCode]['incorectUserName'];
  }

  String get incorectMobileNumber {
    return _localizedValues[locale.languageCode]['incorectMobileNumber'];
  }

  String get itempagenomore {
    return _localizedValues[locale.languageCode]['itempagenomore'];
  }

  String get aboutUs {
    return _localizedValues[locale.languageCode]['aboutUs'];
  }

  String get deliveryperson {
    return _localizedValues[locale.languageCode]['deliveryperson'];
  }

  String get deliveryDate {
    return _localizedValues[locale.languageCode]['deliveryDate'];
  }

  String get callBackReq1 {
    return _localizedValues[locale.languageCode]['callBackReq1'];
  }

  String get callBackReq2 {
    return _localizedValues[locale.languageCode]['callBackReq2'];
  }

  String get nohistoryfound {
    return _localizedValues[locale.languageCode]['nohistoryfound'];
  }

  String get or {
    return _localizedValues[locale.languageCode]['or'];
  }

  String get tnc {
    return _localizedValues[locale.languageCode]['tnc'];
  }

  String get unit2 {
    return _localizedValues[locale.languageCode]['unit2'];
  }

  String get unit1 {
    return _localizedValues[locale.languageCode]['unit1'];
  }

  String get qnty2 {
    return _localizedValues[locale.languageCode]['qnty2'];
  }

  String get qnty1 {
    return _localizedValues[locale.languageCode]['qnty1'];
  }

  String get qntyunit {
    return _localizedValues[locale.languageCode]['qntyunit'];
  }

  String get addVarient {
    return _localizedValues[locale.languageCode]['addVarient'];
  }

  String get printinvoice {
    return _localizedValues[locale.languageCode]['printinvoice'];
  }

  String get close {
    return _localizedValues[locale.languageCode]['close'];
  }

  String get storepheading {
    return _localizedValues[locale.languageCode]['storepheading'];
  }

  String get adminpheading {
    return _localizedValues[locale.languageCode]['adminpheading'];
  }

  String get todayOrd {
    return _localizedValues[locale.languageCode]['todayOrd'];
  }

  String get nextdayOrd {
    return _localizedValues[locale.languageCode]['nextdayOrd'];
  }

  String get noorderfnd {
    return _localizedValues[locale.languageCode]['noorderfnd'];
  }

  String get connect {
    return _localizedValues[locale.languageCode]['connect'];
  }

  String get headingAlert1 {
    return _localizedValues[locale.languageCode]['headingAlert1'];
  }

  String get invoice1h {
    return _localizedValues[locale.languageCode]['invoice1h'];
  }

  String get invoice4h {
    return _localizedValues[locale.languageCode]['invoice4h'];
  }

  String get invoice3h {
    return _localizedValues[locale.languageCode]['invoice3h'];
  }

  String get invoice2h {
    return _localizedValues[locale.languageCode]['invoice2h'];
  }

  String get invoice5h {
    return _localizedValues[locale.languageCode]['invoice5h'];
  }

  String get invoice6h {
    return _localizedValues[locale.languageCode]['invoice6h'];
  }

  String get invoice7h {
    return _localizedValues[locale.languageCode]['invoice7h'];
  }

  String get cancel {
    return _localizedValues[locale.languageCode]['cancel'];
  }

  String get photolib {
    return _localizedValues[locale.languageCode]['photolib'];
  }

  String get camera {
    return _localizedValues[locale.languageCode]['camera'];
  }

  String get pimage1 {
    return _localizedValues[locale.languageCode]['pimage1'];
  }

  String get order1 {
    return _localizedValues[locale.languageCode]['order1'];
  }

  String get qnt {
    return _localizedValues[locale.languageCode]['qnt'];
  }

  String get searchyourlocation {
    return _localizedValues[locale.languageCode]['searchyourlocation'];
  }

  String get bulgarian {
    return _localizedValues[locale.languageCode]['bulgarian'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar', 'pt', 'fr', 'id', 'es', 'bg'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of AppLocalizations.
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
