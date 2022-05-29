<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;

class ProductapproveController extends Controller
{
    public function list(Request $request)
    {
        $title = "App User List";
        $admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting') 
                ->where('set_id', '1')
                ->first();
           $product = DB::table('product_varient')
                   ->join('product','product_varient.product_id','=','product.product_id')
                   ->join('store','product_varient.added_by','=','store.id')
                   ->select('product.product_image','product.product_name','product_varient.*','store.store_name','store.city','store.phone_number')
                    ->paginate(10);
        
    	return view('admin.store_product.list', compact('title',"admin", "logo","product"));
    }
  
     public function approve(Request $request)
    {
        
        $varient_id = $request->id;
        $getvar = DB::table('product_varient')
                ->where('varient_id',$varient_id)
                ->first();
         $product = DB::table('product_varient')
                ->where('varient_id',$varient_id)
                ->update(['approved'=>1]);
    if($product){  
        $insert2 = DB::table('product')
                 ->where('product_id', $getvar->product_id)
                 ->update(['approved'=>1]);
       $insert2 = DB::table('store_products')
                  ->insert(['store_id'=>$getvar->added_by,'stock'=>0, 'varient_id'=>$varient_id, 'price'=>$getvar->base_price,'mrp'=>$getvar->base_mrp]);
    return redirect()->back()->withSuccess(trans('keywords.Approved Successfully'));
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
    
     public function reject(Request $request)
    {
        
       $varient_id = $request->id;
       $product = DB::table('product_varient')
                ->where('varient_id',$varient_id)
                ->update(['approved'=>2]);
                
     if($product){   
    return redirect()->back()->withSuccess(trans('keywords.Rejected Successfully'));
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
    
 
}