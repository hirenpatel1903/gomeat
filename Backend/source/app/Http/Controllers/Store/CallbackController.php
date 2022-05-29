<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;
class CallbackController extends Controller
{
    public function callbacklist(Request $request)
    {
         $title = "Callback Requests";
        	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        
        $requests = DB::table('callback_req')
                ->where('store_id', $store->id)
                ->paginate(10);
                
        return view('store.callback.request', compact('title','requests','store','logo','store_email'));    
        
        
    }
     public function call_proc(Request $request)
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
    
    
    
    
     public function drivercallbacklist(Request $request)
    {
         $title = "Callback Requests";
        	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();
        
        $requests = DB::table('driver_callback_req')
                ->join('delivery_boy','driver_callback_req.driver_id','=','delivery_boy.dboy_id')
                ->join('store','delivery_boy.store_id','=','store.id')
                ->where('delivery_boy.store_id',$store->id)
                ->paginate(10);
                
        return view('store.callback.driver_request', compact('title','requests','store','logo','store_email'));    
        
        
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