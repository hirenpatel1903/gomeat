<?php

namespace App\Traits;

use App\User;
use App\Partner;
use App\WebSetting;
use DB;
use Twilio\Rest\Client;

trait SendSms {
    public function ordersuccessfull($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_phone) {
        $countrycode =DB::table('country_code')
                     ->first();
		$currency = DB::table('currency')
                  ->first();	
                  
         $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
        $delivery_date1 = date('d-m-Y',strtotime($delivery_date));          
        $getInvitationMsg = "Order Successfully Placed: Your order id #".$cart_id." contains of " .$stv." of price ".$currency->currency_sign." ".$price2. " is placed Successfully.You can expect your item(s) will be delivered on ".$delivery_date1." between ".$time_slot.".";
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user ='+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
     public function ordersuccessfullstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$store_phone) {
        $countrycode =DB::table('country_code')
                     ->first();
		$currency = DB::table('currency')
                  ->first();
        $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
        $delivery_date1 = date('d-m-Y',strtotime($delivery_date));             
        $getInvitationMsg ="You got an order cart id #".$cart_id." contains of " .$stv." of price ".$currency->currency_sign." ".$price2. ". It will have to delivered on ".$delivery_date1." between ".$time_slot.".";
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$store_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user ='+'.$countrycode->country_code.$store_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
  
     public function orderconfirmedsms($cart_id,$user_phone,$orr) {
        $countrycode =DB::table('country_code')
                     ->first();     
         $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
        $delivery_date1 = date('d-m-Y',strtotime($orr->delivery_date));               
                     
        $getInvitationMsg = "Your Order is confirmed: Your order id #".$cart_id." is confirmed by the store.You can expect your item(s) will be delivered on ".$delivery_date1." (".$orr->time_slot.").";
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
     public function delout($cart_id, $prod_name, $price2,$currency,$ord,$user_phone) {
         $countrycode =DB::table('country_code')
                     ->first();
         $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
         if($ord->payment_method=="COD" || $ord->payment_method=="cod"){
                        $getInvitationMsg = "Out For Delivery: Your order id #".$cart_id." contains of " .$stv." of price ".$currency->currency_sign." ".$price2. " is Out For Delivery.Get ready with ".$currency->currency_sign." ". $ord->rem_price. " cash.";
            }
            else{
                $getInvitationMsg = "Out For Delivery: Your order id #".$cart_id." contains of " .$prod_name." of price " .$currency->currency_sign." ".$price2. " is Out For Delivery.Get ready."; 
            }
        $smsby =  DB::table('smsby')
               ->first();
        if($smsby->status==1){         
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
        }          
    }
    
     public function deloutstore($cart_id, $prod_name, $price2,$currency,$ord,$user_phone,$dboy_name,$store_n,$store_phone) {
         $countrycode =DB::table('country_code')
                     ->first();
         $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
       
         $getInvitationMsg = "Out For Delivery: Order id #".$cart_id." contains of " .$stv." of price ".$currency->currency_sign." ".$price2. " is Out For Delivery.".$dboy_name." will deliver the Order.";
           
        $smsby =  DB::table('smsby')
               ->first();
        if($smsby->status==1){         
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$store_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$store_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
        }          
    }
   
    
     public function delcomsms($cart_id, $prod_name, $price2,$currency,$user_phone) {
         $countrycode =DB::table('country_code')
                     ->first();
         $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
         
         $getInvitationMsg = "Delivery Completed: Your order id #".$cart_id." contains of " .$stv." of price ".$currency->currency_sign." ".$price2." is Delivered Successfully.";
        $smsby =  DB::table('smsby')
               ->first();
               
        if($smsby->status==1){         
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
        }          
    }
    
    
    public function delcomsmsstore($cart_id, $prod_name, $price2,$currency,$user_phone,$dboy_name,$store_n,$store_phone) {
         $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
      
         $countrycode =DB::table('country_code')
                     ->first();
         $getInvitationMsg ="Delivery Completed: Order id #".$cart_id." from ".$store_n." contains of ".$stv." of price ".$currency->currency_sign." ".$price2. " is Delivered Successfully.";
        $smsby =  DB::table('smsby')
               ->first();
               
        if($smsby->status==1){         
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$store_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$store_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
        }          
    }
    
    
  
     public function otpmsg($otpval,$user_phone) {
        $countrycode =DB::table('country_code')
                     ->first(); 
                     
        //  dd($countrycode);           
        $getInvitationMsg = "Dear User, Your OTP is {$otpval} to activate your profile. Regards, Bharatam."; 
        $smsby =  DB::table('smsby')
               ->first();
        if($smsby->status==1){         
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => 917895811769,
                            'message' => $message1,
                            'sender' => "BHRTAM",
                            'route' => $route,
                            'DLT_TE_ID'=>1207162370396674321
                        );
        
                       $url="http://api.msg91.com/api/sendhttp.php";
        // init the resource
        $ch = curl_init();
        curl_setopt_array($ch, array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_POST => true,
            CURLOPT_POSTFIELDS => $postData
            //,CURLOPT_FOLLOWLOCATION => true
        ));
        //Ignore SSL certificate verification
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
        //get response
        $output = curl_exec($ch);
      
        //Print error if any
        if(curl_errno($ch))
        {
            return false;
        }
        curl_close($ch);
        return true;
               
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
        }          
    }



//////Store Payout////////
 public function sendpayoutmsg($amt,$store_phone) {
         $countrycode =DB::table('country_code')
                     ->first();
         $getInvitationMsg = 'Amount of '.$amt.' marked paid successfully against your request.';
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$store_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$store_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
    //////Store Payout////////
 public function sendrejectmsg($cause,$user,$cart_id) {
        $countrycode =DB::table('country_code')
                     ->first();
         $getInvitationMsg = 'Hello '.$user->name.', We are cancelling your order ('.$cart_id.') due to following reason:  '.$cause;
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user->user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$user->user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
     public function rechargesms($curr,$user_name, $add_to_wallet,$user_phone) {
         $countrycode =DB::table('country_code')
                     ->first();
        $getInvitationMsg = "Hey ".$user_name." :your wallet recharge of ".$curr->currency_sign." ".$add_to_wallet." is successful.";
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
    public function sendrejectmsgbystore($cause,$user,$ord_id) {
        $countrycode =DB::table('country_code')
                     ->first();
         $getInvitationMsg = 'Hello '.$user->name.', We are cancelling your order no. = '.$ord_id.' due to following reason:  '.$cause;
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user->user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user = '+'.$countrycode->country_code.$user->user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
    
     public function welmsg($user_name,$user_phone,$user_email) {
        $countrycode =DB::table('country_code')
                     ->first();
         $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;             
        $getInvitationMsg = "Welcome Dear, ".$user_name." to ".$app_name." Family. We are happy to have you here." ;
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user ='+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
    
      public function ordercancelled($cart_id,$user_phone,$user_name,$prod_name, $price2) {
        $countrycode =DB::table('country_code')
                     ->first();
           $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
        
                 
        $currency = DB::table('currency')
                 ->first();
        $getInvitationMsg = "Order Cancelled: Your order id #".$cart_id." Successfully Cancelled. It Contains ".$stv." of Price ".$currency->currency_sign." ".$price2.".";
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$user_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user ='+'.$countrycode->country_code.$user_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
     public function ordercancelledstore($cart_id,$user_phone,$store_phone,$user_name,$prod_name, $price2) {
        $countrycode =DB::table('country_code')
                     ->first();
        $currency = DB::table('currency')
                  ->first();
            $st = DB::table('store_orders')
               ->where('order_cart_id',$cart_id)
               ->where('store_approval',1)
               ->sum('qty');
        $stv= $st." products";  
              
        $getInvitationMsg ="Order cart id #".$cart_id." Cancelled By the User. It Contains ".$stv." of Price ".$currency->currency_sign." ".$price2.".";
        $smsby =  DB::table('smsby')
               ->first();
    if($smsby->status==1){       
        if($smsby->msg91==1){       
         $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
                        $api_key = $sms_api_key->api_key;
                        $sender_id = $sms_api_key->sender_id;
                        $getAuthKey = $api_key;
                        $getSenderId = $sender_id;
                        
                        $authKey = $getAuthKey;
                        $senderId = $getSenderId;
                        $message1 = $getInvitationMsg;
                        $route = "4";
                        $postData = array(
                            'authkey' => $authKey,
                            'mobiles' => $countrycode->country_code.$store_phone,
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
        }else{
      
       $twilio=DB::table('twilio')
             ->first();
                           
       $twilsid = $twilio->twilio_sid;  
       $twiltoken = $twilio->twilio_token; 
       $twilphone = $twilio->twilio_phone; 
         // send SMS
        // Your Account SID and Auth Token from twilio.com/console
        $sid = $twilsid;
        $token = $twiltoken;
        $client = new Client($sid, $token);
        $user ='+'.$countrycode->country_code.$store_phone;
        // Use the client to do fun stuff like send text messages!
        $client->messages->create(
            // the number you'd like to send the message to
            $user,
            array(
                // A Twilio phone number you purchased at twilio.com/console
                'from' => $twilphone,
                // the body of the text message you'd like to send
                'body' => $getInvitationMsg
               
            )
        );
        }
    }
                
    }
    
    
    
}