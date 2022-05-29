<?php

namespace App\Http\Controllers\Driverapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class DriverloginController extends Controller
{
 public function driver_login(Request $request)
    
     {
    	$phone = $request->phone;
    	$password = $request->password;
    	$device_id = $request->device_id;
    	$checkdriver1 = DB::table('delivery_boy')
    					->where('boy_phone', $phone)
    					->first();
    if($checkdriver1){					
    	$checkdriver = DB::table('delivery_boy')
    					->where('boy_phone', $phone)
    					->where('password', $password)
    					->first();

    	if($checkdriver){
    		   $updateDeviceId = DB::table('delivery_boy')
    		                       ->where('boy_phone', $phone)
    		                        ->update(['device_id'=>$device_id]);
    		                       
    		                        
    			$message = array('status'=>'1', 'message'=>'login successfully', 'data'=>[$checkdriver]);
	        	return $message;
    	   }	   
    	
    	
    	else{
    		$message = array('status'=>'0', 'message'=>'Wrong Password', 'data'=>[]);
	        return $message;
    	}
    }
    else{
        	$message = array('status'=>'0', 'message'=>'Driver Not Registered', 'data'=>[]);
	        return $message;
    }
    }
    
    
    
    
    public function driverprofile(Request $request)
    {   
        $boy_id = $request->dboy_id;
         $diver=  DB::table('delivery_boy')
                ->where('dboy_id', $boy_id )
                ->first();
        $driver_incentive =  DB::table('driver_incentive')
                ->where('dboy_id', $boy_id )
                ->first();   
        $driver_bank =  DB::table('driver_bank')
                ->where('driver_id', $boy_id )
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
                        
    if($diver){
        	$message = array('status'=>'1', 'message'=>'Delivery Boy Profile','total_incentive'=>$total_incentive, 'received_incentive'=>$received_incentive,'remaining_incentive'=>$remaining_incentive,'driver_data'=>$diver,'bank_details'=>$driver_bank);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Delivery Boy not found', 'data'=>[]);
	        return $message;
    	}
        
    }
    
    
    public function driverbank(Request $request)
    {    
        $dboy_id =$request->dboy_id;
        $ac_no = $request->ac_no;
        $ifsc = $request->ifsc;
        $bank_name= $request->bank_name;
        $ac_holder = $request->ac_holder;
        $upi = $request->upi;
        
        
        $check = DB::table('driver_bank')
               ->where('driver_id', $dboy_id)
               ->first();
        if($check){
            $update = DB::table('driver_bank')
               ->where('driver_id', $dboy_id)
               ->update(['ac_no'=> $ac_no,'ifsc'=>$ifsc,'holder_name'=>$ac_holder,'bank_name'=>$bank_name,'upi'=>$upi]);
               
        if($update){
        	$message = array('status'=>'1', 'message'=>'Bank Details Updated Successfully');
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Something wents wrong');
	        return $message;
    	}
        }else{
            $update = DB::table('driver_bank')
               ->insert(['driver_id'=>$dboy_id,'ac_no'=> $ac_no,'ifsc'=>$ifsc,'holder_name'=>$ac_holder,'bank_name'=>$bank_name,'upi'=>$upi]);
               
         if($update){
        	$message = array('status'=>'1', 'message'=>'Bank Details Updated Successfully');
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Something wents wrong');
	        return $message;
    	}   
        } 
        
        
    
    }
    
         public function driverupdateprofile(Request $request)
    {   
        $dboy_id = $request->dboy_id;
       $boy_name = $request->boy_name;
       $boy_phone =$request->boy_phone;
       $password = $request->password;

       
        
     $chkboyrphon = DB::table('delivery_boy')
                  ->where('boy_phone', $boy_phone)
                  ->where('dboy_id','!=',$dboy_id)
                 ->first(); 

        if($chkboyrphon){
            	$message = array('status'=>'0', 'message'=>trans('keywords.This Phone Number Is Already Registered With Another Delivery Boy'));
	        return $message;
        } 
        
        



        $updated = DB::table('delivery_boy')
                   ->where('dboy_id', $dboy_id)
                    ->update([
                        'boy_name'=>$boy_name,
                        'boy_phone'=>$boy_phone,
                        'password'=>$password
                       
                    ]);

        if($updated){
         $driver=  DB::table('delivery_boy')
                ->where('dboy_id', $dboy_id )
                ->first();
        	$message = array('status'=>'1', 'message'=>'Driver Profile Updated', 'data'=>$driver);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Nothing to Update');
	        return $message;
    	}
        
    }
    
}