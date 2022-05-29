<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
class DrivercallbackController extends Controller
{
    public function drivercallbacklist(Request $request)
    {
         $title = "Callback Requests";
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        
        $requests = DB::table('driver_callback_req')
                ->join('delivery_boy','driver_callback_req.driver_id','=','delivery_boy.dboy_id')
                ->Leftjoin('store','delivery_boy.store_id','=','store.id')
                ->paginate(10);
                
        return view('admin.callback.driver_request', compact('title','requests','admin','logo','admin_email'));    
        
        
    }
     public function driver_call_proc(Request $request)
    {
         $title = "Callback Requests process";
         $id = $request->id;
        
        $requests = DB::table('driver_callback_req')
                 ->where('callback_req_id', $id)
                 ->update(['processed'=>1]);
         if($requests){       
         return redirect()->back()->withSuccess(trans('keywords.Call has been done successfully'));
        }else{
          return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));  
        }
        
        
    }
}