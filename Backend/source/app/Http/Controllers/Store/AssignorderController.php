<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use App\Traits\SendSms;
use App\Traits\SendMail;
use App\Traits\SendInapp;
use Auth;

class AssignorderController extends Controller
{
    use SendSms;
    use SendInapp;
    use SendMail;
    public function assignedorders(Request $request)
    {
        $title = "Order section (Today)";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
          $date = date('Y-m-d');      
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store','orders.store_id','=','store.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->leftjoin('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
             ->where('orders.store_id',$store->id)
             ->where('orders.delivery_date',$date)
             ->where('payment_method', '!=', NULL)
             ->where('orders.order_status','!=','cancelled')
			->where('orders.order_status','!=','Completed')
             ->get();
             
         $details  =   DB::table('orders')
    	                ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
    	               ->where('orders.store_id',$store->id)
    	               ->where('store_orders.store_approval',1)
    	               ->get();         
                
           $nearbydboy = DB::table('delivery_boy')
                ->join('store_delivery_boy','delivery_boy.dboy_id','=','store_delivery_boy.ad_dboy_id')
                ->leftJoin('orders', 'delivery_boy.dboy_id', '=', 'orders.dboy_id') 
                ->select("delivery_boy.boy_name","delivery_boy.dboy_id","delivery_boy.lat","delivery_boy.lng","delivery_boy.boy_city",DB::raw("Count(orders.order_id)as count"),DB::raw("6371 * acos(cos(radians(".$store->lat . ")) 
                * cos(radians(delivery_boy.lat)) 
                * cos(radians(delivery_boy.lng) - radians(" . $store->lng . ")) 
                + sin(radians(" .$store->lat. ")) 
                * sin(radians(delivery_boy.lat))) AS distance"))
               ->groupBy("delivery_boy.boy_name","delivery_boy.dboy_id","delivery_boy.lat","delivery_boy.lng","delivery_boy.boy_city")
               ->where('delivery_boy.boy_city', $store->city)
               ->orderBy('distance')
               ->get();  	       
       return view('store.orders.assignedorders', compact('title','logo','ord','store','details','nearbydboy'));         
    }
        
    
  public function orders(Request $request)
    {
          $title = "Order section (Next Day)";
		 $date = date('Y-m-d');
         $day = 1;
         $next_date = date('Y-m-d', strtotime($date.' + '.$day.' days'));
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
              ->join('store','orders.store_id','=','store.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
			->leftjoin('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
             ->where('orders.store_id',$store->id)
             ->where('orders.delivery_date', $next_date)
              ->where('orders.order_status','!=','cancelled')
			->where('orders.order_status','!=','Completed')
             ->where('payment_method', '!=', NULL)
             ->get();
             
         $details  =   DB::table('orders')
    	                ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
    	               ->where('orders.store_id',$store->id)
    	               ->where('store_orders.store_approval',1)
    	               ->get();            
          $store_id = $store->id;
    	 		   
    	 $nearbydboy = DB::table('delivery_boy')
                ->join('store_delivery_boy','delivery_boy.dboy_id','=','store_delivery_boy.ad_dboy_id')
                ->leftJoin('orders', 'delivery_boy.dboy_id', '=', 'orders.dboy_id') 
                ->select("delivery_boy.boy_name","delivery_boy.dboy_id","delivery_boy.lat","delivery_boy.lng","delivery_boy.boy_city",DB::raw("Count(orders.order_id)as count"),DB::raw("6371 * acos(cos(radians(".$store->lat . ")) 
                * cos(radians(delivery_boy.lat)) 
                * cos(radians(delivery_boy.lng) - radians(" . $store->lng . ")) 
                + sin(radians(" .$store->lat. ")) 
                * sin(radians(delivery_boy.lat))) AS distance"))
               ->groupBy("delivery_boy.boy_name","delivery_boy.dboy_id","delivery_boy.lat","delivery_boy.lng","delivery_boy.boy_city")
               ->where('delivery_boy.boy_city', $store->city)
               ->orderBy('distance')
               ->get();  	     
       return view('store.orders.orders', compact('title','logo','ord','store','details', 'nearbydboy'));         
    }    

   
   
   
       
    public function confirm_order(Request $request)
    {
       $cart_id= $request->cart_id;
       $gt_orders =DB::table('orders')
                  ->join('address','orders.address_id','=','address.address_id')
                  ->select('address.lat', 'address.lng')
                  ->where('orders.cart_id',$cart_id)
                  ->first();
       $dboy_id = $request->dboy_id;
        $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
        $store_id = $store->id;  
        $curr = DB::table('currency')
             ->first();      
        
          $orr =   DB::table('orders')
                ->where('cart_id',$cart_id)
                ->first();
           $userssss =  DB::table('users')
                ->where('id',$orr->user_id)
                ->first();      
         $user_phone=$userssss->user_phone; 
         $user_name = $userssss->name;
          $v = DB::table('store_orders')
 		   ->where('order_cart_id',$cart_id)
 		   ->get(); 
 		  $nearbydboy = DB::table('store_delivery_boy')
                ->select("store_delivery_boy.ad_dboy_id",DB::raw("6371 * acos(cos(radians(".$gt_orders->lat . ")) 
                * cos(radians(store_delivery_boy.lat)) 
                * cos(radians(store_delivery_boy.lng) - radians(" . $gt_orders->lng . ")) 
                + sin(radians(" .$gt_orders->lat. ")) 
                * sin(radians(store_delivery_boy.lat))) AS distance"))
               ->groupBy("store_delivery_boy.boy_name","store_delivery_boy.dboy_id","store_delivery_boy.lat","store_delivery_boy.lng","store_delivery_boy.boy_city")
               ->where('store_delivery_boy.store_id' ,$store_id) 
               ->where('store_delivery_boy.status','1')
               ->orderBy('distance')
               ->first();  	
               
               
        $getDDevice = DB::table('delivery_boy')
                         ->where('dboy_id', $dboy_id)
                        ->select('device_id','boy_name','dboy_id')
                        ->first();  
 		    
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
                    'dboy_id'=>$nearbydboy->ad_dboy_id]);
                    
          $v = DB::table('store_orders')
 		   ->where('order_cart_id',$cart_id)
 		   ->get();  
 		   
         if($orderconfirm){
             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                         ->first();
            if($cart_status){             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                        ->update(['confirm'=>Carbon::now()]);
            }  
              //send sms and app notification to user//
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
             
                
                $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                         ->first();
            if($cart_status){             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                        ->update(['confirm'=>Carbon::now()]);
            }
             
        	return redirect()->back()->withSuccess(trans('keywords.Order is confirmed and Assigned to').' '.$getDDevice->boy_name);
              }
    	else{
    	return redirect()->back()->withErrors(trans('keywords.Already Assigned to').' '.$getDDevice->boy_name);
    	} 
    }
            
     public function reassign_order(Request $request)
    {
       $cart_id= $request->cart_id;
       $gt_orders =DB::table('orders')
                  ->join('address','orders.address_id','=','address.address_id')
                  ->select('address.lat', 'address.lng')
                  ->where('orders.cart_id',$cart_id)
                  ->first();
       $dboy_id = $request->dboy_id;
        $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
        $store_id = $store->id;  
        $curr = DB::table('currency')
             ->first();      
        
          $orr =   DB::table('orders')
                ->where('cart_id',$cart_id)
                ->first();
           $userssss =  DB::table('users')
                ->where('id',$orr->user_id)
                ->first();      
         $user_phone=$userssss->user_phone; 
         $user_name = $userssss->name;
          $v = DB::table('store_orders')
 		   ->where('order_cart_id',$cart_id)
 		   ->get(); 
 	 	
        $getDDevice = DB::table('delivery_boy')
                        ->where('dboy_id', $dboy_id)
                       
                        ->first();  
 		    
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
                    'dboy_id'=>$dboy_id]);
                    
          $v = DB::table('store_orders')
 		   ->where('order_cart_id',$cart_id)
 		   ->get();  
 		   
         if($orderconfirm){
              //send sms and app notification to user//
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
              
             
             
        	return redirect()->back()->withSuccess(trans('keywords.Order is confirmed and Assigned to').' '.$getDDevice->boy_name);
              }
    	else{
    	return redirect()->back()->withErrors(trans('keywords.Already Assigned to') .' '.$getDDevice->boy_name);
    	} 
    }
   
   
}      