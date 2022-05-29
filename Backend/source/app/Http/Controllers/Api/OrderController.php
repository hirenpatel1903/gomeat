<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use App\Traits\SendMail;
use App\Traits\SendSms;
use App\Traits\SendInapp;
use App\Setting;
use Razorpay\Api\Api;
use PayPal\Api\Amount;
use PayPal\Api\Refund;
use PayPal\Api\RefundRequest;
use PayPal\Api\Sale;

class OrderController extends Controller
{
   use SendMail; 
   use SendSms;
   use SendInapp;
 public function checkout(Request $request)
    { 
        $cart_id=$request->cart_id;
        $payment_method= $request->payment_method;
        
        $payment_status = $request->payment_status;
        $wallet = $request->wallet;
          $payment_id = $request->payment_id;
            $payment_gateway = $request->payment_gateway;
            if($request->payment_gateway == NULL || $request->payment_method == "Wallet" || $request->payment_method == "wallet" || $request->payment_method == "WALLET"  ){
       $payment_id = "WALLETORCOD";
        $payment_gateway = "WALLETORCOD";
        }else{  
         $payment_id = $request->payment_id;
        $payment_gateway = $request->payment_gateway;
        }
        if($payment_method==NULL){
            $payment_method = 'COD'; 
        }
        $orderr = DB::table('orders')
           ->where('cart_id', $cart_id)
           ->first(); 
          $cart_id=$request->cart_id; 
         $cart =  DB::table('orders')
           ->where('cart_id', $cart_id)
           ->first();   
        $store_id = $cart->store_id;  
         $getD = DB::table('store')
                         ->where('id', $store_id)
                        ->first();
                        
       $store_n = $getD->store_name; 
        $user_id= $orderr->user_id;   
        $delivery_date = $orderr->delivery_date;
        $time_slot= $orderr->time_slot;
        
        $var= DB::table('store_orders')
           ->where('order_cart_id', $cart_id)
           ->get();
        $price2 = $orderr->rem_price;
        $ph = DB::table('users')
                  ->select('name','user_phone','wallet')
                  ->where('id',$user_id)
                  ->first();
        $user_phone = $ph->user_phone;  
        $user_name = $ph->name;
        $rem_priceeer=0;
        foreach ($var as $h){
        $varient_id = $h->varient_id;
        $p = DB::table('store_orders')
           ->where('order_cart_id',$cart_id)
           ->where('varient_id',$varient_id)
           ->first();
        $price = $p->price;   
        $order_qty = $h->qty;
        $unit[] = $p->unit;
        $qty[]= $p->quantity;
        $p_name[] = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
        $prod_name = implode(',',$p_name);
        $rem_priceeer+=$price;
        }
         $charge = 0;
         $prii = $price2;
        if ($payment_method == 'COD' || $payment_method =='cod'){
             $walletamt = 0;    
            
             $payment_status="COD";
            if($wallet == 'yes' || $wallet == 'Yes' || $wallet == 'YES'){
             if($ph->wallet >= $prii){
                 
                $rem_amount = 0; 
                $walletamt = $prii; 
                $rem_wallet = $ph->wallet-$prii;
                $walupdate = DB::table('users')
                           ->where('id',$user_id)
                           ->update(['wallet'=>$rem_wallet]);
                $payment_status="success";           
                $payment_method = "wallet";   
                $payment_id = $cart_id;
                $payment_gateway = "wallet";
             }
             else{
                $rem_amount= $prii - $ph->wallet;
                $walletamt = $ph->wallet;
                $rem_wallet = 0;
                $walupdate = DB::table('users')
                           ->where('id',$user_id)
                           ->update(['wallet'=>$rem_wallet]);
             }
         }
         else{
             $rem_amount=  $prii;
             $walletamt= 0;
         }
       
          $oo = DB::table('orders')
           ->where('cart_id',$cart_id)
            ->update([
            'paid_by_wallet'=>$walletamt,
            'rem_price'=>$rem_amount,
            'payment_status'=>$payment_status,
            'payment_method'=>$payment_method
            ]); 
             
            $sms = DB::table('notificationby')
                       ->select('sms')
                       ->where('user_id',$user_id)
                       ->first();
            $sms_status = $sms->sms;
            
                if($sms_status == 1){
                    $orderplacedmsg = $this->ordersuccessfull($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_phone);
                    
            
                }
                
                
                
                
                
                      /////send mail
            $email = DB::table('notificationby')
                   ->select('email','app')
                   ->where('user_id',$user_id)
                   ->first();
             $q = DB::table('users')
                              ->select('email','name','device_id')
                              ->where('id',$user_id)
                              ->first();
            $user_email = $q->email;             
            $device_id = $q->device_id;     
            $user_name = $q->name;       
            $email_status = $email->email;       
            if($email_status == 1){
                   
                     $codorderplaced = $this->codorderplacedMail($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name);
                    
                    
               }
               
    
               
                 ///////send notification to User//////
             if($email->app ==1){
                 
                  $codorderplaced = $this->codorderplacedinapp($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name,$user_id,$device_id);
                    
                     
                 
             }  
                $orderr1 = DB::table('orders')
                       ->where('cart_id', $cart_id)
                       ->first();   
           
                ///////send notification to store//////
                $getD = DB::table('store')
                         ->where('id', $store_id)
                        ->first();
                        
                $store_n = $getD->store_name; 
             if($getD){
               
                  $store_phone = $getD->phone_number;
                  $store_email = $getD->email;
                      $orderplacedmsgstore = $this->ordersuccessfullstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$store_phone);
                      $codorderplacedstore = $this->codorderplacedMailstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name, $store_n,$store_email);
                     
                       $codorderplacedstore = $this->codorderplacedinappstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name,$store_n,$store_id);
                  }
          $admin = DB::table('admin')
                 ->first();
           $admin_email = $admin->email;
           $admin_name = $admin->name;
              $codorderplacedadmin = $this->codorderplacedMailadmin($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name,$store_n,$admin_email,$admin_name); 
               
                               
            $delete = DB::table('store_orders')
                           ->where('store_approval',$user_id)
                           ->where('order_cart_id', 'incart')
                           ->delete();
                           
                           
            $cart_status=DB::table('cart_status')
                        ->insert(['pending'=>Carbon::now(),
                        'cart_id'=>$cart_id]);
			 $orderr1->order_id=$cart_id;
            $message = array('status'=>'1', 'message'=>'Order Placed successfully', 'data'=>$orderr1 );
            return $message;   
        }
       
        else{
        $walletamt = 0;    
        $prii = $price2 + $charge;
        if($request->wallet == 'yes' || $request->wallet == 'Yes' || $request->wallet == 'YES'){
             if($ph->wallet >= $prii){
                $rem_amount = 0; 
                $walletamt = $prii; 
                $rem_wallet = $ph->wallet - $prii;
                $walupdate = DB::table('users')
                           ->where('id',$user_id)
                           ->update(['wallet'=>$rem_wallet]);
                $payment_status="success";           
                $payment_method = "wallet";
                $payment_id =$cart_id;
                $payment_gateway = "wallet";
                
             }
             else{
                 
                $rem_amount=  $prii-$ph->wallet;
                $walletamt = $ph->wallet;
                $rem_wallet =0;
                $walupdate = DB::table('users')
                           ->where('id',$user_id)
                           ->update(['wallet'=>$rem_wallet]);
             }
         }
          else{
              $rem_amount=  $prii;
              $walletamt = 0;
          }
        if($payment_status=='success'){
            
          
            $oo = DB::table('orders')
           ->where('cart_id',$cart_id)
            ->update([
            'paid_by_wallet'=>$walletamt,
            'rem_price'=>$rem_amount,
            'payment_method'=>$payment_method,
            'payment_status'=>'success'
            ]); 
            
         $payments = DB::table('cart_payments')
            ->insert([
            'cart_id'=>$cart_id,
            'amount'=>$rem_amount,
            'payment_gateway'=>$payment_gateway,
            'payment_id'=>$payment_id,
            'created_at'=>Carbon::now(),
            'updated_at'=>Carbon::now()
            ]); 
            
            $sms = DB::table('notificationby')
                       ->select('sms')
                       ->where('user_id',$user_id)
                       ->first();
            $sms_status = $sms->sms;
                if($sms_status == 1){
                    
                /////send sms/////    
                $codorderplaced = $this->ordersuccessfull($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_phone);
                }
                      /////send mail
            $email = DB::table('notificationby')
                   ->select('email','app')
                   ->where('user_id',$user_id)
                   ->first();
            $email_status = $email->email;
             $q = DB::table('users')
                  ->select('email','name')
                  ->where('id',$user_id)
                  ->first();
            $user_email = $q->email;     
            $user_name = $q->name;
             if($email_status == 1){
                   
                     ///sending mails//    
                     $orderplaced = $this->orderplacedMail($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name);
                 
               }
            if($email->app == 1){
                 ///////send notification to User//////
                 $codorderplaced = $this->codorderplacedinapp($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name,$user_id);
                
                 
             } 
            $orderr1 = DB::table('orders')
           ->where('cart_id', $cart_id)
           ->first();
           
              ///////send notification to store//////
                $getD = DB::table('store')
                         ->where('id', $store_id)
                        ->first();
                        
                $store_n = $getD->store_name;   
                
                
               
                                
            $delete = DB::table('store_orders')
                           ->where('store_approval',$user_id)
                           ->where('order_cart_id', 'incart')
                           ->delete();
    
    
              if($getD){
               
                   $store_phone = $getD->phone_number;
                   $store_email = $getD->email;
                     $orderplacedmsgstore = $this->ordersuccessfullstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$store_phone);
                      $codorderplacedstore = $this->codorderplacedMailstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name, $store_n,$store_email);
                     
                       $codorderplacedstore = $this->codorderplacedinappstore($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name,$store_n,$store_id);
                  }
         $admin = DB::table('admin')
                 ->first();
          $admin_email = $admin->email;
           $admin_name = $admin->name;
              $codorderplacedadmin = $this->codorderplacedMailadmin($cart_id,$prod_name,$price2,$delivery_date,$time_slot,$user_email,$user_name,$store_n,$admin_email,$admin_name); 
             
             $cart_status=DB::table('cart_status')
                        ->insert(['pending'=>Carbon::now(),
                        'cart_id'=>$cart_id]);
             $orderr1->order_id=$cart_id;
            $message = array('status'=>'1', 'message'=>'Order Placed successfully', 'data'=>$orderr1 );
            return $message; 
         }
         else{
              $oo = DB::table('orders')
           ->where('cart_id',$cart_id)
            ->update([
            'paid_by_wallet'=>0,
            'rem_price'=>$rem_amount,
            'payment_method'=>NULL,
            'payment_status'=>'failed'
            ]);  
            $message = array('status'=>'0', 'message'=>'Payment Failed');
            return $message;
         }
      }
    }       
           








     
 
  public function ongoing(Request $request)
    {
      $user_id = $request->user_id;
      $ongoing = DB::table('orders')
            ->join('store','orders.store_id','=','store.id')
            ->join('users','orders.user_id','=','users.id')
             ->join('address','orders.address_id','=','address.address_id')
             ->leftJoin('delivery_boy', 'orders.dboy_id', '=', 'delivery_boy.dboy_id')
              ->where('orders.user_id',$user_id)
              ->where('orders.order_status', '!=', 'NULL')
              ->where('orders.payment_method', '!=', NULL)
              ->orderBy('orders.order_id', 'DESC')
               ->paginate(10);
      
      if(count($ongoing)>0){
      foreach($ongoing as $ongoings){
      $order = DB::table('store_orders')
            ->where('order_cart_id',$ongoings->cart_id)
            ->get();
       $ongoings->discountonmrp=$ongoings->total_products_mrp - $ongoings->price_without_delivery; 
       $ongoings->total_items=count($order);
       foreach($order as $orderssss){
           $checkstore= DB::Table('orders')
                 ->where('cart_id',$ongoings->cart_id)
                 ->first();
           $getrating = DB::table('product_rating')
                          ->where('varient_id',$orderssss->varient_id)
                          ->where('user_id',$user_id)
                          ->where('store_id',$checkstore->store_id)
                          ->first(); 
                   if($getrating) {
                      
                    $orderssss->rating=$getrating->rating; 
                     $orderssss->rating_description=$getrating->description;
                 } 
                 else{
                      $orderssss->rating=NULL; 
                     $orderssss->rating_description=NULL;
                 }     
         $orderssss->cart_qty = $orderssss->qty;
         $orddet[]=$orderssss;
       }           
        
        $data[]=array('user_name'=>$ongoings->name,'delivery_address'=>$ongoings->house_no.','.$ongoings->society.','.$ongoings->city.','.$ongoings->landmark.','.$ongoings->state.','.$ongoings->pincode,'store_name'=>$ongoings->store_name,'store_owner'=>$ongoings->employee_name, 'store_phone'=>$ongoings->phone_number, 'store_email'=>$ongoings->email, 'store_address'=>$ongoings->address ,'order_status'=>$ongoings->order_status, 'delivery_date'=>$ongoings->delivery_date, 'time_slot'=>$ongoings->time_slot,'payment_method'=>$ongoings->payment_method,'payment_status'=>$ongoings->payment_status,'paid_by_wallet'=>$ongoings->paid_by_wallet, 'cart_id'=>$ongoings->cart_id ,'total_price'=>$ongoings->total_price,'delivery_charge'=>$ongoings->delivery_charge,'rem_price'=>$ongoings->rem_price,'coupon_discount'=>$ongoings->coupon_discount,'dboy_name'=>$ongoings->boy_name,'dboy_phone'=>$ongoings->boy_phone,'price_without_delivery'=>$ongoings->price_without_delivery,'avg_tax_per'=>$ongoings->avg_tax_per,'total_tax_price'=>$ongoings->total_tax_price,'user_id'=>$ongoings->user_id,'total_products_mrp'=>$ongoings->total_products_mrp,'discountonmrp'=> $ongoings->discountonmrp,'cancelling_reason'=>$ongoings->cancelling_reason,'order_date'=>$ongoings->order_date,'dboy_id'=>$ongoings->dboy_id,'user_signature'=>$ongoings->user_signature,'coupon_id'=>$ongoings->coupon_id,'dboy_incentive'=>$ongoings->dboy_incentive,'total_items'=>$ongoings->total_items,'data'=>$orddet); 
        }
        $message = array('status'=>'1', 'message'=>'My All orders', 'data'=>$data);
            return $message;
        }
        else{
            $message = array('status'=>'1', 'message'=>'No Orders Yet' , 'data'=>[]);
            return $message;
        }
                  
                  
  }     
  
  
   public function pen_con_out(Request $request)
    {
      $user_id = $request->user_id;
      
      $ongoing = DB::table('orders')
            ->join('store','orders.store_id','=','store.id')
            ->join('users','orders.user_id','=','users.id')
             ->join('address','orders.address_id','=','address.address_id')
             ->leftJoin('delivery_boy', 'orders.dboy_id', '=', 'delivery_boy.dboy_id')
              ->where('orders.user_id',$user_id)
              ->where('orders.order_status', '!=', 'NULL')
              ->where('orders.order_status', '!=', 'Cancelled')
              ->where('orders.order_status', '!=', 'Completed')
              ->where('orders.order_status', '!=', 'cancelled')
              ->where('orders.order_status', '!=', 'completed')
              ->where('orders.payment_method', '!=', NULL)
              ->orderBy('orders.order_id', 'DESC')
               ->paginate(10);
      
      if(count($ongoing)>0){
      foreach($ongoing as $ongoings){
      $order = DB::table('store_orders')
            ->where('order_cart_id',$ongoings->cart_id)
            ->get();
       $ongoings->discountonmrp=$ongoings->total_products_mrp - $ongoings->price_without_delivery; 
       $ongoings->total_items=count($order);
       foreach($order as $orderssss){
           $checkstore= DB::Table('orders')
                 ->where('cart_id',$ongoings->cart_id)
                 ->first();
           $getrating = DB::table('product_rating')
                          ->where('varient_id',$orderssss->varient_id)
                          ->where('user_id',$user_id)
                          ->where('store_id',$checkstore->store_id)
                          ->first(); 
                   if($getrating) {
                      
                    $orderssss->rating=$getrating->rating; 
                     $orderssss->rating_description=$getrating->description;
                 } 
                 else{
                      $orderssss->rating=NULL; 
                     $orderssss->rating_description=NULL;
                 }     
         $orderssss->cart_qty = $orderssss->qty;
         $orddet[]=$orderssss;
       }           
        
        $data[]=array('user_name'=>$ongoings->name,'delivery_address'=>$ongoings->house_no.','.$ongoings->society.','.$ongoings->city.','.$ongoings->landmark.','.$ongoings->state.','.$ongoings->pincode,'store_name'=>$ongoings->store_name,'store_owner'=>$ongoings->employee_name, 'store_phone'=>$ongoings->phone_number, 'store_email'=>$ongoings->email, 'store_address'=>$ongoings->address ,'order_status'=>$ongoings->order_status, 'delivery_date'=>$ongoings->delivery_date, 'time_slot'=>$ongoings->time_slot,'payment_method'=>$ongoings->payment_method,'payment_status'=>$ongoings->payment_status,'paid_by_wallet'=>$ongoings->paid_by_wallet, 'cart_id'=>$ongoings->cart_id ,'total_price'=>$ongoings->total_price,'delivery_charge'=>$ongoings->delivery_charge,'rem_price'=>$ongoings->rem_price,'coupon_discount'=>$ongoings->coupon_discount,'dboy_name'=>$ongoings->boy_name,'dboy_phone'=>$ongoings->boy_phone,'price_without_delivery'=>$ongoings->price_without_delivery,'avg_tax_per'=>$ongoings->avg_tax_per,'total_tax_price'=>$ongoings->total_tax_price,'user_id'=>$ongoings->user_id,'total_products_mrp'=>$ongoings->total_products_mrp,'discountonmrp'=> $ongoings->discountonmrp,'cancelling_reason'=>$ongoings->cancelling_reason,'order_date'=>$ongoings->order_date,'dboy_id'=>$ongoings->dboy_id,'user_signature'=>$ongoings->user_signature,'coupon_id'=>$ongoings->coupon_id,'dboy_incentive'=>$ongoings->dboy_incentive,'total_items'=>$ongoings->total_items,'data'=>$orddet); 
        }
        $message = array('status'=>'1', 'message'=>'My All orders', 'data'=>$data);
            return $message;
        }
        else{
            $message = array('status'=>'1', 'message'=>'No Orders Yet' , 'data'=>[]);
            return $message;
        }
                   
                  
  }     
 
  
  public function cancel_for(Request $request)
    { 
   $cancelfor = DB::table('cancel_for')
                  ->get();
      
       if($cancelfor){
            $message = array('status'=>'1', 'message'=>'Cancelling reason list', 'data'=>$cancelfor);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'no list found', 'data'=>[]);
            return $message;
        }
  }
  
  
  public function delete_order(Request $request)
  {
      $cart_id = $request->cart_id;
       $user = DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
       $var= DB::table('store_orders')
           ->where('order_cart_id', $cart_id)
           ->get();
           $store_id =$user->store_id; 
        $price2=0;
        $ph = DB::table('users')
                  ->select('user_phone','wallet','name','id')
                  ->where('id',$user->user_id)
                  ->first();
        $user_id = $ph->id;          
        $user_phone = $ph->user_phone;   
        $user_name = $ph->name;
        foreach ($var as $h){
        $varient_id = $h->varient_id;
       $p = DB::table('store_products')
            ->join('product_varient','store_products.varient_id','=','product_varient.varient_id') 
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('product_varient.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
        $price = $p->price;   
        $order_qty = $h->qty;
        $price2+= $price*$order_qty;
        $unit[] = $p->unit;
        $qty[]= $p->quantity;
        $p_name[] = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
        $prod_name = implode(',',$p_name);
        }   
        $c_pmnt = DB::table('cart_payments')
              ->where('cart_id',$cart_id)
              ->first();      
        $user_id1 = $user->user_id;
         $userwa1 = DB::table('users')
                     ->where('id',$user_id1)
                     ->first();
      $reason = $request->reason;
       if($reason ==NULL){
		    $message = array('status'=>'0', 'message'=>'Select a Cancelling Reason First');
            return $message;
	   }
      $order_status = 'Cancelled';
      $updated_at = Carbon::now();
      $order = DB::table('orders')
                  ->where('cart_id', $cart_id)
                  ->update([
                        'cancelling_reason'=>$reason,
                        'order_status'=>$order_status,
                        'updated_at'=>$updated_at]);
      
       if($order){
           $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                         ->first();
            if($cart_status){             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                        ->update(['cancelled'=>Carbon::now()]);
            }  
        if($user->payment_method == 'COD' || $user->payment_method == 'Cod' || $user->payment_method == 'cod'){
            $newbal1 = $userwa1->wallet + $user->paid_by_wallet;  
			 $userwalletupdate = DB::table('users')
                                 ->where('id',$user_id1)
                                 ->update(['wallet'=>$newbal1]);  
              }
           elseif($user->payment_method == 'Wallet' || $user->payment_method == 'wallet' || $user->payment_method == 'WALLET'){
			     $newbal1 = $userwa1->wallet + $user->paid_by_wallet;  
			 $userwalletupdate = DB::table('users')
                                 ->where('id',$user_id1)
                                 ->update(['wallet'=>$newbal1]);  
		   }
          else{
			
              if($user->payment_status=='success' && $c_pmnt && $c_pmnt->payment_gateway != NULL){

                if($c_pmnt->payment_gateway == "sslcommerz" || $c_pmnt->payment_gateway == "Sslcommerz" || $c_pmnt->payment_gateway == "SSLCOMMERZ"){
                        $newbal1 = $userwa1->wallet + $user->paid_by_wallet;  
                    $userwalletupdate = DB::table('users')
                                     ->where('id',$user_id1)
                                        ->update(['wallet'=>$newbal1]);  
                    
                   }elseif($c_pmnt->payment_gateway == "stripe" || $c_pmnt->payment_gateway == "Stripe" || $c_pmnt->payment_gateway == "STRIPE"){
                     $stripe_secret =Setting::where('name', 'stripe_secret_key')->select('value')->first(); 
                     $stripe_publishable_key =Setting::where('name', 'stripe_publishable_key')->select('value')->first(); 
                    $stripe = new \Stripe\StripeClient(
                      $stripe_secret->value
                    );
                    $stripe->refunds->create([
                      'charge' => $c_pmnt->payment_id,
                    ]);
                    $newbal1 = $userwa1->wallet + $user->paid_by_wallet;  
                    $userwalletupdate = DB::table('users')
                                     ->where('id',$user_id1)
                                        ->update(['wallet'=>$newbal1]);  
                    
                   }elseif($c_pmnt->payment_gateway == "paystack" || $c_pmnt->payment_gateway == "Paystack" || $c_pmnt->payment_gateway == "PAYSTACK"){
                    $paystack_public_key =Setting::where('name', 'paystack_public_key')->select('value')->first(); 
                    $paystack_secret_key =Setting::where('name', 'paystack_secret_key')->select('value')->first(); 
                                  
                                   $url = "https://api.paystack.co/refund";
              $fields = [
                'transaction' =>  $c_pmnt->payment_id
              ];
              $fields_string = http_build_query($fields);
              $ch = curl_init();
              curl_setopt($ch,CURLOPT_URL, $url);
              curl_setopt($ch,CURLOPT_POST, true);
              curl_setopt($ch,CURLOPT_POSTFIELDS, $fields_string);
              curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                "Authorization: Bearer ".$paystack_secret_key,
                "Cache-Control: no-cache",
              ));
              
              curl_setopt($ch,CURLOPT_RETURNTRANSFER, true); 
              $result = curl_exec($ch);
                    $newbal1 = $userwa1->wallet + $user->paid_by_wallet;  
                    $userwalletupdate = DB::table('users')
                                      ->where('id',$user_id1)
                                        ->update(['wallet'=>$newbal1]);  
             
                   }else{
                    $clientId =Setting::where('name', 'paypal_client_id')->select('value')->first();
                    $clientSecret =Setting::where('name', 'paypal_secret_key')->select('value')->first();   
                    $newbal1 = $userwa1->wallet + $user->paid_by_wallet;; 
                     $userwalletupdate = DB::table('users')
                    ->where('id',$user_id1)
                     ->update(['wallet'=>$newbal1]);  
                 }
              }
              else{
                   $newbal1 = $userwa1->wallet+$user->paid_by_wallet;   
                    $userwalletupdate = DB::table('users')
                                 ->where('id',$user_id1)
                                 ->update(['wallet'=>$newbal1]);  
              }
             }      
             
              $sms = DB::table('notificationby')
                       ->select('sms')
                       ->where('user_id',$user_id1)
                       ->first();
                       
            $sms_status = $sms->sms;
            $user_phone = $userwa1->user_phone;
            $user_name = $userwa1->name;
            $device_id = $userwa1->device_id;
            $user_email = $userwa1->email;
            $store = DB::table('store')
                   ->where('id', $user->store_id)
                   ->first();
                if($sms_status == 1){
                    $ordercancelled = $this->ordercancelled($cart_id,$user_phone,$user_name,$prod_name, $price2);
                   
                }
                 
                
                    
                      /////send mail
            $email = DB::table('notificationby')
                   ->select('email','app')
                   ->where('user_id',$user_id1)
                   ->first();
             $q = DB::table('users')
                  ->select('email','name','device_id')
                  ->where('id',$user_id)
                  ->first();
            $user_email = $q->email;             
            $device_id = $q->device_id;     
            $user_name = $q->name;       
            $email_status = $email->email;       
            if($email_status == 1){
                   
                    $codordercancel = $this->ordercancelMail($cart_id,$user_phone,$user_name,$user_email,$prod_name, $price2);
               }
          
          
           if($store){
               
                   $store_phone = $store->phone_number;
                   $store_email = $store->email;
                   $store_n = $store->store_name;
                     $ordercancelledstore = $this->ordercancelledstore($cart_id,$user_phone,$store_phone,$user_name,$prod_name, $price2);
                     $codorderplacedstore = $this->ordercancelMailstore($cart_id,$user_phone,$user_name,$store_email,$store_n,$prod_name, $price2);
                 }
                 
          $admin = DB::table('admin')
                ->first();
          $admin_email = $admin->email;
          $admin_name = $admin->name;
             $codorderplacedadmin = $this->ordercancelMailadmin($cart_id,$user_phone,$user_name,$admin_email,$admin_name,$prod_name, $price2);     
            $message = array('status'=>'1', 'message'=>'order cancelled', 'data'=>$order);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'something went wrong');
            return $message;
        }
      
      
  }   
  
  
  
  
    public function whatsnew(Request $request){
        $current = Carbon::now(); 
       $store_id = $request->store_id;
         $filter1 = $request->byname;
    $price1 = DB::table('store_products')
                ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.price','store_products.stock')
                  ->groupBy('store_products.price','store_products.stock')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->orderBy('store_products.price','desc')
                  ->first();
    
    if($price1){
    $price = $price1->price;
    }else{
            $message = array('status'=>'0', 'message'=>'Products not found');
            return $message;
        }  
    
    $min_rating= $request->min_rating;
    if($min_rating == NULL){
      $min_rating=0;  
    }
    $max_rating= $request->max_rating;
    if($max_rating == NULL){
        $max_rating =5;
    }
     $min_price= $request->min_price;
     if($min_price == NULL){
      $min_price=0;  
    }
    $max_price= $request->max_price;
    if($max_price == NULL){
      $max_price=$price;  
    }
    $stock = $request->stock;
    if($stock == 'out'){
        $stock="<";
        $by=1;
       
    }elseif($stock == 'all' || $stock == NULL){
         $stock="!=";
         $by=NULL;
    }else{
      $stock=">"; 
      $by=0;
    }    
      $min_discount= $request->min_discount;
     if($min_discount == NULL){
      $min_discount=0;  
    }
    $max_discount= $request->max_discount;
       if($max_discount == NULL){
      $max_discount=100;  
    }
	if($filter1 != NULL){
       $news = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                   ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderBy('product.product_name',$filter1)
                  ->orderBy('count','desc')
                  ->paginate(10);
    }else{
       $news = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                  ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                   ->orderBy('store_products.p_id','desc')
                  ->paginate(10);
          }
     
            $prodsd = $news->unique('product_id'); 
        
        
         $new = NULL;
        foreach($prodsd as $store)
        {
           
                $new[] = $store; 
            
        }      
     if($new != NULL){
            $result =array();
            $j = 0;
            $k= 0;
            $l=0;
            $m=0;
            foreach ($new as $prods) {
                
            $a=0;
                $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $prods->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $prods->price= round($sp->price,0);
            
           } 
                
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$prods->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
               
                          
                 if($wishlist) {
                   $prods->isFavourite='true';  
                 } 
                 else{
                    $prods->isFavourite='false'; 
                 }
                 if($cart) {
                    $prods->cart_qty=$cart->qty;  
                 } 
                 else{
                    $prods->cart_qty=0; 
                 }
                 
                }else{
                $prods->isFavourite='false'; 
                 $prods->cart_qty=0;
                }
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $prods->avgrating=round($rating,0); 
                    $prods->countrating=$countrating;
                 } 
                 else{
                     $prods->avgrating=0; 
                    $prods->countrating=0;
                 }         
                 
                if($prods->mrp != 0){
                $discountper=100-(($prods->price*100)/$prods->mrp);
            $prods->discountper=round($discountper,0);
                }else{
                   $prods->discountper=0;   
                }
                $prods->maxprice=$price;
                array_push($result, $prods);
                 $c = array($prods->product_id);
                    $app1 =DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                 ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
                         ->select('store_products.store_id','store_products.stock','product_varient.varient_id', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','deal_product.deal_price', 'deal_product.valid_from', 'deal_product.valid_to')
                         ->where('store_products.store_id', $store_id)
                        ->whereIn('product_varient.product_id', $c)
                        ->where('store_products.price','!=',NULL)
                         ->where('product_varient.approved',1)
                         ->get();
                         
                      foreach($app1 as $aa){   
            
		      $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $app1[$a]->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $app1[$a]->price= round($sp->price,0);
            
           }
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$aa->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
               
                          
                 if($wishlist) {
                    $app1[$a]->isFavourite='true';  
                 } 
                 else{
                    $app1[$a]->isFavourite='false'; 
                 }
                 if($cart) {
                    $app1[$a]->cart_qty=$cart->qty;  
                 } 
                 else{
                    $app1[$a]->cart_qty=0; 
                 }
                 
                }else{
                 $app1[$a]->isFavourite='false'; 
                  $app1[$a]->cart_qty=0;
                }
                
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $app1[$a]->avgrating=round($rating,0); 
                    $app1[$a]->countrating=$countrating;
                 } 
                 else{
                     $app1[$a]->avgrating=0; 
                    $app1[$a]->countrating=0;
                 }         
                 
              if($aa->mrp != 0){
               $discountper=100-(($aa->price*100)/$aa->mrp);
               $app1[$a]->discountper=round($discountper,0);
                }else{
                    $app1[$a]->discountper=0;   
                }
                $app1[$a]->maxprice=$price;
            $a++;
            }  
                 $result[$k]->varients = $app1;
                 $k++;
                    $l++; 
                $app = json_decode($prods->product_id);
                $apps = array($app);
                $images = DB::table('product_images')
                ->select('image')
                 ->whereIn('product_id', $apps)
                 ->get();
                if(count($images)>0){
                    $result[$m]->images = $images;
                    $m++; 
                }else{
                    $images = DB::table('product')
                 ->select('product_image as image')    
                 ->whereIn('product_id', $apps)
                 ->get();
                 
                  $result[$m]->images = $images;
                    $m++; 
                    
                }
                $tag = DB::table('tags')
                 ->whereIn('product_id', $apps)
                ->get();
                $result[$j]->tags = $tag;  
                $j++;
               
             
            }

            $message = array('status'=>'1', 'message'=>'New in Store', 'data'=>$new);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'nothing in new');
            return $message;
        }      
           
                  
         
        

  }    
  
  

  
  
   public function completed_orders(Request $request)
    {
      $user_id = $request->user_id;
      
      
      $ongoing = DB::table('orders')
            ->join('store','orders.store_id','=','store.id')
            ->join('users','orders.user_id','=','users.id')
             ->join('address','orders.address_id','=','address.address_id')
             ->leftJoin('delivery_boy', 'orders.dboy_id', '=', 'delivery_boy.dboy_id')
              ->where('orders.user_id',$user_id)
              ->where('orders.order_status', '!=', 'NULL')
              ->where('orders.payment_method', '!=', NULL)
               ->where('orders.order_status', 'Completed')
              ->orderBy('orders.order_id', 'DESC')
               ->paginate(10);
      
       if(count($ongoing)>0){
      foreach($ongoing as $ongoings){
      $order = DB::table('store_orders')
            ->where('order_cart_id',$ongoings->cart_id)
            ->get();
       $ongoings->discountonmrp=$ongoings->total_products_mrp - $ongoings->price_without_delivery; 
       $ongoings->total_items=count($order);
       foreach($order as $orderssss){
           $checkstore= DB::Table('orders')
                 ->where('cart_id',$ongoings->cart_id)
                 ->first();
           $getrating = DB::table('product_rating')
                          ->where('varient_id',$orderssss->varient_id)
                          ->where('user_id',$user_id)
                          ->where('store_id',$checkstore->store_id)
                          ->first(); 
                   if($getrating) {
                      
                    $orderssss->rating=$getrating->rating; 
                     $orderssss->rating_description=$getrating->description;
                 } 
                 else{
                      $orderssss->rating=NULL; 
                     $orderssss->rating_description=NULL;
                 }     
         $orderssss->cart_qty = $orderssss->qty;
         $orddet[]=$orderssss;
       }           
        
        $data[]=array('user_name'=>$ongoings->name,'delivery_address'=>$ongoings->house_no.','.$ongoings->society.','.$ongoings->city.','.$ongoings->landmark.','.$ongoings->state.','.$ongoings->pincode,'store_name'=>$ongoings->store_name,'store_owner'=>$ongoings->employee_name, 'store_phone'=>$ongoings->phone_number, 'store_email'=>$ongoings->email, 'store_address'=>$ongoings->address ,'order_status'=>$ongoings->order_status, 'delivery_date'=>$ongoings->delivery_date, 'time_slot'=>$ongoings->time_slot,'payment_method'=>$ongoings->payment_method,'payment_status'=>$ongoings->payment_status,'paid_by_wallet'=>$ongoings->paid_by_wallet, 'cart_id'=>$ongoings->cart_id ,'total_price'=>$ongoings->total_price,'delivery_charge'=>$ongoings->delivery_charge,'rem_price'=>$ongoings->rem_price,'coupon_discount'=>$ongoings->coupon_discount,'dboy_name'=>$ongoings->boy_name,'dboy_phone'=>$ongoings->boy_phone,'price_without_delivery'=>$ongoings->price_without_delivery,'avg_tax_per'=>$ongoings->avg_tax_per,'total_tax_price'=>$ongoings->total_tax_price,'user_id'=>$ongoings->user_id,'total_products_mrp'=>$ongoings->total_products_mrp,'discountonmrp'=> $ongoings->discountonmrp,'cancelling_reason'=>$ongoings->cancelling_reason,'order_date'=>$ongoings->order_date,'dboy_id'=>$ongoings->dboy_id,'user_signature'=>$ongoings->user_signature,'coupon_id'=>$ongoings->coupon_id,'dboy_incentive'=>$ongoings->dboy_incentive,'total_items'=>$ongoings->total_items,'data'=>$orddet); 
        }
        $message = array('status'=>'1', 'message'=>'My All orders', 'data'=>$data);
            return $message;
        }
        else{
            $message = array('status'=>'1', 'message'=>'No Orders Yet' , 'data'=>[]);
            return $message;
        }
                  
                  
  }     
  
  
  
  
   public function can_orders(Request $request)
    {
      $user_id = $request->user_id;
       $ongoing = DB::table('orders')
            ->join('store','orders.store_id','=','store.id')
            ->join('users','orders.user_id','=','users.id')
             ->join('address','orders.address_id','=','address.address_id')
             ->leftJoin('delivery_boy', 'orders.dboy_id', '=', 'delivery_boy.dboy_id')
              ->where('orders.user_id',$user_id)
              ->where('orders.order_status', '!=', 'NULL')
              ->where('orders.payment_method', '!=', NULL)
               ->where('orders.order_status', 'Cancelled')
              ->orderBy('orders.order_id', 'DESC')
               ->paginate(10);
      
      if(count($ongoing)>0){
      foreach($ongoing as $ongoings){
      $order = DB::table('store_orders')
            ->where('order_cart_id',$ongoings->cart_id)
            ->get();
                  
        
         $data[]=array('user_name'=>$ongoings->name,'delivery_address'=>$ongoings->house_no.','.$ongoings->society.','.$ongoings->city.','.$ongoings->landmark.','.$ongoings->state.','.$ongoings->pincode,'store_name'=>$ongoings->store_name,'store_owner'=>$ongoings->employee_name, 'store_phone'=>$ongoings->phone_number, 'store_email'=>$ongoings->email, 'store_address'=>$ongoings->address ,'order_status'=>$ongoings->order_status, 'delivery_date'=>$ongoings->delivery_date, 'time_slot'=>$ongoings->time_slot,'payment_method'=>$ongoings->payment_method,'payment_status'=>$ongoings->payment_status,'paid_by_wallet'=>$ongoings->paid_by_wallet, 'cart_id'=>$ongoings->cart_id ,'price'=>$ongoings->total_price,'delivery_charge'=>$ongoings->delivery_charge,'rem_price'=>$ongoings->rem_price,'coupon_discount'=>$ongoings->coupon_discount,'dboy_name'=>$ongoings->boy_name,'dboy_phone'=>$ongoings->boy_phone,'sub_total'=>$ongoings->price_without_delivery,'avg_tax_per'=>$ongoings->avg_tax_per,'total_tax_price'=>$ongoings->total_tax_price, 'data'=>$order); 
         
        }
         $message = array('status'=>'1', 'message'=>'Cancelled orders', 'data'=>$data);
            return $message;
        }
        else{
             $message = array('status'=>'1', 'message'=>'No Orders Cancelled Yet','data'=>[]);
            return $message;
        }
                  
                  
  }     
  
  
   public function top_selling(Request $request){
      
       $current = Carbon::now();
       $store_id = $request->store_id;
    $price1 = DB::table('store_products')
                ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.price','store_products.stock')
                  ->groupBy('store_products.price','store_products.stock')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->orderBy('store_products.price','desc')
                  ->first();
    
   if($price1){
    $price = $price1->price;
    }else{
            $message = array('status'=>'0', 'message'=>'Products not found');
            return $message;
        }  
    
    $min_rating= $request->min_rating;
    if($min_rating == NULL){
      $min_rating=0;  
    }
    $max_rating= $request->max_rating;
    if($max_rating == NULL){
        $max_rating =5;
    }
     $min_price= $request->min_price;
     if($min_price == NULL){
      $min_price=0;  
    }
    $max_price= $request->max_price;
    if($max_price == NULL){
      $max_price=$price;  
    }
    $stock = $request->stock;
    if($stock == 'out'){
        $stock="<";
        $by=1;
       
    }elseif($stock == 'all' || $stock == NULL){
         $stock="!=";
         $by=NULL;
    }else{
      $stock=">"; 
      $by=0;
    }
    
    $min_discount= $request->min_discount;
     if($min_discount == NULL){
      $min_discount=0;  
    }
    $max_discount= $request->max_discount;
       if($max_discount == NULL){
      $max_discount=100;  
    }
    
    
         $filter1 = $request->byname;
    if($filter1 != NULL){
       $topsellings = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                   ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderBy('product.product_name',$filter1)
                  ->orderBy('count','desc')
                  ->paginate(10);
    }else{
       $topsellings = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                  ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderBy('count','desc')
                  ->paginate(10);
          }
    
             $prodsd = $topsellings->unique('product_id'); 
        
        
         $topselling = NULL;
        foreach($prodsd as $store)
        { 
          
                $topselling[] = $store; 
            
        }      
         if($topselling != NULL){
              $result =array();
            $j = 0;
            $l=0;
            $k=0;
            $m=0;
            foreach ($topselling as $prods) {
              $a=0;
              
             $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $prods->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $prods->price= round($sp->price,0);
            
           }
              
              
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$prods->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
                
                 
                          
                 if($wishlist) {
                   $prods->isFavourite='true';  
                 } 
                 else{
                    $prods->isFavourite='false'; 
                 }
                 if($cart) {
                    $prods->cart_qty=$cart->qty;  
                 } 
                 else{
                    $prods->cart_qty=0; 
                 }
                 
                }else{
                $prods->isFavourite='false'; 
                 $prods->cart_qty=0;
                }
                
                  $getrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $prods->avgrating=round($rating,0); 
                    $prods->countrating=$countrating;
                 } 
                 else{
                     $prods->avgrating=0; 
                    $prods->countrating=0;
                 }         
                if($prods->mrp != 0){
                $discountper=100-(($prods->price*100)/$prods->mrp);
            $prods->discountper=round($discountper,0);
                }else{
                   $prods->discountper=0;   
                }
            $prods->maxprice=$price;       
                array_push($result, $prods);
                $c = array($prods->product_id);
                    $app1 =DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                 ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
                         ->select('store_products.store_id','store_products.stock','product_varient.varient_id', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','deal_product.deal_price', 'deal_product.valid_from', 'deal_product.valid_to')
                         ->where('store_products.store_id', $store_id)
                        ->whereIn('product_varient.product_id', $c)
                        ->where('store_products.price','!=',NULL)
                         ->where('product_varient.approved',1)
                         ->get();
                      foreach($app1 as $aa){   
            
		      $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $app1[$a]->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $app1[$a]->price= round($sp->price,0);
            
           }
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$aa->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
               
                          
                 if($wishlist) {
                    $app1[$a]->isFavourite='true';  
                 } 
                 else{
                    $app1[$a]->isFavourite='false'; 
                 }
                 if($cart) {
                    $app1[$a]->cart_qty=$cart->qty;  
                 } 
                 else{
                    $app1[$a]->cart_qty=0; 
                 }
                 
                }else{
                 $app1[$a]->isFavourite='false'; 
                  $app1[$a]->cart_qty=0;
                }
                
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $app1[$a]->avgrating=round($rating,0); 
                    $app1[$a]->countrating=$countrating;
                 } 
                 else{
                     $app1[$a]->avgrating=0; 
                    $app1[$a]->countrating=0;
                 }         
                 
              if($aa->mrp != 0){
               $discountper=100-(($aa->price*100)/$aa->mrp);
               $app1[$a]->discountper=round($discountper,0);
                }else{
                    $app1[$a]->discountper=0;   
                }
                 $app1[$a]->maxprice=$price;  
            $a++;
            }           
                 $result[$k]->varients = $app1;
                 $k++;
                    $l++; 
                $app = json_decode($prods->product_id);
                $apps = array($app);
              $images = DB::table('product_images')
                ->select('image')
                 ->whereIn('product_id', $apps)
                 ->get();
                if(count($images)>0){
                    $result[$m]->images = $images;
                    $m++; 
                }else{
                    $images = DB::table('product')
                 ->select('product_image as image')    
                 ->whereIn('product_id', $apps)
                 ->get();
                 
                  $result[$m]->images = $images;
                    $m++; 
                    
                }
                $tag = DB::table('tags')
                 ->whereIn('product_id', $apps)
                ->get();
                $result[$j]->tags = $tag;  
                $j++;
               
             
            }
            $message = array('status'=>'1', 'message'=>'top selling products', 'data'=>$topselling);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'nothing in top');
            return $message;
        }      
     
  }    
     public function spotlight(Request $request){
        $current = Carbon::now();    
          $store_id = $request->store_id;
         $filter1 = $request->byname;
    $price1 = DB::table('spotlight')
                ->join ('store_products', 'spotlight.p_id', '=', 'store_products.p_id')
                ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.price','store_products.stock')
                  ->groupBy('store_products.price','store_products.stock')
                  ->where('spotlight.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->orderBy('store_products.price','desc')
                  ->first();
    
    if($price1){
    $price = $price1->price;
    }else{
            $message = array('status'=>'0', 'message'=>'Products not found');
            return $message;
        }  
    
    $min_rating= $request->min_rating;
    if($min_rating == NULL){
      $min_rating=0;  
    }
    $max_rating= $request->max_rating;
    if($max_rating == NULL){
        $max_rating =5;
    }
     $min_price= $request->min_price;
     if($min_price == NULL){
      $min_price=0;  
    }
    $max_price= $request->max_price;
    if($max_price == NULL){
      $max_price=$price;  
    }
    $stock = $request->stock;
    if($stock == 'out'){
        $stock="<";
        $by=1;
       
    }elseif($stock == 'all' || $stock == NULL){
         $stock="!=";
         $by=NULL;
    }else{
      $stock=">"; 
      $by=0;
    }    
      $min_discount= $request->min_discount;
     if($min_discount == NULL){
      $min_discount=0;  
    }
    $max_discount= $request->max_discount;
       if($max_discount == NULL){
      $max_discount=100;  
    }
    if($filter1 != NULL){
       $recentsellings = DB::table('spotlight')
                ->join ('store_products', 'spotlight.p_id', '=', 'store_products.p_id')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('spotlight.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                   ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderBy('product.product_name',$filter1)
                  ->paginate(10);
    }else{
       $recentsellings =DB::table('spotlight')
                ->join ('store_products', 'spotlight.p_id', '=', 'store_products.p_id')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('spotlight.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                  ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderByRaw('RAND()')
                  ->paginate(10);
          }
    
       
           
         $prodsd = $recentsellings->unique('product_id'); 
        
        
         $recentselling = NULL;
        foreach($prodsd as $store)
        {
           
                $recentselling[] = $store; 
            
        }      
                  
         if($recentselling != NULL){
             
         $result =array();
            $j = 0;
            $l=0;
            $k=0;
            $m=0;
            foreach ($recentselling as $prods) {
                
              $a=0;
               $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $prods->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $prods->price= round($sp->price,0);
            
           }
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$prods->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
              
                          
                 if($wishlist) {
                   $prods->isFavourite='true';  
                 } 
                 else{
                    $prods->isFavourite='false'; 
                 }
                 if($cart) {
                    $prods->cart_qty=$cart->qty;  
                 } 
                 else{
                    $prods->cart_qty=0; 
                 }
                 
                }else{
                $prods->isFavourite='false'; 
                 $prods->cart_qty=0;
                }
                  $getrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $prods->avgrating=round($rating,0); 
                    $prods->countrating=$countrating;
                 } 
                 else{
                     $prods->avgrating=0; 
                    $prods->countrating=0;
                 }         
                 
                
                
                if($prods->mrp != 0){
                $discountper=100-(($prods->price*100)/$prods->mrp);
            $prods->discountper=round($discountper,0);
                }else{
                   $prods->discountper=0;   
                }
                
                $prods->maxprice=$price; 
                array_push($result, $prods);
                $c = array($prods->product_id);
                    $app1 =DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                 ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
                         ->select('store_products.store_id','store_products.stock','product_varient.varient_id', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','deal_product.deal_price', 'deal_product.valid_from', 'deal_product.valid_to')
                         ->where('store_products.store_id', $store_id)
                        ->whereIn('product_varient.product_id', $c)
                        ->where('store_products.price','!=',NULL)
                         ->where('product_varient.approved',1)
                         ->get();
                         
                        foreach($app1 as $aa){   
               
		      $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $app1[$a]->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $app1[$a]->price= round($sp->price,0);
            
           }
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$aa->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
               
                          
                 if($wishlist) {
                    $app1[$a]->isFavourite='true';  
                 } 
                 else{
                    $app1[$a]->isFavourite='false'; 
                 }
                 if($cart) {
                    $app1[$a]->cart_qty=$cart->qty;  
                 } 
                 else{
                    $app1[$a]->cart_qty=0; 
                 }
                 
                }else{
                 $app1[$a]->isFavourite='false'; 
                  $app1[$a]->cart_qty=0;
                }
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $app1[$a]->avgrating=round($rating,0); 
                    $app1[$a]->countrating=$countrating;
                 } 
                 else{
                     $app1[$a]->avgrating=0; 
                    $app1[$a]->countrating=0;
                 }         
                 
              if($aa->mrp != 0){
               $discountper=100-(($aa->price*100)/$aa->mrp);
               $app1[$a]->discountper=round($discountper,0);
                }else{
                    $app1[$a]->discountper=0;   
                }
                $app1[$a]->maxprice=$price; 
            $a++;
            }         
                 $result[$k]->varients = $app1;
                 $k++;
                    $l++; 
                $app = json_decode($prods->product_id);
                $apps = array($app);
                $images = DB::table('product_images')
                ->select('image')
                 ->whereIn('product_id', $apps)
                 ->get();
                if(count($images)>0){
                    $result[$m]->images = $images;
                    $m++; 
                }else{
                    $images = DB::table('product')
                 ->select('product_image as image')    
                 ->whereIn('product_id', $apps)
                 ->get();
                 
                  $result[$m]->images = $images;
                    $m++; 
                    
                }
                $tag = DB::table('tags')
                 ->whereIn('product_id', $apps)
                ->get();
                $result[$j]->tags = $tag;  
                $j++;
               
             
            }
            $message = array('status'=>'1', 'message'=>'spotlight products', 'data'=>$recentselling);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'nothing in recentselling');
            return $message;
        } 
    
  }    
  
    public function recentselling(Request $request){
        $current = Carbon::now();    
          $store_id = $request->store_id;
            $filter1 = $request->byname;
    $price1 = DB::table('store_products')
                ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.price','store_products.stock')
                  ->groupBy('store_products.price','store_products.stock')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->orderBy('store_products.price','desc')
                  ->first();
    
   if($price1){
    $price = $price1->price;
    }else{
            $message = array('status'=>'0', 'message'=>'Products not found');
            return $message;
        }  
    
    $min_rating= $request->min_rating;
    if($min_rating == NULL){
      $min_rating=0;  
    }
    $max_rating= $request->max_rating;
    if($max_rating == NULL){
        $max_rating =5;
    }
     $min_price= $request->min_price;
     if($min_price == NULL){
      $min_price=0;  
    }
    $max_price= $request->max_price;
    if($max_price == NULL){
      $max_price=$price;  
    }
    $stock = $request->stock;
    if($stock == 'out'){
        $stock="<";
        $by=1;
       
    }elseif($stock == 'all' || $stock == NULL){
         $stock="!=";
         $by=NULL;
    }else{
      $stock=">"; 
      $by=0;
    }   
    
      $min_discount= $request->min_discount;
     if($min_discount == NULL){
      $min_discount=0;  
    }
    $max_discount= $request->max_discount;
       if($max_discount == NULL){
      $max_discount=100;  
    }
        if($filter1 != NULL){
       $recentsellings = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin ('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                   ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderBy('product.product_name',$filter1)
                  ->paginate(10);
    }else{
       $recentsellings = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin('store_orders', 'store_products.varient_id', '=', 'store_orders.varient_id') 
                  ->Leftjoin('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->Leftjoin('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                  ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('count(store_orders.varient_id) as count'),DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                  ->where('store_products.store_id', $store_id)
                  ->where('deal_product.deal_price', NULL)
                  ->where('store_products.price','!=',NULL)
                  ->where('product.hide',0)
                  ->whereBetween('store_products.price',[$min_price, $max_price])
                  ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderByRaw('RAND()')
                  ->paginate(10);
          }
    
           
               $prodsd = $recentsellings->unique('product_id'); 
        
        
         $recentselling = NULL;
        foreach($prodsd as $store)
        {
           
                $recentselling[] = $store; 
            
        }      
                  
         if($recentselling != NULL){
             
         $result =array();
            $j = 0;
            $l=0;
            $k=0;
            $m=0;
            foreach ($recentselling as $prods) {
                
              $a=0;
               $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $prods->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$prods->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $prods->price= round($sp->price,0);
            
           }
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$prods->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
                   
                 
                          
                 if($wishlist) {
                   $prods->isFavourite='true';  
                 } 
                 else{
                    $prods->isFavourite='false'; 
                 }
                 if($cart) {
                    $prods->cart_qty=$cart->qty;  
                 } 
                 else{
                    $prods->cart_qty=0; 
                 }
                 
                }else{
                $prods->isFavourite='false'; 
                 $prods->cart_qty=0;
                }
                
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$prods->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $prods->avgrating=round($rating,0); 
                    $prods->countrating=$countrating;
                 } 
                 else{
                     $prods->avgrating=0; 
                    $prods->countrating=0;
                 }     
                if($prods->mrp != 0){
                $discountper=100-(($prods->price*100)/$prods->mrp);
            $prods->discountper=round($discountper,0);
                }else{
                   $prods->discountper=0;   
                }
                $prods->maxprice=$price;
                array_push($result, $prods);
                $c = array($prods->product_id);
                    $app1 =DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                 ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
                         ->select('store_products.store_id','store_products.stock','product_varient.varient_id', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','deal_product.deal_price', 'deal_product.valid_from', 'deal_product.valid_to')
                         ->where('store_products.store_id', $store_id)
                        ->whereIn('product_varient.product_id', $c)
                        ->where('store_products.price','!=',NULL)
                         ->where('product_varient.approved',1)
                         ->get();
                         
                        foreach($app1 as $aa){   
             
		      $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $app1[$a]->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $app1[$a]->price= round($sp->price,0);
            
           }
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$aa->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
              
                 
                          
                 if($wishlist) {
                    $app1[$a]->isFavourite='true';  
                 } 
                 else{
                    $app1[$a]->isFavourite='false'; 
                 }
                 if($cart) {
                    $app1[$a]->cart_qty=$cart->qty;  
                 } 
                 else{
                    $app1[$a]->cart_qty=0; 
                 }
                 
                }else{
                 $app1[$a]->isFavourite='false'; 
                  $app1[$a]->cart_qty=0;
                }
                  $getrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$aa->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $app1[$a]->avgrating=round($rating,0); 
                    $app1[$a]->countrating=$countrating;
                 } 
                 else{
                     $app1[$a]->avgrating=0; 
                    $app1[$a]->countrating=0;
                 }         
                
                
              if($aa->mrp != 0){
               $discountper=100-(($aa->price*100)/$aa->mrp);
               $app1[$a]->discountper=round($discountper,0);
                }else{
                    $app1[$a]->discountper=0;   
                }
               $app1[$a]->maxprice=$price; 
            $a++;
            }         
                 $result[$k]->varients = $app1;
                 $k++;
                    $l++; 
                $app = json_decode($prods->product_id);
                $apps = array($app);
                $images = DB::table('product_images')
                ->select('image')
                 ->whereIn('product_id', $apps)
                 ->get();
                if(count($images)>0){
                    $result[$m]->images = $images;
                    $m++; 
                }else{
                    $images = DB::table('product')
                 ->select('product_image as image')    
                 ->whereIn('product_id', $apps)
                 ->get();
                 
                  $result[$m]->images = $images;
                    $m++; 
                    
                }
                $tag = DB::table('tags')
                 ->whereIn('product_id', $apps)
                ->get();
                $result[$j]->tags = $tag;  
                $j++;
               
             
            }
            $message = array('status'=>'1', 'message'=>'recent selling products', 'data'=>$recentselling);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'nothing in recentselling');
            return $message;
        } 
    
  }    
  
}