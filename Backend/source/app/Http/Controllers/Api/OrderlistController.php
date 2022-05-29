<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use Illuminate\Support\Facades\Storage;

class OrderlistController extends Controller
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
   public function orderlist(Request $request)
    {   
        $user_id = $request->user_id;
        $address_id = $request->address_id;
        $store_id = $request->store_id;
        $date=date('Y-m-d');
           $image = $request->orderlist;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('orderlist');
                $filePath = '/images/order/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/order/'.$date.'/', $fileName);
            $filePath = '/images/order/'.$date.'/'.$fileName;
        
            }
        
        
       
        $check =  DB::table('order_by_photo')
                 ->where('user_id',$user_id)
                 ->where('store_id',$store_id)
                 ->where('processed', 0)
                 ->get();
        if(count($check)==0){ 
        
    	$insert = DB::table('order_by_photo')
                    ->insertgetid([
                        'user_id'=>$user_id,
                        'list_photo'=>$filePath,
                        'address_id'=>$address_id,
                        'store_id'=>$store_id,
                        'processed'=>0
                        ]);
                        
      if($insert){
        	$message = array('status'=>'1', 'message'=>'Order List Submitted! you will get an sms and notification once it will processed');
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Please try again later');
	        return $message;
            	}
        }
        else{
            $message = array('status'=>'2', 'message'=>'You already submitted an Order list please wait till the older ones Confirmation.');
	        return $message;
        }
   
 }
        
        
 public function order_show_address(Request $request)
    {
    $user_id = $request->user_id;
    $lat = $request->lat;
    $lng = $request->lng;
       $nearbystore = DB::table('store')
                    ->select('del_range','store_id','lat','lng',DB::raw("6371 * acos(cos(radians(".$lat . ")) 
                    * cos(radians(store.lat)) 
                    * cos(radians(store.lng) - radians(" . $lng . ")) 
                    + sin(radians(" .$lat. ")) 
                    * sin(radians(store.lat))) AS distance"))
                  ->where('store.del_range','>=','distance')
                  ->orderBy('distance')
                  ->first();
           
if ($nearbystore){         
       $store_id = $nearbystore->store_id;                  
    if($nearbystore->del_range >= $nearbystore->distance)  {              
  
     $store = $nearbystore;
       
    $address = DB::table('address')
         ->where('user_id',$user_id)
         ->where('select_status','!=',2)
         ->select('address.*',DB::raw("6371 * acos(cos(radians(".$store->lat . ")) 
                    * cos(radians(address.lat)) 
                    * cos(radians(address.lng) - radians(" . $store->lng . ")) 
                    + sin(radians(" .$store->lat. ")) 
                    * sin(radians(address.lat))) AS distancee"))
                    ->Having('distancee','<=',$store->del_range)
                    ->orderBy('distancee')
                    ->get();
    
	 
         
       if(count($address)>0){
		   foreach($address as $addresses)
		   {
			   $address_id[]=$addresses->address_id;
		   }
		    $check = DB::table('address')
             ->WhereIn('address_id',$address_id)
		     ->where('select_status',1)
		     ->get();
    if(count($check)==0){
		   $selected =   DB::table('address')
         ->where('user_id',$user_id)
         ->where('select_status',1)
	     ->update(['select_status'=>0]);
	}
                $message = array('status'=>'1', 'message'=>'Address list','data'=>$address);
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'Address not found! Add Address', 'data'=>[]);
	            return $message;
    	}    
     }
     else{
       $message = array('status'=>'0', 'message'=>'We are not delivering in your area', 'data'=>[]);
	            return $message;  
     }
}else{
     $message = array('status'=>'0', 'message'=>'We are not delivering in your area', 'data'=>[]);
	            return $message;  
}
}
        
        
  
  
}