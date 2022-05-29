<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use App\Models\Admin;
use Auth;

class NoticeController extends Controller
{
    public function adminnotice(Request $request)
    {
        $title = "Notice in App";
         $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();	
        $notice = DB::table('app_notice')
                ->first();
        return view('admin.notice.notice',compact("title","admin","logo","admin","notice"));
    }
    
     public function adminupdatenotice(Request $request)
    {
        $date = date('d-m-Y');
        $title = "Notice in App";
        $status = $request->status;
       
    
        $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();	
        $notice = $request->notice;
        $this->validate(
            $request,
                [
                    
                    'notice' => 'required|min:20'
                ]
        );
        $noticecheck = DB::table('app_notice')
                ->first();
        if($noticecheck) {
            $update = DB::table('app_notice')
                    ->update(['notice'=>$notice, 'status'=>$status]);
        }
        else{
           $update = DB::table('app_notice')
                    ->insert(['notice'=>$notice, 'status'=>$status]);  
        }
        if($update){
             return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
             return redirect()->back()->withSuccess(trans('keywords.Already Updated'));
        }
        }      
                
        
    }
    