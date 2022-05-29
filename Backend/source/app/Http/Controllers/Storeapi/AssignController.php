<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use App\Traits\SendMail;
use App\Traits\SendSms;
use App\Traits\SendInapp;
class AssignController extends Controller
{
 use SendMail; 
   use SendSms;
   use SendInapp;
 public function delivery_boy_list (Request $request)
     {
         
         $store_id = $request->store_id;
         $store= DB::table('store')
    	 		   ->where('id',$store_id)
    	 		   ->first();
    	 		   
    	  $nearbydboy = DB::table('delivery_boy')
                ->leftJoin('orders', 'delivery_boy.dboy_id', '=', 'orders.dboy_id') 
                ->select("delivery_boy.boy_name","delivery_boy.dboy_id","delivery_boy.lat","delivery_boy.lng","delivery_boy.boy_city",DB::raw("Count(orders.order_id)as count"),DB::raw("6371 * acos(cos(radians(".$store->lat . ")) 
                * cos(radians(delivery_boy.lat)) 
                * cos(radians(delivery_boy.lng) - radians(" . $store->lng . ")) 
                + sin(radians(" .$store->lat. ")) 
                * sin(radians(delivery_boy.lat))) AS distance"))
               ->groupBy("delivery_boy.boy_name","delivery_boy.dboy_id","delivery_boy.lat","delivery_boy.lng","delivery_boy.boy_city")
               ->where('delivery_boy.boy_city', $store->city)
               ->where('delivery_boy.status','1')
               ->orderBy('distance')
               ->get();  	
               
        if (count($nearbydboy)>0){
            $message = array('status'=>'1', 'message'=>'Delivery Boy List', 'data'=>$nearbydboy);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'No Delivery Boy In Your City');
	        return $message;
    	} 
    	
   }
   
   
    public function storeconfirm(Request $request)
    {
       $cart_id= $request->cart_id;
       $gt_orders =DB::table('orders')
                  ->join('address','orders.address_id','=','address.address_id')
                  ->select('address.lat', 'address.lng','orders.user_id')
                  ->where('orders.cart_id',$cart_id)
                  ->first();
                  
        $gt_orders2 =DB::table('orders')
                  ->where('cart_id',$cart_id)
                  ->first();          
       $store_id = $request->store_id;
        $store= DB::table('store')
    	 		   ->where('id',$store_id)
    	 		   ->first();  
          $userssss = DB::table('users')
                    ->where('id',$gt_orders2->user_id)
                    ->first();
                    
            $user_phone =  $userssss->user_phone;       
            $nearbydboy = DB::table('delivery_boy')
             ->join('store_delivery_boy','delivery_boy.dboy_id','=','store_delivery_boy.ad_dboy_id')
                ->select("delivery_boy.dboy_id",DB::raw("6371 * acos(cos(radians(".$gt_orders->lat . ")) 
                * cos(radians(delivery_boy.lat)) 
                * cos(radians(delivery_boy.lng) - radians(" . $gt_orders->lng . ")) 
                + sin(radians(" .$gt_orders->lat. ")) 
                * sin(radians(delivery_boy.lat))) AS distance"))
               ->groupBy("delivery_boy.boy_name","delivery_boy.dboy_id","delivery_boy.lat","delivery_boy.lng","delivery_boy.boy_city")
               ->where('store_delivery_boy.store_id' ,$store_id) 
               ->where('delivery_boy.status','1')
               ->orderBy('distance')
               ->first();  	
          
        if($nearbydboy){  
       $curr = DB::table('currency')
             ->first();
       
     $store= DB::table('store')
        	->where('id',$store_id)
    	 	->first();
       
    $getDevice = DB::table('delivery_boy')
             ->where('dboy_id', $nearbydboy->dboy_id)
            ->select('device_id','boy_name','dboy_id')
            ->first(); 
    $getDDevice  =  $getDevice;       
            
        $orr =   DB::table('orders')
                ->where('cart_id',$cart_id)
                ->first();
                    
           $v = DB::table('store_orders')
 		   ->where('order_cart_id',$cart_id)
 		   ->get(); 
          foreach($v as $vs){
                $qt = $vs->qty;
                $pr = DB::table('store_products')
            ->join('product_varient','store_products.varient_id','=','product_varient.varient_id') 
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$vs->varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
                 $stoc = DB::table('store_products')
                    ->where('varient_id',$vs->varient_id)
                    ->where('store_id',$store_id) 
                    ->first();
              if($stoc){     
                $newstock = $stoc->stock - $qt;     
                $st = DB::table('store_products')
                    ->where('varient_id',$vs->varient_id)
                    ->where('store_id',$store_id)
                    ->update(['stock'=>$newstock]);
              }
             }       
       $orderconfirm = DB::table('orders')
                    ->where('cart_id',$cart_id)
                    ->update(['order_status'=>'Confirmed',
                    'dboy_id'=>$nearbydboy->dboy_id]);
         
 		   
         if($orderconfirm){
                 $sms = DB::table('notificationby')
                       ->select('sms','app')
                       ->where('user_id',$orr->user_id)
                       ->first();
            $sms_status = $sms->sms;
                if($sms_status == 1){
                $codorderplaced = $this->orderconfirmedsms($cart_id,$user_phone,$orr);
                }

            if($sms->app == 1){
                
                 $confirmedinappuser = $this->orderconfirmedinapp($cart_id,$user_phone,$orr);
             
            }
           
            
             $confirmedinappdriver = $this->orderconfirmedinappdriver($getDDevice,$cart_id,$user_phone,$orr,$curr);
             
        	$message = array('status'=>'1', 'message'=>'order is confirmed and Assigned to '.$getDevice->boy_name);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Already Assigned to '.$getDevice->boy_name);
	        return $message;
    	} 
        }else{
           	$message = array('status'=>'1', 'message'=>'no delivery boy is online/available');
	        return $message; 
        }
   
    }
   
   
   
}      