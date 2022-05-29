<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class SearchController extends Controller
{
 
    public function search(Request $request)
    { 
        $ean_code = $request->ean_code;
        if($ean_code == NULL){
             $message = array('status'=>'0', 'message'=>'Not able to scan any barcode');
            return $message;
        }
         $store_id = $request->store_id;
         $prod =  DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
            ->where('product_varient.ean',$ean_code)
          ->where('store_products.store_id', $store_id)
          ->where('store_products.price','!=',NULL)
          ->where('product.hide',0)
          ->where('product.approved',1)
          ->first();
          $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$prod->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $prod->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$prod->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $prod->price= round($sp->price,0);
            
           }
          if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$prod->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$prod->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
                     
                 
                          
                 if($wishlist) {
                    $prod->isFavourite='true';  
                 } 
                 else{
                    $prod->isFavourite='false'; 
                 }
                 if($cart) {
                    $prod->cart_qty=$cart->qty;  
                 } 
                 else{
                    $prod->cart_qty=0; 
                 }
                 
                }else{
                 $prod->isFavourite='false'; 
                  $prod->cart_qty=0;
                }  
                 $getrating = DB::table('product_rating')
                          ->where('varient_id',$prod->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$prod->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$prod->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $prod->avgrating=round($rating,0); 
                    $prod->countrating=$countrating;
                 } 
                 else{
                     $prod->avgrating=0; 
                    $prod->countrating=0;
                 }   
                 if($prod->mrp != 0){
                $discountper=100-(($prod->price*100)/$prod->mrp);
                $prod->discountper=round($discountper,0);
                }else{
                  $prod->discountper=0;  
                }
         
        if($prod){
            $cat_id=$prod->cat_id;
       $prodsssss =  DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                  ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
          ->where('product.cat_id', $cat_id)
          ->where('store_products.store_id', $store_id)
          ->where('store_products.price','!=',NULL)
          ->where('product.hide',0)
          ->where('product.approved',1)
          ->paginate(5);
         
        $prodsd = $prodsssss->unique('product_id'); 
        
        
         $prod1 = NULL;
        foreach($prodsd as $store)
        {
           
                $prod1[] = $store; 
            
        }
         
        if($prod1 != NULL){
            $result =array();
            $o = 0;
            $p = 0;
            $q = 0;
            $z = 0;
          
            
            foreach($prod1 as $prods) {
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
                array_push($result, $prods);

                $app = json_decode($prods->product_id);
                $apps = array($app);
                $app =  DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                 ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
                         ->select('store_products.store_id','store_products.stock','product_varient.varient_id', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','deal_product.deal_price', 'deal_product.valid_from', 'deal_product.valid_to')
                         ->where('store_products.store_id', $store_id)
                        ->whereIn('product_varient.product_id', $apps)
                        ->where('store_products.price','!=',NULL)
                         ->where('product_varient.approved',1)
                        ->get();
                $images = DB::table('product_images')
                ->select('image')
                 ->whereIn('product_id', $apps)
                 ->get();
                if(count($images)>0){
                    $result[$q]->images = $images;
                    $q++; 
                }else{
                    $images = DB::table('product')
                 ->select('product_image as image')    
                 ->whereIn('product_id', $apps)
                 ->get();
                 
                  $result[$q]->images = $images;
                    $q++; 
                    
                }
                $tag = DB::table('tags')
                 ->whereIn('product_id', $apps)
                ->get();
                $result[$p]->tags = $tag;  
                $p++;
        foreach($app as $aa){   
            $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $app[$a]->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$aa->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $app[$a]->price= round($sp->price,0);
            
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
                    $app[$a]->isFavourite='true';  
                 } 
                 else{
                    $app[$a]->isFavourite='false'; 
                 }
                 if($cart) {
                    $app[$a]->cart_qty=$cart->qty;  
                 } 
                 else{
                    $app[$a]->cart_qty=0; 
                 }
                 
                }else{
                 $app[$a]->isFavourite='false'; 
                  $app[$a]->cart_qty=0;
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
                    $app[$a]->avgrating=round($rating,0); 
                    $app[$a]->countrating=$countrating;
                 } 
                 else{
                     $app[$a]->avgrating=0; 
                    $app[$a]->countrating=0;
                 }         
             if($aa->mrp != 0){
               $discountper=100-(($aa->price*100)/$aa->mrp);
               $app[$a]->discountper=round($discountper,0);
                }else{
                    $app[$a]->discountper=0;   
                }
          
            $a++;
            }
         
         
          $result[$z]->varients = $app;
            $z++; 
             
            }
          
          
            
        } 
            $result =array();
            $i = 0;
            $j = 0;
            $m = 0;
  
                array_push($result, $prod);

                $p_id =$prod->product_id;
               
                $app =  DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
                 ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
                         ->select('store_products.store_id','store_products.stock','product_varient.varient_id', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','deal_product.deal_price', 'deal_product.valid_from', 'deal_product.valid_to')
                         ->where('store_products.store_id', $store_id)
                        ->where('product_varient.product_id', $p_id)
                        ->where('store_products.price','!=',NULL)
                         ->where('product_varient.approved',1)
                        ->get();
                $images = DB::table('product_images')
                ->select('image')
                 ->where('product_id', $p_id)
                 ->get();
                if(count($images)>0){
                    $result[$m]->images = $images;
                    $m++; 
                }else{
                    $images = DB::table('product')
                 ->select('product_image as image')    
                 ->where('product_id', $p_id)
                 ->get();
                 
                  $result[$m]->images = $images;
                    $m++; 
                    
                }
                $tag = DB::table('tags')
                 ->where('product_id', $p_id)
                ->get();
                $result[$j]->tags = $tag;  
                $j++;
                
                $d = Carbon::Now(); 
         $deal = DB::table('deal_product')
           ->where('varient_id',$app[$i]->varient_id)
           ->where('store_id',$store_id)
           ->whereDate('deal_product.valid_from','<=',$d->toDateString())
           ->where('deal_product.valid_to','>',$d->toDateString())
           ->first();  
           
           if($deal){
              $app[$i]->price= round($deal->deal_price,0);
              
           }else{
               $sp = DB::table('store_products')
           ->where('varient_id',$app[$i]->varient_id)
           ->where('store_id',$store_id)
           ->first();   
               $app[$i]->price= round($sp->price,0);
            
           }
               if($request->user_id != NULL){
                $wishlist = DB::table('wishlist')
                          ->where('varient_id',$app[$i]->varient_id)
                          ->where('user_id',$request->user_id)
                          ->first();
                $cart = DB::table('store_orders')
                          ->where('varient_id',$app[$i]->varient_id)
                          ->where('store_approval',$request->user_id)
                          ->where('order_cart_id','incart')
                          ->where('store_id',$store_id)
                          ->first(); 
                    
                 
                          
                 if($wishlist) {
                    $app[$i]->isFavourite='true';  
                 } 
                 else{
                    $app[$i]->isFavourite='false'; 
                 }
                 if($cart) {
                    $app[$i]->cart_qty=$cart->qty;  
                 } 
                 else{
                    $app[$i]->cart_qty=0; 
                 }
                 
                }else{
                 $app[$i]->isFavourite='false'; 
                  $app[$i]->cart_qty=0;
                }
                  $getrating = DB::table('product_rating')
                          ->where('varient_id',$app[$i]->varient_id)
                          ->where('store_id',$store_id)
                          ->get(); 
                   if(count($getrating)>0) {
                       $countrating = DB::table('product_rating')
                          ->where('varient_id',$app[$i]->varient_id)
                          ->where('store_id',$store_id)
                          ->count();
                        $rating = DB::table('product_rating')
                          ->where('varient_id',$app[$i]->varient_id)
                          ->where('store_id',$store_id)
                          ->avg('rating'); 
                    $app[$i]->avgrating=round($rating,0); 
                    $app[$i]->countrating=$countrating;
                 } 
                 else{
                     $app[$i]->avgrating=0; 
                    $app[$i]->countrating=0;
                 }   
                if($app[$i]->mrp != 0){
                $discountper=($app[$i]->price*100)/$app[$i]->mrp;
                $app[$i]->discountper =round($discountper,0);
                }else{
                   $app[$i]->discountper =0; 
                }
                $result[$i]->varients = $app;
               
                $i++; 
             
           $data=array('detail'=>$prod,'similar_product'=>$prod1);

            $message = array('status'=>'1', 'message'=>'Products Detail', 'data'=>$data);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'Product not found');
            return $message;
        }
    }
    
    
     public function searchbystore(Request $request)
    {
        $keyword = $request->keyword;
        $store_id = $request->store_id;
          $user_id =$request->user_id;
          $filter1 = $request->byname;
    $price1 = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
			     ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
			      ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                   ->join('store', 'store_products.store_id', '=', 'store.id')
                 ->select('store_products.price')
                  ->groupBy('store_products.price')
                 ->where('store_products.store_id', $store_id)
                ->where('product.product_name', 'like', '%'.$keyword.'%')
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
          
        $prodsssss = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
			     ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
			      ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                   ->join('store', 'store_products.store_id', '=', 'store.id')
                 ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')
                 ->where('store_products.store_id', $store_id)
                ->where('product.product_name', 'like', '%'.$keyword.'%')
                 ->whereBetween('store_products.price',[$min_price, $max_price])
                 ->havingBetween('avgrating',[$min_rating, $max_rating])
                 ->havingBetween('discountper',[$min_discount, $max_discount])
                 ->where('store_products.stock',$stock,$by)
                ->orderBy('product.product_name',$filter1)
                ->paginate(10);
                
	}else{
	      $prodsssss = DB::table('store_products')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
			     ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
			      ->Leftjoin ('product_rating', 'store_products.varient_id', '=', 'product_rating.varient_id') 
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                   ->join('store', 'store_products.store_id', '=', 'store.id')
                ->select('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type',DB::raw('100-((store_products.price*100)/store_products.mrp) as discountper'),DB::raw('sum(IFNULL(product_rating.rating,0))/count(IFNULL(product_rating.rating,0)) as avgrating'))
                  ->groupBy('store_products.store_id','store_products.stock','store_products.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type','product_rating.rating')   
                 ->where('store_products.store_id', $store_id)
                ->where('product.product_name', 'like', '%'.$keyword.'%')
                 ->whereBetween('store_products.price',[$min_price, $max_price])
                 ->havingBetween('avgrating',[$min_rating, $max_rating])
                 ->havingBetween('discountper',[$min_discount, $max_discount])
                 ->where('store_products.stock',$stock,$by)
                ->paginate(10);
	}
          $deal_p = $prodsssss->unique('product_id');        
          
         $prod = array();
        foreach($deal_p as $store)
        {
           
                $prod[] = $store; 
            
        }
        if(count($prod)>0){
            $result =array();
            $i = 0;
            $j = 0;
            $m= 0;
              foreach ($prod as $prods) {
                  
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
                  $a=0;
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
                 $result[$i]->varients = $app1;
                    $i++; 
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
             if($user_id != NULL){
                 $check=DB::table('recent_search')
                        ->where('user_id',$user_id)
                        ->get();
                        
                 $checkww=DB::table('recent_search')
                        ->where('user_id',$user_id)
                        ->first();         
                   $deletesame=DB::table('recent_search')
                        ->where('keyword',$keyword)
                        ->delete(); 
                        
                if(count($check)>=10){
                     $chec=DB::table('recent_search')
                        ->where('id',$checkww->id)
                        ->delete();  
                }        
               $add = DB::table('recent_search')
                    ->insert(['user_id'=>$user_id,'keyword'=>$keyword]);
           }
            $message = array('status'=>'1', 'message'=>'Products found', 'data'=>$prod);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'Products not found');
            return $message;
        }
      
    }
    
    
     public function trensearchproducts(Request $request)
    {

        $store_id = $request->store_id; 
        $prodsssss = DB::table('trending_search')
                 ->join ('store_products', 'trending_search.varient_id', '=', 'store_products.varient_id')
                 ->join ('product_varient', 'store_products.varient_id', '=', 'product_varient.varient_id')
			     ->join ('product', 'product_varient.product_id', '=', 'product.product_id')
                  ->Leftjoin ('deal_product', 'product_varient.varient_id', '=', 'deal_product.varient_id')
                   ->join('store', 'store_products.store_id', '=', 'store.id')
                  ->select('store_products.stock','store_products.store_id','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type')
                ->groupBy('store_products.stock','store_products.store_id','product_varient.varient_id','product.product_id','product.product_name', 'product.product_image', 'product_varient.description', 'store_products.price', 'store_products.mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','product.type')    
                 ->where('store_products.store_id', $store_id)
                ->get();
        
        if(count($prodsssss)>0){
           

            $message = array('status'=>'1', 'message'=>'Products found', 'data'=>$prodsssss);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'Products not found');
            return $message;
        }
      
    }
    
    
        public function recentsearch(Request $request)
    {

        $user_id = $request->user_id; 
        $prodsssss = DB::table('recent_search')
                 ->where('user_id', $user_id)
                ->get();
        
        if(count($prodsssss)>0){
           

            $message = array('status'=>'1', 'message'=>'Recent Search found', 'data'=>$prodsssss);
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'Products not found');
            return $message;
        }
      
    }
    
    
    
    
    
    
    
    
}
