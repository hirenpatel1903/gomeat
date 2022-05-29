<?php

namespace App\Http\Controllers\Driverapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class DriverstatusController extends Controller
{
   public function status(Request $request)
    { 
        $dboy_id = $request->dboy_id; 
        $status = $request->status;
        
        $update= DB::table('delivery_boy') 
               ->where('dboy_id', $dboy_id)
               ->update(['status'=>$status]);
               
        if($update){
            $message = array('status'=>'1', 'message'=>'Status Updated');
        	return $message;
        }  
        else{
            $message = array('status'=>'0', 'message'=>'Nothing happened');
        	return $message;
        }
               
    }
    
    
     public function get_status(Request $request)
    { 
        $dboy_id = $request->dboy_id; 
        
        
        $update= DB::table('delivery_boy') 
              ->select('status')
               ->where('dboy_id', $dboy_id)
               ->first();
               
         $orders = DB::table('orders')
                  ->where('dboy_id', $dboy_id)
                  ->Where('order_status','!=',NULL)
                  ->where('order_status','!=','Cancelled')
                  ->where('payment_method','!=',NULL)
                  ->count();
          $completed =  DB::table('orders')
                  ->where('dboy_id', $dboy_id)
                  ->where('order_status','Completed')
                  ->where('payment_method','!=',NULL)
                  ->count();              
                  
         $pending =  DB::table('orders')
                  ->where('dboy_id', $dboy_id)
                  ->where('order_status','Confirmed')
                  ->where('payment_method','!=',NULL)
                  ->count();         
                  
         $driver_incentive =  DB::table('driver_incentive')
                ->where('dboy_id', $dboy_id )
                ->first();   
                
        if($driver_incentive){
            $total_incentive= $driver_incentive->earned_till_now;
            $received_incentive= $driver_incentive->paid_till_now;
            $remaining_incentive = $driver_incentive->remaining;
        }   else{
            $total_incentive= 0;
            $received_incentive= 0;
            $remaining_incentive = 0;
        }    
                  
         if($update){
        	$message = array('status'=>'1', 'message'=>'Delivery boy Status','online_status'=>$update->status, 'total_orders'=>$orders,'total_incentive'=>$total_incentive, 'received_incentive'=>$received_incentive,'remaining_incentive'=>$remaining_incentive,'pending_orders'=>$pending,'completed_orders'=>$completed);
        	return $message;
        }       
               
               

        else{
            $message = array('status'=>'0', 'message'=>'Nothing happened');
        	return $message;
        }
               
    }
    
    
    
     public function latlngupdate(Request $request)
    { 
        $dboy_id = $request->dboy_id; 
        $lat = $request->lat;
         $lng = $request->lng;
        $update= DB::table('delivery_boy') 
               ->where('dboy_id', $dboy_id)
               ->update(['current_lat'=>$lat,
                         'current_lng'=>$lng]);
               
        if($update){
            $message = array('status'=>'1', 'message'=>'Lat Lng Updated');
        	return $message;
        }  
        else{
            $message = array('status'=>'0', 'message'=>'Nothing happened');
        	return $message;
        }
               
    }
}