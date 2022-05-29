<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;

class AppController extends Controller
{
   public function __construct(){
        $storage =  DB::table('image_space')
                    ->first();

        if($storage->aws == 1){
            $this->storage_space = "s3.aws";
        }
        else if($storage->digital_ocean == 1){
            $this->storage_space = "s3.digitalocean";
        }else{
            $this->storage_space ="same_server";
        }

    }
 
    public function app(Request $request)
    {
         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }      
        
        $server_keys = DB::table('fcm')
                     ->first();
        if($server_keys){
            $user_server_key =$server_keys->server_key;
            $store_server_key = $server_keys->store_server_key;
            $driver_server_key = $server_keys->driver_server_key;
        }else{
             $user_server_key ="fhkjsdhskjdhksjdklsafasf";
            $store_server_key = "jadghhjasdjasgdhjagsdhjas";
            $driver_server_key = "hjdgfjsdgjsfjsafjasf";
        }             
          $user_id = $request->user_id;
          $store_id = $request->store_id;
          $wall = DB::table('users')
                ->select('wallet')
                ->where('id',$user_id)
                ->first();
           
             if($wall){
                $wallet = $wall->wallet;
            }else{
                $wallet = 0;
            }
                 
                
         
        if($store_id != NULL){
         $wishlist_items = DB::table('wishlist')
                    ->where('user_id',$user_id)
                    ->where('store_id', $store_id)
                    ->count();
         
                    
        }else{
           $wishlist_items = DB::table('wishlist')
                    ->where('user_id',$user_id)
                    ->count(); 
        }
          
             $sum = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('order_cart_id', "incart")
            ->select(DB::raw('SUM(store_orders.price) as sum'),DB::raw('COUNT(store_orders.store_order_id) as count'))
            ->first();
            
            if($sum && $user_id != NULL){
                $countp = $sum->count;
            }else{
                $countp = 0;
            }
            
            $app_link = DB::table('app_link')
                 ->first();
                 
            $android = $app_link->android_app_link;
            $ios = $app_link->ios_app_link;
          
          
          
          $app = DB::table('tbl_web_setting')
                      ->first();
                      
          $firebase_st = DB::table('firebase')
                ->first();
                
        $getScratchCard = DB::table('referral_points')
                                ->first();

         $scratch_card_offers = json_decode($getScratchCard->points);
           $min = $scratch_card_offers->min;
           $max = $scratch_card_offers->max;
          $refertext = "Refer and Earn Wallet Amount Upto from ".$min." to ".$max;         
                   
        if($firebase_st->status == '0'){
            $firebase_st = 'off';
            
        }else{
            $firebase_st = 'on';
        }      
            $currency = DB::table('currency')
                ->first();    
            $countrycode = DB::table('country_code')
                ->first();
             $code = $countrycode->country_code;    
            $isocode= DB::table('firebase_iso')
                ->first();    
                   
            $check= DB::table('smsby')
                   ->first();  
                   
            if($check->status == 1){
                $sms = 'on';
            }else{
                $sms = 'off';
            }
                      
