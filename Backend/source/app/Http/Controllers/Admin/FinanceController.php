<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Traits\SendMail;
use App\Models\Admin;
use Auth;

class FinanceController extends Controller
{
    use SendMail;

    public function finance(Request $request)
    {
         $title = "Home";
          $admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
         $total_earnings=DB::table('store')
                           ->join('orders','store.id','=','orders.store_id')
                           ->leftJoin('store_earning','store.id','=','store_earning.store_id')
                           ->select('store.id','store.store_name', 'store.phone_number','store.address','store.email','store_earning.paid',DB::raw('SUM(orders.total_price)-SUM(orders.total_price)*(store.admin_share)/100 as sumprice'))
                           ->groupBy('store.id','store.store_name', 'store.phone_number','store.address','store.email','store_earning.paid','store.admin_share')
                           ->where('order_status','Completed')
                           ->paginate(10);
                        
    	return view('admin.store.finance', compact('title',"admin", "logo","total_earnings"));
    }
    
    
     public function store_pay(Request $request)
    {
        $store_id=$request->store_id;
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $amt = $request->amt;
        $check = DB::table('store_earning')
                ->where('store_id',$store_id)
                ->first();
        $check2 = DB::table('store')
                ->where('store_id',$store_id)
                ->first();        
                
        if($check){
        $new_amount = $check->paid + $amt;    
        $update = DB::table('store_earning')
                ->where('store_id',$store_id)
                ->update(['paid'=>$new_amount]);
        }
        else{
         $update = DB::table('store_earning')
                ->insert(['store_id'=>$store_id,'paid'=>$amt]);   
        }
        if($update){
            
             $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
            $api_key = $sms_api_key->api_key;
            $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        $getInvitationMsg = 'Amount of '.$amt.' marked paid successfully to '.$check2->store_name.'.';
        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $check2->phone_number,
                            'message' => $message1,
                            'sender' => $senderId,
                            'route' => $route
                        );
        
                        $url="https://control.msg91.com/api/sendhttp.php";
        
                        $ch = curl_init();
                        curl_setopt_array($ch, array(
                            CURLOPT_URL => $url,
                            CURLOPT_RETURNTRANSFER => true,
                            CURLOPT_POST => true,
                            CURLOPT_POSTFIELDS => $postData
                        ));

                //Ignore SSL certificate verification
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);

                //get response
                $output = curl_exec($ch);

                curl_close($ch);
                
                $store_name = $check2->store_name;
                $user_email = $check2->email;  
                $app_name = $logo->name;
            /////send mail
                 $Msg1 = 'Amount of '.$amt.' marked paid successfully to '.$check2->store_name.'.'; 
                               
                         
                     $to = $user_email;
                    
                    $head = "MIME-Version: 1.0\r\n";
                    $head .= "Content-type: text/plain; charset=iso-8859-1\r\n";
                    $head .= "X-Priority: 3\r\n";
                    $head .= "X-Mailer: PHP". phpversion() ."\r\n";
                    $head .= "From: $sender_id \r\n";
                    //constructing the message
                    $body = "Subject: Amount Paid\n\n $Msg1 ";
                     
                    // ...and away we go!
                    $retval = mail($to,'GoGrocer:Amount paid',$body,$head);
               
            $welcomeMail = $this->payoutMail($amt,$store_name,$user_email,$app_name); 
            
            
            
             return redirect()->back()->withSuccess(trans('keywords.Amount of').' '.$amt.' '.trans('keywords.marked paid successfully to').' '.$check2->store_name);
        }
        else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    
    
     public function boy_incentive(Request $request)
    {
         $title = "Home";
         $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
         $total_earnings=DB::table('driver_incentive')
                           ->leftJoin('delivery_boy','driver_incentive.dboy_id','=','delivery_boy.dboy_id')
                           ->leftJoin('orders','delivery_boy.dboy_id','=','orders.dboy_id')
                           ->leftJoin('driver_bank', 'delivery_boy.dboy_id','=','driver_bank.driver_id')
                            ->select('delivery_boy.dboy_id','delivery_boy.boy_name','delivery_boy.boy_phone','delivery_boy.boy_loc','delivery_boy.boy_city','driver_incentive.earned_till_now','driver_incentive.paid_till_now','driver_incentive.remaining','driver_bank.bank_name','driver_bank.ac_no','driver_bank.holder_name','driver_bank.ifsc','driver_bank.upi',DB::raw('COUNT(orders.order_id) as count'))
                           ->groupBy('delivery_boy.dboy_id','delivery_boy.boy_name','delivery_boy.boy_phone','delivery_boy.boy_loc','delivery_boy.boy_city','driver_incentive.earned_till_now','driver_incentive.paid_till_now','driver_incentive.remaining','driver_bank.bank_name','driver_bank.ac_no','driver_bank.holder_name','driver_bank.ifsc','driver_bank.upi')
                           ->where('delivery_boy.added_by','admin')
                        //   ->where('orders.order_status','Completed')
                           ->paginate(10);
                        
    	return view('admin.d_boy.finance', compact('title',"admin", "logo","total_earnings"));
    }
    
    
     public function incentive_pay(Request $request)
    {
        $dboy_id=$request->dboy_id;
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $amt = $request->amt;
        $check = DB::table('driver_incentive')
                ->where('dboy_id',$dboy_id)
                ->first();
        $check2 = DB::table('delivery_boy')
                ->where('dboy_id',$dboy_id)
                ->first();        

        $new_amount = $check->paid_till_now + $amt; 
        $new_rem = $check->remaining - $amt;
        $update = DB::table('driver_incentive')
                ->where('dboy_id',$dboy_id)
                ->update(['paid_till_now'=>$new_amount,
                'remaining'=>$new_rem]);
       
        if($update){
                $boy_name = $check2->boy_name;
                $boy_phone = $check2->boy_phone;  
                $app_name = $logo->name;
                $Msg1 = 'Amount of '.$amt.' marked paid successfully to '.$check2->boy_name.'.'; 
                               
                  

            
            
             return redirect()->back()->withSuccess(trans('keywords.Amount of').' '.$amt.' '.trans('keywords.marked paid successfully to').' '.$check2->boy_name);
        }
        else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
       
     
}
