<?php

use Illuminate\Http\Request;
//user app//
use App\Http\Controllers\Api\AppController;
use App\Http\Controllers\Api\AddressController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\CouponController;
use App\Http\Controllers\Api\CurrencyController;
use App\Http\Controllers\Api\FirebaseController;
use App\Http\Controllers\Api\forgotpasswordController;
use App\Http\Controllers\Api\MapsetController;
use App\Http\Controllers\Api\AppsetController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\PagesController;
use App\Http\Controllers\Api\RatingController;
use App\Http\Controllers\Api\RewardController;
use App\Http\Controllers\Api\SearchController;
use App\Http\Controllers\Api\SupportController;
use App\Http\Controllers\Api\TimeslotController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\UsernotificationController;
use App\Http\Controllers\Api\WalletController;
use App\Http\Controllers\Api\WishlistController;
use App\Http\Controllers\Api\PassportController;
use App\Http\Controllers\Api\CartController;
use App\Http\Controllers\Api\OrderlistController;
//store//
use App\Http\Controllers\Storeapi\AddproductController;
use App\Http\Controllers\Storeapi\AssignController;
use App\Http\Controllers\Storeapi\NotificationController;
use App\Http\Controllers\Storeapi\RegController;
use App\Http\Controllers\Storeapi\StorecallController;
use App\Http\Controllers\Storeapi\StorecouponController;
use App\Http\Controllers\Storeapi\StoreinvoiceController;
use App\Http\Controllers\Storeapi\StoreloginController;
use App\Http\Controllers\Storeapi\StoreorderController;
use App\Http\Controllers\Storeapi\StoresupportController;
use App\Http\Controllers\Storeapi\StproductController;
use App\Http\Controllers\Storeapi\StvarientController;
//driver//
use App\Http\Controllers\Driverapi\DrivercallController;
use App\Http\Controllers\Driverapi\DriverloginController;
use App\Http\Controllers\Driverapi\DriverNotificationController;
use App\Http\Controllers\Driverapi\DriverorderController;
use App\Http\Controllers\Driverapi\DriverstatusController;
use App\Http\Controllers\Driverapi\DriversupportController;





