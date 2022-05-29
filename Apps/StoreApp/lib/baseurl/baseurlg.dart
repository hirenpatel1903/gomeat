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
var storebaseUrl = imagebaseUrl1 + 'api/store/';
var appInfoUri = Uri.parse('${apibaseUrl}app_info');
var appAboutusUri = Uri.parse('${apibaseUrl}appaboutus');
var appTermsUri = Uri.parse('${apibaseUrl}appterms');
var storeLoginUri = Uri.parse('${storebaseUrl}store_login');
var registrationStoreUri = Uri.parse('${storebaseUrl}regstore');
var cityUri = Uri.parse('${apibaseUrl}city');
var storeIdList = Uri.parse('${storebaseUrl}id_list');
var storeProductsUri = Uri.parse('${storebaseUrl}store_products');
var storeProductsAdminUri = Uri.parse('${storebaseUrl}st_products');
var storeProfileUri = Uri.parse('${storebaseUrl}store_profile');
var storeUpdateProfileUri = Uri.parse('${storebaseUrl}store_update_profile');
var storetodayOrdersUri = Uri.parse('${storebaseUrl}storetoday_orders');
var storenextdayOrdersUri = Uri.parse('${storebaseUrl}storenextday_orders');
var nearbydboysUri = Uri.parse('${storebaseUrl}nearbydboys');
var assignBoyToOrderUri = Uri.parse('${storebaseUrl}storeconfirm');
var catListUri = Uri.parse('${storebaseUrl}cat_list');
var storeProductsAddUri = Uri.parse('${storebaseUrl}store_products_add');
var storeProductsUpdateUri = Uri.parse('${storebaseUrl}store_products_update');
var storeProductsDeleteUri = Uri.parse('${storebaseUrl}store_products_delete');
var storeVarientsListUri = Uri.parse('${storebaseUrl}store_varients_list');
var storeVarientsAddUri = Uri.parse('${storebaseUrl}store_varients_add');
var storeVarientsUpdateUri = Uri.parse('${storebaseUrl}store_varients_update');
var storeVarientsDeleteUri = Uri.parse('${storebaseUrl}store_varients_delete');
var storeFeedbackUri = Uri.parse('${storebaseUrl}store_feedback');
var storeProductRevenueUri = Uri.parse('${storebaseUrl}top_products');
var storeNotificationUri = Uri.parse('${storebaseUrl}st_notificationlist');
var storeNotificationDeleteAllUri = Uri.parse('${storebaseUrl}st_delete_all_notification');
var storeCallbackReqUri = Uri.parse('${storebaseUrl}store_callback_req');
var storeOrderHistoryUri = Uri.parse('${storebaseUrl}store_order_history');
var cancelOrderUri = Uri.parse('${storebaseUrl}order_rejected');
var getInvoiceUri = Uri.parse('${storebaseUrl}cart_invoice');
var storeStockUpdateUri = Uri.parse('${storebaseUrl}store_stock_update');
var mapbyUri = Uri.parse('${apibaseUrl}mapby');
var googleMapUri = Uri.parse('${apibaseUrl}google_map');
var mapboxUri = Uri.parse('${apibaseUrl}mapbox');
