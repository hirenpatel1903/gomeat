<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use App\Traits\SendMail;
use App\Traits\SendSms;
use App\Traits\SendInapp;
class StoreorderController extends Controller
{
  use SendMail; 
   use SendSms;
   use SendInapp;
 public function nextdayorders(Request $request)
     {
         $date = date('Y-m-d');
         $day = 1;
         $next_date = date('Y-m-d', strtotime($date.' + '.$day.' days'));
         $store_id = $request->store_id;
         $store= DB::table('store')
    	 		   ->where('id',$store_id)
    	 		   ->first();
    	 		   
        $ord =DB::table('orders')
             ->leftJoin('users', 'orders.user_id', '=','users.id')
             ->leftJoin('address','orders.address_id','=','address.address_id')
			 ->leftJoin('delivery_boy', 'orders.dboy_id', '=','delivery_boy.dboy_id')
             ->select('orders.cart_id','orders.paid_by_wallet','orders.coupon_discount', 'orders.delivery_charge','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot','orders.order_status','orders.payment_method','users.user_phone','address.*')
             ->where('orders.store_id',$store_id)
             ->where('payment_method', '!=', NULL)
             ->where('orders.delivery_date',$next_date)
             ->where('orders.order_status','!=','cancelled')
			->orderByRaw("FIELD(order_status , 'Pending', 'Confirmed', 'Out_For_Delivery', 'Completed') ASC")
             ->get();
       
       if(count($ord)>0){
      foreach($ord as $ords){
             $cart_id = $ords->cart_id;    
         $details  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->get(); 
                  
        
        $data[]=array('paid_by_wallet'=>$ords->paid_by_wallet,'coupon_discount'=>$ords->coupon_discount,'delivery_charge'=>$ords->delivery_charge,'user_address'=>$ords->house_no.','.$ords->society.','.$ords->city.','.$ords->landmark.','.$ords->state.','.$ords->pincode, 'cart_id'=>$cart_id,'user_name'=>$ords->name, 'user_phone'=>$ords->user_phone, 
        'remaining_price'=>$ords->rem_price,'order_price'=>$ords->total_price,'delivery_boy_name'=>$ords->boy_name,'delivery_boy_phone'=>$ords->boy_phone,'delivery_date'=>$ords->delivery_date,'time_slot'=>$ords->time_slot,'payment_mode'=>$ords->payment_method,  'payment_status'=>$ords->payment_status,'order_status'=>$ords->order_status, 'customer_phone'    =>$ords->user_phone,'order_details'=>$details); 
        }
        }
        else{
            $data[]=array('order_details'=>'no orders found');
        }
        return $data;     
    }          
    
    
 public function todayorders(Request $request)
     {
         $date = date('Y-m-d');
         $store_id = $request->store_id;
         $store= DB::table('store')
    	 		   ->where('id',$store_id)
    	 		   ->first();
    	 		   
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->leftJoin('address','orders.address_id','=','address.address_id')
             ->leftJoin('delivery_boy', 'orders.dboy_id', '=','delivery_boy.dboy_id')
             ->select('orders.cart_id','orders.paid_by_wallet','orders.coupon_discount', 'orders.delivery_charge','users.name', 'users.user_phone', 'orders.delivery_date', 'orders.total_price','orders.delivery_charge','orders.rem_price','orders.payment_status','delivery_boy.boy_name','delivery_boy.boy_phone','orders.time_slot','orders.order_status','orders.payment_method','users.user_phone','address.*')
             ->where('orders.store_id',$store_id)
			->where('orders.delivery_date', $date)
             ->where('payment_method', '!=', NULL)
              ->where('orders.order_status','!=','cancelled')
			->orderByRaw("FIELD(order_status , 'Pending', 'Confirmed', 'Out_For_Delivery', 'Completed') ASC")
             ->get();
       
       if(count($ord)>0){
      foreach($ord as $ords){
             $cart_id = $ords->cart_id;    
         $details  =   DB::table('store_orders')
    	               ->where('order_cart_id',$cart_id)
    	               ->where('store_approval',1)
    	               ->get(); 
                  
        
        $data[]=array('paid_by_wallet'=>$ords->paid_by_wallet,'coupon_discount'=>$ords->coupon_discount,'delivery_charge'=>$ords->delivery_charge,'user_address'=>$ords->house_no.','.$ords->society.','.$ords->city.','.$ords->landmark.','.$ords->state.','.$ords->pincode, 'cart_id'=>$cart_id,'user_name'=>$ords->name, 'user_phone'=>$ords->user_phone, 
        'remaining_price'=>$ords->rem_price,'order_price'=>$ords->total_price,'delivery_boy_name'=>$ords->boy_name,'delivery_boy_phone'=>$ords->boy_phone,'delivery_date'=>$ords->delivery_date,'time_slot'=>$ords->time_slot,'payment_mode'=>$ords->payment_method, 'payment_status'=>$ords->payment_status,'order_status'=>$ords->order_status, 'customer_phone'    =>$ords->user_phone,'order_details'=>$details); 
        }
        }
        else{
            $data[]=array('order_details'=>'no orders found');
        }
        return $data;     
    }      
            
