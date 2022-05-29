<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use Auth;

class StoreassignHomecateController extends Controller
{
    public function assignhomecat(Request $request)
    {
        
        $title = "Assign Category(s) to Home Category Group";
        $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        	
        	$homecat_id=$request->id;
        	
        	$homecat=DB::table('store_homecat')
            ->where('homecat_id',$homecat_id)
            ->first();
            
            
            $assigned_categories=DB::table('store_assign_homecat')
                  ->where('homecat_id',$homecat_id)
                  ->get();
            
            $assigned_categoroy_list=DB::table('store_assign_homecat')
            ->join('categories', 'store_assign_homecat.cat_id', '=', 'categories.cat_id')
            ->where('homecat_id',$homecat_id)
            ->get();
            
            if(count($assigned_categoroy_list)>0){
                foreach($assigned_categories as $assigned_categoroy_id)
                {
                    $aci[]=$assigned_categoroy_id->cat_id;
                }
            }
            else
            {
                $aci=array();
            }
            
            
            $cityadminCategory = DB::table('categories')
                             ->where('level',1)
        			         ->get();
            return view('store.storehomecate.assignhomecate',compact("cityadminCategory","title",'store','logo',"homecat","aci","assigned_categoroy_list"));
    }
    
    public function InsertAssignHomeCat(Request $request)
    {
    
        $this->validate(
            $request,
                [
                    'selectedcat' => 'required',
                ],
                [
                    'selectedcat.required' => 'Please Select Atleast One Category.',
                ]
        );
       
        $homecat_id = $request->homecat_id;
        $selectedcat = $request->selectedcat;
        foreach($selectedcat as $data)
        {
            $insertCategory = DB::table('store_assign_homecat')
                            ->insert([
                                'homecat_id'=>$homecat_id,
                                'cat_id'=>$data,
                            ]);
        }
        
        if($insertCategory){
            return redirect()->back()->withSuccess(trans('keywords.Category Assign Successfully to Home Category'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
      
    }
    

    
    
    public function DeleteAssignhomecat(Request $request)
    {
            $assign_id_id=$request->id;
        
        	$delete=DB::table('store_assign_homecat')->where('assign_id',$assign_id_id)->delete();
            if($delete)
            {
             
                return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
    
            }
            else
            {
               return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
            }
		

    }

}