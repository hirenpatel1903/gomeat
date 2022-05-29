<?php

namespace App\Traits;
use DB;
use Mail;


trait SendMail {
    
    
      public function payoutMail($amt,$store_name,$user_email,$app_name) {
       
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$store_name, 'from-name' => $app_name);
        $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        Mail::send('admin.mail.payout', compact('amt', 'store_name', 'user_email','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Admin paid to you");
            });
            
        return "send";
    }
    
      public function codorderplacedMail($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign;         
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.codorderplaced', compact('cart_id', 'prod_name', 'price2', 'delivery_date', 'time_slot','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Successfully Placed");
            });
            
        return "send";
    }
    
      public function codorderplacedMailstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name, $store_n,$store_email) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $store_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$store_n, 'from-name' => $app_name);

        Mail::send('admin.mail.codorderplacedstore', compact('cart_id','prod_name','price2','delivery_date','time_slot','user_email','user_name', 'store_n','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Successfully Placed");
            });
            
        return "send";
    }
      public function codorderplacedMailadmin($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name, $store_n,$admin_email,$admin_name) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $admin_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$admin_name, 'from-name' => $app_name);

        Mail::send('admin.mail.codorderplacedadmin', compact('cart_id','prod_name','price2','delivery_date','time_slot','user_email','user_name', 'store_n','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Successfully Placed");
            });
            
        return "send";
    }
    
     public function photoorderplacedMail ($cart_id,$prod_name,$price2,$delivery_date,$user_email,$user_name) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.photoorderplaced', compact('cart_id', 'prod_name', 'price2', 'delivery_date','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Successfully Placed");
            });
            
        return "send";
    }
    
     public function orderplacedMail($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.orderplaced', compact('cart_id', 'prod_name', 'price2', 'delivery_date', 'time_slot','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Successfully Placed");
            });
            
        return "send";
    }
    
    
    
     public function coddeloutMail($cart_id, $prod_name, $price2, $user_email, $user_name, $rem_price) {
        
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.coddel_out', compact('cart_id', 'prod_name', 'price2','currency','rem_price','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Out For Delivery");
            });
            
        return "send";
    }
     public function coddeloutMailstore($cart_id, $prod_name, $price2, $user_email, $user_name, $rem_price,$store_n, $store_email) {
        
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $store_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$store_n, 'from-name' => $app_name);

        Mail::send('admin.mail.coddel_outstore', compact('cart_id', 'prod_name', 'price2','currency','rem_price','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Out For Delivery");
            });
            
        return "send";
    }
     public function coddeloutMailadmin($cart_id, $prod_name, $price2, $user_email, $user_name, $rem_price,$admin_name,$admin_email) {
       
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $admin_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$admin_name, 'from-name' => $app_name);

        Mail::send('admin.mail.coddel_outadmin', compact('cart_id', 'prod_name', 'price2','currency','rem_price','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Out For Delivery");
            });
            
        return "send";
    }
    
    public function deloutMail($cart_id, $prod_name, $price2,$user_email, $user_name,$rem_price) {
        $currency = DB::table('currency')
                  ->first();
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
                 ->first();
        $currency_sign= $currency->currency_sign; 
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.del_out', compact('cart_id', 'prod_name', 'price2','currency','rem_price','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Out For Delivery");
            });
            
        return "send";
    }
    
      public function delcomMail($cart_id, $prod_name, $price2,$user_email, $user_name) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $curr =  DB::table('currency')
             ->first();
       $currency_sign = $curr->currency_sign;
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.del_com', compact('cart_id', 'prod_name', 'price2','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Delivery Completed");
            });
            
        return "send";
    }
    
     public function delcomMailstore($cart_id, $prod_name, $price2,$user_email, $user_name,$dboy_name,$store_n,$store_email) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $curr =  DB::table('currency')
             ->first();
       $currency_sign = $curr->currency_sign;
        $data = array('to' => $store_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$store_n, 'from-name' => $app_name);

        Mail::send('admin.mail.del_comstore', compact('cart_id', 'prod_name', 'price2','currency_sign','dboy_name','store_n'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Delivery Completed");
            });
            
        return "send";
    }
     public function delcomMailadmin($cart_id, $prod_name, $price2,$user_email, $user_name,$dboy_name,$store_n,$admin_email, $admin_name) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $curr =  DB::table('currency')
             ->first();
       $currency_sign = $curr->currency_sign;
        $data = array('to' => $admin_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$admin_name, 'from-name' => $app_name);

        Mail::send('admin.mail.del_comadmin', compact('cart_id', 'prod_name', 'price2','currency_sign','dboy_name','store_n'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Delivery Completed");
            });
            
        return "send";
    }
    
    
     public function rechargeMail($user_id,$user_name, $user_email, $user_phone,$add_to_wallet) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
               ->first();
       $currency_sign = $currency->currency_sign;
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.recharge', compact('add_to_wallet','user_name','user_id','currency','add_to_wallet', 'app_name','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Recharge Successful.");
            });
            
        return "send";
    }
     public function sendrejectmail($cause,$user,$cart_id) {
        
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $currency = DB::table('currency')
               ->first();
       $currency_sign = $currency->currency_sign;
        $data = array('to' => $user->email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user->name, 'from-name' => $app_name);

        Mail::send('admin.mail.rejectmail', compact('cause', 'user', 'cart_id','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Cancelled.");
            });
            
        return "send";
     }
     
     
      public function welmail($user_name,$user_phone,$user_email) {
      $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.welmail', compact('user_name','user_phone','user_email','app_name'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Welcome To Gogrocer");
            });
            
        return "send";
    }
    
    
    
    public function ordercancelMail($cart_id,$user_phone,$user_name,$user_email,$prod_name, $price2) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $curr =  DB::table('currency')
             ->first();
       $currency_sign = $curr->currency_sign;
        $data = array('to' => $user_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$user_name, 'from-name' => $app_name);

        Mail::send('admin.mail.ord_cancel', compact('cart_id','user_phone','user_name','user_email','prod_name', 'price2','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Cancelled");
            });
            
        return "send";
    }
    
      public function ordercancelMailstore($cart_id,$user_phone,$user_name,$store_email,$store_n,$prod_name, $price2) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $curr =  DB::table('currency')
             ->first();
       $currency_sign = $curr->currency_sign;
        $data = array('to' => $store_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$store_n, 'from-name' => $app_name);

        Mail::send('admin.mail.ord_cancelstore', compact('cart_id','user_phone','user_name','store_email','store_n','prod_name', 'price2','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Cancelled By User");
            });
            
        return "send";
    }
     public function ordercancelMailadmin($cart_id,$user_phone,$user_name,$admin_email,$admin_name,$prod_name, $price2) {
       $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $curr =  DB::table('currency')
             ->first();
       $currency_sign = $curr->currency_sign;
        $data = array('to' => $admin_email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$admin_name, 'from-name' => $app_name);

        Mail::send('admin.mail.ord_canceladmin', compact('cart_id','user_phone','user_name','admin_email','admin_name','prod_name', 'price2','currency_sign'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Order Cancelled By User");
            });
            
        return "send";
    }
    
    
private function sendResetEmail($email, $token)
{
      $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
       $check = DB::table('admin')
              ->where('email',$email)
              ->first();
       
//Retrieve the user from the database
$user = DB::table('admin')->where('email', $email)->first();
//Generate, the password reset link. The token generated is embedded in the link
$link = config('base_url') . 'password/reset/' . $token . '?email=' . urlencode($email);

    $data = array('to' => $email, 'from' => 'noreply@thecodecafe.in', 'to-name'=>$email, 'from-name' =>$app_name);
       
        Mail::send('admin.forgetpassword.forgot_passwordadmin', compact('email','check','link','token'), function ($m) use ($data){
                $m->from($data['from'], $data['from-name']);
                $m->to($data['to'], $data['to-name'])->subject("Check your mail");
            });
}
}