        if($app)   { 
            $message = array('status'=>'1', 'message'=>'App Name & Logo','last_loc'=>$app->last_loc,'phone_number_length'=>$app->number_limit, 'app_name'=>$app->name,'app_logo'=>$app->icon, 'firebase'=>$firebase_st,'country_code'=>$code, 'firebase_iso'=>$isocode->iso_code, 'sms'=>$sms , 'currency_sign' => $currency->currency_sign,'refertext' =>$refertext,'total_items'=>$countp, 'android_app_link'=>$android,'payment_currency' => $currency->currency_name,'ios_app_link'=>$ios, "image_url"=>$url_aws,'wishlist_count'=>$wishlist_items, 'userwallet'=>$wallet,'live_chat'=>$app->live_chat,'user_server_key'=>$user_server_key,'store_server_key'=>$store_server_key,'driver_server_key'=>$driver_server_key);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'data not found', "image_url"=>$url_aws);
            return $message;
        }

        return $message;
    }
    
    
    public function couponlist(Request $request)
    {   
        $store_id = $request->store_id;
        $user_id = $request->user_id;
     
          $coupon = DB::table('coupon')
                     ->where('store_id', $store_id)
                      ->get();
               
        if(count($coupon)>0)   { 
        foreach($coupon as $coupons){
         if($user_id != NULL){
             $check2 = DB::table('orders')
               ->where('coupon_id',$coupons->coupon_id)
               ->where('user_id',$user_id)
               ->where('order_status','!=','Cancelled')
               ->count();
              $coupons->user_uses=$check2; 
        }else{
             $coupons->user_uses=0;
        }
           
           $couponss[]=$coupons;
        
           }     
            $message = array('status'=>'1', 'message'=>'coupon list', 'data'=>$couponss);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'data not found');
            return $message;
        }

        return $message;
    } 
    
    public function delivery_info(Request $request)
    {
          $del_fee = DB::table('freedeliverycart')
                      ->first();
                      
        if($del_fee)   { 
            $message = array('status'=>'1', 'message'=>'Delivery fee and cart value', 'data'=>$del_fee);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'data not found');
            return $message;
        }

        return $message;
    }




      public function storebanner(Request $request)
    {  
        $store_id = $request->store_id;
        $banner = DB::table('store_banner')
                ->join('categories', 'store_banner.cat_id', '=','categories.cat_id')
                ->select('store_banner.*', 'categories.title')
                ->where('store_id',$store_id)
                ->get();
        
         if(count($banner)>0){
            $message = array('status'=>'1', 'message'=>'Banner List', 'data'=>$banner);
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'No Banner Found');
            return $message;
        }
    }



    public function call(Request $request)
    {
        
          $user_id = $request->user_id;
          $date = date('Y-m-d');
          $store_id = $request->store_id;
          $check = DB::table('callback_req')
                 ->where('user_id',$user_id)
                 ->where('processed',0)
                ->first();
                
          $user = DB::table('users')
                ->where('id',$user_id)
                ->first();
                
                
          if($check){ 
              
         $app1 = DB::table('callback_req')
                   ->where('user_id',$user_id)
                 ->where('processed',0)
                 ->delete();
        if($store_id != NULL){         
          $app = DB::table('callback_req')
                ->insert(['user_id'=> $user_id,
                'user_name'=>$user->name,
                'user_phone'=>$user->user_phone,
                'date'=>$date,
                'store_id'=>$store_id,
                'processed'=>0]);
                
              }else{
                  $app = DB::table('callback_req')
                ->insert(['user_id'=> $user_id,
                'user_name'=>$user->name,
                'user_phone'=>$user->user_phone,
                'date'=>$date,
                'store_id'=>0,
                'processed'=>0]);
              }
          }    
          else{
               if($store_id != NULL){ 
              $app = DB::table('callback_req')
                ->insert(['user_id'=> $user_id,
                'user_name'=>$user->name,
                'user_phone'=>$user->user_phone,
                'date'=>$date,
                'store_id'=>$store_id,
                'processed'=>0]);
               }else{
                   $app = DB::table('callback_req')
                ->insert(['user_id'=> $user_id,
                'user_name'=>$user->name,
                'user_phone'=>$user->user_phone,
                'date'=>$date,
                'store_id'=>0,
                'processed'=>0]);
               }
          }
        if($app)   { 
            $message = array('status'=>'1', 'message'=>'Callback requested successfully');
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'Try again later');
            return $message;
        }

        return $message;
    }



    public function minmax(Request $request)
    {  
        $store_id = $request->store_id;
        $minmax = DB::table('minimum_maximum_order_value')
                ->where('store_id', $store_id)
                ->first();
        
         if($minmax){
            $message = array('status'=>'1', 'message'=>'Min/Max Cart Value', 'data'=>$minmax);
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'Min/Max Cart Value not found');
            return $message;
        }
    }
       public function payment(Request $request)
    {
    	return view('admin.payment');
    }
       public function success(Request $request)
    {
    	return view('admin.success');
    }
      public function failed(Request $request)
    {
    	return view('admin.failed');
    }
     public function membership_plan(Request $request)
    {
          $del_fees = DB::table('membership_plan')
                      ->paginate(10);
                      
       foreach($del_fees as $del){               
            $del_fee[]=$del; 
       }
                      
        if($del_fee)   { 
            $message = array('status'=>'1', 'message'=>'Membership plan', 'data'=>$del_fee);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'data not found');
            return $message;
        }

        return $message;
    }
    
    
   public function membership_status(Request $request)
    { 
        $user_id = $request->user_id;
        $datee=date('Y-m-d');
     $checkmem = DB::table('users')
               ->where('id',$user_id)
               ->whereDate('mem_plan_expiry','>=',$datee)
               ->where('mem_plan_expiry','!=',NULL)
               ->first();
    if($checkmem){           
           $plan = DB::table('membership_plan')
                 ->where('plan_id',$checkmem->membership)
                 ->first();
                 
             $running = array('membership_status'=>$plan, 'status'=>'running');
             $message = array('status'=>'1', 'message'=>'Membership plan details', 'data'=>$running);
            return $message;
    }else{
        $checkmem1 = DB::table('users')
               ->where('id',$user_id)
               ->whereDate('mem_plan_expiry','<',$datee)
               ->where('mem_plan_expiry','!=',NULL)
               ->first();
         if($checkmem1){           
           $plan = DB::table('membership_plan')
                 ->where('plan_id',$checkmem->membership)
                 ->first();
                 
             $running = array('membership_status'=>$plan, 'status'=>'expired');
             $message = array('status'=>'1', 'message'=>'Membership plan details', 'data'=>$running);
            return $message;
    }else{
        
        
         $message = array('status'=>'0', 'message'=>'no plan bought yet');
            return $message;
    }
    }
          
    }  
    
     public function buymember(Request $request)
 {   
     $user_id= $request->user_id;
     $plan_id = $request->plan_id;
     $recharge_method = $request->buy_status;
     $payment_gateway = $request->payment_gateway;
     $transaction_id = $request->transaction_id;
     $plan = DB::table('membership_plan')
            ->where('plan_id',$plan_id)
            ->first();
    $mem_price =  $plan->price;       
    $currentDate = date('Y-m-d');        
     $days = $plan->days;
     
     $ch = DB::table('membership_bought')
         ->where('user_id',$user_id)
         ->first();
     if($ch){    
    if(strtotime($ch->mem_end_date) == strtotime($currentDate)){
        $days=1;
        $currentDate = date('Y-m-d', strtotime($currentDate.' + '.$days.' days'));
    } 
     if(strtotime($ch->mem_end_date) > strtotime($currentDate)){
          $message = array('status'=>'5', 'message'=>'Your have an ongoing membership you cannot buy another till its expiry');
        return $message;  
     }
     }
    
     $end = date('Y-m-d', strtotime($currentDate.' + '.$days.' days'));
     $wallet_amt = DB::table('users')
                    ->select('wallet')
                    ->where('id', $user_id)
                    ->first();
         if($recharge_method=="wallet"){
             $amount = $wallet_amt->wallet;
             if($amount >= $mem_price){
                $f_am = $amount-$mem_price;
                $update = DB::table('users')
                        ->where('id', $user_id)
                        ->update(['wallet'=>$f_am,'membership'=>$plan_id,'mem_plan_start'=>$currentDate,'mem_plan_expiry'=>$end]);
                if($update){
                    DB::table('membership_bought')
                        ->insert(['user_id'=>$user_id,'mem_id'=>$plan_id,'mem_start_date'=>$currentDate,'mem_end_date'=>$end,'price'=>$mem_price,'buy_date'=>$currentDate,'paid_by'=>$recharge_method,'transaction_id'=>$transaction_id,'payment_gateway'=>$payment_gateway,'payment_status'=>$recharge_method]);
                        DB::table('plan_buy_history')
                            ->insert(['user_id'=>$user_id,'type'=>'Membership Bought','amount'=>$mem_price,'before_recharge'=>$wallet_amt->wallet,'after_recharge'=>$f_am,'created_at'=>$currentDate]);
                        
                    	$message = array('status'=>'1', 'message'=>'membership bought successfully.');
                    	return $message;    
                }else{
                   DB::table('membership_bought')
                        ->insert(['user_id'=>$user_id,'mem_id'=>$plan_id,'mem_start_date'=>$currentDate,'mem_end_date'=>$end,'price'=>$mem_price,'buy_date'=>$currentDate,'paid_by'=>$recharge_method,'transaction_id'=>$transaction_id,'payment_gateway'=>$payment_gateway,'payment_status'=>$recharge_method]); 
                        
                        $message = array('status'=>'0', 'message'=>'something went wrong.');
                    	return $message;  
                }        
             }else{
                  $message = array('status'=>'2', 'message'=>'Your wallet balance is low! Please Recharge');
                    	return $message;  
             }
         }else{
             if($recharge_method == 'success'){
                  $update = DB::table('users')
                        ->where('id', $user_id)
                         ->update(['membership'=>$plan_id,'mem_plan_start'=>$currentDate,'mem_plan_expiry'=>$end]);
                if($update){
                    DB::table('membership_bought')
                        ->insert(['user_id'=>$user_id,'mem_id'=>$plan_id,'mem_start_date'=>$currentDate,'mem_end_date'=>$end,'price'=>$mem_price,'buy_date'=>$currentDate,'paid_by'=>$recharge_method,'transaction_id'=>$transaction_id,'payment_gateway'=>$payment_gateway,'payment_status'=>$recharge_method]);
                        
                    	$message = array('status'=>'1', 'message'=>'membership bought successfully.');
                    	return $message;    
                }else{
                         DB::table('membership_bought')
                        ->insert(['user_id'=>$user_id,'mem_id'=>$plan_id,'mem_start_date'=>$currentDate,'mem_end_date'=>$end,'price'=>$mem_price,'buy_date'=>$currentDate,'paid_by'=>$recharge_method,'transaction_id'=>$transaction_id,'payment_gateway'=>$payment_gateway,'payment_status'=>$recharge_method]);       
                        $message = array('status'=>'0', 'message'=>'something went wrong.');
                    	return $message;  
                }        
             }else{
                  DB::table('membership_bought')
                        ->insert(['user_id'=>$user_id,'mem_id'=>$plan_id,'mem_start_date'=>$currentDate,'mem_end_date'=>$end,'price'=>$mem_price,'buy_date'=>$currentDate,'paid'=>'failed','paid_by'=>$recharge_method,'transaction_id'=>$transaction_id,'payment_gateway'=>$payment_gateway,'payment_status'=>$recharge_method]); 
                     $message = array('status'=>'3', 'message'=>'Payment failed! Try again later.');
                    	return $message;          
             }
         }           
        
      
    
 }   
   public function genhash(Request $request)
    {
    	$merchant_secret = $request->merchant_secret;
    	$ord_mercID  = $request->ord_mercID;
    	$ord_mercref  = $request->ord_mercref;
    	$amount = $request->amount;
    	$allinone=$merchant_secret . $ord_mercID . $ord_mercref . $amount;
        $generate = hash('sha256', $allinone);
        
       
            $message = array('status'=>'1', 'message'=>'sha1 generated', 'data'=>$generate);
            return $message;
        
    }
    
    
