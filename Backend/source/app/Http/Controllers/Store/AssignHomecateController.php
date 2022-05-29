<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use Auth;

class AssignHomecateController extends Controller
{
    public function assignhomecat(Request $request)
    {
        
           $title = "Assign Special Category(s) to Special Home Category";
           $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        	
        	$homecat_id=$request->id;
        	
        	$homecat=DB::table('homecat')
            ->where('homecat_id',$homecat_id)
            ->first();
            
            
            $assigned_categories=DB::table('assign_homecat')
                  ->where('homecat_id',$homecat_id)
                  ->get();
            
            $assigned_categoroy_list=DB::table('assign_homecat')
            ->join('store_cat', 'assign_homecat.cat_id', '=', 'store_cat.st_cat_id')
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
            
            
            $cityadminCategory = DB::table('store_cat')
                             ->where('store_id', $store->store_id)
        			         ->get();
            return view('store.homecate.assignhomecate',compact("cityadminCategory","title",'store','logo',"homecat","aci","assigned_categoroy_list"));
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
            $insertCategory = DB::table('assign_homecat')
                            ->insert([
                                'homecat_id'=>$homecat_id,
                                'cat_id'=>$data,
                            ]);
        }
        
        if($insertCategory){
            return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something wents wrong'));
        }
      
    }
    

    
    
    public function DeleteAssignhomecat(Request $request)
    {
            $assign_id_id=$request->id;
        
        	$delete=DB::table('assign_homecat')->where('assign_id',$assign_id_id)->delete();
            if($delete)
            {
             
                return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
    
            }
            else
            {
               return redirect()->back()->withErrors(trans('keywords.Something wents wrong')); 
            }
		

    }

}