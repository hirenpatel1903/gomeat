<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;

class PriceController extends Controller
{
      public function stt_product(Request $request)
    {
        $title = "Products Price/Mrp";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
         
        $selected =  DB::table('store_products')
                ->join('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join('product', 'product_varient.product_id', '=', 'product.product_id')
                ->where('store_id', $store->id)
               ->paginate(10); 
                
      
    	return view('store.products.product', compact('title',"store", "logo","selected"));
          
        }
      
      public function stt_product2(Request $request)
    {
        $title = "Products Price/Mrp";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
         
        $selected =  DB::table('store_products')
                ->join('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join('product', 'product_varient.product_id', '=', 'product.product_id')
                ->where('store_id', $store->id)
                ->paginate(10);
                
      
    	return view('store.products.quantity', compact('title',"store", "logo","selected"));
          
        }
    
     public function qty_update(Request $request)
    {
        $id =$request->id;
        $min_qty = $request->min_qty;
        $max_qty = $request->max_qty;
    	 $stockupdate = DB::table('store_products')
                ->where('p_id', $id)
                ->update(['min_ord_qty'=>$min_qty,
                'max_ord_qty'=>$max_qty]);
         if($stockupdate){
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully')); 
         } else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }

    }
 
    
     public function price_update(Request $request)
    {
        $id =$request->id;
        $mrp = $request->mrp;
        $price = $request->price;
    	 $stockupdate = DB::table('store_products')
                ->where('p_id', $id)
                ->update(['mrp'=>$mrp,
                'price'=>$price]);
         if($stockupdate){
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully')); 
         } else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }

    }
}
