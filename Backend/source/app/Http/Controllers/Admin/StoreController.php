<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
use Hash;
use Illuminate\Support\Facades\Storage;

class StoreController extends Controller
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
    public function storeclist(Request $request)
    {
         $title = "Home";
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	 $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $city = DB::table('store')
                 ->where('admin_approval', 1)
                 ->paginate(10);
     if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }        
                
        return view('admin.store.storeclist', compact('title','city','admin','logo','url_aws'));    
        
        
    }
    public function store(Request $request)
    {
        $title = "Home";
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $city = DB::table('city')
                ->get();
        $map1 = DB::table('map_api')
             ->first();
         $map = $map1->map_api_key;     
         $mapset = DB::table('map_settings')
                ->first();
        $mapbox = DB::table('mapbox')
                ->first();
        $id = DB::table('id_types')
             ->get();
        return view('admin.store.storeadd', compact('title','city','admin','logo','map','mapset','mapbox','id'));    
        
        
    }
    public function storeadd(Request $request)
    {
        $title = "Home";
        
        $store_name = $request->store_name;
        $emp_name = $request->emp_name;
        $number = $request->number;
        $city = $request->city;
         $citydet=DB::table('city')
                ->where('city_name',$city)
                ->first();
        $city_id=$citydet->city_id;       
        $email = $request->email;
        $id_name = $request->id_name;
        $id_img = $request->id_img;
        $id_numb = $request->id_numb;
        $range = $request->range;
        $password = Hash::make($request->password);
        $orders_per_slot = $request->orders;
        $address = $request->address;
        $share =$request->share;
        $discount = str_replace("%",'', $share);
        $addres = str_replace(" ", "+", $address);
        $address1 = str_replace("-", "+", $addres);
        $start_time = $request->start_time;
        $end_time = $request->end_time;
        $interval = $request->interval;
        $date=date('d-m-Y');
        $checkmap = DB::table('map_api')
                  ->first();
         $mapset= DB::table('map_settings')
                ->first();
         
             
        
        $this->validate(
            $request,
                [
                    
                    'store_name'=>'required',
                    'emp_name'=>'required',
                    'number'=>'required',
                    'range'=>'required',
                    'address'=>'required',
                    'start_time'=>'required',
                    'end_time'=>'required',
                    'interval'=>'required',
                    'email'=>'required',
                    'password'=>'required',
                    'image'=>'required|mimes:jpeg,png,jpg|max:1000',
                    'orders'=>'required',
                    'id_name'=>'required',
                    'id_numb'=>'required',
                    'id_img'=>'required|mimes:jpeg,png,jpg|max:1000',
                ],
                [
                    
                    'store_name.required'=>'Store Name Required',
                    'emp_name.required'=>'Employee Name Required',
                    'number.required'=>'Phone Number Required',
                    'range.required'=>'Enter delivery range',
                     'start_time.required'=>'Enter Start time',
                    'end_time.required'=>'Enter End time',
                    'interval.required'=>'Enter Timeslot Interval',
                    'address.required'=>'Enter store address',
                    'email.required'=>'E-mail Address Required',
                    'password.required'=>'Password Required',
                    'image.required'=>'Image Required',
                    'orders.required'=>'Enter Orders Per Slot',
                     'id_name.required'=>'Select ID',
                    'id_numb.required'=>'Insert ID number',
                    'id_img.required'=>'Insert ID Photo'

                ]
        );       
        $chkstorphon = DB::table('store')
                      ->where('phone_number', $number)
                      ->first(); 
         $chkstoremail = DB::table('store')
                      ->where('email', $email)
                      ->first();              
        
         if($chkstorphon && $chkstoremail){
             return redirect()->back()->withErrors(trans('keywords.This Phone Number and Email Are Already Registered With Another Store'));
        } 

        if($chkstorphon){
             return redirect()->back()->withErrors(trans('keywords.This Phone Number is Already Registered With Another Store'));
        } 
        if($chkstoremail){
             return redirect()->back()->withErrors(trans('keywords.This Email is Already Registered With Another Store'));
        } 
          
        if($mapset->mapbox == 0 && $mapset->google_map == 1){        
        $response =json_decode(file_get_contents("https://maps.googleapis.com/maps/api/geocode/json?address=".urlencode($address1)."&key=".$checkmap->map_api_key));
        
         $lat = $response->results[0]->geometry->location->lat;
         $lng = $response->results[0]->geometry->location->lng;
        }
        else{
           $lat = $request->lat;
           $lng = $request->lng;  
        }
   
          if($request->hasFile('image')){
              $image = $request->image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('image');
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
                $id_img = $request->file('id_image');
                $filePath11 = '/store/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath11, fopen($request->file('id_image'), 'r+'), 'public');
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
                        'city_id'=>$city_id,
                        'email'=>$email,
                        'del_range'=> $range,
                        'password'=>$password,
                        'address'=>$address,
                        'store_opening_time'=>$start_time,
                        'store_closing_time'=>$end_time,
                        'time_interval'=>$interval,
                        'lat'=>$lat,
                        'lng'=>$lng,
                        'admin_share'=>$share,
                        'store_photo'=>$filePath,
                        'orders'=>$orders_per_slot,
                        'id_type'=>$id_name,
                        'id_number'=>$id_numb,
                        'id_photo'=>$filePath11,
                        
                        ]);
                        
      if($insert){
          $society=DB::table('society')
                  ->where('city_id',$city_id)
                  ->get();
                  
          foreach($society as $s){
              $ser_area=DB::table('service_area')
                       ->insert(['store_id'=>$insert,
                       'society_name'=>$s->society_name,
                       'society_id'=>$s->society_id,
                       'delivery_charge'=>0,
                       'added_by'=>0,
                        'city_id'=>$city_id]);
          }          
        return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
      }else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
      }

    }
    
    public function storedit(Request $request)
    {
         $title = "Edit Store";
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $store_id = $request->store_id;
        
        $city = DB::table('city')
                    ->get();
                    
         $id = DB::table('id_types')
             ->get();
       $map1 = DB::table('map_api')
             ->first();
         $map = $map1->map_api_key;   
        $store = DB::table('store')
                ->where('id',$store_id)
                ->first();
         $mapset = DB::table('map_settings')
                ->first();
        $mapbox = DB::table('mapbox')
                ->first();

         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }        
       
        return view('admin.store.storeedit', compact('title','id','city','store','admin','logo','map','mapset','mapbox','url_aws'));    
        
        
    }
    
    public function storeupdate(Request $request)
    {
        $title = "Update store";
        $store_id = $request->store_id;
        
        $share =$request->share;
        $store_name = $request->store_name;
        $emp_name = $request->emp_name;
        $number = $request->number;
         $id_name = $request->id_name;
        $id_img = $request->id_img;
        $id_numb = $request->id_numb;
        $city = $request->city;
        $citydet=DB::table('city')
                ->where('city_name',$city)
                ->first();
        $city_id=$citydet->city_id;        
        $range = $request->range;
        $orders_per_slot = $request->orders;
        $email = $request->email;
        $password = Hash::make($request->password);
        $address = $request->address;
        $addres = str_replace(" ", "+", $address);
        $address1 = str_replace("-", "+", $addres);
        $start_time = $request->start_time;
        $end_time = $request->end_time;
        $interval = $request->interval;
        $date=date('d-m-Y');
        $this->validate(
            $request,
                [
                    
                    'store_name'=>'required',
                    'emp_name'=>'required',
                    'number'=>'required',
                    'range'=>'required',
                    'address'=>'required',
                    'start_time'=>'required',
                    'end_time'=>'required',
                    'interval'=>'required',
                    'email'=>'required',
                    'password'=>'required',
                    'orders'=>'required',
                    'id_name'=>'required',
                    'id_numb'=>'required'
                ],
                [
                    
                    'store_name.required'=>'Store Name Required',
                    'emp_name.required'=>'Employee Name Required',
                    'number.required'=>'Phone Number Required',
                    'range.required'=>'Enter delivery range',
                     'start_time.required'=>'Enter Start time',
                    'end_time.required'=>'Enter End time',
                    'interval.required'=>'Enter Timeslot Interval',
                    'address.required'=>'Enter store address',
                    'email.required'=>'E-mail Address Required',
                    'password.required'=>'Password Required',
                     'orders.required'=>'Enter Orders Per Slot',
                      'id_name.required'=>'Select ID',
                    'id_numb.required'=>'Insert ID number'

                ]
        );       
         $checkmap = DB::table('map_api')
                  ->first();
         $mapset= DB::table('map_settings')
                ->first();
         $chkstorphon = DB::table('store')
                      ->where('phone_number', $number)
                      ->where('id', '!=', $store_id)
                      ->first(); 
         $chkstoremail = DB::table('store')
                      ->where('email', $email)
                      ->where('id', '!=', $store_id)
                      ->first();              
        
         
         if($chkstorphon && $chkstoremail){
             return redirect()->back()->withErrors(trans('keywords.This Phone Number and Email Are Already Registered With Another Store'));
        } 

        if($chkstorphon){
             return redirect()->back()->withErrors(trans('keywords.This Phone Number is Already Registered With Another Store'));
        } 
        if($chkstoremail){
             return redirect()->back()->withErrors(trans('keywords.This Email is Already Registered With Another Store'));
        } 
        
        if($mapset->mapbox == 0 && $mapset->google_map == 1){ 
        $response = json_decode(file_get_contents("https://maps.googleapis.com/maps/api/geocode/json?address=".urlencode($address1)."&key=".$checkmap->map_api_key));
        
         $lat = $response->results[0]->geometry->location->lat;
         $lng = $response->results[0]->geometry->location->lng;
        }
        else{
            $lat = $request->lat;
            $lng = $request->lng;
        }
        
         $getstore = DB::table('store')
                        ->where('id', $store_id)
                        ->first();

        $image = $getstore->store_photo;
        

        if($request->hasFile('image')){
              $this->validate(
            $request,
                [
                    'image' => 'required|mimes:jpeg,png,jpg|max:1000',
                ],
                [
                    'image.required' => 'Choose Store image.',
                ]
              );
            if(file_exists($image)){
                unlink($image);
            }
             $image = $request->image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('image');
                $filePath = '/store/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/store/'.$date.'/', $fileName);
            $filePath = '/images/store/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath = $image;
        }
       
       
         if($request->hasFile('id_img')){
              $this->validate(
            $request,
                [
                    'id_img' => 'required|mimes:jpeg,png,jpg|max:1000',
                ],
                [
                    'id_img.required' => 'Choose ID image.',
                ]
              );
              $id_img = $request->id_img;
            $fileName11 = $id_img->getClientOriginalName();
            $fileName11 = str_replace(" ", "-", $fileName11);
           

           if($this->storage_space != "same_server"){
                $image_name = $id_img->getClientOriginalName();
                $id_img = $request->file('id_image');
                $filePath11 = '/store/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath11, fopen($request->file('id_image'), 'r+'), 'public');
            }
            else{
           
           $id_img->move('images/store/'.$date.'/', $fileName11);
            $filePath11 = '/images/store/'.$date.'/'.$fileName11;
        
            }
        }
        else{
            $filePath11 = $getstore->id_photo;
        }
        
    	 $insert = DB::table('store')
    	            ->where('id',$store_id)
                    ->update([
                        'store_name'=>$store_name,
                        'employee_name'=>$emp_name,
                        'phone_number'=>$number,
                        'city'=>$city,
                        'city_id'=>$city_id,
                        'email'=>$email,
                        'del_range'=>$range,
                        'password'=>$password,
                         'store_opening_time'=>$start_time,
                        'store_closing_time'=>$end_time,
                        'time_interval'=>$interval,
                        'address'=>$address,
                        'lat'=>$lat,
                        'lng'=>$lng,
                        'admin_share'=>$share,
                        'store_photo'=>$filePath,
                         'orders'=>$orders_per_slot,
                          'id_type'=>$id_name,
                        'id_number'=>$id_numb,
                        'id_photo'=>$filePath11,
                        ]);
     
      $store = DB::table('store')
                ->where('id',$store_id)
                ->first();
     if($city_id != $store->city_id){
          $ser_area_del=DB::table('service_area')
                    ->where('id',$store_id)
                    ->delete();
          $society=DB::table('society')
                  ->where('city_id',$city_id)
                  ->get();
                  
          foreach($society as $s){
              $ser_area=DB::table('service_area')
                       ->insert(['store_id'=>$insert,
                       'society_name'=>$s->society_name,
                       'society_id'=>$s->society_id,
                       'delivery_charge'=>0,
                       'added_by'=>0,
                       'city_id'=>$city_id]);
          }     
     }
            
     return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
    }
    
    public function storedelete(Request $request)
    {
        
                    $store_id=$request->store_id;
            
                	$delete=DB::table('store')->where('id',$store_id)->delete();
                    if($delete)
                    {
                    DB::table('store_products')->where('store_id',$store_id)->delete();
                     DB::table('orders')->where('store_id',$store_id)->delete();
                     DB::table('store_orders')->where('store_id',$store_id)->delete();
                     DB::table('store_notification')->where('store_id',$store_id)->delete();
                    return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
            
                    }
                    else
                    {
                       return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
                    }
    }
}