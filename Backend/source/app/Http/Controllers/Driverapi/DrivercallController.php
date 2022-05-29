<?php

namespace App\Http\Controllers\Driverapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;

class DrivercallController extends Controller
{
 
    public function call(Request $request)
    {
        
          $date = date('Y-m-d');
          $driver_id = $request->driver_id;
          $check = DB::table('driver_callback_req')
                 ->where('driver_id',$driver_id)
                 ->where('processed',0)
                ->first();
                
          $driver = DB::table('delivery_boy')
                ->where('dboy_id',$driver_id)
                ->first();
                
                
          if($check){ 
              $app1 = DB::table('driver_callback_req')
                   ->where('driver_id',$driver_id)
                 ->where('processed',0)
                 ->delete();
          $app = DB::table('driver_callback_req')
                ->insert(['driver_name'=>$driver->boy_name,
                'driver_phone'=>$driver->boy_phone,
                'date'=>$date,
                'driver_id'=>$driver_id ]);
          }    
          else{
              $app = DB::table('driver_callback_req')
                ->insert(['driver_name'=>$driver->boy_name,
                'driver_phone'=>$driver->boy_phone,
                'date'=>$date,
                'driver_id'=>$driver_id]);
          }
        if($app)   { 
            $message = array('status'=>'1', 'message'=>'Callback requested successfully');
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'Try again later', 'data'=>[]);
            return $message;
        }

        return $message;
    }
}