<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class RatingController extends Controller
{
   public function review_on_delivery(Request $request)
    { 
        $user_id = $request->user_id;
        $cart_id = $request->cart_id;
        $rating = $request->rating;
        $description=$request->description;
         if($description1 != NULL){
            $description = $description1;
        }else{
            $description = "N/A";
        }
        $check = DB::table('orders')
               ->where('cart_id',$cart_id)
               ->where('order_status', 'Completed')
               ->first();
         if($check){
        $review= DB::table('delivery_rating') 
               ->insert(['cart_id'=>$cart_id,
               'user_id'=>$user_id,
               'rating'=>$rating,
               'dboy_id'=>$check->dboy_id,
               'description'=>$description]);
               
        if($review){
            $message = array('status'=>'1', 'message'=>'reviewed successfully');
        	return $message;
        }  
        else{
            $message = array('status'=>'0', 'message'=>'Please try again later');
        	return $message;
        }
         }
         else{
              $message = array('status'=>'0', 'message'=>'Please Wait for Order Completion');
          return $message;
         }      
    }

    public function add_product_rating(Request $request)
    { 
        $user_id = $request->user_id;
        $store_id = $request->store_id;
        $varient_id = $request->varient_id;
        $rating = $request->rating;
        $description=$request->description;
        $created_at = Carbon::now();
        $checkreview= DB::table('product_rating') 
                     ->where('user_id',$user_id)
				  ->where('varient_id',$varient_id)
			         ->where('store_id',$store_id)
                     ->first();
  if($checkreview){
	   $review= DB::table('product_rating') 
		    ->where('user_id',$user_id)
		    ->where('varient_id',$varient_id)
		     ->where('store_id',$store_id)
               ->update([
               'store_id'=>$store_id,
               'rating'=>$rating,
               'description'=>$description,
               'updated_at'=>$created_at]);
  }else{
        $review= DB::table('product_rating') 
               ->insert([ 'user_id'=>$user_id,
               'varient_id'=>$varient_id,
               'store_id'=>$store_id,
               'rating'=>$rating,
               'description'=>$description,
               'created_at'=>$created_at,
               'updated_at'=>$created_at]);
  }     
        if($review){
            $message = array('status'=>'1', 'message'=>'reviewed successfully');
          return $message;
        }  
        else{
            $message = array('status'=>'0', 'message'=>'Please try again later');
          return $message;
        }
    }
    
    
    
    
     public function check_for_rating(Request $request)
    { 
        $user_id = $request->user_id;
        $varient_id = $request->varient_id;
        $store_id = $request->store_id;
       
        $check = DB::table('orders')
               ->join('store_orders','orders.cart_id','=','store_orders.order_cart_id')
               ->join('product_varient','store_orders.varient_id','=','product_varient.varient_id')
               ->where('store_orders.varient_id',$varient_id)
               ->where('orders.order_status', 'Completed')
               ->where('orders.user_id', $user_id)
               ->where('orders.store_id', $store_id)
               ->first();
       
       
       $check2 = DB::table('product_rating')
               ->where('varient_id',$varient_id)
               ->where('user_id', $user_id)
               ->where('store_id', $store_id)
               ->first();
               
    $getrating = DB::table('product_rating')
               ->where('varient_id',$varient_id)
               ->where('user_id', $user_id)
               ->where('store_id', $store_id)
               ->get();           
               
        if($check && !$check2){
            $message = array('status'=>'1', 'message'=>'User Can Review');
          return $message;
        }  
        elseif($check && $check2){
            $message = array('status'=>'2', 'message'=>'User Already Reviewed');
          return $message;
        }else{
            $message = array('status'=>'0', 'message'=>'User Cannot Reviewed');
          return $message;
        }
    }
    
    
    
     public function get_product_rating(Request $request)
    { 

        $varient_id = $request->varient_id;
        $store_id = $request->store_id;
               
   $getrating = DB::table('product_rating')
               ->join('users','product_rating.user_id','=','users.id')
               ->select('users.name as user_name','product_rating.*')
              ->where('product_rating.varient_id',$varient_id)
              ->where('product_rating.store_id', $store_id)
               ->paginate(10);       
               
        if($getrating){
            foreach($getrating as $getratings)
            {
                $ratingssss[]=$getratings;
            }
            $message = array('status'=>'1', 'message'=>'Product Rating', 'data'=>$ratingssss);
          return $message;
        }  
       else{
            $message = array('status'=>'0', 'message'=>'User Cannot Reviewed');
          return $message;
        }
    }

}