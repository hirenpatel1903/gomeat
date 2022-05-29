<?php

namespace App\Http\Controllers\Api;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use App\Traits\SendMail;
use App\Traits\SendSms;

class WishlistController extends Controller
{
   use SendMail; 
   use SendSms;
   public function add_to_wishlist(Request $request)
    {   
        $current = Carbon::now();
        $user_id= $request->user_id;
        $store_id = $request->store_id;
        $varient_id = $request->varient_id;
      
        $created_at = Carbon::now();
        $ph = DB::table('users')
                  ->select('user_phone','wallet')
                  ->where('id',$user_id)
                  ->first();
        $user_phone = $ph->user_phone;
        
    
        $p = DB::table('store_products')
             ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
            ->join('product','product_varient.product_id','=','product.product_id')
           ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
           ->where('store_products.varient_id',$varient_id)
           ->where('store_products.store_id',$store_id)
           ->first();
         if($p->deal_price != NULL &&  $p->valid_from < $current && $p->valid_to > $current){
          $price= round($p->deal_price,0);    
        }else{
      $price = round($p->price,0);
        } 
        
        $mrpprice = $p->mrp;
        $price2= $price;
        $price5=$mrpprice;
     
       $var_image = $p->product_image;
        $n =$p->product_name;
      
        $check = DB::table('wishlist')
            ->where('varient_id',$varient_id)
            ->where('user_id', $user_id)
            ->where('store_id', $store_id)
            ->first();
      
     if(!$check){

        $insert = DB::table('wishlist')
                ->insert([
                        'store_id' => $store_id,
                        'varient_id'=>$varient_id,
                        'product_name'=>$n,
                        'varient_image'=>$var_image,
                        'quantity'=>$p->quantity,
                        'unit'=>$p->unit,
                        'mrp'=>$price5,'description'=>$p->description,
                        'user_id'=>$user_id,
                        'created_at'=>$created_at,
                        'updated_at'=>$created_at,
                        'price'=>$price2]);
                        
  if($insert){
      $count = DB::table('wishlist')
            ->where('user_id', $user_id)
            ->where('store_id', $store_id)
            ->count();
        	$message = array('status'=>'1', 'message'=>'Added to Wishlist', 'wishlist_count'=>$count);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'Something Wents Wrong');
        	return $message;
        }
      
     }
     else{
          $del = DB::table('wishlist')
            ->where('varient_id',$varient_id)
            ->where('user_id', $user_id)
            ->where('store_id', $store_id)
            ->delete();
            
         if($del){
          $count = DB::table('wishlist')
             ->where('user_id', $user_id)
             ->where('store_id', $store_id)
               ->count();
        	$message = array('status'=>'2', 'message'=>'Removed from Wishlist', 'wishlist_count'=>$count);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'Something Wents Wrong', 'data'=>[]);
        	return $message;
        }  
         
     }

 }
 
  public function wishlist_to_cart(Request $request)
    {   
        $current = Carbon::now();
        $user_id= $request->user_id;
        $store_id = $request->store_id;
      
        $data_array = DB::table('wishlist')
              ->where('user_id', $user_id)
              ->where('store_id', $store_id)
              ->get();
           
        $price2=0;
        $price5=0;
        $ph = DB::table('users')
                  ->select('user_phone','wallet')
                  ->where('id',$user_id)
                  ->first();
        $user_phone = $ph->user_phone;
    foreach ($data_array as $h){
       $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$h->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $h->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$h->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $h->price= round($sp->price,0);
            
           }
	 
        
    $cart = DB::table('store_orders')
              ->where('varient_id',$h->varient_id)
              ->where('store_approval',$request->user_id)
              ->where('order_cart_id','incart')
              ->where('store_id',$store_id)
              ->first(); 
   if(!$cart){
      $checkstock = DB::table('store_products')
           ->where('varient_id',$h->varient_id)
           ->where('store_id',$store_id)
           ->first(); 
if($checkstock->stock > 0){
      $qty=1; 
       $varient_id = $h->varient_id;
        $insert = DB::table('store_orders')
                ->insertGetId([
                        'store_id'=> $store_id,
                        'varient_id'=>$varient_id,
                        'qty'=>$qty,
                        'product_name'=>$h->product_name,
                        'varient_image'=>$h->varient_image,
                        'quantity'=>$h->quantity,
                        'unit'=>$h->unit,
                        'total_mrp'=>$h->mrp,
                        'store_approval'=>$user_id,
                        'order_cart_id'=>"incart",
                        'order_date'=>$current,
                        'price'=>$h->price, 
                        'description'=>$h->description]);
	
	$delete = DB::table('wishlist')
                    ->where('user_id',$user_id)
                    ->where('store_id', $store_id)
		            ->where('varient_id',$h->varient_id)
                    ->delete();
    }
   }else{
	    $checkstock = DB::table('store_products')
           ->where('varient_id',$h->varient_id)
           ->where('store_id',$store_id)
           ->first(); 
	   if($checkstock->stock > 0){
		   $delete = DB::table('wishlist')
                    ->where('user_id',$user_id)
                    ->where('store_id', $store_id)
		            ->where('varient_id',$h->varient_id)
                    ->delete();
    }else{
         $cart = DB::table('store_orders')
              ->where('varient_id',$h->varient_id)
              ->where('store_approval',$request->user_id)
              ->where('order_cart_id','incart')
              ->where('store_id',$store_id)
              ->delete(); 
	   }
   }
       
      
 }
 

          
                    
  $store = DB::table('store_orders')
                    ->where('store_approval',$user_id)
                    ->where('order_cart_id', 'incart')
                    ->first();
        if($store){            
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
                $discountper=100-(($cart_itemss->price*100)/$cart_itemss->total_mrp);
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
      
      
        	$message = array('status'=>'1', 'message'=>'Added to cart','data'=>$adata);
        	return $message;     
        }
       else{
           $message = array('status'=>'0', 'message'=>'All wishlisted items is out of stock');
        	return $message;    
       }
 }       
 
   public function show_wishlist(Request $request)
    { 
        $user_id= $request->user_id;
        $store_id= $request->store_id;
         $filter1 = $request->byname;
    $price1 = DB::table('wishlist')
                   ->join('store_products','wishlist.varient_id','=', 'store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                   ->select('store_products.price')
                    ->where('wishlist.user_id',$user_id)
                    ->where('wishlist.store_id', $store_id)
                  ->orderBy('store_products.price','desc')
                  ->first();
    
    $price = $price1->price;
    
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
         $prodsssss = DB::table('wishlist')
                   ->join('store_products','wishlist.varient_id','=', 'store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->Leftjoin('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id')
                     ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                   ->select('wishlist.*', 'store_products.stock', 'product.product_id','product.product_image','product.type')
                    ->where('wishlist.user_id',$user_id)
                    ->where('wishlist.store_id', $store_id)
                     ->whereBetween('store_products.price',[$min_price, $max_price])
                  ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                  ->orderBy('product.product_name',$filter1)
                    ->paginate(10);
          $count = DB::table('wishlist')
            ->where('user_id', $user_id)
            ->where('store_id', $store_id)
            ->count();
	}else{
	   $prodsssss = DB::table('wishlist')
                   ->join('store_products','wishlist.varient_id','=', 'store_products.varient_id')
                      ->join('product_varient','store_products.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->Leftjoin('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id')
                    ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                    ->where('wishlist.user_id',$user_id)
                    ->where('wishlist.store_id', $store_id)
                     ->whereBetween('store_products.price',[$min_price, $max_price])
                  ->havingBetween('avgrating',[$min_rating, $max_rating])
                  ->havingBetween('discountper',[$min_discount, $max_discount])
                  ->where('store_products.stock',$stock,$by)
                    ->paginate(10);
          $count = DB::table('wishlist')
            ->where('user_id', $user_id)
            ->where('store_id', $store_id)
            ->count(); 
	}              
      
    $wishlist_item = $prodsssss->unique('varient_id'); 
         $wishlist_items = NULL;
        foreach($wishlist_item as $store)
        {
               $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$store->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $store->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$store->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $store->price= round($sp->price,0);
            
           }
		     
              if($request->user_id != NULL && $store_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$store->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$store->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
               
                          
                 if($wishlist) {
                   $store->isFavourite='true';  
                 } 
                 else{
                    $store->isFavourite='false'; 
                 }
                 if($cart) {
                    $store->cart_qty=$cart->qty;  
                 } 
                 else{
                    $store->cart_qty=0; 
                 }
                 
                }else{
                $store->isFavourite='false'; 
                 $store->cart_qty=0;
                }
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$store->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$store->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$store->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $store->avgrating=round($rating,0); 
                    $store->countrating=$countrating;
                 } 
                 else{
                     $store->avgrating=0; 
                    $store->countrating=0;
                 }         
                 
                if($store->mrp != 0){
                $discountper=100-(($store->price*100)/$store->mrp);
            $store->discountper=round($discountper,0);
                }else{
                   $store->discountper=0;   
                }
               $store->maxprice=$price;
                   
        
                $wishlist_items[] = $store; 
            
        }                        
        if($wishlist_items != NULL){
            
            
            $message = array('status'=>'1', 'message'=>'Wishlist items','count'=>$count, 'data'=>$wishlist_items );
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'Nothing in Wishlist From This Location');
        	return $message;
        }
        }

}