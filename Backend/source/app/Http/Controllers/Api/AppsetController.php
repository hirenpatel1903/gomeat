<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class AppsetController extends Controller
{
   public function appsetting(Request $request)
    {  
        $user_id = $request->user_id;
        $appset = DB::table('notificationby')
                ->where('user_id',$user_id)
                ->first();
        
         if($appset){
            $message = array('status'=>'1', 'message'=>'user app notify settings', 'data'=>$appset);
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'User settings Not Found');
            return $message;
        }
    }
    
    
    
    public function updateapp(Request $request)
    {  
        $user_id = $request->user_id;
        $sms = $request->sms;
        $email = $request->email;
        $app = $request->app;
        $appset = DB::table('notificationby')
                ->where('user_id',$user_id)
                ->update(['sms'=>$sms,
                'email'=>$email,
                'app'=>$app]);
        
         if($appset){
            $message = array('status'=>'1', 'message'=>'Updated Successfully');
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'Already Updated');
            return $message;
        }
    }
}