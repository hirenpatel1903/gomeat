<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use App\Traits\SendInapp;
use App\Traits\SendMail;
use App\Traits\SendSms;
use App\Models\Admin;
use Auth;
use Illuminate\Support\Facades\Storage;


class AdminorderController extends Controller
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

    
     public function admin_com_orders(Request $request)
    {
         $title = trans('keywords.Completed Orders');
         $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
             ->join('store','orders.store_id', '=', 'store.id')
              ->join('address', 'orders.address_id', '=','address.address_id')
             ->join('delivery_boy','orders.dboy_id', '=', 'delivery_boy.dboy_id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->orderBy('orders.delivery_date','DESC')
             ->where('order_status', 'completed')
             ->orWhere('order_status', 'Completed')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
          
           if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }            
       return view('admin.all_orders.com_orders', compact('title','logo','ord','details','admin','url_aws'));         
    }
    
    
    
      public function admin_can_orders(Request $request)
    {
         $title = trans('keywords.Cancelled Orders');
         $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
             ->leftjoin('store','orders.store_id', '=', 'store.id')
              ->join('address', 'orders.address_id', '=','address.address_id')
             ->leftjoin('delivery_boy','orders.dboy_id', '=', 'delivery_boy.dboy_id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->orderBy('orders.delivery_date','DESC')
             ->where('order_status', 'cancelled')
             ->orWhere('order_status', 'Cancelled')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id')
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.all_orders.cancelled', compact('title','logo','ord','details','admin'));         
    }
    
    
      public function admin_pen_orders(Request $request)
    {
         $title = trans('keywords.Pending Orders');
        $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
              ->join('store','orders.store_id','=','store.id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->orderBy('orders.delivery_date','DESC')
             ->where('orders.order_status', 'Pending')
             ->orWhere('orders.order_status', 'pending')
            ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.all_orders.pending', compact('title','logo','ord','details','admin'));         
    }
    
    
    public function admin_store_orders(Request $request)
    {
         $title = "Store Order section";
         $id = $request->id;
         $store = DB::table('store')
                ->where('id',$id)
                ->first();
        $admin_email=Auth::guard('admin')->user()->email;
       $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
              ->join('store','orders.store_id','=','store.id')
              ->join('address', 'orders.address_id', '=','address.address_id')
             ->where('orders.store_id',$store->id)
             ->orderBy('orders.order_id','ASC')
             ->where('order_status','!=', 'completed')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('orders.store_id',$id)
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.store.orders', compact('title','logo','ord','store','details','admin'));         
    }
    
    
    
     public function admin_dboy_orders(Request $request)
    {
         $title = "Delivery Boy Order section";
         $id = $request->id;
         $dboy = DB::table('delivery_boy')
                ->where('dboy_id',$id)
                ->first();
                
                
        $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
    
          $date = date('Y-m-d');
     $nearbydboy = DB::table('store_delivery_boy')
                ->leftJoin('orders', 'store_delivery_boy.ad_dboy_id', '=', 'orders.dboy_id') 
                ->select("store_delivery_boy.store_id","store_delivery_boy.boy_name","store_delivery_boy.dboy_id","store_delivery_boy.lat","store_delivery_boy.lng","store_delivery_boy.boy_city",DB::raw("Count(orders.order_id)as count"),DB::raw("6371 * acos(cos(radians(".$dboy->lat . ")) 
                * cos(radians(store_delivery_boy.lat)) 
                * cos(radians(store_delivery_boy.lng) - radians(" . $dboy->lng . ")) 
                + sin(radians(" .$dboy->lat. ")) 
                * sin(radians(store_delivery_boy.lat))) AS distance"))
               ->groupBy("store_delivery_boy.store_id","store_delivery_boy.boy_name","store_delivery_boy.dboy_id","store_delivery_boy.lat","store_delivery_boy.lng","store_delivery_boy.boy_city")
               ->where('store_delivery_boy.boy_city', $dboy->boy_city)
               ->where('store_delivery_boy.ad_dboy_id','!=',$dboy->dboy_id)
               ->orderBy('count')
               ->orderBy('distance')
               ->get();  
    
                
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
              ->join('store','orders.store_id','=','store.id')
              ->join('address', 'orders.address_id', '=','address.address_id')
             ->where('orders.dboy_id',$dboy->dboy_id)
             ->orderBy('orders.delivery_date','ASC')
             ->where('order_status','!=', 'completed')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                       ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('orders.dboy_id',$id)
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.d_boy.orders', compact('title','logo','ord','dboy','details','admin','nearbydboy'));         
    }
    
    
    
    public function store_cancelled(Request $request)
    {
         $title = "Store Cancelled Orders";
         $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->orderBy('orders.delivery_date','ASC')
             ->where('order_status','!=', 'completed')
             ->where('order_status','!=', 'cancelled')
              ->where('payment_method','!=', NULL)
             ->where('store_id', 0)
             ->paginate(10);
             

          
          $nearbystores = DB::table('store')
                      ->join('service_area','store.id','=','service_area.store_id')
                     ->select('store.id','store.store_name')
					->groupBy('store.id','store.store_name')
                      ->get();
	
         
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.store.cancel_orders', compact('title','logo','ord','details','admin','nearbystores'));  
    }
    
    
    public function assignstore(Request $request)
    {
         $title = "Store Cancelled Orders";
         $cart_id=$request->id;
         $store = $request->store;
         $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
      
          $ord =DB::table('orders')
             ->where('cart_id', $cart_id)
             ->update(['store_id'=>$store, 'cancel_by_store'=>0]);
             
        
      return redirect()->back()->withSuccess(trans('keywords.Assigned to Store Successfully'));
    }
    
    
    
    
       public function assigndboy(Request $request)
    {
         $cart_id=$request->id;
         $d_boy = $request->d_boy;
         $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
      
          $ord =DB::table('orders')
             ->where('cart_id', $cart_id)
             ->update(['dboy_id'=>$d_boy]);
             
      
      return redirect()->back()->withSuccess(trans('keywords.Assigned to Another Delivery Boy Successfully'));
    }
    
    
        public function rejectorder(Request $request)
    {
         $cart_id=$request->id;
         $ord= DB::table('orders')
                ->where('cart_id',$cart_id)
                ->first();
         $total_price = $ord->rem_price;        
         $user = DB::table('users')
                ->where('id',$ord->user_id)
                ->first();  
         $user_id = $ord->user_id;      
         $wall = $user->wallet;     
         $bywallet = $ord->paid_by_wallet;  
         if($ord->payment_method != 'COD' || $ord->payment_method != 'cod'|| $ord->payment_method != 'Cod'){
        $newwallet = $wall + $total_price + $bywallet;
        $update = DB::table('users')
                ->where('id',$ord->user_id)
                ->update(['wallet'=>$newwallet]);
         }  
         else{
                $newwallet = $wall + $bywallet;
        $update = DB::table('users')
                ->where('id',$ord->user_id)
                ->update(['wallet'=>$newwallet]);
         }
         
         $cause = $request->cause;
         
         $checknotificationby = DB::table('notificationby')
                              ->where('user_id',$user->id)
                              ->first();
         if($checknotificationby->sms == 1){
         $sendmsg = $this->sendrejectmsg($cause,$user,$cart_id);
         }
         if($checknotificationby->email == 1){
         $sendmail = $this->sendrejectmail($cause,$user,$cart_id);
         }
         if($checknotificationby->app == 1){
         //////send notification to user//////////
         $sendinapp = $this->sendrejectnotification($cause,$user,$cart_id,$user_id);
         
             
         }
         
          $ord =DB::table('orders')
             ->where('cart_id', $cart_id)
             ->update(['cancelling_reason'=>"Cancelled by Admin due to the following reason: ".$cause,
             'order_status'=>"Cancelled"]);
          
           $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                         ->first();
            if($cart_status){             
             $cart_status=DB::table('cart_status')
                         ->where('cart_id',$cart_id)
                        ->update(['cancelled'=>Carbon::now()]);
            }  
             
         return redirect()->back()->withSuccess(trans('keywords.Order Rejected Successfully'));
    }
    
     public function missed_orders(Request $request)
    {
         $title = trans('keywords.Missed Orders');
         $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $today = date('Y-m-d');  
        $day = 1;
        $next_date = date('Y-m-d', strtotime($today.' - '.$day.' days'));
        $ord =DB::table('orders')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('store','orders.store_id','=','store.id')
              ->join('address', 'orders.address_id', '=','address.address_id')
             ->leftJoin('delivery_boy','orders.dboy_id','=','delivery_boy.dboy_id')
             ->orderBy('orders.delivery_date','DESC')
             ->select('orders.*','users.*','store.*','delivery_boy.boy_name','address.*')
            ->where('orders.order_status', '!=','Completed')
            ->where('orders.order_status', '!=','Cancelled')
             ->where('orders.delivery_date','<',$today)
             ->where('orders.payment_method','!=', NULL)
             ->where('orders.store_id','!=', 0)
            ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();  
                       
                       
         $delivery = DB::table('store_delivery_boy')
                   ->get();
                
       return view('admin.all_orders.missed', compact('title','logo','ord','details','admin','delivery'));         
    }
         public function admin_on_orders(Request $request)
    {
         $title = trans('keywords.Confirmed Orders');
        $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
              ->join('store','orders.store_id','=','store.id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->orderBy('orders.delivery_date','DESC')
             ->where('orders.order_status', 'Confirmed')
             ->orWhere('orders.order_status', 'confirmed')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.all_orders.ongoing', compact('title','logo','ord','details','admin'));         
    }
    
 public function admin_all_orders(Request $request)
    {
         $title = trans('keywords.All Orders');
        $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
              ->join('store','orders.store_id','=','store.id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->orderBy('orders.delivery_date','DESC')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.all_orders.all_orders', compact('title','logo','ord','details','admin'));         
    }
    public function admin_out_orders(Request $request)
    {
         $title = trans('keywords.Out For Delivery Orders');
        $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
              ->join('store','orders.store_id','=','store.id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
              ->where('orders.order_status', 'Out_For_Delivery')
             ->orWhere('orders.order_status', 'out_for_delivery')
             ->orderBy('orders.delivery_date','DESC')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.all_orders.out_orders', compact('title','logo','ord','details','admin'));         
    }
     public function admin_failed_orders(Request $request)
    {
         $title = trans('keywords.Payment Failed Orders');
        $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $ord =DB::table('orders')
              ->join('store','orders.store_id','=','store.id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
              ->where('orders.payment_status', 'failed')
             ->orderBy('orders.delivery_date','DESC')
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();         
                
       return view('admin.all_orders.failed', compact('title','logo','ord','details','admin'));         
    }
}