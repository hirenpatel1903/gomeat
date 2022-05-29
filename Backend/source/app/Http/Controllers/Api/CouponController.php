<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class CouponController extends Controller
{
   public function apply_coupon(Request $request)
    {
        $cart_id = $request->cart_id;
        $coupon_code = $request->coupon_code;
                       
        $coupon = DB::table('coupon')
                ->where('coupon_code', $coupon_code)
                ->first();
                
        if($coupon){        
        $check = DB::table('orders')
               ->where('cart_id',$cart_id)
               ->first();
         $p=$check->total_price; 
          $mincart = $coupon->cart_value;
         if($mincart <= $p){
         $orderchecked =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->where('coupon_id',$coupon->coupon_id)
              ->first();     
              
        if(!$orderchecked){     
         $check2 = DB::table('orders')
               ->where('coupon_id',$coupon->coupon_id)
               ->where('user_id',$check->user_id)
               ->where('order_status','!=','Cancelled')
               ->count();
       
        if($coupon->uses_restriction > $check2){
      
        $mincart = $coupon->cart_value;
        $am = $coupon->amount;
        $type = $coupon->type;
        if($type=='%'||$type=='Percentage'||$type=='percentage'){
          $per = ($p*$am)/100;  
          $rem_price = $p-$per;
        }
        else{
            $per = $am;
            $rem_price = $p-$am; 
        }
        $update=DB::table('orders')
              ->where('cart_id',$cart_id)
              ->update(['rem_price'=>$rem_price,
              'coupon_discount'=>$per,
              'coupon_id'=>$coupon->coupon_id]);
              
        $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
              
    $coup = $order->price_without_delivery-$per;          
      $order->discountonmrp=$order->total_products_mrp - $order->price_without_delivery;                    
     if($order){   
        if($update){
            $message = array('status'=>'1', 'message'=>'Coupon Applied Successfully', 'data'=>$order);
            return $message;
            }
        else{
            $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
            $order->discountonmrp=$order->total_products_mrp -$order->price_without_delivery;   
            $message = array('status'=>'0', 'message'=>'Cannot Applied! Try again Later', 'data'=>$order);
            return $message;
        }
     }else{
         $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
              $order->discountonmrp=$order->total_products_mrp -$order->price_without_delivery;   
         $message = array('status'=>'0', 'message'=>'order not found', 'data'=>$order);
         return $message;
     }
    }
    else{
        $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
              $order->discountonmrp=$order->total_products_mrp -$order->price_without_delivery;   
         $message = array('status'=>'0', 'message'=>'Invalid Coupon! Maximum use limit reached', 'data'=>$order);
         return $message;
    }
        }
        else{
            $update=DB::table('orders')
              ->where('cart_id',$cart_id)
              ->update(['rem_price'=>$p,
              'coupon_discount'=>0,
              'coupon_id'=>0]);
             $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();  
              
         if($update){
             $order->discountonmrp=$order->total_products_mrp -$order->price_without_delivery;   
            $message = array('status'=>'2', 'message'=>'Coupon Unapplied', 'data'=>$order);
            return $message;
            }
        else{
            $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
              $order->discountonmrp=$order->total_products_mrp -$order->price_without_delivery;   
            $message = array('status'=>'0', 'message'=>'Try again Later', 'data'=>$order);
            return $message;
        }      
        }
    
    }else{
        $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
              $order->discountonmrp=$order->total_products_mrp -$order->price_without_delivery;   
        $message = array('status'=>'0', 'message'=>'Cart Value is low! minimum cart value should be greater than equal to '.$mincart, 'data'=>$order);
            return $message;
        }
            
            $order =DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
              $order->discountonmrp=$order->total_products_mrp -$order->price_without_delivery;   
        $message = array('status'=>'0', 'message'=>'Coupon not found', 'data'=>$order);
            return $message;
    }
    }
    
    public function coupon_list(Request $request)
    {
        $currentdate = Carbon::now();
        $cart_id = $request->cart_id; 
        $store_id = $request->store_id;
        $check = DB::table('orders')
               ->where('cart_id',$cart_id)
               ->first();
        if($check){        
        $p=$check->total_price;
        $coupon = DB::table('coupon')
                ->where('store_id',$check->store_id)
                ->where('cart_value','<=', $p)
                ->where('start_date','<=',$currentdate)
                ->where('end_date','>=',$currentdate)
                ->get();
        }else{
             $coupon = DB::table('coupon')
                ->where('store_id',$store_id)
                ->where('start_date','<=',$currentdate)
                ->where('end_date','>=',$currentdate)
                ->get();
        }
         if(count($coupon)>0){
             
     foreach($coupon as $coupons){
             $check2 = DB::table('orders')
               ->where('coupon_id',$coupons->coupon_id)
               ->where('user_id',$check->user_id)
               ->where('order_status','!=','Cancelled')
               ->count();
              $coupons->user_uses=$check2; 
           
           $couponss[]=$coupons;
        
           }     
            $message = array('status'=>'1', 'message'=>'Coupon List', 'data'=>$couponss);
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'Coupon not Found');
            return $message;
        }
    
    }
    
}