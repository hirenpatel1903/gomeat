<?php

namespace App\Http\Controllers\Driverapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use App\Traits\SendInapp;
use App\Traits\SendMail;
use App\Traits\SendSms;
use Illuminate\Support\Facades\Storage;

class DriverorderController extends Controller
{
    use SendMail;
    use SendSms;
    use SendInapp;
	
	  public function __construct(){
        $storage =  DB::table('image_space')
                    ->first();

        if($storage->aws == 1){
            $this->storage_space = "s3.aws";
        }
        else if($storage->digital_ocean == 1){
            $this->storage_space = "s3.digitalocean";
        }else{
            $this->storage_space ="same_server";
        }

    }
	
	
    public function completed_orders(Request $request)
     {
         
        $dboy_id = $request->dboy_id;
    	 		   
        $orde =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store', 'orders.store_id', '=', 'store.id')
             ->join('address', 'orders.address_id','=','address.address_id')
             ->join('delivery_boy', 'orders.dboy_id', '=','delivery_boy.dboy_id')
             ->select('orders.order_status','orders.cart_id','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot', 'store.address as store_address', 'store.store_name','store.phone_number','store.lat as store_lat','store.lng as store_lng','address.lat as userlat', 'address.lng as userlng', 'delivery_boy.lat as dboy_lat', 'delivery_boy.lng as dboy_lng', 'address.receiver_name', 'address.receiver_phone', 'address.city','address.society','address.house_no','address.landmark','address.state')
        
             ->where('orders.dboy_id',$dboy_id)
             ->orderBy('orders.delivery_date', 'desc')
             ->get();
                    
         $orders = DB::table('orders')
                  ->where('dboy_id', $dboy_id)
                  ->Where('order_status','!=',NULL)
                  ->where('order_status','!=','Cancelled')
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
                  
       
        $prodsd = $orde->unique('cart_id'); 
        
        
         $ord = NULL;
        foreach($prodsd as $store)
        {
           
                $ord[] = $store; 
            
        }        
       
     if($ord != NULL){
      foreach($ord as $ords){
             $cart_id = $ords->cart_id;    
         $details  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->sum('store_orders.qty');
        
        $data[]=array('user_address'=>$ords->house_no.','.$ords->society.','.$ords->city.','.$ords->landmark.','.$ords->state ,'order_status'=>$ords->order_status,'store_name'=>$ords->store_name, 'store_lat'=>$ords->store_lat, 'store_lng'=>$ords->store_lng, 'store_address'=>$ords->store_address, 'user_lat'=>$ords->userlat, 'user_lng'=>$ords->userlng, 'dboy_lat'=>$ords->dboy_lat, 'dboy_lng'=>$ords->dboy_lng, 'cart_id'=>$cart_id,'user_name'=>$ords->name, 'user_phone'=>$ords->user_phone, 'remaining_price'=>$ords->rem_price,'delivery_boy_name'=>$ords->boy_name,'delivery_boy_phone'=>$ords->boy_phone,'delivery_date'=>$ords->delivery_date,'time_slot'=>$ords->time_slot,'order_details'=>$details); 
        }
        }
        else{
            $data[]=array('order_details'=>'no orders found');
        }
        return $data;     
    }       
    
   public function order_items(Request $request)
     {
         
        $cart_id = $request->cart_id;
    	 		   
          	               
    	  $items  =   DB::table('store_orders')
    	              ->leftJoin('product_varient', 'store_orders.varient_id','=','product_varient.varient_id')
    	               ->select('store_orders.*','product_varient.description')
    	               ->where('store_orders.order_cart_id',$cart_id)
    	               ->where('store_orders.store_approval',1)
    	               ->get();             
       
       if(count($items)>0){
        
         $message = array('status'=>'1', 'message'=>'order items', 'cart_items'=>$items);
        	return $message;
    	          }          
            else{
             $message = array('status'=>'0', 'message'=>'Items are not there in order');
        	return $message;
       }            
    }       
    
