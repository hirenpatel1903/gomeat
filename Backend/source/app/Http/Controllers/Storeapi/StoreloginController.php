<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use Hash;
use Illuminate\Support\Facades\Storage;

class StoreloginController extends Controller
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
 public function store_login(Request $request)
    
     {
    	$email = $request->email;
    	$password = $request->password;
    	$device_id = $request->device_id;
    	$checkstore1 = DB::table('store')
    					->where('email', $email)
    					->first();
    if($checkstore1){					
    	$checkstore = DB::table('store')
    					->where('email', $email)
    					->first();

    	if($checkstore){
    	  if($checkstore->store_status==0){
             $message = array('status'=>'2', 'message'=>'Your store has been blocked please contact admin.', 'data'=>[]);
	        return $message;
          }
          else{
    	    if($checkstore->admin_approval==1){ 
    	         if(Hash::check($password, $checkstore->password)){
    		   $updateDeviceId = DB::table('store')
    		                       ->where('email', $email)
    		                        ->update(['device_id'=>$device_id]);
    		                       
    		                        
    			$message = array('status'=>'1', 'message'=>'login successfully', 'data'=>[$checkstore]);
	        	return $message;
    	         }
    	         else{
    	       $message = array('status'=>'0', 'message'=>'Wrong Password', 'data'=>[]);
	            return $message;
    	         }
    	   }	   
    	   else{
    		$message = array('status'=>'0', 'message'=>'Your store is under approval. Please wait for admin approval.', 'data'=>[]);
	        return $message;
    	}
          }
    	}
    	else{
    		$message = array('status'=>'0', 'message'=>'Wrong Password', 'data'=>[]);
	        return $message;
    	}
    }
    else{
        	$message = array('status'=>'0', 'message'=>'Store Not Registered', 'data'=>[]);
	        return $message;
    }
    }
    
    
    
    
    public function storeprofile(Request $request)
    {   
        $store_id = $request->store_id;
         $store=  DB::table('store')
                ->leftJoin('orders','store.id','=','orders.store_id')
               ->leftJoin('store_earning','store.id','=','store_earning.store_id')
               ->select('store.store_name','store.phone_number','store.email','store.address','store.store_photo','store.password','store.employee_name','store_earning.paid',DB::raw('SUM(orders.total_price)-SUM(orders.total_price)*(store.admin_share)/100 as store_earning'))
               ->groupBy('store.store_name','store.phone_number','store.email','store.address','store_earning.paid','store.admin_share','store.store_photo','store.password','store.employee_name')
                ->where('store.id', $store_id )
                ->first();
         
           if($store == NULL){
             $store=  DB::table('store')
                ->leftJoin('orders','store.id','=','orders.store_id')
               ->leftJoin('store_earning','store.id','=','store_earning.store_id')
               ->select('store.employee_name','store.store_name','store.phone_number','store.email','store.address','store.admin_share','store.store_photo')
               ->groupBy('store.employee_name','store.store_name','store.phone_number','store.email','store.address','store.admin_share','store.store_photo')
                ->where('store.id', $store_id )
                ->first();

             $paid = 0;
             $store_earning = 0;

                $data[] = array(
                    'employee_name'=>$store->employee_name,
                  'store_name' => $store->store_name,
                  'phone_number' => $store->phone_number,
                  'email'=> $store->email,
                  'address'=> $store->address,
                    'paid'=>$paid,
                    'store_photo'=>$store->store_photo,
                   'store_earning'=> $store_earning,
                   'password'=>$store->password
                                   );
                 }else{
                $paid = $store->paid; 
                if($paid==NULL){
                   $paid=0; 
                }
                $store_earning = $store->store_earning;
               $data[] = array(
                    'employee_name'=>$store->employee_name,
                  'store_name' => $store->store_name,
                  'phone_number' => $store->phone_number,
                  'email'=> $store->email,
                  'address'=> $store->address,
                    'paid'=>$paid,
                    'store_photo'=>$store->store_photo,
                   'store_earning'=> $store_earning,
                     'password'=>$store->password
                                   );
              }
         
                        
    if($store){
        	$message = array('status'=>'1', 'message'=>'Store Profile', 'data'=>$data);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Store not found', 'data'=>[]);
	        return $message;
    	}
        
    }
    
    
    
   public function storeupdateprofile(Request $request)
    {   
        $store_id = $request->store_id;
          $store=  DB::table('store')
                ->select('store_photo','email')
                ->where('id', $store_id )
                ->first();
          
        $storessss=  DB::table('store')
                ->where('id', $store_id )
                ->first();
        $owner_name = $request->owner_name;       
        $store_name= $request->store_name;
        $store_email = $request->store_email;
        $store_phone = $request->store_phone;
        if($request->password==NULL){
        $store_password = $storessss->password;
		}else{
			 $store_password = Hash::make($request->password);
		}
    
        $date=date('d-m-Y');
          if($request->hasFile('store_photo')){
              $image = $request->store_photo;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('store_photo');
                $user_image = '/store/'.$image_name;
                Storage::disk($this->storage_space)->put($user_image, fopen($request->file('store_photo'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/store/'.$date.'/', $fileName);
            $user_image = '/images/store/'.$date.'/'.$fileName;
        
            }
        }
          else{
               $user_image = $store->store_photo;
            }
        $chkstorphon = DB::table('store')
                      ->where('phone_number', $store_phone)
                      ->where('id', '!=', $store_id)
                      ->first(); 
         $chkstoremail = DB::table('store')
                      ->where('email', $store_email)
                      ->where('id', '!=', $store_id)
                      ->first();              
        
         
         if($chkstorphon && $chkstoremail){
             
             
             $message = array('status'=>'0', 'message'=>trans('keywords.This Phone Number and Email Are Already Registered With Another Store'));
	        return $message;
            
        } 

        if($chkstorphon){
           $message = array('status'=>'0', 'message'=>trans('keywords.This Phone Number is Already Registered With Another Store'));
	        return $message;
        } 
        if($chkstoremail){
            
            $message = array('status'=>'0', 'message'=>trans('keywords.This Email is Already Registered With Another Store'));
	        return $message;
        } 
       
       $update= DB::table('store')
             ->where('id', $store_id)
             ->update(['store_name'=>$store_name,
             'employee_name'=>$owner_name,
             'password'=>$store_password,
             'phone_number'=>$store_phone,
             'store_photo'=>$user_image,
             'email'=>$store_email
             ]);
                        
    if($update){
        $store=  DB::table('store')
                ->leftJoin('orders','store.id','=','orders.store_id')
               ->leftJoin('store_earning','store.id','=','store_earning.store_id')
               ->select('store.store_name','store.phone_number','store.email','store.address','store.store_photo','store.password','store.employee_name','store_earning.paid',DB::raw('SUM(orders.total_price)-SUM(orders.total_price)*(store.admin_share)/100 as store_earning'))
               ->groupBy('store.store_name','store.phone_number','store.email','store.address','store_earning.paid','store.admin_share','store.store_photo','store.password','store.employee_name')
                ->where('store.id', $store_id )
                ->first();
         
           if($store == NULL){
             $store=  DB::table('store')
                ->leftJoin('orders','store.id','=','orders.store_id')
               ->leftJoin('store_earning','store.id','=','store_earning.store_id')
               ->select('store.employee_name','store.store_name','store.phone_number','store.email','store.address','store.admin_share','store.store_photo')
               ->groupBy('store.employee_name','store.store_name','store.phone_number','store.email','store.address','store.admin_share','store.store_photo')
                ->where('store.id', $store_id )
                ->first();

             $paid = 0;
             $store_earning = 0;

                $data[] = array(
                    'employee_name'=>$store->employee_name,
                  'store_name' => $store->store_name,
                  'phone_number' => $store->phone_number,
                  'email'=> $store->email,
                  'address'=> $store->address,
                    'paid'=>$paid,
                    'store_photo'=>$store->store_photo,
                   'store_earning'=> $store_earning,
                   'password'=>$store->password
                                   );
                 }else{
                $paid = $store->paid; 
                if($paid==NULL){
                   $paid=0; 
                }
                $store_earning = $store->store_earning;
               $data[] = array(
                    'employee_name'=>$store->employee_name,
                  'store_name' => $store->store_name,
                  'phone_number' => $store->phone_number,
                  'email'=> $store->email,
                  'address'=> $store->address,
                    'paid'=>$paid,
                    'store_photo'=>$store->store_photo,
                   'store_earning'=> $store_earning,
                     'password'=>$store->password
                                   );
              }
         
        	$message = array('status'=>'1', 'message'=>'Store Profile Updated', 'data'=>$data);
	        return $message;
              }
    	else{
    		$message = array('status'=>'1', 'message'=>'Nothing to Update');
	        return $message;
    	}
    }
    
       public function top_selling(Request $request){
       $current = Carbon::now();
       $store_id = $request->store_id;
       
                  
      $topselling = DB::table('store_orders')
                  ->join ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                  ->select('store_orders.store_id','store_orders.product_name','store_orders.varient_id','store_orders.varient_image','store_orders.quantity', 'store_orders.unit', 'store_orders.description',DB::raw('count(store_orders.varient_id) as count'),DB::raw('SUM(store_orders.qty) as totalqty'),DB::raw('SUM(store_orders.price) as revenue'))
                  ->groupBy('store_orders.store_id','store_orders.product_name','store_orders.varient_id','store_orders.varient_image','store_orders.quantity', 'store_orders.unit', 'store_orders.description')
                  ->where('store_orders.store_id', $store_id)
                  ->orderBy('count','desc')
                  ->limit(20)
                  ->get();
          
          $orders = DB::table('orders')
                  ->where('store_id', $store_id)
                  ->Where('order_status','!=',NULL)
                  ->where('order_status','!=','Cancelled')
                  ->where('payment_method','!=',NULL)
                  ->count();
         $pending =  DB::table('orders')
                  ->where('store_id', $store_id)
                  ->where('order_status','Pending')
                  ->where('payment_method','!=',NULL)
                  ->count();         
                  
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
          
                  
         if(count($topselling)>0){
        	$message = array('status'=>'1', 'message'=>'Top Products Of Store', 'total_orders'=>$orders,'total_revenue'=>$sum,'pending_orders'=>$pending,'data'=>$topselling);
        	return $message;
        }
        else{
        	$message = array('status'=>'0', 'message'=>'nothing in top', 'data'=>[]);
        	return $message;
        }      
     
  }   
    
}