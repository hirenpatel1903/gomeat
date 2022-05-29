<?php
namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class AddressController extends Controller
{
     public function address(Request $request)
    {
            $user_id = $request->user_id;
            $unselect= DB::table('address')
                     ->where('user_id' ,$user_id)
                     ->get();
                     
            if(count($unselect)>0){
            $unselect= DB::table('address')
                     ->where('user_id' ,$user_id)
                     ->update(['select_status' => 0]);
            }
            $type = $request->type;
            $receiver_name = $request->receiver_name;
            $receiver_phone = $request->receiver_phone;
            $city = $request->city_name;
            $citydet = DB::table('city')
                      ->where('city_name',$city)
                      ->first();
            $city_id = $citydet->city_id;
            
            $society = $request->society_name;
             $socitydet = DB::table('society')
                      ->where('society_name',$society)
                      ->first();
            $society_id = $socitydet->society_id;
            $house_no = $request->house_no;
            $landmark = $request->landmark;
            $state = $request->state;
            $pin = $request->pin;
            $lat = $request->lat;
            $lng = $request->lng;
            $status= 1;
       
            $added_at= Carbon::Now();
    	    if($type == "Others"){
    	    $insertaddress = DB::table('address')
    						->insert([
    							'user_id'=>$user_id,
    							'receiver_name'=>$receiver_name,
    							'receiver_phone'=>$receiver_phone,
    							'city'=>$city,
    							'society'=>$society,
    							'city_id'=>$city_id,
    							'society_id'=>$society_id,
    							'house_no'=>$house_no,
    							'landmark'=> $landmark,
    							'state'=>$state,
    							'pincode'=>$pin,
    							'select_status'=>1,
    							'lat' => $lat,
    							'lng' => $lng,
    							'type'=>"Others",
    							'added_at'=>$added_at
                            ]);
    	    }
    	    else{
    	        $getaddress= DB::table('address')
                     ->where('user_id' ,$user_id)
                     ->where('type', $type)
                     ->first();
    	        if($getaddress){
    	            $insertaddress = DB::table('address')
    	                        ->where('user_id' ,$user_id)
                              ->where('type', $type)
    						->update([
    							'receiver_name'=>$receiver_name,
    							'receiver_phone'=>$receiver_phone,
    							'city'=>$city,
    							'society'=>$society,
    							'city_id'=>$city_id,
    							'society_id'=>$society_id,
    							'house_no'=>$house_no,
    							'landmark'=> $landmark,
    							'state'=>$state,
    							'pincode'=>$pin,
    							'select_status'=>1,
    							'lat' => $lat,
    							'lng' => $lng,
    							'type'=> $type,
    							'added_at'=>$added_at
                            ]);
    	        }else{
    	             $insertaddress = DB::table('address')
    						->insert([
    							'user_id'=>$user_id,
    							'receiver_name'=>$receiver_name,
    							'receiver_phone'=>$receiver_phone,
    							'city'=>$city,
    							'society'=>$society,
    							'city_id'=>$city_id,
    							'society_id'=>$society_id,
    							'house_no'=>$house_no,
    							'landmark'=> $landmark,
    							'state'=>$state,
    							'pincode'=>$pin,
    							'select_status'=>1,
    							'lat' => $lat,
    							'lng' => $lng,
    							'type'=>$type,
    							'added_at'=>$added_at
                            ]);
    	        }
    	    }
          if($insertaddress){
                $message = array('status'=>'1', 'message'=>trans('keywords.Address Saved'));
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'something went wrong');
	            return $message;
    	}
      }
      
    public function city(Request $request)
    {
    $city= DB::table('city')
         ->join('society','city.city_id','=','society.city_id')
         ->select('city.city_id','city.city_name')
         ->groupBy('city.city_id','city.city_name')
         ->get();
         
       if(count($city)>0){
                $message = array('status'=>'1', 'message'=>'city list','data'=>$city);
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'city not found');
	            return $message;
    	}    
    }
    
    public function society(Request $request)
    {
  
    $city_id = $request->city_id;
   
    
    $society= DB::table('society')
         ->join('city', 'society.city_id','=','city.city_id')
         ->where('city.city_id',$city_id)
         ->get();
         
    
         
       if(count($society)>0){
                $message = array('status'=>'1', 'message'=>'Society list','data'=>$society);
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'Society not found');
	            return $message;
    	}    
     }
     
     
   public function show_address(Request $request)
    {
    $user_id = $request->user_id;
    $store_id = $request->store_id;
     $store = DB::table('store')
       ->where('id', $store_id)
       ->first();

    
         $store = DB::table('store')
       ->where('id', $store_id)
       ->first();
    $addresss = DB::table('address')
         ->where('user_id',$user_id)
         ->where('select_status','!=',2)
         ->select('*',DB::raw("6371 * acos(cos(radians(".$store->lat . ")) 
                    * cos(radians(lat)) 
                    * cos(radians(lng) - radians(" . $store->lng . ")) 
                    + sin(radians(" .$store->lat. ")) 
                    * sin(radians(address.lat))) AS distancee"))
                    ->groupBy('type','address_id','lat','lng','receiver_name','receiver_phone','user_id',
                    'city','society','house_no','landmark','state','pincode','select_status','added_at','address_id','updated_at','city_id','society_id')  
                    ->Having('distancee','<=',$store->del_range)
                    ->orderBy('distancee')
                    ->get();
                    
                    
         $address = NULL;
        foreach($addresss as $store)
        {
            
                $address[] = $store; 
            
        }     
         if($address != NULL){     
              $message = array('status'=>'1', 'message'=>'Address list','data'=>$address);
                return $message;
          }else{
             $message = array('status'=>'0', 'message'=>'No addresses found! please Add');
                return $message;
          }
                    
     
     }
     
     
public function select_address(Request $request)
    {
    $address_id = $request->address_id;
    $user = DB::table('address')
         ->where('address_id',$address_id)
         ->first();
    $checkuser = $user->user_id;  
    $select1 = DB::table('address')
         ->where('user_id',$checkuser)
         ->update(['select_status'=> 0]);
    $select = DB::table('address')
         ->where('address_id',$address_id)
         ->update(['select_status'=> 1]);
         if($select){
                $message = array('status'=>'1', 'message'=>'Address Selected');
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'cannot select please try again later');
	            return $message;
    	}    
     }     
     