/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::namespace("Api")->prefix('')->group(function () {
    Route::post('login', [UserController::class,'login']);
    Route::post('verify_via_firebase', [UserController::class,'verifyotpfirebase']);
     Route::post('login_with_email', [UserController::class,'login_with_email']);
    Route::post('register_details', [UserController::class,'register_details']);
    Route::post('social_login', [UserController::class,'social_login']);
    
    Route::post('verify_phone', [UserController::class,'verifyPhone']);
    Route::post('forget_password', [UserController::class,'forgotPassword']);
     Route::post('verifyOtpPass', [UserController::class,'verifyOtpPass']);
     Route::post('verifyOtpPassfirebase', [UserController::class,'verifyOtpPassfb']);
    Route::post('verify_otp', [UserController::class,'verifyOtp']);
    Route::post('loginverify_phone', [UserController::class,'loginverifyPhone']);
    Route::post('loginverify_via_firebase', [UserController::class,'loginverifyotpfirebase']);
    Route::get('validate', [PassportController::class,'validates'])->name('validate');
    Route::post('app_info', [AppController::class,'app']);
    Route::get('currency', [CurrencyController::class,'currency']);
    Route::get('mapby', [MapsetController::class,'mapby']);
    Route::get('google_map', [MapsetController::class,'google_map']);
    Route::get('mapbox', [MapsetController::class,'mapbox']);
    Route::get('payment_load', [AppController::class,'payment']); 
     ////pages//
    Route::get('appaboutus', [PagesController::class,'appaboutus']);
    Route::get('appterms', [PagesController::class,'appterms']);
    Route::get('city', [AddressController::class,'city']);
    Route::post('society', [AddressController::class,'society']);
      ////category product, product_varient///////
    Route::post('oneapi', [CategoryController::class,'oneapi']);
     Route::post('varient', [CategoryController::class,'varient']);
     Route::post('dealproduct', [CategoryController::class,'dealproduct']);
     Route::post('catee', [CategoryController::class,'cate']);
     Route::post('subcatee', [CategoryController::class,'catego']);
     Route::post('cat_product', [CategoryController::class,'cat_product']);
     Route::post('topcat', [CategoryController::class,'top_cat']);
    Route::post('homecat', [CategoryController::class,'homecat']);
    Route::post('store_homecat', [CategoryController::class,'store_homecat']);
    Route::post('tag_product', [CategoryController::class,'tag_product']);
    Route::post('top_cat_prduct', [CategoryController::class,'top_cat_prduct']);   
    Route::post('tabs', [CategoryController::class,'tabs']);
     Route::get('all_p', [CategoryController::class,'productm'])->name('testp');
      Route::post('top_selling', [OrderController::class,'top_selling']);
     Route::post('recentselling', [OrderController::class,'recentselling']);
     Route::post('whatsnew', [OrderController::class,'whatsnew']);
     Route::post('store_banner', [AppController::class,'storebanner']);
    Route::post('storecoupons', [AppController::class,'couponlist']);
	 Route::post('getneareststore', [CategoryController::class,'getneareststore']);
	 Route::get('payment_success', [AppController::class,'success']);
     Route::get('payment_failed', [AppController::class,'failed']);
     Route::post('checkout', [OrderController::class,'checkout']);
         /////time slot////// 
     Route::post('resendotp', [UserController::class,'resendotp']);
     Route::post('timeslot', [TimeslotController::class,'timeslot']);
     Route::get('membership_plan', [AppController::class,'membership_plan']);
      Route::post('forgot_password', [forgotpasswordController::class,'forgot_password']);
      Route::post('change_pass', [forgotpasswordController::class,'change_pass'])->name('change_pass');
     Route::get('checkotponoff', [forgotpasswordController::class,'checkotponoff']); 
       Route::post('change_password', [UserController::class,'changePassword']);
       Route::post('firebase_otp_ver', [forgotpasswordController::class,'verifyOtp3']);
        Route::post('banner_var', [CategoryController::class,'banner_var']);
     Route::post('trendsearchproducts', [SearchController::class,'trensearchproducts']);
      Route::post('searchbystore', [SearchController::class,'searchbystore']);
    Route::post('search', [SearchController::class,'search']);
    Route::post('recent_search', [SearchController::class,'recentsearch']);
    Route::post('product_det', [CategoryController::class,'product_det']);
     Route::get('users_delete', [AppController::class,'delete_users']); 
   Route::post('spotlight', [OrderController::class,'spotlight']);  
  Route::post('get_product_rating', [RatingController::class,'get_product_rating']);   
   Route::get('app_notice', [FirebaseController::class,'app_notice']);   
    

     
});

    Route::middleware('auth:api')->namespace("Api")->prefix('')->group(function () {
Route::get('payment_gateways', [CurrencyController::class,'gatewaysettings']);
Route::post('reorder', [CartController::class,'re_ordercart']);
   Route::post('buymember', [AppController::class,'buymember']);
    Route::post('membership_status', [AppController::class,'membership_status']);
     Route::post('trackorder', [AppController::class,'trackorder']);
    Route::post('minmax', [AppController::class,'minmax']);
    Route::get('delivery_info', [AppController::class,'delivery_info']);
    Route::post('callback_req', [AppController::class,'call']);

    Route::post('checkotp', [UserController::class,'checkOTP']);
    Route::post('myprofile', [UserController::class,'myprofile']);
    Route::post('profile_edit', [UserController::class,'profile_edit']);
    Route::post('user_block_check', [UserController::class,'user_block_check']);
    
   
    Route::post('deleteusr', [UserController::class,'deletenum']); 
  
	  
    //////address///////
     Route::post('add_address', [AddressController::class,'address']);
     
     Route::post('show_address', [AddressController::class,'show_address']);
     Route::post('select_address', [AddressController::class,'select_address']);
     Route::post('edit_address', [AddressController::class,'edit_add']);
     Route::post('remove_address', [AddressController::class,'rem_user_address']);
     Route::post('show_all_address', [AddressController::class,'show_all_address']);

    
    
     //orders//
     Route::post('my_orders', [OrderController::class,'ongoing']);
     Route::get('cancelling_reasons', [OrderController::class,'cancel_for']);
     Route::post('delete_order', [OrderController::class,'delete_order']);
     
     
     Route::post('completed_orders', [OrderController::class,'completed_orders']);
     Route::post('can_orders', [OrderController::class,'can_orders']);
     
    
  
    //coupon//
     Route::post('apply_coupon', [CouponController::class,'apply_coupon']);
     Route::post('couponlist', [CouponController::class,'coupon_list']);

     Route::post('walletamount', [WalletController::class,'walletamount']);
     Route::post('recharge_wallet', [WalletController::class,'add_credit']);
     Route::post('paid_by_wallet', [WalletController::class,'totalbill']);
     Route::post('wallet_recharge_history', [WalletController::class,'show_recharge_history']);

     
     /////rating/////
     Route::post('review_on_delivery', [RatingController::class,'review_on_delivery']);
     Route::post('check_for_product_rating', [RatingController::class,'check_for_rating']);
    
     Route::post('add_product_rating', [RatingController::class,'add_product_rating']);
    
     
     //redeem rewards//
    Route::post('redeem_rewards', [RewardController::class,'redeem']);
    Route::get('rewardvalues', [RewardController::class,'rewardvalues']);
    Route::post('rewardlines', [RewardController::class,'rewardlines']);

     
      //notifications//
     Route::post('notificationlist', [UsernotificationController::class,'notificationlist']);
     Route::post('read_by_user', [UsernotificationController::class,'read_by_user']);
     Route::post('mark_all_as_read', [UsernotificationController::class,'mark_all_as_read']);
     Route::post('delete_all_notification', [UsernotificationController::class,'delete_all']);

    

    Route::get('countrycode', [FirebaseController::class,'countrycode']);
    Route::get('firebase', [FirebaseController::class,'firebase']);


    
    Route::post('checknum', [forgotpasswordController::class,'checknum']);

   
         
    Route::get('firebase_iso', [FirebaseController::class,'firebase_iso']);
    Route::post('add_rem_wishlist', [WishlistController::class,'add_to_wishlist']);
    Route::post('show_wishlist', [WishlistController::class,'show_wishlist']);
    Route::post('wishlist_to_cart', [WishlistController::class,'wishlist_to_cart']);
    

    Route::post('user_feedback', [SupportController::class,'feedback']);

    Route::post('add_to_cart', [CartController::class,'add_to_cart']);
    Route::post('make_order', [CartController::class,'make_an_order']);
    Route::post('show_cart', [CartController::class,'show_cart']);
    Route::post('del_frm_cart', [CartController::class,'del_frm_cart']);
    Route::post('check_cart', [CartController::class,'check_cart']);
    Route::post('clear_cart', [CartController::class,'clear_cart']);
    Route::post('societyforaddress', [AddressController::class,'societyforadd']);

      //notification by///
     Route::post('appsetting', [AppsetController::class,'appsetting']);
     Route::post('updateappsetting', [AppsetController::class,'updateapp']); 
     Route::post('pen_con_out', [OrderController::class,'pen_con_out']);
        Route::post('orderlist', [OrderlistController::class,'orderlist']);
});

