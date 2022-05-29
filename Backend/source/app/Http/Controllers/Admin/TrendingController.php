<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;

class TrendingController extends Controller
{
    public function sel_product(Request $request)
    {
        $title = "Add Product";
           $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();

         
        $selected =  DB::table('trending_search')
                ->join('product_varient', 'trending_search.varient_id', '=', 'product_varient.varient_id')
                ->join('product', 'product_varient.product_id', '=', 'product.product_id')
                ->get();  
                
                
        $check=  DB::table('trending_search')
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
        
    	return view('admin.trending.trending', compact('title',"admin","admin_email", "logo","products","selected"));
        }else{
             $products = DB::table('product_varient')
                ->join('product','product_varient.product_id', '=', 'product.product_id')
                ->join('categories', 'product.cat_id', '=', 'categories.cat_id')
                 ->where('product_varient.approved',1)
                ->get();
                
            return view('admin.trending.trending', compact('title',"admin","admin_email", "logo","products","selected"));    
        }
      
    }
    
    
    
    
    
    
    public function added_product(Request $request)
    {
          $admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
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
                 
            $insert2 = DB::table('trending_search')
                  ->insert([ 'varient_id'=>$prod[$i]]);
        }     
          
         return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
    }
    }
    
     public function delete_product(Request $request)
    {
        $id =$request->id;
    	 $delete = DB::table('trending_search')
                ->where('trend_id', $id)
                ->delete();
         if($delete){
            return redirect()->back()->withSuccess(trans('keywords.Product Removed')); 
         } else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }

    }
    
    
}
