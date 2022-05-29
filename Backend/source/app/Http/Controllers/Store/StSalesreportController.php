<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;

class StSalesreportController extends Controller
{
   public function sales_today(Request $request)
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
             ->join('store', 'orders.store_id','=','store.id')
             ->leftjoin('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
             ->where('orders.delivery_date',$date)
             ->where('orders.store_id',$store->id)
             ->where('payment_method', '!=', NULL)
             ->where('orders.order_status','!=','cancelled')
             ->get();
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
    
       return view('store.salesreport.todaysales', compact('title','logo','ord','store','email','details'));         
    }
        
    
  public function orders(Request $request)
    {
          
         $date = $request->sel_date;
         $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
         $payment_method = $request->payment_method;
         $to_date = $request->to_date;
         $next_date = date('Y-m-d', strtotime($date));
         $next_date2 = date('Y-m-d', strtotime($to_date));
         $title = $payment_method." orders of ".$next_date.' - '.$next_date2;
       
         $logo = DB::table('tbl_web_setting')
                ->first();
        if($payment_method == "COD"){       
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store', 'orders.store_id','=','store.id')
            ->leftjoin('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
             ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.store_id',$store->id)
              ->where('orders.order_status','!=','cancelled')
             ->where('payment_method', $payment_method)
             ->where('payment_status', '!=',"failed")
             ->get();
        }
        elseif($payment_method == "wallet"){
            $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store', 'orders.store_id','=','store.id')
            ->leftjoin('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
             ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.store_id',$store->id)
              ->where('orders.order_status','!=','cancelled')
              ->where('payment_method','wallet')
             ->where('payment_status', '!=',"failed")
             ->get();
        }
         elseif($payment_method == "online"){
            $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store', 'orders.store_id','=','store.id')
            ->leftjoin('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
            ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.store_id',$store->id)
              ->where('orders.order_status','!=','cancelled')
              ->where('payment_method','!=','COD')
              ->where('payment_method','!=','wallet')
              ->where('payment_method','!=',NULL)
             ->where('payment_status', '!=',"failed")
             ->get();
        }
        else{
            $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store', 'orders.store_id','=','store.id')
            ->leftjoin('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
            ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.store_id',$store->id)
              ->where('orders.order_status','!=','cancelled')
             ->where('payment_status', '!=',"failed")
             ->get();
        }
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();            
       return view('store.salesreport.datewise', compact('title','logo','ord','store','email','details'));          
    }    
}