public function rem_user_address(Request $request)
    {
    $address_id = $request->address_id;
    $checkcart = DB::table('orders')
               ->where('address_id', $address_id)
               ->get();
    if(count($checkcart)==0) {
        $deladdress= DB::table('address')
         ->where('address_id',$address_id)
         ->delete();
        
    }  
    else{
    $deladdress= DB::table('address')
         ->where('address_id',$address_id)
         ->update(['select_status'=>2]);
    }
  
       if($deladdress){
         
                $message = array('status'=>'1', 'message'=>'Address Removed');
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'Try Again Later');
	            return $message;
    	}    
     }     
          
     
      
public function edit_add(Request $request)
    {
           $address_id = $request->address_id;
           $lat= $request->lat;
           $lng = $request->lng;
           $user_id = $request->user_id;
            $unselect= DB::table('address')
                     ->where('user_id' ,$user_id)
                     ->get();
                     
            if(count($unselect)>0){
            $unselect= DB::table('address')
                     ->where('user_id' ,$user_id)
                     ->update(['select_status'=> 0]);
            }
            
            $receiver_name = $request->receiver_name;
            $receiver_phone = $request->receiver_phone;
           
             $city = $request->city_name;
            $citydet = DB::table('city')
                      ->where('city_name',$city)
                      ->first();
            $city_id = $citydet->city_id;
            
            $society = $request->society_name;
           $socitydet = DB::table('society')
                      ->where('society_name',$society)
                      ->first();
            $society_id = $socitydet->society_id;
            $house_no = $request->house_no;
            $landmark = $request->landmark;
            $state = $request->state;
            $pin = $request->pin;
            $status= 1;
         
            $added_at= Carbon::Now();
            $type = $request->type;
      
    	    
    	    $insertaddress = DB::table('address')
    	                  ->where('address_id', $address_id)
    						->update([
    							'receiver_name'=>$receiver_name,
    							'receiver_phone'=>$receiver_phone,
    							'city'=>$city,
    							'society'=>$society,
    							'city_id'=>$city_id,
    							'society_id'=>$society_id,
    							'house_no'=>$house_no,
    							'landmark'=> $landmark,
    							'state'=>$state,
    							'pincode'=>$pin,
    							'select_status'=>1,
    							'lat' => $lat,
    							'lng' => $lng,
    							'type'=>$type,
    							'updated_at'=>$added_at
                            ]);
                            
          if($insertaddress){
                $message = array('status'=>'1', 'message'=>'Address Saved');
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'something went wrong');
	            return $message;
    	}  
     }  
      
      
  public function show_all_address(Request $request)
    {
    $user_id = $request->user_id;

    $types = DB::table('address')
         ->where('user_id',$user_id)
         ->where('select_status','!=',2)
         ->select('type','address_id')
         ->get();
         
         
    if(count($types)>0){     
       $typess = $types->unique('type');        
          
           $type = NULL;
        foreach($typess as $store)
        {
           
                $type[] = $store; 
            
        }   
    }
    else{
        $home[]=array('data'=>'No Address Found');
        return $home;
    }
      if(count($type)>0){
		   foreach($type as $addresses)
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
      
         
    $address = NULL;
     foreach($type as $types){  
    $addresss = DB::table('address')
         ->where('user_id',$user_id)
         ->where('select_status','!=',2)
         ->where('type', $types->type)
         ->get();
         $address = NULL;
        foreach($addresss as $store)
        {
            
                $address[] = $store; 
            
        }     
         if($address != NULL){     
            $home[]=array('type'=>$types->type, 'data'=>$address);
          }else{
           $home[]=array('data'=>'No Address Found');  
          }
                    
     }
      }
        else{
            $home[]=array('data'=>'No Address Found');
        }
        return $home;
     }      
     
     
    
    
    public function societyforadd(Request $request)
    {
  
    $store_id = $request->store_id;
   
    
    $society= DB::table('service_area')
        ->select('society_name','society_id')
         ->where('store_id',$store_id)
         ->get();
         
    
         
       if(count($society)>0){
                $message = array('status'=>'1', 'message'=>'Society list','data'=>$society);
                return $message;
                            }		
          else{
                 $message = array('status'=>'0', 'message'=>'Society not found');
	            return $message;
    	}    
     }
      
}