 public function ordersfortoday(Request $request)
     {
         $date = date('Y-m-d');
        $dboy_id = $request->dboy_id;
    	 		   
        $orde =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store', 'orders.store_id', '=', 'store.id')
             ->join('address', 'orders.address_id','=','address.address_id')
             ->join('delivery_boy', 'orders.dboy_id', '=','delivery_boy.dboy_id')
             ->select('orders.order_status','orders.cart_id','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','orders.payment_method','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot', 'store.address as store_address', 'store.store_name','store.phone_number','store.lat as store_lat','store.lng as store_lng','address.lat as userlat', 'address.lng as userlng', 'delivery_boy.lat as dboy_lat', 'delivery_boy.lng as dboy_lng', 'address.receiver_name', 'address.receiver_phone', 'address.city','address.society','address.house_no','address.landmark','address.state')

             ->where('orders.store_id','!=',0)
             ->where('orders.dboy_id',$dboy_id)
             ->where('orders.delivery_date', $date)
             ->orderBy('orders.time_slot', 'ASC')
             ->get();
         $prodsd = $orde->unique('cart_id'); 
        
        
         $ord = NULL;
        foreach($prodsd as $store)
        {
           
                $ord[] = $store; 
            
        }        
       
     if($ord != NULL){
      foreach($ord as $ords){
             $cart_id = $ords->cart_id;    
         $details  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->sum('store_orders.qty');
    	               
    	  $items  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->get();             
                  
        
        $data[]=array('cart_id'=>$ords->cart_id,'payment_method'=>$ords->payment_method, 'payment_status'=>$ords->payment_status,'user_address'=>$ords->house_no.','.$ords->society.','.$ords->city.','.$ords->landmark.','.$ords->state ,'order_status'=>$ords->order_status,'store_name'=>$ords->store_name, 'store_lat'=>$ords->store_lat, 'store_lng'=>$ords->store_lng, 'store_address'=>$ords->store_address, 'user_lat'=>$ords->userlat, 'user_lng'=>$ords->userlng, 'dboy_lat'=>$ords->dboy_lat, 'dboy_lng'=>$ords->dboy_lng, 'cart_id'=>$cart_id,'user_name'=>$ords->name, 'user_phone'=>$ords->user_phone, 'remaining_price'=>$ords->rem_price,'delivery_boy_name'=>$ords->boy_name,'delivery_boy_phone'=>$ords->boy_phone,'delivery_date'=>$ords->delivery_date,'time_slot'=>$ords->time_slot,'total_items'=>$details,'items'=>$items); 
        }
        }
        else{
            $data[]=array('order_details'=>'no orders found');
        }
        return $data;     
    }      
    
    
    
     public function ordersfornextday(Request $request)
     {
         $date = date('Y-m-d');
         $day = 1;
         $next_date = date('Y-m-d', strtotime($date.' + '.$day.' days'));
         $dboy_id = $request->dboy_id;
    	 		   
        $orde =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store', 'orders.store_id', '=', 'store.id')
             ->join('address', 'orders.address_id','=','address.address_id')
             ->join('delivery_boy', 'orders.dboy_id', '=','delivery_boy.dboy_id')
             ->select('orders.order_status','orders.cart_id','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','orders.payment_method','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot', 'store.address as store_address', 'store.store_name','store.phone_number','store.lat as store_lat','store.lng as store_lng','address.lat as userlat', 'address.lng as userlng', 'delivery_boy.lat as dboy_lat', 'delivery_boy.lng as dboy_lng', 'address.receiver_name', 'address.receiver_phone', 'address.city','address.society','address.house_no','address.landmark','address.state','store.phone_number')
             ->where('orders.order_status','!=', 'completed')
             ->where('orders.order_status','!=', 'Completed')
             ->where('orders.store_id','!=',0)
             ->where('orders.dboy_id',$dboy_id)
             ->whereDate('orders.delivery_date', $next_date)
             ->orderBy('orders.time_slot', 'ASC')
             ->get();
        $prodsd = $orde->unique('cart_id'); 
        
        
         $ord = NULL;
        foreach($prodsd as $store)
        {
           
                $ord[] = $store; 
            
        }        
       
     if($ord != NULL){
      foreach($ord as $ords){
             $cart_id = $ords->cart_id;    
         $details  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->sum('store_orders.qty');
           $items  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->get();     
        $data[]=array('payment_method'=>$ords->payment_method,'payment_status'=>$ords->payment_status,'user_address'=>$ords->house_no.','.$ords->society.','.$ords->city.','.$ords->landmark.','.$ords->state , 'order_status'=>$ords->order_status,'store_name'=>$ords->store_name,'store_phone'=>$ords->phone_number, 'store_lat'=>$ords->store_lat, 'store_lng'=>$ords->store_lng, 'store_address'=>$ords->store_address, 'user_lat'=>$ords->userlat, 'user_lng'=>$ords->userlng, 'dboy_lat'=>$ords->dboy_lat, 'dboy_lng'=>$ords->dboy_lng, 'cart_id'=>$cart_id,'user_name'=>$ords->name, 'user_phone'=>$ords->user_phone, 'remaining_price'=>$ords->rem_price,'delivery_boy_name'=>$ords->boy_name,'delivery_boy_phone'=>$ords->boy_phone,'delivery_date'=>$ords->delivery_date,'time_slot'=>$ords->time_slot,'total_items'=>$details,'items'=>$items); 
        }
        }
        else{
            $data[]=array('order_details'=>'no orders found');
        }
        return $data;     
    }      
 
 
 
 
 
 
            