  public function productcancelled(Request $request)
    {
       $id= $request->store_order_id;
       $cart = DB::table('store_orders')
            ->select('order_cart_id','varient_id','qty')
            ->where('store_order_id', $id)
            ->first();
          $curr = DB::table('currency')
            ->first();
      $cart_id = $cart->order_cart_id;
      $st = DB::table('orders')
            ->where('cart_id',$cart_id)
            ->first();	
		$store_id = $st->store_id;
      $var = DB::table('store_orders')
    ->where('order_cart_id', $cart_id)
    ->get();
       $price2 = 0;
     
     foreach ($var as $h){
        $varient_id = $h->varient_id;
         $p = DB::table('store_products')
            ->join('product_varient','store_products.varient_id','=','product_varient.varient_id') 
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
        $price = $p->price;
        $mrpprice = $p->mrp;
        $order_qty = $h->qty;
        $price2+= $price*$order_qty;
        $unit[] = $p->unit;
        $qty[]= $p->quantity;
        $p_name[] = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
        $prod_name = implode(',',$p_name);
        }    
       $v = DB::table('store_products')
            ->join('product_varient','store_products.varient_id','=','product_varient.varient_id') 
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
       
       $v_price =$v->price * $cart->qty;       
      $ordr = DB::table('orders')
            ->where('cart_id', $cart->order_cart_id)
            ->first();
       $user_id = $ordr->user_id;
       $userwa = DB::table('users')
                     ->where('id',$user_id)
                     ->first();
     if($ordr->payment_method == 'COD' || $ordr->payment_method == 'Cod' || $ordr->payment_method == 'cod'){          
        $newbal = $userwa->wallet;   
      }
      else{
        $newbal = $userwa->wallet + $v_price;  
      }             
       $orders = DB::table('store_orders')
            ->where('order_cart_id', $cart->order_cart_id)
            ->where('store_approval',1)
            ->get();   
       
        if(count($orders)==1 || count($orders)==0){
         $email=Session::get('bamaStore');
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
   
    
            $cancel=2;
             $ordupdate = DB::table('orders')
                     ->where('cart_id', $cart->order_cart_id)
                     ->update(['store_id'=>0,
                     'cancel_by_store'=>$cancel]);
             $carte= DB::table('store_orders')
            ->where('order_cart_id', $cart->order_cart_id)
            ->where('store_approval',0)
            ->get();
            
            foreach($carte as $carts){
                $v1 = DB::table('store_products')
            ->join('product_varient','store_products.varient_id','=','product_varient.varient_id') 
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
               
               $v_price1 =$v1->price * $carts->qty;       
               $ordr1 = DB::table('orders')
                    ->where('cart_id', $carts->order_cart_id)
                    ->first();
               $user_id1 = $ordr1->user_id;
               $userwa1 = DB::table('users')
                             ->where('id',$user_id1)
                             ->first();
                $newbal1 = $userwa1->wallet - $v_price1;
                 $userwalletupdate = DB::table('users')
                     ->where('id',$user_id1)
                     ->update(['wallet'=>$newbal1]);
            }    
            
            $cart_update= DB::table('store_orders')
            ->where('order_cart_id', $cart->order_cart_id)
            ->update(['store_approval'=>1]);
        $data[]=array('result'=>'order cancelled successfully');
       
         
        }    
            
        else{    
       $cancel_product = DB::table('store_orders')
                       ->where('store_order_id', $id)
                       ->update(['store_approval'=>0]);
         $userwallet = DB::table('users')
                     ->where('id',$user_id)
                     ->update(['wallet'=>$newbal]);
         $data[]=array('result'=>'product cancelled successfully');                  
                       
        }             
       return $data;            
    }





