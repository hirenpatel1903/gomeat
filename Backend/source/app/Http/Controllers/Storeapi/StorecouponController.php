<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;

class StorecouponController extends Controller
{
    public function couponlist(Request $request)
    {
       $store_id = $request->store_id;
        $coupon= DB::table('coupon')
                ->where('store_id', $store_id)
                ->get();
    if(count($coupon)>0){
       $message = array('status'=>'1', 'message'=>'Coupon List', 'data'=>$coupon);
      return $message; 
    }            
      else{          
      $message = array('status'=>'0', 'message'=>'No Coupons Added');
      return $message;
    }
    } 
    
    
    
    public function addcoupon(Request $request)
    {
        $store_id = $request->store_id;
        $coupon_name = $request->coupon_name;
        $coupon_code = $request->coupon_code;
        $coupon_desc = $request->coupon_desc;
        $valid_to = $request->valid_to;
        $valid_from = $request->valid_from;
        $cart_value = $request->cart_value;
        $coupon_type = $request->coupon_type;
        $coupon_discount =$request->coupon_discount;
        $restriction = $request->restriction;
        $discount = str_replace("%",'', $coupon_discount);
      

        $insert = DB::table('coupon')
                  ->insert([
                       'coupon_name'=>$coupon_name,
                       'coupon_description'=>$coupon_desc,
                       'coupon_code'=>$coupon_code,
                       'start_date'=>$valid_to,
                       'end_date'=>$valid_from,
                       'type'=>$coupon_type,
                       'uses_restriction'=>$restriction,
                       'amount'=>$discount,
                       'cart_value'=>$cart_value,
                       'store_id'=>$store_id]);
      if($insert){
       $message = array('status'=>'1', 'message'=>trans('keywords.Added Successfully'));
      return $message; 
    }            
      else{          
      $message = array('status'=>'0', 'message'=>trans('keywords.Something Wents Wrong'));
      return $message;
    }

    }
    
  
    public function updatecoupon(Request $request)
    {
        $coupon_id = $request->coupon_id;
        $coupon_name = $request->coupon_name;
        $coupon_code = $request->coupon_code;
        $coupon_type = $request->coupon_type;
        $coupon_desc = $request->coupon_desc;
        $valid_to = $request->valid_to;
        $valid_from = $request->valid_from;
        $cart_value = $request->cart_value;
        $restriction = $request->restriction;
     
        $update = DB::table('coupon')
                 ->where('coupon_id', $coupon_id)
                 ->update([
                      'coupon_name'=>$coupon_name,
                       'coupon_description'=>$coupon_desc,
                       'coupon_code'=>$coupon_code,
                       'start_date'=>$valid_to,
                       'type'=>$coupon_type,
                       'end_date'=>$valid_from,
                       'cart_value'=>$cart_value,
                       'uses_restriction'=>$restriction]);

        if($update){

             $message = array('status'=>'1', 'message'=>trans('keywords.Updated Successfully'));
           return $message;  
        }
        else{
          $message = array('status'=>'0', 'message'=>trans('keywords.Something Wents Wrong'));
      return $message;
        }
    }
  public function deletecoupon(Request $request)
    {
        $coupon_id=$request->coupon_id;

    	$delete=DB::table('coupon')->where('coupon_id',$request->coupon_id)->delete();
        if($delete)
        {
        $message = array('status'=>'1', 'message'=>trans('keywords.Deleted Successfully'));
           return $message;  
            }
   
        else
        {
           $message = array('status'=>'0', 'message'=>trans('keywords.Something Wents Wrong'));
           return $message;
        }

    }
	
    
}
