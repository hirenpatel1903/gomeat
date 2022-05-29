<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use App\Traits\SendMail;
use App\Traits\SendSms;

class WalletController extends Controller
{
   use SendSms;
   use SendMail;
   public function walletamount(Request $request)
    {  
        $user_id = $request->user_id;
        $wallet = DB::table('users')
                ->select('wallet')
                ->where('id', $user_id)
                ->first();
        $wallet_amt = $wallet->wallet; 
        
         if($wallet){
            $message = array('status'=>'1', 'message'=>'Wallet_amount', 'data'=>$wallet_amt);
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'No user Found', 'data'=>$wallet_amt);
            return $message;
        }
    }
    
    
     public function add_credit(Request $request)
    { 
        $add_to_wallet = $request->amount;
        $curr = DB::table('currency')
             ->first();
        $recharge_status = $request->recharge_status;
        $payment_gateway = $request->payment_gateway;
        $user_id = $request->user_id;
        $wallet_amt = DB::table('users')
                    ->select('wallet')
                    ->where('id', $user_id)
                    ->first();
             
        $date_of_recharge= carbon::now();            
        $amount = $wallet_amt->wallet;
        $added = $add_to_wallet + $amount;
        $currentDate = date('Y-m-d'); 
        $ph = DB::table('users')
                  ->select('user_phone', 'email','name')
                  ->where('id',$user_id)
                  ->first();
        $user_phone = $ph->user_phone;
        $user_email = $ph->email;
        $user_name = $ph->name;
                      
    
if($recharge_status == 'success'){
             $wallet_amt = DB::table('users')
                    ->where('id', $user_id)
                    ->update(['wallet'=>$added]);
             
              $insert=  DB::table('wallet_recharge_history')
                    ->insert(['user_id'=>$user_id,
                    'amount'=>$add_to_wallet,
                    'date_of_recharge'=>$date_of_recharge,
                    'recharge_status'=> $recharge_status,
                    'payment_gateway'=>$payment_gateway]);        
           
           
               

        if($insert){
            // start sms
            $sms = DB::table('notificationby')
                   ->select('sms')
                   ->where('user_id',$user_id)
                   ->first();
            $sms_status = $sms->sms;  
            $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
              $api_key = $sms_api_key->api_key;
              $sender_id = $sms_api_key->sender_id;
            if($sms_status == 1){
                 $rechargeSms = $this->rechargesms($curr,$user_name, $add_to_wallet,$user_phone);
            }
                    // end sms
                  
                 
                 
                 /////send mail
            $email = DB::table('notificationby')
                   ->select('email')
                   ->where('user_id',$user_id)
                   ->first();
            $email_status = $email->email;       
            if($email_status == 1){
                 
                    $rechargeMail = $this->rechargeMail($user_id,$user_name, $user_email, $user_phone,$add_to_wallet); 
               }
                 ////end send mail 
           
        	$message = array('status'=>'1', 'message'=>'wallet recharged successfully');
        	return $message;
        }
        }
        
        
        else{
             $insert=  DB::table('wallet_recharge_history')
                    ->insert(['user_id'=>$user_id,
                    'amount'=>$add_to_wallet,
                    'date_of_recharge'=>$date_of_recharge,
                    'recharge_status'=> 'failed',
                    'payment_gateway'=>$payment_gateway]); 
        	$message = array('status'=>'0', 'message'=>'Failed! try again', 'data'=>[]);
        	return $message;
        }
        
        }
 
     
    
    
    public function totalbill(Request $request)
    { 
        $user_id = $request->user_id;


        $orders = DB::table('orders')
                    ->where('user_id', $user_id)
                    ->where('paid_by_wallet','!=', 0)
                    ->paginate(10);
            
                    
     if(count($orders)>0){
         foreach($orders as $ordersss){
             $or[]=$ordersss;
         }
        	$message = array('status'=>'1', 'message'=>'data found','data'=>$or);
        	return $message;
        }
        else{
        	$message = array('status'=>'1', 'message'=>'data not found','data'=>[]);
        	return $message;
        }          
    }
    
    
      public function show_recharge_history(Request $request)
    { 
        $user_id = $request->user_id;
        $show =  DB::table('wallet_recharge_history')
              ->join('users', 'wallet_recharge_history.user_id','=','users.id')
              ->where('users.id',$user_id)
              ->orderBy('wallet_recharge_history.wallet_recharge_history', 'DESC' )
              ->paginate(10);
        
        if(count($show)>0){
             foreach($show as $showss){
             $or[]=$showss;
         }
        	$message = array('status'=>'1', 'message'=>'data found','data'=>$or);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'something went wrong');
        	return $message;
        }               
    }
}
