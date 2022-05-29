<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
class UsercallbackController extends Controller
{
    public function usercallbacklist(Request $request)
    {
         $title = "Callback Requests";
          $admin_email=Auth::guard('admin')->user()->email;
    $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        
        $requests = DB::table('callback_req')
                ->join('users','callback_req.user_id','=','users.id')
                ->Leftjoin('store','callback_req.store_id','=','store.id')
                ->paginate(10);
                
        return view('admin.callback.user_request', compact('title','requests','admin','logo','admin_email'));    
        
        
    }
     public function user_call_proc(Request $request)
    {
         $title = "Callback Requests process";
         $id = $request->id;
        
        $requests = DB::table('callback_req')
                 ->where('callback_req_id', $id)
                 ->update(['processed'=>1]);
         if($requests){       
         return redirect()->back()->withSuccess(trans('keywords.Call has been done successfully'));
        }else{
          return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));  
        }
        
        
    }
}