Route::group(['prefix'=>'store', ['middleware' => ['XSS']], 'namespace'=>'Storeapi'], function(){
   
    Route::post('store_login', [StoreloginController::class,'store_login']);
    Route::post('store_profile', [StoreloginController::class,'storeprofile']);

    Route::post('storetoday_orders', [StoreorderController::class,'todayorders']);
    Route::post('storenextday_orders', [StoreorderController::class,'nextdayorders']);
    Route::post('productcancelled', [StoreorderController::class,'productcancelled']);
    Route::post('order_rejected', [StoreorderController::class,'order_rejected']);

    Route::post('nearbydboys', [AssignController::class,'delivery_boy_list']);
    Route::post('storeconfirm', [AssignController::class,'storeconfirm']);

    Route::post('cart_invoice', [StoreinvoiceController::class,'cart_invoice']);

    Route::post('regstore', [RegController::class,'regstore']);

    Route::post('orderlistbyday', [OrdersaleController::class,'orderlist']);
    
    Route::post('st_productselect', [AddproductController::class,'productselect']);
    Route::post('st_products', [AddproductController::class,'store_products']);
    Route::post('st_stock_update', [AddproductController::class,'stock_update']);
    Route::post('st_delete_product', [AddproductController::class,'delete_product']); 
    Route::post('st_add_products', [AddproductController::class,'add_products']); 

    Route::post('store_products', [StproductController::class,'list']);
    Route::get('cat_list', [StproductController::class,'category_list']);
    Route::post('store_products_add', [StproductController::class,'st_addproduct']);
    Route::post('store_products_update', [StproductController::class,'St_updateproduct']); 
    Route::post('store_products_delete', [StproductController::class,'DeleteProduct']); 


    Route::post('store_varients_list', [StvarientController::class,'varient_list']);
    Route::post('store_varients_add', [StvarientController::class,'AddNewproduct']);
    Route::post('store_varients_update', [StvarientController::class,'Updateproduct']);
    Route::post('store_varients_delete', [StvarientController::class,'deleteproduct']); 

    Route::post('store_update_profile', [StoreloginController::class,'storeupdateprofile']); 
    Route::post('top_products', [StoreloginController::class,'top_selling']); 
 


    Route::post('store_feedback', [StoresupportController::class,'feedback']); 
    Route::post('store_callback_req', [StorecallController::class,'call']); 
    Route::post('store_order_history', [StoreorderController::class,'store_order_history']); 

    Route::post('st_couponlist', [StorecouponController::class,'couponlist']); 
    Route::post('st_coupon_add', [StorecouponController::class,'addcoupon']); 
    Route::post('st_updatecoupon', [StorecouponController::class,'updatecoupon']); 
    Route::post('st_deletecoupon', [StorecouponController::class,'deletecoupon']); 
     //notifications//
     Route::post('st_notificationlist', [NotificationController::class,'notificationlist']);
     Route::post('read_by_store', [NotificationController::class,'read_by_store']);
     Route::post('all_as_read', [NotificationController::class,'all_as_read']);
     Route::post('st_delete_all_notification', [NotificationController::class,'delete_all']);
     Route::get('id_list', [RegController::class,'idlist']);

});


