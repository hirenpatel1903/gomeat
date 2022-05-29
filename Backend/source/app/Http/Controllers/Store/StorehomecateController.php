<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use Auth;

class StorehomecateController extends Controller
{
    public function allhomecate(Request $request)
    {
          $title="Home Category Group";
     	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        
        $home= DB::table('store_homecat')
             ->where('store_id', $store->id)
             ->get();
        return view('store.storehomecate.show_homecategory',compact("home", "store_email", "store","logo","title"));
    	
    }
    
    public function AddCategory(Request $request)
    {
        $title="Add Home Category Group";
    $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        return view('store.storehomecate.add_homecategory',compact("store_email", "store","logo","title"));
    }
    
     public function InsertCategory(Request $request)
    {
       $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    
        $category_name = $request->category_name;
        $order = $request->category_order;
        $status=$request->category_status;
        $homeCategory = DB::table('store_homecat')
                       ->where('store_id', $store->id)
    			         ->get();
    			         
    if(count($homeCategory) >= 5){		         
    	return redirect()->back()->withErrors(trans('keywords.Can Not Add More Then 5'));
    }
    if($request->category_status=="")
    {
        $status =0 ;
    }
        
    $this->validate(
        $request,
            [
                'category_name' => 'required',
                'category_order' => 'required',
            ],
            [
                'category_name.required' => 'Enter category name.',
                'category_order.required' => 'Enter Order Of Home Category.',
            ]
    );

        $insertCategory = DB::table('store_homecat')
                            ->insert([
                                'homecat_name'=>$category_name,
                                'order'=>$order,
                                'homecat_status'=>$status,
                                'store_id'=>$store->id
                            ]);
        
        if($insertCategory){
            return redirect()->back()->withSuccess(trans('keywords.Added successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
      
    
    }
    
    public function EditCategory(Request $request)
    {
          $title="Edit Home Category Group";
       $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	 
    	$category_id = $request->id;

    	$category = DB::table('store_homecat')
        	          ->where('homecat_id', $category_id)
        			  ->first();
        

        return view('store.storehomecate.update_homecategory',compact("category","store_email", "store","logo","title"));
	
    }

    public function UpdateCategory(Request $request)
    {
     $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
          $id = $request->id;
        $category_name = $request->category_name;
        $order = $request->category_order;
        $status=$request->category_status;
        $homeCategory = DB::table('store_homecat')
    			         ->get();
        
    if($request->category_status=="")
    {
        $status =0 ;
    }
    $this->validate(
        $request,
            [
                'category_name' => 'required',
                'category_order' => 'required',
            ],
            [
                'category_name.required' => 'Enter category name.',
                'category_order.required' => 'Enter Order Of Home Category.',
            ]
    );
        $updateCategory = DB::table('store_homecat')
                            ->where('homecat_id', $id)
                            ->update([
                                'homecat_name'=>$category_name,
                                'order'=>$order,
                                'homecat_status'=>$status,
                            ]);
        
        if($updateCategory){
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
       
    }
    
    
    
     public function DeleteCategory(Request $request)
    {
        $category_id=$request->id;

    	$delete=DB::table('store_homecat')
                ->where('homecat_id',$category_id)
                ->delete();
        if($delete)
        {
        
           $delete=DB::table('store_assign_homecat')
                ->where('homecat_id',$category_id)
                ->delete();
         
        return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));

        }
        else
        {
           return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
        }
    }

}