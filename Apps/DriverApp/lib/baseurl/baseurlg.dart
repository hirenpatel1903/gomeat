import 'package:shared_preferences/shared_preferences.dart';

var imagebaseUrl1 = 'https://gomeat.tecmanic.com/';
var imagebaseUrl;
void getImageBaseUrl() async {
  SharedPreferences.getInstance().then((value) {
    if (value.containsKey('imagebaseurl')) {
      imagebaseUrl = value.getString('imagebaseurl') + '/';
    } else {
      imagebaseUrl = imagebaseUrl1;
    }
  });
}

var apibaseUrl = imagebaseUrl1 + 'api/';
var dirverBaseUrl = apibaseUrl + 'driver/';
var cityUri = Uri.parse('${apibaseUrl}city');
var appInfoUri = Uri.parse('${apibaseUrl}app_info');
var appTermsUri = Uri.parse('${apibaseUrl}appterms');
var loginUrl = Uri.parse('${dirverBaseUrl}driver_login');
var driverCallbackReqUrl = Uri.parse('${dirverBaseUrl}driver_callback_req');
var driverFeedbackUrl = Uri.parse('${dirverBaseUrl}driver_feedback');
var completedOrdersUrl = Uri.parse('${dirverBaseUrl}completed_orders');
var appAboutusUri = Uri.parse('${apibaseUrl}appaboutus');
var driverNotificationUri = Uri.parse('${dirverBaseUrl}driver_notificationlist');
var driverDeleteAllNotificationUri = Uri.parse('${dirverBaseUrl}driver_delete_all_notification');
var updateStatusUri = Uri.parse('${dirverBaseUrl}update_status');
var ordersfortodayUri = Uri.parse('${dirverBaseUrl}ordersfortoday');
var ordersfornextdayUri = Uri.parse('${dirverBaseUrl}ordersfornextday');
var outForDeliveryUri = Uri.parse('${dirverBaseUrl}out_for_delivery');
var deliveryCompletedUri = Uri.parse('${dirverBaseUrl}delivery_completed');
var driverStatusUri = Uri.parse('${dirverBaseUrl}driver_status');
var driverBankUri = Uri.parse('${dirverBaseUrl}driver_bank');
var driverProfileUri = Uri.parse('${dirverBaseUrl}driver_profile');
var driverupdateprofileUri = Uri.parse('${dirverBaseUrl}driverupdateprofile');
var updatelatlng = Uri.parse('${dirverBaseUrl}latlngupdate');
