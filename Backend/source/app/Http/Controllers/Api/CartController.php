<?php

namespace App\Http\Controllers\Api;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use App\Traits\SendMail;
use App\Traits\SendSms;

class CartController extends Controller
{
   use SendMail; 
   use SendSms;
   public function add_to_cart(Request $request)
    {   
        $current = Carbon::now();
        $user_id= $request->user_id;
        $qty = $request->qty;
        $store_id = $request->store_id;
        $varient_id = $request->varient_id;
        $order_status = "incart";
        $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                $val = "";
                for ($i = 0; $i < 4; $i++){
                    $val .= $chars[mt_rand(0, strlen($chars)-1)];
                }
        $chars2 = "0123456789";
                $val2 = "";
                for ($i = 0; $i < 2; $i++){
                    $val2 .= $chars2[mt_rand(0, strlen($chars2)-1)];
                }    
                
        $cart_items = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->first();
      
       if($cart_items){       
        $store_id1 = $cart_items->store_id; 
       
         if ($store_id != $store_id){
            $message = array('status'=>'2', 'message'=>'your previous cart items will be cleared when you are going to order from new store.');
        	return $message; 
            
        }else{
        $cr  = substr(md5(microtime()),rand(0,26),2);
        $cart_id = $val.$val2.$cr;
        $created_at = Carbon::now();
        $ph = DB::table('users')
                  ->select('user_phone','wallet')
                  ->where('id',$user_id)
                  ->first();
        if(!$ph){
            $message = array('status'=>'0', 'message'=>'User not Found');
        	return $message;
        }          
        $user_phone = $ph->user_phone;
        
    
        $p = DB::table('store_products')
             ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
           
          $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
         if($deal){
          $price=round($deal->deal_price,0);    
        }else{
      $price = round($p->price,0);
        } 
        
       
        $mrpprice = $p->mrp;
        $price2= $price*$qty;
         $pricepr= $price*$qty;
        $price5=$mrpprice*$qty;
          $cat=DB::table('categories')
             ->join('categories as cat','categories.cat_id', '=', 'cat.parent' )
             ->select('categories.*')
            ->where('cat.cat_id',$p->cat_id)
            ->first();
        $tax_p = $cat->tax_per;
        $tax_type =$cat->tax_type;
        $tax_name =$cat->tax_name;
        $tax_price = ($pricepr*$tax_p)/100;
        if($tax_type==0){
        $price_without_tax=$pricepr-$tax_price;
        $price2=$pricepr;
        }else{
         $price_without_tax= $pricepr;
         $price2=$pricepr+$tax_price;
        }
        
       $var_image = $p->product_image;
        $n =$p->product_name;
      
        $check = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('order_cart_id', "incart")
            ->first();
      
     if(!$check){

        $insert = DB::table('store_orders')
                ->insert([
                        'store_id' => $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$qty,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'store_approval'=>$user_id,
                        'total_mrp'=>round($price5,0),
                        'order_cart_id'=>"incart",
                        'order_date'=>$created_at,
                        'price'=>round($price2,0),
                        'description'=>$p->description,
                        'tx_per'=>round($tax_p,0),
                        'price_without_tax'=>round($price_without_tax,0),
                        'tx_price'=>round($tax_price,0),
                        'tx_name'=>$tax_name,
                        'type'=>$p->type]);
      
     }
     else{
          $del = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('order_cart_id', "incart")
            ->delete();
     
         $insert = DB::table('store_orders')
                ->insert([
                        'store_id' => $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$qty,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'store_approval'=>$user_id,
                        'total_mrp'=>round($price5,0),
                        'order_cart_id'=>"incart",
                        'order_date'=>$created_at,
                        'price'=>round($price2,0),
                        'description'=>$p->description,
                        'tx_per'=>round($tax_p,0),
                        'price_without_tax'=>round($price_without_tax,0),
                        'tx_price'=>round($tax_price,0),
                        'tx_name'=>$tax_name,
                        'type'=>$p->type]);
         
     }

   
 
  if($insert){
      $del = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('qty', 0)
            ->delete();
      $sum = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->where('store_products.store_id',$store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
            ->select(DB::raw('SUM(store_orders.total_mrp) as mrp'),DB::raw('SUM(store_orders.price) as sum'),DB::raw('COUNT(store_orders.store_order_id) as count'),DB::raw('SUM(store_orders.tx_price) as sum_tax'),DB::raw('SUM(store_orders.tx_per) as sum_per'))
            ->first();
            if($sum->count!=0){
           $tax_per_avg =  $sum->sum_per/$sum->count; 
            }else{
                $tax_per_avg=0;
            }
           $round_pr= round($tax_per_avg,0);
           $taxtotal = round($sum->sum_tax,0);      
            
     $cart_items1 = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                   ->select('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_orders.total_mrp','store_products.price','store_orders.qty as cart_qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type','store_orders.price as ord_price')
                   ->groupBy('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_products.price','store_orders.total_mrp','store_orders.qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type','store_orders.price')
                    ->where('store_products.store_id',$store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
                    ->get();
                 
    foreach ($cart_items1 as $cart_itemss) {
                    $a=0;
         $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$cart_itemss->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $cart_itemss->price= round($deal->deal_price,0);
              $new_price=round($deal->deal_price,0)*$cart_itemss->cart_qty;
              $cur_price= round($cart_itemss->ord_price,0);
             
              if($cur_price != $new_price){
                  $update=DB::table('store_orders')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$user_id)
                          ->where('order_cart_id',"incart")
                          ->update(['price'=>$new_price]);
              }
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$cart_itemss->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $cart_itemss->price= round($sp->price,0);
                $new_price=round($sp->price,0)*$cart_itemss->cart_qty;
              $cur_price= round($cart_itemss->ord_price,0);
             
              if($cur_price != $new_price){
                  $update=DB::table('store_orders')
                  ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$user_id)
                          ->where('order_cart_id',"incart")
                          ->update(['price'=>$new_price]);
              }
           }
              
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('user_id',$request->user_id)
                          ->where('store_id',$store_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
                     
                 
                          
                 if($wishlist) {
                   $cart_itemss->isFavourite='true';  
                 } 
                 else{
                    $cart_itemss->isFavourite='false'; 
                 }
                 if($cart) {
                    $cart_itemss->cart_qty=$cart->qty;  
                 } 
                 else{
                    $cart_itemss->cart_qty=0; 
                 }
                 
                }else{
                $cart_itemss->isFavourite='false'; 
                 $cart_itemss->cart_qty=0;
                }
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $cart_itemss->avgrating=round($rating,0); 
                    $cart_itemss->countrating=$countrating;
                 } 
                 else{
                     $cart_itemss->avgrating=0; 
                    $cart_itemss->countrating=0;
                 }   
                if($cart_itemss->total_mrp != 0){
                $discountper=100-(($cart_itemss->price*$cart_itemss->cart_qty*100)/$cart_itemss->total_mrp);
            $cart_itemss->discountper=round($discountper,0);
                }else{
                   $cart_itemss->discountper=0;   
                }
                // array_push($result, $cart_itemss);
    }                
                    
            $nearbystore = DB::table('store')
                  ->where('id',$store_id)
                  ->first();
         
  
    $datee=date('Y-m-d');

  
  $sum1 = round($sum->sum,0);
  $mrppp=round($sum->mrp,0);
  $discountonmrp=$mrppp-$sum1;
  $discountonmrp=round($discountonmrp,0);
  $adata=array('discountonmrp'=>$discountonmrp,'total_price'=>$sum1,'total_mrp'=>$mrppp,'total_items'=>$sum->count,'store_details'=>$nearbystore,'total_tax'=>$taxtotal,'avg_tax'=>$round_pr, 'data'=>$cart_items1);
     

      
        	$message = array('status'=>'1', 'message'=>'Cart_updated', 'data'=>$adata);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'insertion failed');
        	return $message;
        }
        
        }
       }
    else{
        $cr  = substr(md5(microtime()),rand(0,26),2);
        $cart_id = $val.$val2.$cr;
        $created_at = Carbon::now();
        $ph = DB::table('users')
                  ->select('user_phone','wallet')
                  ->where('id',$user_id)
                  ->first();
        if(!$ph){
            $message = array('status'=>'0', 'message'=>'User not Found');
        	return $message;
        }          
        $user_phone = $ph->user_phone;
        
    
        $p = DB::table('store_products')
             ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
            ->join('product','product_varient.product_id','=','product.product_id')
           ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
           ->where('store_products.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
           
         $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();    
           
         if($deal){
          $price= $deal->deal_price;    
        }else{
         $price = $p->price;
        } 
        
        $mrpprice = $p->mrp;
        $price2= $price*$qty;
        $pricepr= $price*$qty;
        $price5=$mrpprice*$qty;
        $cat=DB::table('categories')
             ->join('categories as cat','categories.cat_id', '=', 'cat.parent' )
             ->select('categories.*')
            ->where('cat.cat_id',$p->cat_id)
            ->first();
         
        $tax_p = $cat->tax_per;
        $tax_type =$cat->tax_type;
        $tax_name =$cat->tax_name;
        $tax_price = ($pricepr*$tax_p)/100;
        $price_without_tax=$pricepr-$tax_price;
         if($tax_type==1){
        $price_without_tax= $pricepr;
         $price2=$pricepr+$tax_price;
        
        }else{
        $price_without_tax=$pricepr-$tax_price;
        $price2=$pricepr;
        }
       $var_image = $p->product_image;
        $n =$p->product_name;
      
        $check = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('order_cart_id', "incart")
            ->first();
      
     if(!$check){

        $insert = DB::table('store_orders')
                ->insert([
                        'store_id' => $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$qty,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'store_approval'=>$user_id,
                        'total_mrp'=>round($price5,0),
                        'order_cart_id'=>"incart",
                        'order_date'=>$created_at,
                        'price'=>round($price2,0),
                        'description'=>$p->description,
                        'tx_per'=>round($tax_p,0),
                        'price_without_tax'=>round($price_without_tax,0),
                        'tx_price'=>round($tax_price,0),
                        'tx_name'=>$tax_name,
                        'type'=>$p->type]);
      
     }
     else{
          $del = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('order_cart_id', "incart")
            ->delete();
     
         $insert = DB::table('store_orders')
                ->insert([
                        'store_id' => $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$qty,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'store_approval'=>$user_id,
                        'total_mrp'=>round($price5,0),
                        'order_cart_id'=>"incart",
                        'order_date'=>$created_at,
                        'price'=>round($price2,0),
                        'description'=>$p->description,
                        'tx_per'=>round($tax_p,0),
                        'price_without_tax'=>round($price_without_tax,0),
                        'tx_price'=>round($tax_price,0),
                        'tx_name'=>$tax_name,
                        'type'=>$p->type]);
         
     }

   
 
  if($insert){
      $del = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('qty', 0)
            ->delete();
       $sum = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->where('store_products.store_id',$store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
            ->select(DB::raw('SUM(store_orders.total_mrp) as mrp'),DB::raw('SUM(store_orders.price) as sum'),DB::raw('COUNT(store_orders.store_order_id) as count'),DB::raw('SUM(store_orders.tx_price) as sum_tax'),DB::raw('SUM(store_orders.tx_per) as sum_per'))
            ->first();
         if($sum->count!=0){
            $tax_per_avg =  $sum->sum_per/$sum->count;  
            }else{
                $tax_per_avg=0;
            }
         
           $round_pr= round($tax_per_avg,0);
           $taxtotal = round($sum->sum_tax,0);      
            
       $cart_items1 = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                   ->select('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_orders.total_mrp','store_products.price','store_orders.qty as cart_qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type','store_orders.price as ord_price')
                   ->groupBy('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_products.price','store_orders.total_mrp','store_orders.qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type','store_orders.price')
                    ->where('store_products.store_id',$store->store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
		              ->orderBy('store_orders.store_order_id','ASC')
                    ->get();
        foreach ($cart_items1 as $cart_itemss) {
                    $a=0;
                
                          $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $cart_itemss->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$cart_itemss->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $cart_itemss->price= round($sp->price,0);
            
           }
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$cart_itemss->varient_id)
                           ->where('store_id',$store_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
              
                 
                          
                 if($wishlist) {
                   $cart_itemss->isFavourite='true';  
                 } 
                 else{
                    $cart_itemss->isFavourite='false'; 
                 }
                 if($cart) {
                    $cart_itemss->cart_qty=$cart->qty;  
                 } 
                 else{
                    $cart_itemss->cart_qty=0; 
                 }
                 
                }else{
                $cart_itemss->isFavourite='false'; 
                 $cart_itemss->cart_qty=0;
                }
                  $getrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $cart_itemss->avgrating=round($rating,0); 
                    $cart_itemss->countrating=$countrating;
                 } 
                 else{
                     $cart_itemss->avgrating=0; 
                    $cart_itemss->countrating=0;
                 }         
                if($cart_itemss->total_mrp != 0){
                $discountper=100-(($cart_itemss->price*$cart_itemss->cart_qty*100)/$cart_itemss->total_mrp);
            $cart_itemss->discountper=round($discountper,0);
                }else{
                   $cart_itemss->discountper=0;   
                }
    }        
   
      $nearbystore = DB::table('store')
                  ->where('id',$store_id)
                  ->first();
         
  
    $datee=date('Y-m-d');

  
  $sum1 = round($sum->sum,0);
  $mrppp=round($sum->mrp,0);
  $discountonmrp=$mrppp-$sum1;
  $discountonmrp=round($discountonmrp,0);
  $adata=array('discountonmrp'=>$discountonmrp,'total_price'=>$sum1,'total_mrp'=>$mrppp,'total_items'=>$sum->count,'store_details'=>$nearbystore,'total_tax'=>$taxtotal,'avg_tax'=>$round_pr, 'data'=>$cart_items1);
      
        	$message = array('status'=>'1', 'message'=>'Cart Updated', 'data'=>$adata);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'insertion failed');
        	return $message;
        }
        
        }
 }
 
  public function make_an_order(Request $request)
    {   
        $current = Carbon::now();
        $user_id= $request->user_id;
        $delivery_date = $request-> delivery_date;
        $time_slot= $request->time_slot;
       
         $ordsssss = DB::table('orders')
             ->where('payment_method', NULL)
             ->where('user_id',$user_id)
             ->get();
         foreach($ordsssss as $ordt){
             DB::table('store_orders')
             ->where('order_cart_id', $ordt->cart_id)
             ->delete();
         } 
         $ordelete = DB::table('orders')
             ->where('payment_method', NULL)
             ->where('user_id',$user_id)
             ->delete();
         
             
        $store =  DB::table('store_orders')
              ->where('store_approval', $user_id)
              ->where('order_cart_id',"incart")
              ->first();
          if($store){    
        $store_id = $store->store_id;
            $store = DB::table('store')
       ->where('id', $store_id)
       ->first();
          }else{
            $message = array('status'=>'0', 'message'=>'No Items in cart');
        	return $message;  
          }
     $dell = $store->del_range;  
    $typessss = DB::table('address')
         ->where('user_id',$user_id)
         ->where('select_status','!=',2)
         ->select('type','address_id',DB::raw("6371 * acos(cos(radians(".$store->lat . ")) 
                    * cos(radians(address.lat)) 
                    * cos(radians(address.lng) - radians(" . $store->lng . ")) 
                    + sin(radians(" .$store->lat. ")) 
                    * sin(radians(address.lat))) AS distancee"))
        ->groupBy('type','address_id','lat','lng')            
         ->Having('distancee','<=',$dell)
        ->orderBy('distancee')
       ->where('select_status',1)
         ->first();
        
        if(!$typessss){
             $message = array('status'=>'0', 'message'=>'you do not have selected an address in delivery range of store please add/select an address in store delivery range');
        	return $message;
        }
        
        $data_array = DB::table('store_orders')
        ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->select('store_orders.*')
              ->where('store_orders.store_approval', $user_id)
              ->where('store_orders.order_cart_id',"incart")
              ->get();
        $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                $val = "";
                for ($i = 0; $i < 4; $i++){
                    $val .= $chars[mt_rand(0, strlen($chars)-1)];
                }
                
        $chars2 = "0123456789";
                $val2 = "";
                for ($i = 0; $i < 2; $i++){
                    $val2 .= $chars2[mt_rand(0, strlen($chars2)-1)];
                }        
        $cr  = substr(md5(microtime()),rand(0,26),2);
        $cart_id = $val.$val2.$cr;
        $ar= DB::table('address')
            ->select('society','city','city_id','society_id','lat','lng','address_id')
            ->where('user_id', $user_id)
            ->where('select_status', 1)
            ->first();
        $ar_id=DB::table('service_area')
              ->where('society_id',$ar->society_id)
              ->where('store_id',$store_id)
              ->first();
       if(!$ar){
           	$message = array('status'=>'0', 'message'=>'Select any Address');
        	return $message;
       }
        $created_at = Carbon::now();
        $price2=0;
        $price5=0;
        $tax_p=0;
        $tax_price=0;
        $pricecheck=0;
        $ph = DB::table('users')
                  ->select('user_phone','wallet')
                  ->where('id',$user_id)
                  ->first();
        $user_phone = $ph->user_phone;
      foreach ($data_array as $h){
        
        $varient_id = $h->varient_id;
        $p = DB::table('store_orders')
            ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
            ->select('store_orders.*','product.cat_id')
            ->where('store_orders.order_cart_id','incart')
           ->where('store_orders.varient_id',$varient_id)
           ->where('store_orders.store_id',$store_id)
           ->where('store_orders.store_approval',$user_id)
           ->first();
       
            $var_image= $p->varient_image; 
      
        $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
        $order_qty = $h->qty;   
         if($deal){
          $price= $deal->deal_price;    
        }else{
      $price = $p->price/$order_qty;
        } 
       
        $mrpprice = $p->total_mrp;
        
        $pricecheck+= $price*$order_qty;
       
        $tax_p+= $p->tx_per;
        $count = DB::table('store_orders')
            ->where('order_cart_id','incart')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->where('store_approval',$user_id)
           ->count();
        $tax_price+=$p->tx_price;
       
      }
      $tax_avg=$tax_p/$count;
      
      $min = DB::table('minimum_maximum_order_value')
           ->where('store_id', $store_id)
           ->first();
    if($min){       
       if($pricecheck<$min->min_value){
           $message = array('status'=>'0', 'message'=>'you have to order between '.$min->min_value.' to '.$min->max_value);
        	return $message;
       }
        if($pricecheck>$min->max_value){
           $message = array('status'=>'0', 'message'=>'you have to order between '.$min->min_value.' to '.$min->max_value);
        	return $message;
       }
    }
    foreach ($data_array as $h){
        
        $varient_id = $h->varient_id;
        $p = DB::table('store_orders')
           ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->select('store_orders.*','store_products.min_ord_qty','store_products.max_ord_qty','product.cat_id')
           ->where('store_orders.varient_id',$varient_id)
           ->where('store_orders.store_id',$store_id)
           ->where('store_orders.order_cart_id','incart')
            ->where('store_orders.store_approval',$user_id)
           ->first();

            $var_image= $p->varient_image; 
      
       $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
         $order_qty = $h->qty;  
         if($deal){
          $price= $deal->deal_price;    
        }else{
      $price = $p->price/$order_qty;
        } 
        if($order_qty < $p->min_ord_qty){
           
            $p_name = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
           $message = array('status'=>'0', 'message'=>'you have to order '.$p_name.' quantity between '.$p->min_ord_qty.' to '.$p->max_ord_qty);
        	return $message;
       }
        if($order_qty >$p->max_ord_qty){
            $p_name = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
           $message = array('status'=>'0', 'message'=>'you have to order '.$p_name.' quantity between '.$p->min_ord_qty.' to '.$p->max_ord_qty);
        	return $message;
      }
        $mrpprice = $p->total_mrp;
        
       
        $price5+=$mrpprice;
        $unit[] = $p->unit;
        $qty[]= $p->quantity;
        $p_name[] = $p->product_name."(".$p->quantity.$p->unit.")*".$order_qty;
        $prod_name = implode(',',$p_name);
        $n =$p->product_name;
       $total_mrp = $p->total_mrp;
        $price1 = $price*$order_qty;
         $price2+= $price1;
         $cat=DB::table('categories')
             ->join('categories as cat','categories.cat_id', '=', 'cat.parent' )
             ->select('categories.*')
            ->where('cat.cat_id',$p->cat_id)
            ->first();
        $tax_p = $cat->tax_per;
        $tax_type =$cat->tax_type;
        $tax_name =$cat->tax_name;
        $tax_price = ($price2*$tax_p)/100;
        if($tax_type==0){
        $price_without_tax=$price2-$tax_price;
        $price2=$price2;
        }else{
         $price_without_tax= $price2;
         $price2=$price2+$tax_price;
        }
        $insert = DB::table('store_orders')
                ->insertGetId([
                        'store_id'=> $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$order_qty,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'total_mrp'=>$total_mrp,
                        'order_cart_id'=>$cart_id,
                        'order_date'=>$created_at,
                        'price'=>$price1,
                        'description'=>$p->description,
                        'type'=>$p->type]);
      
 }
 $ar_id=DB::table('service_area')
              ->where('society_id',$ar->society_id)
              ->where('store_id',$store_id)
              ->first();
 $delcharge=DB::table('freedeliverycart')
           ->where('store_id', $store_id)
           ->first();
           
  if($delcharge && $ar_id){         
if ($delcharge->min_cart_value <= $price2){
    $charge=0;
}  
else{
    $charge =$ar_id->delivery_charge;
}
  }else{
      $charge=0;
  }
  
   if($time_slot == "instant"){
         $datee=date('Y-m-d');
     $checkmem = DB::table('users')
               ->where('id',$user_id)
               ->whereDate('mem_plan_expiry','>=',$datee)
               ->first();
    if($checkmem){           
           $plan = DB::table('membership_plan')
                 ->where('plan_id',$checkmem->membership)
                 ->first();
                 
             if($plan->free_delivery==1){
                  $charge=0;
             }    
              if($plan->instant_delivery==1){
                  $time_slot='instant';
                  $delivery_date = date('Y-m-d');
             }    
    }else{
          $message = array('status'=>'5', 'message'=>'Please buy a membership for use instant delivery/free delivery feature');
        	return $message;
    }
    }
  
  if($insert){
        $oo = DB::table('orders')
            ->insertGetId(['cart_id'=>$cart_id,
            'total_price'=>round(($price2 + $charge),0),
            'price_without_delivery'=>round($price2,0),
            'total_products_mrp'=>round($price5,0),
            'delivery_charge'=>round($charge,0),
            'user_id'=>$user_id,
            'store_id'=>$store_id,
            'rem_price'=>round(($price2 + $charge),0),
            'order_date'=> $created_at,
            'delivery_date'=> $delivery_date,
            'time_slot'=>$time_slot,
            'address_id'=>$ar->address_id,
            'avg_tax_per'=>round($tax_avg,0),
            'total_tax_price'=>round($tax_price,0)]); 
                    
           $ordersuccessed = DB::table('orders')
                           ->where('order_id',$oo)
                           ->first();
                           
             $ordersuccessed->discountonmrp=$ordersuccessed->total_products_mrp -$ordersuccessed->price_without_delivery;              
          
        	$message = array('status'=>'1', 'message'=>'Proceed to payment', 'data'=>$ordersuccessed );
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'insertion failed');
        	return $message;
        }
       
 }       
 
   public function show_cart(Request $request)
    { 
        $user_id= $request->user_id;
        $cart_items = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->get();
       
                        
        if(count($cart_items)>0){
             $store = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->first();
             $sum = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->where('store_products.store_id',$store->store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
            ->select(DB::raw('SUM(store_orders.total_mrp) as mrp'),DB::raw('SUM(store_orders.price) as sum'),DB::raw('COUNT(store_orders.store_order_id) as count'),DB::raw('SUM(store_orders.tx_price) as sum_tax'),DB::raw('SUM(store_orders.tx_per) as sum_per'))
            ->first();
            
           $tax_per_avg =  $sum->sum_per/$sum->count; 
           $round_pr= round($tax_per_avg,0);
           $taxtotal = round($sum->sum_tax,0);
           
        $cart_items1 = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                   ->select('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_orders.total_mrp','store_products.price','store_orders.qty as cart_qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type','store_orders.price as ord_price')
                   ->groupBy('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_products.price','store_orders.total_mrp','store_orders.qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type','store_orders.price')
                    ->where('store_products.store_id',$store->store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
                    ->get();
                 
    foreach ($cart_items1 as $cart_itemss) {
                    $a=0;
         $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$cart_itemss->varient_id)
           ->where('store_id',$store->store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $cart_itemss->price= round($deal->deal_price,0);
              $new_price=round($deal->deal_price,0)*$cart_itemss->cart_qty;
              $cur_price= round($cart_itemss->ord_price,0);
             
              if($cur_price != $new_price){
                  $update=DB::table('store_orders')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$user_id)
                          ->where('order_cart_id',"incart")
                          ->update(['price'=>$new_price]);
              }
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$cart_itemss->varient_id)
           ->where('store_id',$store->store_id)
           ->first();   
               $cart_itemss->price= round($sp->price,0);
                $new_price=round($sp->price,0)*$cart_itemss->cart_qty;
              $cur_price= round($cart_itemss->ord_price,0);
             
              if($cur_price != $new_price){
                  $update=DB::table('store_orders')
                  ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$user_id)
                          ->where('order_cart_id',"incart")
                          ->update(['price'=>$new_price]);
              }
           }
              
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('user_id',$request->user_id)
                          ->where('store_id',$store->store_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store->store_id)
                          ->first(); 
                     
                 
                          
                 if($wishlist) {
                   $cart_itemss->isFavourite='true';  
                 } 
                 else{
                    $cart_itemss->isFavourite='false'; 
                 }
                 if($cart) {
                    $cart_itemss->cart_qty=$cart->qty;  
                 } 
                 else{
                    $cart_itemss->cart_qty=0; 
                 }
                 
                }else{
                $cart_itemss->isFavourite='false'; 
                 $cart_itemss->cart_qty=0;
                }
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store->store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store->store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store->store_id)
                          ->avg('rating'); 
                    $cart_itemss->avgrating=round($rating,0); 
                    $cart_itemss->countrating=$countrating;
                 } 
                 else{
                     $cart_itemss->avgrating=0; 
                    $cart_itemss->countrating=0;
                 }   
                if($cart_itemss->total_mrp != 0){
                $discountper=100-(($cart_itemss->price*$cart_itemss->cart_qty*100)/$cart_itemss->total_mrp);
            $cart_itemss->discountper=round($discountper,0);
                }else{
                   $cart_itemss->discountper=0;   
                }
                // array_push($result, $cart_itemss);
    }                
                    
            $nearbystore = DB::table('store')
                  ->where('id',$store->store_id)
                  ->first();
         
  
    $datee=date('Y-m-d');

  
  $sum1 = round($sum->sum,0);
  $mrppp=round($sum->mrp,0);
  $discountonmrp=$mrppp-$sum1;
  $discountonmrp=round($discountonmrp,0);
  $adata=array('discountonmrp'=>$discountonmrp,'total_price'=>$sum1,'total_mrp'=>$mrppp,'total_items'=>$sum->count,'store_details'=>$nearbystore,'total_tax'=>$taxtotal,'avg_tax'=>$round_pr, 'data'=>$cart_items1);
            
            $message = array('status'=>'1', 'message'=>'cart_items','data'=>$adata);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'No Items in Cart');
        	return $message;
        }
        }
        
  public function del_frm_cart(Request $request)
    { 
        $user_id= $request->user_id;
        $store_id = $request->store_id;
        $varient_id = $request->varient_id;
        $cart_items = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->where('varient_id', $varient_id)
                    ->delete();
         
                        
        if($cart_items){
            $cart_items2 = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->get();
              $sum = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->where('store_products.store_id',$store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
            ->select(DB::raw('SUM(store_orders.total_mrp) as mrp'),DB::raw('SUM(store_orders.price) as sum'),DB::raw('COUNT(store_orders.store_order_id) as count'),DB::raw('SUM(store_orders.tx_price) as sum_tax'),DB::raw('SUM(store_orders.tx_per) as sum_per'))
            ->first();
            
           $tax_per_avg =  $sum->sum_per/$sum->count; 
           $round_pr= round($tax_per_avg,0);
           $taxtotal = round($sum->sum_tax,0);
            
          
  $datee=date('Y-m-d');
   
   $sum1 = round($sum->sum,0);
   $discountonmrp=$sum->mrp-$sum1;
   $discountonmrp=round($discountonmrp,0);
   $data=array('discountonmrp'=>$discountonmrp,'total_price'=>$sum1,'total_items'=>$sum->count, 'data'=>$cart_items2,'total_tax'=>$taxtotal,'avg_tax'=>$round_pr, 'data'=>$cart_items1);
   
            $message = array('status'=>'1', 'message'=>'Product has been removed from cart', 'data'=>$data);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'insertion failed');
        	return $message;
        }
        }      
        
   public function check_cart(Request $request)
    { 
        $user_id= $request->user_id;
        $store_id = $request->store_id;
        $cart_items = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->get();
        if(count($cart_items)>0){
        $store =  DB::table('store_orders')
              ->where('store_approval', $user_id)
              ->where('order_cart_id',"incart")
              ->first();
              
        $store_id1 = $store->store_id;
    
        if ($store_id != $store_id){
            $message = array('status'=>'1', 'message'=>'your previous cart items will be cleared when you are going to order from new store.');
        	return $message; 
            
        }
        else{
             $message = array('status'=>'0', 'message'=>'enter to store');
        	return $message; 
        }
        }else{
              $message = array('status'=>'0', 'message'=>'enter to store');
        	return $message; 
        }
        }
        
        
     public function clear_cart(Request $request)
    { 
        $user_id= $request->user_id;
        $cart_items = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->delete();
        
    
        if ($cart_items){
            $message = array('status'=>'1', 'message'=>'your cart has been cleared.');
        	return $message; 
            
        }
        else{
             $message = array('status'=>'0', 'message'=>'nothing in cart');
        	return $message; 
        }
        }    
         
   
    public function re_ordercart(Request $request)
    {   
        $current = Carbon::now();
        $cart_id=$request->cart_id;
        $user_id=$request->user_id;
        $created_at = Carbon::now();
         $orde = DB::table('orders')
            ->where('cart_id',$cart_id)
             ->first();
           if($orde){    
        $store_id = $orde->store_id;
            $store = DB::table('store')
       ->where('id', $store_id)
       ->first();
          }else{
            $message = array('status'=>'0', 'message'=>'No Cart Found');
        	return $message;  
          }
             
        $store_orders =  DB::table('store_orders')
             ->where('order_cart_id',$cart_id)
              ->get();
        
          
        $order_status = "incart";
       foreach($store_orders as $h){
           
        $varient_id = $h->varient_id;
        $p = DB::table('store_products')
             ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
            ->join('product','product_varient.product_id','=','product.product_id')
           ->where('store_products.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
           $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();   
           
         if($deal){
          $price= $deal->deal_price;    
        }else{
      $price = $p->price;
        } 
        
       $qty=$h->qty;
        $mrpprice = $p->mrp;
        $price2= $price*$qty;
         $pricepr= $price*$qty;
        $price5=$mrpprice*$qty;
         $cat=DB::table('categories')
             ->join('categories as cat','categories.cat_id', '=', 'cat.parent' )
             ->select('categories.*')
            ->where('cat.cat_id',$p->cat_id)
            ->first();
        $tax_p = $cat->tax_per;
        $tax_type =$cat->tax_type;
        $tax_name =$cat->tax_name;
        $tax_price = ($pricepr*$tax_p)/100;
        if($tax_type==0){
        $price_without_tax=$pricepr-$tax_price;
        $price2=$pricepr;
        }else{
         $price_without_tax= $pricepr;
         $price2=$pricepr+$tax_price;
        }
        
       $var_image = $p->product_image;
        $n =$p->product_name;
        if($h->qty <= $p->stock){
        $check = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('order_cart_id', "incart")
            ->first();
      
     if(!$check){

        $insert = DB::table('store_orders')
                ->insert([
                        'store_id' => $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$qty,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'store_approval'=>$user_id,
                        'total_mrp'=>$price5,
                        'order_cart_id'=>"incart",
                        'order_date'=>$created_at,
                        'price'=>$price2,
                        'description'=>$p->description,
                        'tx_per'=>$tax_p,
                        'price_without_tax'=>$price_without_tax,
                        'tx_price'=>$tax_price,
                        'tx_name'=>$tax_name,
                        'type'=>$p->type]);
      
     }
     else{
          $del = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('order_cart_id', "incart")
            ->delete();
     
         $insert = DB::table('store_orders')
                ->insert([
                        'store_id' => $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$qty,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'store_approval'=>$user_id,
                        'total_mrp'=>$price5,
                        'order_cart_id'=>"incart",
                        'order_date'=>$created_at,
                        'price'=>$price2,
                        'description'=>$p->description,
                        'tx_per'=>$tax_p,
                        'price_without_tax'=>$price_without_tax,
                        'tx_price'=>$tax_price,
                        'tx_name'=>$tax_name,
                        'type'=>$p->type]);
         
     }
  }
}
   
 
  if($insert){
      $del = DB::table('store_orders')
            ->where('store_approval',$user_id)
            ->where('varient_id',$varient_id)
            ->where('qty', 0)
            ->delete();
      $sum = DB::table('store_orders')
                     ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->where('store_products.store_id',$store_id)
                    ->where('store_orders.store_approval',$user_id)
                    ->where('store_orders.order_cart_id', 'incart')
            ->select(DB::raw('SUM(store_orders.total_mrp) as mrp'),DB::raw('SUM(store_orders.price) as sum'),DB::raw('COUNT(store_orders.store_order_id) as count'),DB::raw('SUM(store_orders.tx_price) as sum_tax'),DB::raw('SUM(store_orders.tx_per) as sum_per'))
            ->first();
            
           $tax_per_avg =  $sum->sum_per/$sum->count; 
           $round_pr= round($tax_per_avg,0);
           $taxtotal = round($sum->sum_tax,0);      
            
      $cart_items1 = DB::table('store_orders')
             ->join('store_products', 'store_orders.varient_id','=','store_products.varient_id')
              ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
            ->join('product','product_varient.product_id','=','product.product_id')
           ->select('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_products.price','store_orders.qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type')
            ->groupBy('store_orders.product_name','store_orders.varient_image','store_orders.quantity','store_orders.unit','store_products.price','store_orders.qty','store_orders.total_mrp','store_orders.order_cart_id','store_orders.order_date','store_orders.store_approval','store_orders.store_id','store_orders.varient_id','product.product_id', 'store_products.stock','store_orders.tx_per','store_orders.price_without_tax','store_orders.tx_price','store_orders.tx_name','product.product_image','product_varient.description','product.type')
            ->where('store_products.store_id',$store_id)
            ->where('store_orders.store_approval',$user_id)
            ->where('store_orders.order_cart_id', "incart")
            ->get();
        foreach ($cart_items1 as $cart_itemss) {
                    $a=0;
                
                
              if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$cart_itemss->varient_id)
                           ->where('store_id',$store_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
                   
                 
                          
                 if($wishlist) {
                   $cart_itemss->isFavourite='true';  
                 } 
                 else{
                    $cart_itemss->isFavourite='false'; 
                 }
                 if($cart) {
                    $cart_itemss->cart_qty=$cart->qty;  
                 } 
                 else{
                    $cart_itemss->cart_qty=0; 
                 }
                 
                }else{
                $cart_itemss->isFavourite='false'; 
                 $cart_itemss->cart_qty=0;
                }
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$cart_itemss->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $cart_itemss->avgrating=round($rating,0); 
                    $cart_itemss->countrating=$countrating;
                 } 
                 else{
                     $cart_itemss->avgrating=0; 
                    $cart_itemss->countrating=0;
                 }     
                if($cart_itemss->total_mrp != 0){
                $discountper=100-(($cart_itemss->price*100)/$cart_itemss->total_mrp);
            $cart_itemss->discountper=round($discountper,0);
                }else{
                   $cart_itemss->discountper=0;   
                }
    }        
   
      $nearbystore = DB::table('store')
                  ->where('id',$store_id)
                  ->first();
         
  
    $datee=date('Y-m-d');

  
  $sum1 = round($sum->sum,0);
  $mrppp=round($sum->mrp,0);
  $discountonmrp=$mrppp-$sum1;
  $discountonmrp=round($discountonmrp,0);
  $adata=array('discountonmrp'=>$discountonmrp,'total_price'=>$sum1,'total_mrp'=>$mrppp,'total_items'=>$sum->count,'store_details'=>$nearbystore,'total_tax'=>$taxtotal,'avg_tax'=>$round_pr, 'data'=>$cart_items1);
     
     

      
        	$message = array('status'=>'1', 'message'=>'Added order Products to cart which are available in stock', 'data'=>$adata);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'insertion failed');
        	return $message;
        }
        
}
    
 
   
   
   
   
}