      public function order_rejected(Request $request)
    {
       $cart_id= $request->cart_id;
       $store_id = $request->store_id;
       
      $ordr = DB::table('orders')
            ->where('cart_id', $cart_id)
            ->first();
        $curr = DB::table('currency')
             ->first();
       $orders = DB::table('store_orders')
            ->where('order_cart_id', $cart_id)
            ->where('store_approval',1)
            ->get(); 
         $var = DB::table('store_orders')
            ->where('order_cart_id', $cart_id)
            ->where('store_approval',1)
            ->get();        
    	 $store= DB::table('store')
    	 		   ->where('id',$store_id)
    	 		   ->first();
    	             
        $v_price1 = 0;
        $cartss= DB::table('store_orders')
            ->where('order_cart_id', $cart_id)
            ->where('store_approval',0)
            ->get();
            
      if(count($cartss)>0){
          foreach($cartss as $carts){
                $v1 = DB::table('store_orders')
               ->where('store_order_id', $carts->store_order_id)
               ->first();
               
               $v_price1 += $v1->price * $v1->qty;       
              
            }      
         $user_id1 = $ordr->user_id;
         $userwa1 = DB::table('users')
                     ->where('id',$user_id1)
                     ->first();
       if($ordr->payment_method == 'COD' || $ordr->payment_method == 'Cod' || $ordr->payment_method == 'cod'){
            $newbal1 = $userwa1->wallet;   
          }
          else{
            $newbal1 = $userwa1->wallet - $v_price1;
          }                 
         $userwalletupdate = DB::table('users')
             ->where('id',$user_id1)
             ->update(['wallet'=>$newbal1]);
       }     		   
    	 		   
    	 		   
        $price2 = 0;     
       foreach ($var as $h){
        $varient_id = $h->varient_id;
       $p = DB::table('store_products')
            ->join('product_varient','store_products.varient_id','=','product_varient.varient_id') 
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$varient_id)
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
            $cancel=2;
             $ordupdate = DB::table('orders')
                     ->where('cart_id', $cart_id)
                     ->update(['store_id'=>0,
                     'cancel_by_store'=>$cancel]);
            
             $carte= DB::table('store_orders')
            ->where('order_cart_id', $cart_id)
            ->where('store_approval',0)
            ->get();
            $cart_update= DB::table('store_orders')
            ->where('order_cart_id', $cart_id)
            ->update(['store_approval'=>1]);
        $data[]=array('result'=>'Order Rejected successfully');
        return $data;
                       
                    
    }
    
    

