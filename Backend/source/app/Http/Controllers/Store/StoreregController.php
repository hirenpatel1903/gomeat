<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Hash;
use Session;
use Auth;
use Illuminate\Support\Facades\Storage;
class StoreregController extends Controller
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
  public function register_store(Request $request)
  {
    if(Session::has('bamaStore')){
        return redirect()->route('storeHome');    
    }
    
    $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
    $mapset = DB::table('map_settings')     
           ->first();
    $city = DB::table('city')
          ->get();
          
    $mapbox = DB::table('mapbox')
            ->first();
                
    $map1 = DB::table('map_api')
             ->first();
    $map = $map1->map_api_key;               
  	return view('store.auth.stregister', compact('logo','mapset','city','mapbox','map'));
  }

  public function store_registered(Request $request)
  {	
          $this->validate(
            $request,
                [
                    
                    'store_name' => 'required',
                    'store_doc' => 'required|mimes:jpeg,png,jpg|max:2048',
                    'emp_name' => 'required',
                    'city'=>'required',
                    'email'=>'required',
                    'store_phone'=>'required',
                    'password'=>'required',
                    'address'=>'required',
                    'share'=>'required'
                ],
                [
                    'store_name.required' => 'Enter store name.',
                    'store_doc.required' => 'Choose document proof.',
                    'emp_name.required' => 'Enter Owner Name.',
                    'city.required' => 'Choose City.',
                    'email.required'=>'Choose Store Email.',
                    'store_phone.required'=>'Enter Store Phone.',
                    'password.required'=> 'Enter password',
                    'address.required'=>'Enter Address',
                    'share.required'=>'Enter admin share'
                ]
        );
     	$store_name = $request->store_name;
        $emp_name = $request->emp_name;
        $number = $request->store_phone;
        $city = $request->city;
        $email = $request->email;
        $range = $request->del_range;
        $password = $request->password;
        $address = $request->address;
        $share =$request->share;
        $date = date('d-m-Y');
         
        
            $image = $request->store_doc;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('store_doc');
                $filePath = '/store/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('store_doc'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/store_doc/'.$date.'/', $fileName);
            $filePath = '/images/store_doc/'.$date.'/'.$fileName;
        
            }
        
         if($request->hasFile('image')){
              $image1 = $request->image;
            $fileName1 = $image->getClientOriginalName();
            $fileName1 = str_replace(" ", "-", $fileName1);
           

           if($this->storage_space != "same_server"){
                $image_name1 = $image1->getClientOriginalName();
                $image1 = $request->file('image');
                $filePath1 = '/store/'.$image_name1;
                Storage::disk($this->storage_space)->put($filePath1, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/store/'.$date.'/', $fileName1);
            $filePath1 = '/images/store/'.$date.'/'.$fileName1;
        
            }
        }
        else{
            $filePath1 = 'N/A';
        }

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
	           return redirect()->route('store_register')->withErrors(trans('keywords.This Phone Number and Email Are Already Registered With Another Store and waiting for Admin Approval'));
        } 

        elseif($chkstorphon && $chkstorphon->admin_approval == 0){
	            return redirect()->route('store_register')->withErrors(trans('keywords.This Phone Number is Already Registered With Another Store and waiting for Admin Approval'));
        } 
        elseif($chkstoremail && $chkstoremail->admin_approval == 0){
        
	         return redirect()->route('store_register')->withErrors(trans('keywords.This Email is Already Registered With Another Store and waiting for Admin Approval'));
        } 
         elseif($checkall && $checkall->admin_approval == 1){
             
	          return redirect()->route('store_register')->withErrors(trans('keywords.This Phone Number and Email Are Already Registered With Another Store'));
        } 

        elseif($chkstorphon && $chkstorphon->admin_approval == 0){
            	
	          return redirect()->route('store_register')->withErrors(trans('keywords.This Phone Number is Already Registered With Another Store'));
        } 
        elseif($chkstoremail && $chkstoremail->admin_approval == 0){
           
	        return redirect()->route('store_register')->withErrors(trans('keywords.This Email is Already Registered With Another Store'));
        } 
       else{ 
        $mapapi = DB::table('map_api')
                 ->first();
         $mapset= DB::table('map_settings')
                ->first();  
          $key = $mapapi->map_api_key;  
        if($mapset->mapbox == 0 && $mapset->google_map == 1){ 
        $response = json_decode(file_get_contents("https://maps.googleapis.com/maps/api/geocode/json?address=".$address1."&key=".$key));
        
        
         $lat = $response->results[0]->geometry->location->lat;
         $lng = $response->results[0]->geometry->location->lng;
        }
        else{
            $lat = $request->lat;
            $lng = $request->lng;
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
                        'store_photo'=>$filePath1,
                        'admin_share'=>$share,
                        'admin_approval'=>$admin_approval
                        ]); 
      if($insert){
          $store = DB::table('store')
                ->where('store_id',$insert)
                ->first();  
        $docins =  DB::table('store_doc')
                ->insert(['store_id'=>$insert,
                'document'=>$filePath
                ]);
        
                
        return redirect()->route('store_register')->withErrors(trans('keywords.Store Registered! please wait for Admin Approval'));
      }
    }
  }
  
  
 
}
