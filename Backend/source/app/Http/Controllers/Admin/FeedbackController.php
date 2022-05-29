<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use App\Models\Admin;
use Auth;

class FeedbackController extends Controller
{
    public function user_feedback(Request $request)
    {
        $title = "User Feedback";
         $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();	
        $feedback = DB::table('user_support')
                ->join('users','user_support.id','=','users.id')
                ->where('user_support.type', 'user')
                ->paginate(10);
        return view('admin.feedback.user_feedback',compact("title","admin","logo","admin","feedback"));
    }
    
      public function store_feedback(Request $request)
    {
        $title = "Store Feedback";
         $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();	
        $feedback = DB::table('user_support')
                ->join('store','user_support.id','=','store.id')
                ->where('user_support.type', 'store')
                 ->paginate(10);
        return view('admin.feedback.store_feedback',compact("title","admin","logo","admin","feedback"));
    }
            
          public function driver_feedback(Request $request)
    {
        $title = "Driver Feedback";
         $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();	
        $feedback = DB::table('user_support')
                ->join('delivery_boy','user_support.id','=','delivery_boy.dboy_id')
                ->where('user_support.type', 'driver')
                ->paginate(10);
        return view('admin.feedback.driver_feedback',compact("title","admin","logo","admin","feedback"));
    }
                        
                
        
    }
    