Route::group(['prefix'=>'driver', ['middleware' => ['XSS']], 'namespace'=>'Driverapi'], function(){
  
     Route::post('ordersfortoday', [DriverorderController::class,'ordersfortoday']);
    Route::post('ordersfornextday', [DriverorderController::class,'ordersfornextday']);
    Route::post('out_for_delivery', [DriverorderController::class,'delivery_out']);
    Route::post('delivery_completed', [DriverorderController::class,'delivery_completed']);
    Route::post('order_items', [DriverorderController::class,'order_items']);
    Route::post('completed_orders', [DriverorderController::class,'completed_orders']);
    Route::post('completeorderlistbyday', [DriverorderController::class,'completeorderlist']);

    Route::post('update_status', [DriverstatusController::class,'status']);
    Route::post('driver_status', [DriverstatusController::class,'get_status']);
   

    Route::post('driver_login', [DriverloginController::class,'driver_login']);
    Route::post('driver_bank', [DriverloginController::class,'driverbank']);
    Route::post('driver_profile', [DriverloginController::class,'driverprofile']);
    Route::post('driverupdateprofile', [DriverloginController::class,'driverupdateprofile']);

    Route::post('driver_notificationlist', [DriverNotificationController::class,'notificationlist']);
    Route::post('read_by_driver', [DriverNotificationController::class,'read_by_driver']);
    Route::post('all_as_read_driver', [DriverNotificationController::class,'all_as_read']); 
    Route::post('driver_delete_all_notification', [DriverNotificationController::class,'delete_all']); 

    Route::post('driver_feedback', [DriversupportController::class,'feedback']);
    Route::post('driver_callback_req', [DrivercallController::class,'call']);
    
     Route::post('latlngupdate', [DriverstatusController::class,'latlngupdate']);
  
});



