<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\carbon;
use Auth;
use Illuminate\Support\Facades\Storage;


class StoreHomeController extends Controller
{
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
    public function storeHome(Request $request)
    {
         $title = "Store Dashboard";


         $email=Auth::guard('store')->user()->email;
       $store= DB::table('store')
             ->where('email',$email)
             ->first();

        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();  
 
         $currentDate = Carbon::now();
        $currentDate1 = Carbon::now();
        $agoDate = $currentDate->subDays($currentDate->dayOfWeek)->subWeek();
        $from = date('Y-m-d', strtotime($agoDate));
        $nowDate = $currentDate1->subDays($currentDate1->dayOfWeek); 
        
        $to= date('Y-m-d', strtotime($nowDate));
        $ddate = Date('Y-m-d');
        $next_date = date('Y-m-d', strtotime($ddate.' + '.'1'.' days'));
       
        $last_week = DB::table('orders')
                    ->where('order_status','Completed')
                    ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$from, $to])
                    ->sum('total_price');
                    
        $this_week = DB::table('orders')
                    ->where('order_status','Completed')
                     ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$to, $next_date])
                    ->sum('total_price');            
          $la =$last_week/100;
          if($la == 0){
              $difference =$this_week;
          }else{
          $difference = ($this_week-$last_week)/$la;
          }   
          
          
          $last_week_ord = DB::table('orders')
                    ->where('order_status','Completed')
                     ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$from, $to])
                    ->count();
                    
        $this_week_ord = DB::table('orders')
                    ->where('order_status','!=','Cancelled')
                     ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$to, $next_date])
                    ->count();  
                    
          $la1 =$last_week_ord/100;
          if($la1 == 0){
              $diff_ord =$this_week_ord;
          }else{
          $diff_ord = ($this_week_ord-$last_week_ord)/$la1;
          }       
          
          
          
            $last_week_can = DB::table('orders')
                    ->where('order_status','Cancelled')
                     ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$from, $to])
                    ->count();
                    
        $this_week_can = DB::table('orders')
                    ->where('order_status','Cancelled')
                     ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$to, $next_date])
                    ->count();  
                    
          $la2 =$last_week_can/100;
          if($la2 == 0){
              $diff_can =$this_week_can;
          }else{
          $diff_can = ($this_week_can-$last_week_can)/$la2;
          }         
           
          
            $last_week_pen = DB::table('orders')
                    ->where('order_status','pending')
                     ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$from, $to])
                    ->count();
                    
        $this_week_pen = DB::table('orders')
                    ->where('order_status','pending')
                     ->where('store_id', $store->id)
                    ->whereBetween('delivery_date', [$to, $next_date])
                    ->count();  
                    
          $la3 =$last_week_pen/100;
          if($la3 == 0){
              $diff_pen =$this_week_pen;
          }else{
          $diff_pen = ($this_week_pen-$last_week_pen)/$la3;
          }          
           
            $last_week_usr =DB::table('users')
                     ->join('city', 'users.user_city','=', 'city.city_id')
                     ->join('society', 'users.user_area','=', 'society.society_id')
                     ->join('store', 'city.city_name','=', 'store.city')
                     ->where('store.id', $store->id)
                     ->select('users.name', 'users.id','city.city_name','society.society_name')
                     ->groupBy('users.name', 'users.id','city.city_name','society.society_name')
                      ->whereBetween('users.reg_date', [$from, $to])
                       ->count();
           $this_week_usr =DB::table('users')
                      ->join('city', 'users.user_city','=', 'city.city_id')
                     ->join('society', 'users.user_area','=', 'society.society_id')
                     ->join('store', 'city.city_name','=', 'store.city')
                     ->where('store.id', $store->id)
                     ->select('users.name', 'users.id','city.city_name','society.society_name')
                     ->groupBy('users.name', 'users.id','city.city_name','society.society_name')
                     ->whereBetween('users.reg_date', [$to, $next_date])
                       ->count();
                       
            $la4 =$last_week_usr/100;
          if($la4 == 0){
              $diff_usr =$this_week_usr;
          }else{
          $diff_usr = ($this_week_usr-$last_week_usr)/$la4;
          }                    
                       
         $total_earnings=DB::table('orders')
                            ->where('store_id', $store->id)
                           ->where('order_status','Completed')
                           ->sum('total_price');
             
         
           $today_earnings=DB::table('orders')
                           ->where('order_status','Completed')
                           ->where('delivery_date', $ddate)
                           ->sum('total_price');

            $store_earning = DB::table('store')
                           ->join('orders','store.id','=','orders.store_id')
                           ->select(DB::raw('SUM(orders.price_without_delivery)-SUM(orders.price_without_delivery)*(store.admin_share)/100 as sumprice'))
						   ->groupBy('orders.order_status','store.admin_share')
                           ->where('orders.order_status','Completed')
                            ->where('store.id', $store->id)
                           ->where('orders.payment_method','!=', NULL)
                           ->first();  
            if($store_earning){               
            if($store_earning->sumprice != NULL){            
            $store_earnings = $store_earning->sumprice;
            }
            else{
              $store_earnings =0;
            }
            }
             else{
              $store_earnings =0;
            }
            
            $admin_earnings =  $total_earnings-$store_earnings;
                           
          


                 $date = date('Y-m-d');

    
             $topselling = DB::table('store_orders')
                  ->join ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->select('store_orders.store_id','store_orders.product_name','store_orders.varient_id','store_orders.varient_image','store_orders.quantity', 'store_orders.unit', 'store_orders.description',DB::raw('count(store_orders.varient_id) as count'),DB::raw('SUM(store_orders.qty) as totalqty'),DB::raw('SUM(store_orders.price) as revenue'))
                  ->groupBy('store_orders.store_id','store_orders.product_name','store_orders.varient_id','store_orders.varient_image','store_orders.quantity', 'store_orders.unit', 'store_orders.description')
                  ->orderBy('count','desc')
                  ->where('store_orders.store_id', $store->id)
                  ->where('orders.order_status','Completed')
                  ->whereBetween('orders.delivery_date', [$to, $next_date])
                  ->limit(5)
                  ->get();
      
           $ongoin = DB::table('orders')
            ->join('store','orders.store_id','=','store.id')
            ->join('users','orders.user_id','=','users.id')
             ->join('address','orders.address_id','=','address.address_id')
             ->leftJoin('delivery_boy', 'orders.dboy_id', '=', 'delivery_boy.dboy_id')
              ->where('orders.store_id', $store->id)
              ->where('orders.order_status', '!=', NULL)
              ->where('orders.payment_method', '!=', NULL)
              ->orderBy('orders.order_id', 'DESC')
              ->limit(5)
               ->get();
               
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }          

 
    	return view('store.home', compact('title',"store", "logo","total_earnings","store_earnings","admin_earnings","today_earnings", "last_week","difference","this_week","diff_ord","last_week_ord","this_week_ord","last_week_can","this_week_can","diff_can","diff_pen","last_week_pen","this_week_pen","diff_usr","last_week_usr","this_week_usr","topselling","ongoin","url_aws","to","next_date"));       
      
    }
}
