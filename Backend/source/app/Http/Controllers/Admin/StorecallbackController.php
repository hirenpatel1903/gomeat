<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
class StorecallbackController extends Controller
{
    public function storecallbacklist(Request $request)
    {
         $title = "Callback Requests";
           $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        
        $requests = DB::table('store_callback_req')
                ->paginate(10);
                
        return view('admin.callback.store_request', compact('title','requests','admin','logo','admin_email'));    
        
        
    }
     public function store_call_proc(Request $request)
    {
         $title = "Callback Requests process";
         $id = $request->id;
        
        $requests = DB::table('store_callback_req')
                 ->where('callback_req_id', $id)
                 ->update(['processed'=>1]);
         if($requests){       
         return redirect()->back()->withSuccess(trans('keywords.Call has been done successfully'));
        }else{
          return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));  
        }
        
        
    }
}