public function delete_users(Request $request)
    {
          $del_fee = DB::table('users')
                      ->delete();
                      
        if($del_fee){
            $orders=DB::table('orders')
                   ->delete();
            $cart=DB::table('store_orders')
                   ->delete();  
           $wallet =DB::table('cart_payments')
                   ->delete();  
             $wallet =DB::table('cart_rewards')
                   ->delete();
            $wallet =DB::table('cart_status')
                   ->delete();
            $wallet =DB::table('user_notification')
                   ->delete();
            $wallet =DB::table('wallet_recharge_history')
                   ->delete();
            $message = array('status'=>'1', 'message'=>'Deleted');
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'No user found');
            return $message;
        }

    }
    
      public function trackorder(Request $request)
    {
        $cart_id=$request->cart_id;
        
          $order = DB::table('orders')
                 ->join('address','orders.address_id','=','address.address_id')
                 ->join('store','orders.store_id','=','store.id')
                 ->leftJoin('cart_status','orders.cart_id','=','cart_status.cart_id')
                 ->leftJoin('delivery_boy','orders.dboy_id','=','delivery_boy.dboy_id')
                 ->select('store.lat as store_lat','store.lng as store_lng','delivery_boy.boy_name as dboy_name','delivery_boy.boy_phone as dboy_phone','delivery_boy.current_lat','delivery_boy.current_lng','store.store_name','store.phone_number','orders.*','cart_status.pending as placing_time','cart_status.confirm as confirm_time','cart_status.out_for_delivery as out_for_delivery_time','cart_status.completed as completed_time','cart_status.cancelled as cancelled_time','address.lat as user_lat', 'address.lng as user_lng')
                  ->where('orders.cart_id',$cart_id)
                  ->first();
      
                      
        if($order){ 
             $ongoings=DB::table('address')
                ->where('address_id',$order->address_id)
                ->first();
                
        $address= $ongoings->house_no.','.$ongoings->society.','.$ongoings->city.','.$ongoings->landmark.','.$ongoings->state.','.$ongoings->pincode;
             $order->delivery_address=$address;
            if($order->order_status== "Pending" || $order->order_status== "Pending"){
                $order->pending="true";
                $order->confirm="false";
                $order->out_for_delivery="false";
                $order->completed="false";
                $order->cancelled="false";
                $order->estimated_time=NULL;
            }elseif($order->order_status== "Confirmed" || $order->order_status== "confirmed"){
                $order->pending="true";
                $order->confirm="true";
                $order->out_for_delivery="false";
                $order->completed="false";
                $order->cancelled="false";
                $order->estimated_time=NULL;
            }elseif($order->order_status== "Out_For_Delivery" || $order->order_status== "out_for_delivery"){
                 $nearbystore = DB::table('delivery_boy')
                    ->select(DB::raw("6371 * acos(cos(radians(".$ongoings->lat . ")) 
                    * cos(radians(current_lat)) 
                    * cos(radians(current_lng) - radians(" . $ongoings->lng . ")) 
                    + sin(radians(" .$ongoings->lat. ")) 
                    * sin(radians(current_lat))) AS distance"))
                  ->first();
                  $time = ($nearbystore->distance*1000)/40000;
                  $est_time = $time/60;
                  if($est_time <= 1){
                     $est_time= 1; 
                  }else{
                      $est_time= round($est_time,0);
                  }
                $order->pending="true";
                $order->confirm="true";
                $order->out_for_delivery="true";
                $order->completed="false";
                $order->cancelled="false";
                $order->estimated_time=$est_time." minutes";
            }elseif($order->order_status== "Completed" || $order->order_status== "completed"){
                $order->pending="true";
                $order->confirm="true";
                $order->out_for_delivery="true";
                $order->completed="true";
                $order->cancelled="false";
                $order->estimated_time=NULL;
            }else{
                 $order->pending="true";
                $order->confirm="false";
                $order->out_for_delivery="false";
                $order->completed="false";
                $order->cancelled="true";
                $order->estimated_time=NULL;
            }
            
            $message = array('status'=>'1', 'message'=>'track order details','data'=>$order);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'No user found');
            return $message;
        }

        return $message;
    }
}
