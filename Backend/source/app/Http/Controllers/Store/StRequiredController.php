<?php
namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use Auth;
class StRequiredController extends Controller
{

    
 public function reqfortoday(Request $request)
     {
         $date = date('Y-m-d');
       $title = "Required Product List";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	 $store_id = $store->id;		   
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
    	 		   
        $ord =DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('product.product_name', 'product.product_id','product.product_id')
             ->groupBy('product.product_name', 'product.product_id','product.product_id')
             ->where('orders.delivery_date',$date)
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();
             
             
        $det =  DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('store_orders.quantity', 'store_orders.unit','product.product_id', DB::raw('count(store_orders.unit) as count'), DB::raw('sum(store_orders.qty) as sumqty'))
             ->groupBy('store_orders.quantity', 'store_orders.unit','product.product_id')
             ->where('orders.delivery_date',$date)
             
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();    
             
         return view('store.stocktoday',compact("email","store",'title','logo','ord','det'));
    }      
    
    public function reqforthirty(Request $request)
     {
         $date = date('Y-m-d');
       $title = "Required Product List";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	 $store_id = $store->id;		   
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
    	 		   
        $ord =DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('product.product_name', 'product.product_id','product.product_id')
             ->groupBy('product.product_name', 'product.product_id','product.product_id')
             ->whereDate('orders.delivery_date', '>', Carbon::now()->subDays(30))
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
             ->where('orders.order_status', 'Completed')
             ->get();
             
             
        $det =  DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('store_orders.quantity', 'store_orders.unit','product.product_id', DB::raw('count(store_orders.unit) as count'), DB::raw('sum(store_orders.qty) as sumqty'))
             ->groupBy('store_orders.quantity', 'store_orders.unit','product.product_id')
            ->whereDate('orders.delivery_date', '>', Carbon::now()->subDays(30))
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
              ->where('orders.order_status', 'Completed')
             ->get();    
         return view('store.stockthirty',compact("email","store",'title','logo','ord','det'));
    }     
    
     public function reqfordate(Request $request)
     {
         $date = date('Y-m-d');
         $sel_date = $request->sel_date;
         $next_date = date('Y-m-d', strtotime($sel_date));
         
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	 $store_id = $store->id;		   
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
      if($next_date != $date){	 
          $title = "Required Product List on ".$next_date;
        $ord =DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('product.product_name', 'product.product_id','product.product_id')
             ->groupBy('product.product_name', 'product.product_id','product.product_id')
             ->where('orders.delivery_date',$next_date)
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();
             
             
        $det =  DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('store_orders.quantity', 'store_orders.unit','product.product_id', DB::raw('count(store_orders.unit) as count'), DB::raw('sum(store_orders.qty) as sumqty'))
             ->groupBy('store_orders.quantity', 'store_orders.unit','product.product_id')
             ->where('orders.delivery_date',$next_date)
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();    
             
         return view('store.datewise',compact("email","store",'title','logo','ord','det'));
      }else{
          $title = "Required Product List on ".$date;
          $ord =DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('product.product_name', 'product.product_id','product.product_id')
             ->groupBy('product.product_name', 'product.product_id','product.product_id')
             ->where('orders.delivery_date',$date)
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();
             
             
        $det =  DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('store_orders.quantity', 'store_orders.unit','product.product_id', DB::raw('count(store_orders.unit) as count'), DB::raw('sum(store_orders.qty) as sumqty'))
             ->groupBy('store_orders.quantity', 'store_orders.unit','product.product_id')
             ->where('orders.delivery_date',$date)
             
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id', $store_id)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();  
      }
    }      
 
 
 
 



}