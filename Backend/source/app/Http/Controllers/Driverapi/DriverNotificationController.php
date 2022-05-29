<?php

namespace App\Http\Controllers\Driverapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class DriverNotificationController extends Controller
{
   public function notificationlist(Request $request)
    {  
        $driver_id = $request->dboy_id;
        $notifyby = DB::table('driver_notification')
                ->where('dboy_id',$driver_id)
                ->orderBy('not_id')
                ->get();
        
         if(count($notifyby)>0){
            $message = array('status'=>'1', 'message'=>'Notification List', 'data'=>$notifyby);
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'Not Found');
            return $message;
        }
    }
    
    public function read_by_driver(Request $request)
    {  
        $noti_id = $request->not_id;
        $notifyby = DB::table('driver_notification')
                ->where('not_id',$noti_id)
                ->update(['read_by_driver'=> 1]);
                
         if($notifyby){
            $message = array('status'=>'1', 'message'=>'Read by Store');
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'Not Found', 'data'=>[]);
            return $message;
        }
    }
    
     public function all_as_read(Request $request)
    {  
        $driver_id = $request->dboy_id;
        $notifyby = DB::table('driver_notification')
                ->where('dboy_id',$driver_id)
                ->update(['read_by_store'=> 1]);
                
         if($notifyby){
            $message = array('status'=>'1', 'message'=>'Marked All as Read');
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'Not Found', 'data'=>[]);
            return $message;
        }
    }
    
    
     public function delete_all(Request $request)
    {  
        $driver_id = $request->dboy_id;
        $notifyby = DB::table('driver_notification')
                ->where('dboy_id',$driver_id)
                ->delete();
                
         if($notifyby){
            $message = array('status'=>'1', 'message'=>'All Notifications are Deleted');
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'Not Found');
            return $message;
        }
    }
}
