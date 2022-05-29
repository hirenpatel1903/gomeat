<?php
namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use App\Models\Admin;
use Auth;
class TaxreportController extends Controller
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
    
 public function taxreport(Request $request)
     {
         $date = date('Y-m-d');
         $store_id = $request->id;
       $title = "Item TAX List ".$date;
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
    	 		   
        $orde =DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('product.product_name', 'product.product_id')
             ->groupBy('product.product_name', 'product.product_id')
             ->where('orders.delivery_date',$date)
             ->where('orders.payment_method','!=', NULL)
             ->where('store_orders.tx_price','!=', NULL)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();
             
        $ord=$orde->unique('product_id');     
         $ordd=array(); 
        foreach($ord as $ords){    
        $det =  DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('store_orders.quantity', 'store_orders.unit','product.product_id', DB::raw('SUM(store_orders.tx_price) as sumtax'), DB::raw('AVG(store_orders.tx_per) as avgtx'))
             ->groupBy('store_orders.quantity', 'store_orders.unit','product.product_id','store_orders.tx_per','store_orders.tx_price')
             ->where('orders.delivery_date',$date)
             ->where('product.product_id',$ords->product_id)
             ->where('orders.payment_method','!=', NULL)
              ->where('orders.order_status','!=', 'Cancelled')
             ->first();  
         $ords->sumtax=round($det->sumtax,2);
         $ords->avgtx=round($det->avgtx,2);
        $ordd[]=$ords;    
        }
             
         return view('admin.itemsalesreport.taxtoday',compact("admin","admin_email",'title','logo','ordd'));
    }      
    
    
     public function taxdatewise(Request $request)
     {
         $date = $request->sel_date;
         $store_id = $request->id;
       $title = "Item TAX List ".$date;
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
    	 		   
        $orde =DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('product.product_name', 'product.product_id')
             ->groupBy('product.product_name', 'product.product_id')
             ->where('orders.delivery_date',$date)
             ->where('orders.payment_method','!=', NULL)
             ->where('store_orders.tx_price','!=', NULL)
              ->where('orders.order_status','!=', 'Cancelled')
             ->get();
             
        $ord=$orde->unique('product_id');     
         $ordd=array(); 
        foreach($ord as $ords){    
        $det =  DB::table('store_orders')
             ->join ('orders','store_orders.order_cart_id', '=', 'orders.cart_id')
             ->join('product_varient', 'store_orders.varient_id', '=','product_varient.varient_id')
             ->join('product', 'product_varient.product_id', '=','product.product_id')
             ->select('store_orders.quantity', 'store_orders.unit','product.product_id', DB::raw('SUM(store_orders.tx_price) as sumtax'), DB::raw('AVG(store_orders.tx_per) as avgtx'))
             ->groupBy('store_orders.quantity', 'store_orders.unit','product.product_id','store_orders.tx_per','store_orders.tx_price')
             ->where('orders.delivery_date',$date)
             ->where('product.product_id',$ords->product_id)
             ->where('orders.payment_method','!=', NULL)
              ->where('orders.order_status','!=', 'Cancelled')
             ->first();  
         $ords->sumtax=round($det->sumtax,2);
         $ords->avgtx=round($det->avgtx,2);
        $ordd[]=$ords;    
        }
             
         return view('admin.itemsalesreport.taxdatewise',compact("admin","admin_email",'title','logo','ordd'));
    }      
    
 
 
 



}