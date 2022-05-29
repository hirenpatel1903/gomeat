<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;

class ReasonController extends Controller
{
    public function can_res_list(Request $request)
    {
         $title = "Cancelling Reasons";
           $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $reason = DB::table('cancel_for')
                ->get();
                
        return view('admin.reasons.reasonlist', compact('title','reason','admin','logo'));    
        
        
    }
    public function can_res_add(Request $request)
    {
        $title = "Add Cancelling Reasons";
          $admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
         $reasons = DB::table('cancel_for')
                ->get();
                
        return view('admin.reasons.reasonadd', compact('title','reasons','admin','logo'));    
        
        
    }
    public function can_res_added(Request $request)
    {
       
        $reason = $request->reason;
        
        
        $this->validate(
            $request,
                [
                    
                    'reason'=>'required',
                   
                   
                ],
                [
                    
                    'reason.required'=>'Reason Required',
            
                ]
        );
        
    	$insert = DB::table('cancel_for')
                    ->insert([
                        'reason'=>$reason
                        ]);
                        
      if($insert){
        return redirect()->back()->withSuccess('Added Successfully');
      }else{
         return redirect()->back()->withErrors('Something Wents Wrong'); 
      }

    }
    
    public function can_res_edit(Request $request)
    {
         $title = "Cancellin reason edit";
           $admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $res_id = $request->res_id;

        $reason = DB::table('cancel_for')
                ->where('res_id',$res_id)
                ->first();
                
        return view('admin.reasons.reasonedit', compact('title','reason','admin','logo'));    
        
        
    }
    
    public function can_res_edited(Request $request)
    {
        $reason = $request->reason;
       
        $res_id = $request->res_id;
        
        $this->validate(
            $request,
                [
                    
                    'reason'=>'required',
                  
                ],
                [
                    
                    'reason.required'=>'Enter reason',
                ]
        );
        
    	 $insert = DB::table('cancel_for')
    	            ->where('res_id',$res_id)
                    ->update([
                        'reason'=>$reason
                        ]);
                    
     
        return redirect()->back()->withSuccess('Updated Successfully');
    }
    
    public function can_res_del(Request $request)
    {
        
        $res_id=$request->res_id;

    	$delete=DB::table('cancel_for')->where('res_id',$res_id)->delete();
        if($delete)
        {
        return redirect()->back()->withSuccess('Deleted successfully');

        }
        else
        {
           return redirect()->back()->withErrors('Something Wents Wrong'); 
        }
    }
}