  public function delivery_out(Request $request)
    {
       $cart_id= $request->cart_id;
       $ord = DB::table('orders')
            ->where('cart_id',$cart_id)
            ->first();
        $store_id = $ord->store_id;
        $getd = DB::table('store')
             ->where('id', $store_id)
             ->first();
             
        $store_n =$getd->store_name;
        $store_email = $getd->email;
        $store_phone = $getd->phone_number;
        $getdboy = DB::table('delivery_boy')
             ->where('dboy_id', $ord->dboy_id)
             ->first();
             
        $dboy_name =  $getdboy->boy_name;    
        $user_id=$ord->user_id;    
        
       $var= DB::table('store_orders')
           ->where('order_cart_id', $cart_id)
           ->get();
        $price2=0;
        $ph = DB::table('users')
                  ->select('user_phone','wallet','name')
                  ->where('id',$ord->user_id)
                  ->first();
        $user_phone = $ph->user_phone; 
        $user_name = $ph->name;
        foreach ($var as $h){
        $varient_id = $h->varient_id;
        $p = DB::table('store_orders')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->where('order_cart_id',$cart_id)
           ->first();
        $price = $p->price;   
        $order_qty = $h->qty;
        $price2+= $p->price;
        $unit[] = $p->unit;
        $qty[]= $p->quantity;
        $p_name[] = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
        $prod_name = implode(',',$p_name);
        }
        $currency = DB::table('currency')
                  ->first();
        $apppp = DB::table('tbl_web_setting')
                  ->first();          
       $status = 'Out_For_Delivery';
       $update= DB::table('orders')
              ->where('cart_id',$cart_id)
              ->update(['order_status'=>$status]);
              
        if($update){
            
               
            $sms = DB::table('notificationby')
                       ->select('sms','app')
                       ->where('user_id',$ord->user_id)
                       ->first();
            $sms_status = $sms->sms;
            $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
            $api_key = $sms_api_key->api_key;
            $sender_id = $sms_api_key->sender_id;
                if($sms_status == 1){
                $successmsg = $this->delout($cart_id, $prod_name, $price2,$currency,$ord,$user_phone);
                }
                
                //////send app notification////
                if($sms->app == 1){
                    if($ord->payment_method=="COD" || $ord->payment_method=="cod"){
                        
                 $successmsginapp = $this->deloutinapp($cart_id, $prod_name, $price2,$currency,$ord,$user_phone,$user_id,$store_n);
              
                    }
                    else{
                        
                         $successmsginapp = $this->deloutinappcard($cart_id, $prod_name, $price2,$currency,$ord,$user_phone,$user_id,$store_n);
                       
                    }
                }
                
                
                      /////send mail
            $email = DB::table('notificationby')
                   ->select('email')
                   ->where('user_id',$ord->user_id)
                   ->first();
            $email_status = $email->email; 
            $rem_price = $ord->rem_price;
            if($email_status == 1){
                if($ord->payment_method=="COD" || $ord->payment_method=="cod"){
                    $q = DB::table('users')
                              ->select('email','name')
                              ->where('id',$ord->user_id)
                              ->first();
                    $user_email = $q->email;   
                    $user_name = $q->name;
                      $successmail = $this->coddeloutMail($cart_id, $prod_name, $price2,$user_email, $user_name,$rem_price);
                       
                        
                    }
                    else{
                    $q = DB::table('users')
                              ->select('email','name')
                              ->where('id',$ord->user_id)
                              ->first();
                    $user_email = $q->email;   
                    $user_name = $q->name;
                         $successmail = $this->deloutMail($cart_id, $prod_name, $price2,$user_email, $user_name,$rem_price);
                    }
                    
                    
                    if($getd){
                        $successmailstore = $this->coddeloutMailstore($cart_id, $prod_name, $price2, $user_email, $user_name, $rem_price,$store_n, $store_email);
                         $successmsginapp = $this->deloutinappstore($cart_id, $prod_name, $price2,$currency,$ord,$user_phone,$user_id,$store_id,$store_n);
                         
                          $successmsgstore = $this->deloutstore($cart_id, $prod_name, $price2,$currency,$ord,$user_phone,$dboy_name, $store_n,$store_phone);
                    }
                    
                    
                                     
                      $admin = DB::table('admin')
                              ->first();
                        $admin_email = $admin->email;
                          $admin_name = $admin->name;
                    $successmailadmin = $this->coddeloutMailadmin($cart_id, $prod_name, $price2, $user_email, $user_name, $rem_price,$admin_name,$admin_email);
                    
               }
               
                $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                         ->first();
            if($cart_status){             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                        ->update(['out_for_delivery'=>Carbon::now()]);
            }
    	   $message = array('status'=>'1', 'message'=>'out for delivery');
        	return $message;
    	          }          
            else{
             $message = array('status'=>'0', 'message'=>'something went wrong');
        	return $message;
       }       
              
    }

    
    public function delivery_completed(Request $request)
    {
       $cart_id= $request->cart_id;
       $currency = DB::table('currency')
            ->first();
		$date = date('d-m-Y');	
        $ord = DB::table('orders')
            ->where('cart_id',$cart_id)
            ->first();
            $q = DB::table('users')
                              ->select('email','name')
                              ->where('id',$ord->user_id)
                              ->first();
         $user_email = $q->email;             
        $user_name =$q->name;
		$store_id=$ord->store_id;
		 $getd = DB::table('store')
             ->where('id', $store_id)
             ->first();
             
        $store_n =$getd->store_name;
        $store_email = $getd->email;
        $store_phone=$getd->phone_number;
        $getdboy = DB::table('delivery_boy')
             ->where('dboy_id', $ord->dboy_id)
             ->first();
             
        $dboy_name =  $getdboy->boy_name; 
          $user_id = $ord->user_id;  
		  
        if ($request->hasFile('user_signature')) {
            $user_signature = $request->user_signature;
            $fileName = $user_signature->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $category_image_name = $user_signature->getClientOriginalName();
                $user_signature = $request->file('user_signature');
                $filePath = '/signature/'.$category_image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('user_signature'), 'r+'), 'public');
            }
            else{
           
            $user_signature->move('images/users/'.$date.'/', $fileName);
            $filePath = '/images/users/'.$date.'/'.$fileName;
        
            }


        } else {
            $filePath = 'images/';
            $filePath = 'N/A';
        }

          
       $var= DB::table('store_orders')
           ->where('order_cart_id', $cart_id)
           ->get();
        $price2=0;
        $ph = DB::table('users')
                  ->select('user_phone','wallet','name')
                  ->where('id',$ord->user_id)
                  ->first();
        $user_phone = $ph->user_phone;   
        $user_name = $ph->name;
        foreach ($var as $h){
        $varient_id = $h->varient_id;
       $p = DB::table('store_orders')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->where('order_cart_id',$cart_id)
           ->first();
        $price = $p->price;   
        $order_qty = $h->qty;
        $price2+=  $p->price;
        $unit[] = $p->unit;
        $qty[]= $p->quantity;
        $p_name[] = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
        $prod_name = implode(',',$p_name);
        }
         $apppp = DB::table('tbl_web_setting')
                  ->first();  
       $status = 'Completed';
       
       $delivery_boy = DB::table('delivery_boy')
                     ->where('dboy_id',$ord->dboy_id)
                     ->first();
       
       if($delivery_boy->added_by == 'admin'){
        $incentive = DB::table('admin_driver_incentive')
                       ->first();
                if($incentive){
                    $in_am =$incentive->incentive;
                }else{
                    $in_am =0;
                }       
                       
       }else{
         $incentive = DB::table('store_driver_incentive')
                      ->where('store_id',$ord->store_id)
                       ->first();
                       
                 if($incentive){
                    $in_am =$incentive->incentive;
                }else{
                    $in_am =0;
                }        
       }
                       
       $update= DB::table('orders')
              ->where('cart_id',$cart_id)
              ->update(['order_status'=>$status,'user_signature'=>$filePath,'dboy_incentive'=>$in_am]);
              
        if($update){
            
            $check = DB::table('driver_incentive')
                    ->where('dboy_id', $ord->dboy_id)
                    ->first();
                    
            if($check){
                $newin = $in_am + $check->earned_till_now;
                $inst = DB::table('driver_incentive')
                    ->where('dboy_id', $ord->dboy_id)
                    ->update(['earned_till_now'=>$newin, 'remaining'=>$newin-$check->paid_till_now]);
            }else{
                $inst =  DB::table('driver_incentive')
                    ->insert(['earned_till_now'=>$in_am, 'remaining'=>$in_am,'dboy_id'=>$ord->dboy_id,'paid_till_now'=>0]);
            }
                    
            $sms = DB::table('notificationby')
                       ->select('sms','app')
                       ->where('user_id',$ord->user_id)
                       ->first();
            $sms_status = $sms->sms;
            $sms_api_key=  DB::table('msg91')
    	              ->select('api_key', 'sender_id')
                      ->first();
            $api_key = $sms_api_key->api_key;
            $sender_id = $sms_api_key->sender_id;
                if($sms_status == 1){
                    $successmsg = $this->delcomsms($cart_id, $prod_name, $price2,$currency,$user_phone); 
                     
                   }
                ////send notification to app///
                if($sms->app == 1){
                  
                        
                 $successmsginapp = $this->delcominapp($cart_id, $prod_name, $price2,$currency,$ord,$user_phone,$user_id);
              
                }   
                
              
            /////send mail
            $email = DB::table('notificationby')
                   ->select('email')
                   ->where('user_id',$ord->user_id)
                   ->first();
            $email_status = $email->email;       
            if($email_status == 1){
                    
                    $successmail = $this->delcomMail($cart_id, $prod_name, $price2,$user_email,$user_name); 
                   
                   
               }
			  ////rewards earned////
           $checkre =DB::table('reward_points')
                    ->where('min_cart_value','<=',$ord->total_price)
                    ->orderBy('min_cart_value','desc')
                    ->first();
            if($checkre){       
           $reward_point1 = $checkre->reward_point;
            $datee=date('Y-m-d');
     $checkmem = DB::table('users')
               ->where('id',$user_id)
               ->whereDate('mem_plan_expiry','>=',$datee)
               ->first();
    if($checkmem){           
           $plan = DB::table('membership_plan')
                 ->where('plan_id',$checkmem->membership)
                 ->first();
           $reward_point = $reward_point1 * $plan->reward;      
            
    }else{
        $reward_point = $reward_point1;
    }
           $inreward = DB::table('users')
                     ->where('id',$user_id)
                     ->update(['rewards'=>$reward_point]);
           
           $cartreward = DB::table('cart_rewards')
                     ->insert(['cart_id'=>$cart_id, 'rewards'=>$reward_point, 'user_id'=>$user_id]);
            }
            
            if($getd){
                        $successmailstore = $this->delcomMailstore($cart_id, $prod_name, $price2,$user_email, $user_name,$dboy_name,$store_n,$store_email);
                        
                           $successmsginappstore = $this->delcominappstore($cart_id, $prod_name, $price2,$currency,$ord,$user_phone,$user_id,$store_id);
                           
                            $successmsgstore = $this->delcomsmsstore($cart_id, $prod_name, $price2,$currency,$user_phone,$dboy_name,$store_n,$store_phone);
                        
                    }
                                     
                      $admin = DB::table('admin')
                              ->first();
                        $admin_email = $admin->email;
                          $admin_name = $admin->name;
                    $successmailadmin = $this->delcomMailadmin($cart_id, $prod_name, $price2,$user_email, $user_name,$dboy_name,$store_n,$admin_email, $admin_name);
            
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                         ->first();
            if($cart_status){             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                        ->update(['completed'=>Carbon::now()]);
            }
            
    	   $message = array('status'=>'1', 'message'=>'Delivery Completed');
        	return $message;
    	          }          
            else{
             $message = array('status'=>'0', 'message'=>'something went wrong');
        	return $message;
       }       
              
    }


   public function completeorderlist(Request $request)
    {  

         $date = $request->from_date;
	     $dboy_id = $request->dboy_id;
         $payment_method = $request->payment_method;
         $to_date = $request->to_date;
         $next_date = date('Y-m-d', strtotime($date));
         $next_date2 = date('Y-m-d', strtotime($to_date));
         $title = $payment_method." orders of ".$next_date.' - '.$next_date2;
        if($payment_method == "COD"){       
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->join('store', 'orders.store_id','=','store.id')
			->join('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
			 ->select('orders.order_status','orders.cart_id','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot', 'store.address as store_address', 'store.store_name','store.phone_number','store.lat as store_lat','store.lng as store_lng','address.lat as userlat', 'address.lng as userlng', 'delivery_boy.lat as dboy_lat', 'delivery_boy.lng as dboy_lng', 'address.receiver_name', 'address.receiver_phone', 'address.city','address.society','address.house_no','address.landmark','address.state')
             ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.dboy_id',$dboy_id)
              ->where('orders.order_status','completed')
             ->where('payment_method', $payment_method)
             ->where('payment_status', '!=',"failed")
             ->get();
        }
        elseif($payment_method == "wallet"){
            $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->join('store', 'orders.store_id','=','store.id')
			->join('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
			 ->select('orders.order_status','orders.cart_id','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot', 'store.address as store_address', 'store.store_name','store.phone_number','store.lat as store_lat','store.lng as store_lng','address.lat as userlat', 'address.lng as userlng', 'delivery_boy.lat as dboy_lat', 'delivery_boy.lng as dboy_lng', 'address.receiver_name', 'address.receiver_phone', 'address.city','address.society','address.house_no','address.landmark','address.state')
             ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.dboy_id',$dboy_id)
               ->where('orders.order_status','completed')
              ->where('payment_method','wallet')
             ->where('payment_status', '!=',"failed")
             ->get();
        }
         elseif($payment_method == "online"){
            $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->join('store', 'orders.store_id','=','store.id')
			->join('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
			 ->select('orders.order_status','orders.cart_id','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot', 'store.address as store_address', 'store.store_name','store.phone_number','store.lat as store_lat','store.lng as store_lng','address.lat as userlat', 'address.lng as userlng', 'delivery_boy.lat as dboy_lat', 'delivery_boy.lng as dboy_lng', 'address.receiver_name', 'address.receiver_phone', 'address.city','address.society','address.house_no','address.landmark','address.state')
            ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.dboy_id',$dboy_id)
               ->where('orders.order_status','completed')
              ->where('payment_method','!=','COD')
              ->where('payment_method','!=','wallet')
              ->where('payment_method','!=',NULL)
             ->where('payment_status', '!=',"failed")
             ->get();
        }
        else{
            $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->join('store', 'orders.store_id','=','store.id')
			->join('delivery_boy', 'orders.dboy_id','=','delivery_boy.dboy_id')
			 ->select('orders.order_status','orders.cart_id','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot', 'store.address as store_address', 'store.store_name','store.phone_number','store.lat as store_lat','store.lng as store_lng','address.lat as userlat', 'address.lng as userlng', 'delivery_boy.lat as dboy_lat', 'delivery_boy.lng as dboy_lng', 'address.receiver_name', 'address.receiver_phone', 'address.city','address.society','address.house_no','address.landmark','address.state')
            ->where('orders.delivery_date','>=', $next_date)
            ->where('orders.delivery_date','<', $next_date2)
             ->where('orders.dboy_id',$dboy_id)
              ->where('orders.order_status','completed')
             ->where('payment_status', '!=',"failed")
             ->get();
        }
         if(count($ord)>0){
      foreach($ord as $ords){
             $cart_id = $ords->cart_id;    
         $details  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->sum('store_orders.qty');
        
        $data[]=array('user_address'=>$ords->house_no.','.$ords->society.','.$ords->city.','.$ords->landmark.','.$ords->state ,'order_status'=>$ords->order_status,'store_name'=>$ords->store_name, 'store_lat'=>$ords->store_lat, 'store_lng'=>$ords->store_lng, 'store_address'=>$ords->store_address, 'user_lat'=>$ords->userlat, 'user_lng'=>$ords->userlng, 'dboy_lat'=>$ords->dboy_lat, 'dboy_lng'=>$ords->dboy_lng, 'cart_id'=>$cart_id,'user_name'=>$ords->name, 'user_phone'=>$ords->user_phone, 'remaining_price'=>$ords->rem_price,'delivery_boy_name'=>$ords->boy_name,'delivery_boy_phone'=>$ords->boy_phone,'delivery_date'=>$ords->delivery_date,'time_slot'=>$ords->time_slot,'order_details'=>$details, 'title'=> $title); 
        }
        }
        else{
            $data[]=array('order_details'=>'no orders found');
        }
        return $data;     
        
        
    }




}