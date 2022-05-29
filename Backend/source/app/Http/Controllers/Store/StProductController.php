<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;

class StProductController extends Controller
{
    public function sel_product(Request $request)
    {
        $title = "Add Product";
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
                
                ->where('store_products.store_id', $store->id)
                ->orderBy('store_products.stock','asc')
                ->paginate(15);  
                
                
        $check=  DB::table('store_products')
                ->where('store_id', $store->id)
                ->get(); 
        if(count($check)>0)  {
        foreach($check as $ch){
            $ch2 = $ch->varient_id;
            $ch3[] = array($ch2);
        }
          $products = DB::table('product_varient')
                ->join('product','product_varient.product_id', '=', 'product.product_id')
                 ->join('categories', 'product.cat_id', '=', 'categories.cat_id')
                
                ->whereNotIn('product_varient.varient_id', $ch3)
                 ->where('product_varient.approved',1)
                ->get();    
        
    	return view('store.products.select', compact('title',"store", "logo","products","selected"));
        }else{
             $products = DB::table('product_varient')
                ->join('product','product_varient.product_id', '=', 'product.product_id')
                ->join('categories', 'product.cat_id', '=', 'categories.cat_id')
                 ->where('product_varient.approved',1)
                ->get();
                
            return view('store.products.select', compact('title',"store", "logo","products","selected"));    
        }
      
    }
    
    
    
      public function st_product(Request $request)
    {
        $title = "Products";
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
                ->orderBy('store_products.stock','asc')
                ->paginate(10); 
                
        $check=  DB::table('store_products')
                ->where('store_id', $store->id)
                ->get(); 
        if(count($check)>0)  {
        foreach($check as $ch){
            $ch2 = $ch->varient_id;
            $ch3[] = array($ch2);
        }
          $products = DB::table('product_varient')
                ->join('product','product_varient.product_id', '=', 'product.product_id')
                ->whereNotIn('product_varient.varient_id', $ch3)
                ->where('product_varient.approved',1)
                ->get();    
        
    	return view('store.products.pr', compact('title',"store", "logo","products","selected"));
        }else{
             $products = DB::table('product_varient')
                ->join('product','product_varient.product_id', '=', 'product.product_id')
                ->where('product_varient.approved',1)
                ->get();
                
            return view('store.products.pr', compact('title',"store", "logo","products","selected"));    
        }
      
    }
    
    
    public function added_product(Request $request)
    {
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	 		   
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
          
    $prod = $request->prod;
     if($prod == array()){
        return redirect()->back()->withErrors(trans('keywords.Please select at least one product'));
    }
    else{
    $countprod = count($prod);

    for($i=0;$i<=($countprod-1);$i++)
        {
            $varient_id = $prod[$i];
            $pr= DB::table('product_varient')
                 ->where('varient_id',$varient_id)
                 ->first();
                 
            $insert2 = DB::table('store_products')
                  ->insert(['store_id'=>$store->id,'stock'=>0, 'varient_id'=>$prod[$i], 'price'=>$pr->base_price,'mrp'=>$pr->base_mrp]);
        }     
          
         return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
    }
    }
    
       
     public function delete_product(Request $request)
    {
        $id =$request->id;
        $check=DB::table('store_products')
                ->where('p_id', $id)
                ->first();
        $varient_id = $check->varient_id;
        $store_id = $check->store_id;
    	 $delete = DB::table('store_products')
                ->where('p_id', $id)
                ->delete();
         if($delete){
             $de = DB::table('store_orders')
                ->where('store_id', $store_id)
                ->where('varient_id', $varient_id)
                ->where('order_cart_id', "incart")
                ->delete();
            return redirect()->back()->withSuccess(trans('keywords.Product Removed')); 
         } else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }

    }
    
     public function stock_update(Request $request)
    {
        $id =$request->id;
        $stock = $request->stock;
    	 $stockupdate = DB::table('store_products')
                ->where('p_id', $id)
                ->update(['stock'=>$stock]);
         if($stockupdate){
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully')); 
         } else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }

    }
    
    
    /////spotlight/////
      public function sp_product(Request $request)
    {
        $title = "Products";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
         
        $selected =  DB::table('spotlight')
                ->join('store_products', 'spotlight.p_id', '=', 'store_products.p_id')
                ->join('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join('product', 'product_varient.product_id', '=', 'product.product_id')
                ->join('categories', 'product.cat_id', '=', 'categories.cat_id')
                ->where('spotlight.store_id', $store->id)
                ->orderBy('store_products.stock','asc')
                ->paginate(10);  
                
        $check=  DB::table('spotlight')
                ->where('store_id', $store->id)
                ->get(); 
        if(count($check)>0)  {
        foreach($check as $ch){
            $ch2 = $ch->p_id;
            $ch3[] = array($ch2);
        }
          $products =DB::table('store_products')
                ->join('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join('product', 'product_varient.product_id', '=', 'product.product_id')
                ->join('categories', 'product.cat_id', '=', 'categories.cat_id')
                ->whereNotIn('store_products.p_id', $ch3)
                ->where('product_varient.approved',1)
                ->where('store_products.store_id', $store->id)
                ->get();    
        
    	return view('store.products.spotlight', compact('title',"store", "logo","products","selected"));
        }else{
           
            $products =DB::table('store_products')
                ->join('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join('product', 'product_varient.product_id', '=', 'product.product_id')
                ->join('categories', 'product.cat_id', '=', 'categories.cat_id')
                ->where('product_varient.approved',1)
                ->where('store_products.store_id', $store->id)
                ->get();       
                
            return view('store.products.spotlight', compact('title',"store", "logo","products","selected"));    
        }
      
    }
    
    
    public function added_spotlight(Request $request)
    {
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	 		   
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
          
    $prod = $request->prod;
     if($prod == array()){
        return redirect()->back()->withErrors(trans('keywords.Please select at least one product'));
    }
    else{
    $countprod = count($prod);

    for($i=0;$i<=($countprod-1);$i++)
        {
            $varient_id = $prod[$i];
            $insert2 = DB::table('spotlight')
                  ->insert(['store_id'=>$store->id,'p_id'=>$prod[$i]]);
        }     
          
         return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
    }
    }
    
       
     public function rem_spotlight(Request $request)
    {
        $id =$request->id;
    	 $delete = DB::table('spotlight')
                ->where('sp_id', $id)
                ->delete();
         if($delete){
            return redirect()->back()->withSuccess(trans('keywords.Product Removed')); 
         } else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }

    }
    
    
    
}
