<?php
namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use Hash;
use Illuminate\Support\Facades\Storage;

class RegController extends Controller
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

 public function regstore(Request $request)
    
     {
        $store_name = $request->store_name;
        $emp_name = $request->emp_name;
        $number = $request->store_phone;
        $city = $request->city;
        $email = $request->email;
        $range = $request->del_range;
        $password = Hash::make($request->password);
        $address = $request->address;
        $share =$request->share;
        $open_time = "10:00";
        $close_time="22:00";
        $interval="60";
        $date=date('d-m-Y');
         $id_name = $request->id_name;
        $id_img = $request->id_img;
        $id_numb = $request->id_numb;
        $admin_approval = 0;
        $discount = str_replace("%",'', $share);
        $addres = str_replace(" ", "+", $address);
        $address1 = str_replace("-", "+", $addres);
        $checkmap = DB::table('map_api')
                  ->first();
                  
        $chkstorphon = DB::table('store')
                      ->where('phone_number', $number)
                      ->first(); 
         $chkstoremail = DB::table('store')
                      ->where('email', $email)
                      ->first();              
        $checkall = DB::table('store')
                      ->where('email', $email)
                      ->where('phone_number', $number)
                      ->first();
         if($checkall && $checkall->admin_approval == 0){
             	$message = array('status'=>'0', 'message'=>'This Phone Number and Email Are Already Registered With Another Store and waiting for Admin Approval');
	           return $message;
        } 

        elseif($chkstorphon && $chkstorphon->admin_approval == 0){
            	$message = array('status'=>'0', 'message'=>'This Phone Number is Already Registered With Another Store and waiting for Admin Approval');
	           return $message;
        } 
        elseif($chkstoremail && $chkstoremail->admin_approval == 0){
           	$message = array('status'=>'0', 'message'=>'This Email is Already Registered With Another Store and waiting for Admin Approval');
	           return $message;
        } 
         elseif($checkall && $checkall->admin_approval == 1){
             	$message = array('status'=>'0', 'message'=>'This Phone Number and Email Are Already Registered With Another Store.');
	           return $message;
        } 

        elseif($chkstorphon && $chkstorphon->admin_approval == 0){
            	$message = array('status'=>'0', 'message'=>'This Phone Number is Already Registered With Another Store.');
	           return $message;
        } 
        elseif($chkstoremail && $chkstoremail->admin_approval == 0){
           	$message = array('status'=>'0', 'message'=>'This Email is Already Registered With Another Store.');
	           return $message;
        } 
       else{           
       
         $lat = $request->lat;
         $lng = $request->lng;
          if($request->hasFile('profile')){
              $image = $request->profile;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('profile');
                $filePath = '/store/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/store/'.$date.'/', $fileName);
            $filePath = '/images/store/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath = 'N/A';
        }
        
        
        if($request->hasFile('id_img')){
              $id_img = $request->id_img;
            $fileName11 = $id_img->getClientOriginalName();
            $fileName11 = str_replace(" ", "-", $fileName11);
           

           if($this->storage_space != "same_server"){
                $image_name = $id_img->getClientOriginalName();
                $id_img = $request->file('id_img');
                $filePath11 = '/store/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath11, fopen($request->file('id_img'), 'r+'), 'public');
            }
            else{
           
           $id_img->move('images/store/'.$date.'/', $fileName);
            $filePath11 = '/images/store/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath11 = 'N/A';
        }
        



    	$insert = DB::table('store')
                    ->insertgetid([
                        'store_name'=>$store_name,
                        'employee_name'=>$emp_name,
                        'phone_number'=>$number,
                        'city'=>$city,
                        'email'=>$email,
                        'del_range'=> $range,
                        'password'=>$password,
                        'address'=>$address,
                        'lat'=>$lat,
                        'lng'=>$lng,
                        'admin_share'=>$share,
                        'store_opening_time'=>$open_time,
                        'store_closing_time'=>$close_time,
                        'time_interval'=>$interval,
                        'admin_approval'=>$admin_approval,
                        'store_photo'=>$filePath,
                        'id_type'=>$id_name,
                        'id_number'=>$id_numb,
                        'id_photo'=>$filePath11,
                        ]);
                        
                        
    if($insert){
          $store = DB::table('store')
                ->where('id',$insert)
                ->first();

        	$message = array('status'=>'1', 'message'=>'Store Registered, please wait for admin approval', 'data'=>$store);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Something went wrong', 'data'=>[]);
	        return $message;
    	}
        
    }
     }
     
     
     public function idlist(Request $request)
     {
      $id=DB::table('id_types')
         ->get();
         
       if(count($id)>0){
        	$message = array('status'=>'1', 'message'=>'id list', 'data'=>$id);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'no id list found');
	        return $message;
    	}
           
     }
}