   public function storeconfirm(Request $request)
    {
       $cart_id= $request->cart_id;
       $store_id = $request->store_id;
      $currdate = Carbon::now();
       $curr = DB::table('currency')
             ->first();
       
     $store= DB::table('store')
        	->where('id',$store_id)
    	 	->first();
             
      $del_boy = DB::table('delivery_boy')
          ->select("boy_name","boy_phone","dboy_id"
        ,DB::raw("6371 * acos(cos(radians(".$store->lat . ")) 
        * cos(radians(lat)) 
        * cos(radians(lng) - radians(" . $store->lng . ")) 
        + sin(radians(" .$store->lat. ")) 
        * sin(radians(lat))) AS distance"))
       ->where('delivery_boy.boy_city',$store->city)    
       ->orderBy('distance')
       ->first();         
       $getDDevice =  $del_boy;
        $orr =   DB::table('orders')
                ->where('cart_id',$cart_id)
                ->first();
           $users = DB::table('users')
                  ->where('id', $orr->user_id)
                  ->first();
            $user_phone = $users->user_phone;      
           $v = DB::table('store_orders')
 		   ->where('order_cart_id',$cart_id)
 		   ->get(); 
          foreach($v as $vs){
                $qt = $vs->qty;
                $pr = DB::table('store_products')
            ->join('product_varient','store_products.varient_id','=','product_varient.varient_id') 
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$vs->varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
                    
                 $stoc = DB::table('store_products')
                    ->where('varient_id',$vs->varient_id)
                    ->where('store_id',$store_id) 
                    ->first();
              if($stoc){     
                $newstock = $stoc->stock - $qt;     
                $st = DB::table('store_products')
                    ->where('varient_id',$vs->varient_id)
                    ->where('store_id',$store_id)
                    ->update(['stock'=>$newstock]);
              }
              else{
                  $message = array('status'=>'0', 'message'=>$pr->product_name."(".$pr->quantity." ".$pr->unit.") is not available in your product list");
	              return $message;
              }
             }        
    if($del_boy){   
       $orderconfirm = DB::table('orders')
                    ->where('cart_id',$cart_id)
                    ->update(['order_status'=>'Confirmed',
                    'dboy_id'=>$del_boy->dboy_id,
                     'confirmed_at' => $currdate]);
         
 		   
         if($orderconfirm){
                $sms = DB::table('notificationby')
                       ->select('sms','app')
                       ->where('user_id',$orr->user_id)
                       ->first();
            $sms_status = $sms->sms;
                if($sms_status == 1){
                $codorderplaced = $this->orderconfirmedsms($cart_id,$user_phone,$orr);
                }

            if($sms->app == 1){
                
                 $confirmedinappuser = $this->orderconfirmedinapp($cart_id,$user_phone,$orr);
             
            }
           
            
             $confirmedinappdriver = $this->orderconfirmedinappdriver($getDDevice,$cart_id,$user_phone,$orr,$curr);
           
              $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                         ->first();
            if($cart_status){             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                        ->update(['confirm'=>Carbon::now()]);
            }
        	$message = array('status'=>'1', 'message'=>'order is confirmed');
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'something went wrong');
	        return $message;
    	} 
    }
    else{
        	$message = array('status'=>'0', 'message'=>'No Delivery Boy in Your City');
	        return $message;
    }
    }
    
    
    
    public function store_order_history(Request $request)
    {
    //   $user_id = $request->user_id;
      $store_id = $request->store_id;
      $completeds = DB::table('orders')
              ->join('users','orders.user_id','=','users.id')
               ->leftJoin('delivery_boy', 'orders.dboy_id', '=', 'delivery_boy.dboy_id')
            //   ->where('orders.user_id',$user_id)
              ->where('orders.store_id',$store_id)
              ->where('orders.order_status', 'Completed')
              ->get();
              
        $total_earnings=DB::table('store')
                           ->join('orders','store.id','=','orders.store_id')
                           ->leftJoin('store_earning','store.id','=','store_earning.store_id')
                           ->select('store_earning.paid',DB::raw('SUM(orders.price_without_delivery)-SUM(orders.price_without_delivery)*(store.admin_share)/100 as sumprice'))
                           ->groupBy('store_earning.paid','store.admin_share')
                           ->where('orders.order_status','Completed')
                           ->where('store.id',$store_id)
                           ->first();
          
 


     
        if($total_earnings){                  
            $sum = $total_earnings->sumprice;
        }
            else{
               $sum = 0; 
               $admin_share = 0;
            }
      if(count($completeds)>0){
      foreach($completeds as $completed){
      $order = DB::table('store_orders')
              ->where('order_cart_id',$completed->cart_id)
              ->orderBy('order_date', 'DESC')
              ->get();
                  
        
        $data[]=array('user_name'=>$completed->name,'order_status'=>$completed->order_status, 'delivery_date'=>$completed->delivery_date, 'time_slot'=>$completed->time_slot,'payment_method'=>$completed->payment_method,'payment_status'=>$completed->payment_status,'paid_by_wallet'=>$completed->paid_by_wallet, 'cart_id'=>$completed->cart_id ,'price'=>$completed->total_price,'del_charge'=>$completed->delivery_charge,'remaining_amount'=>$completed->rem_price,'coupon_discount'=>$completed->coupon_discount,'dboy_name'=>$completed->boy_name,'dboy_phone'=>$completed->boy_phone, 'data'=>$order); 
        }
        }
        else{
            $data=array('data'=>[]);
        }
        	$message = array('total_revenue'=>$sum,'data'=>$data);
	        return $message;      
                  
                  
  }     


}