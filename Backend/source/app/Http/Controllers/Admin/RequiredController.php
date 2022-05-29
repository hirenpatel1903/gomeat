<?php
namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use App\Models\Admin;
use Auth;
class RequiredController extends Controller
{
public function storeclist(Request $request)
    {
         $title = "Item Sale Report Store Wise";
           $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $city = DB::table('store')
                ->paginate(10);
                
        return view('admin.itemsalesreport.stores', compact('title','city','admin','logo'));    
        
        
    }
    
 public function reqfortoday(Request $request)
     {
         $date = date('Y-m-d');
         $store_id = $request->id;
       $title = "Required Item List ".$date;
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
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
             
         return view('admin.itemsalesreport.stocktoday',compact("store_id","admin","admin_email",'title','logo','ord','det'));
    }      
    
    
     public function ad_reqforthirty(Request $request)
     {
         $date = date('Y-m-d');
         $title = "Required Product List";
         $email=Session::get('bamaStore');
    	  $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
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
              ->where('orders.order_status', 'Completed')
             ->get();    
         return view('admin.itemsalesreport.stockthirty',compact("admin_email","admin",'title','logo','ord','det'));
    }    
    
    
     public function reqdaywise (Request $request)
     {
         $date = date('Y-m-d');
         $sel_date = $request->sel_date;
         $next_date = date('Y-m-d', strtotime($sel_date));
        
           $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 $store_id = $request->id;		   
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
       if($next_date != $date){	
        $title = "Required Item List on ".$next_date;
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
            //   ->where('orders.order_status','!=', 'Completed')
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
            //   ->where('orders.order_status','!=', 'Completed')
             ->get();    
             
         return view('admin.itemsalesreport.stockdatewise',compact("store_id","admin","admin_email",'title','logo','ord','det'));
         
       }else{
           $title = "Required Item List ".$date;
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
             
         return view('admin.itemsalesreport.stocktoday',compact("store_id","admin","admin_email",'title','logo','ord','det'));
       }
    }      
 
 
 
 



}