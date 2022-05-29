<?php
namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Setting;
use Carbon\Carbon;
use App\Models\Admin;
use Auth;
use Illuminate\Support\Facades\Storage;

class SettingsController extends Controller
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
   
     public function app_details(Request $request)
    {
        
        $title="Global Settings";
       $p = Setting::get();
      $admin_email=Auth::guard('admin')->user()->email;
       $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->first();  
        $cc = DB::table('country_code')
            ->first();
        $currency = DB::table('currency')
            ->first();  
        $fcm = DB::table('fcm')
                ->first();
          
   
                
          $msg91 = DB::table('msg91')
                ->first();   
          $twilio = DB::table('twilio')
                ->first(); 
            $smsby = DB::table('smsby')
                ->first(); 
            $firebase = DB::table('firebase')
                      ->first();
                      
            $fb_iso = DB::table('firebase_iso')
                ->first();
                
               $g = DB::table('map_api')
                ->first();   
          $m = DB::table('mapbox')
                ->first(); 
          $mset = DB::table('map_settings')
                ->first();     
           $notice = DB::table('app_notice')
                ->first(); 

            $referral = DB::table('referral_points')
                       ->first();
                       
            $incentive = DB::table('admin_driver_incentive')
                       ->first();
                       
          $usernull =  DB::table('users') 
          ->where('email','!=', NULL)
           ->where('user_phone','!=', NULL)
           ->where('referral_code', NULL)
              ->get();
              
        $usernull1 =  DB::table('users') 
         ->where('email','!=', NULL)
           ->where('user_phone','!=', NULL)
              ->get();  
              
              
        $app_link = DB::table('app_link')
                  ->first();

         $space = DB::table('image_space') 
                ->first();

       if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }      
         return view('admin.settings.app_details',compact("admin_email","admin",'title','logo','cc','currency', 'fcm','msg91','twilio','smsby','firebase','fb_iso','g','m', 'mset','notice','referral','incentive','p','usernull','app_link','space','url_aws','usernull1'));
      

    }
    
     public function updatereferral(Request $request)
    {
    $user =  DB::table('users') 
           ->where('referral_code', NULL)
              ->get();
               
    if($user){ 
    foreach($user as $users){
    $usersss = str_replace(' ', '', $users->name);  

        $u_name2 = str_replace('.', '', $usersss);
        $u_name3 = str_replace('-', '', $u_name2);
        $u_name = str_replace(',', '', $u_name3);
    $user_id = $users ->id;
    $startingg1 = strtoupper(substr($u_name, 0, 3));
    $startingg = str_replace(' ', '', $startingg1);
    $chars ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                    $referral_code = "";
                    for ($i = 0; $i < 5; $i++){
                      $referral_code .= $chars[mt_rand(0, strlen($chars)-1)];
                    } 
    
    $update=  DB::table('users') 
              ->where('id',$user_id)
              ->update(['referral_code'=>$startingg.$referral_code]);
    }
   
   return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Already Updated'));
        }
    
    }

    
    
    
    
    public function updateref(Request $request)
    {
        
        
  
            $this->validate(
                $request,
                    [
                         'name'=>'required',
                        'min_amount' => 'required',
                        'max_amount' => 'required',
                    ],
                    [   
                        'name.required'=>'enter name for referral points',
                        'min_amount.required' => 'enter referral points min amount.',
                        'max_amount.required' => 'enter referral points max amount.',
                    ]
            );

            $min_amount = $request->min_amount;
            $max_amount = $request->max_amount;
            $scratch_card_offer = array('min'=>$min_amount, 'max'=>$max_amount);
            $name = $request->name;

         $check = DB::table('referral_points')
                ->first();

        if($check){
        $insertScratchEarn = DB::table('referral_points')
                            ->update([
                                'name'=>$name,
                                'points'=>$scratch_card_offer,
                                'updated_at'=>Carbon::now()
                            ]);
            }
        else{
                  $insertScratchEarn = DB::table('referral_points')
                            ->insert([
                                'name'=>$name,
                                'points'=>$scratch_card_offers,
                                'updated_at'=>$updated_at
                            ]);

           }
        
        if($insertScratchEarn){
            return redirect()->back()->withErrors(trans('keywords.Updated Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Already Updated'));
        }
    }
 
    public function updateappdetails(Request $request)
    {
        $this->validate(
            $request,
                [
                    'app_name' => 'required',
                    'country_code'=>'required',
                     'number_length'=>'required',
                     'last_loc'=>'required',
                     'footer'=>'required',
                     'live_chat'=>'required'
                ],
                [
                    'app_name.required' => 'Enter App Name.',
                    'country_code.required'=> 'Enter Country Code',
                    'number_length.required'=>'Enter Phone number length',
                    'last_loc.required'=>'Enter Last location save or not',
                    'footer'=>'Enter Footer Text',
                    'live_chat'=>'Select live chat value'
                    
                ]
        );
        $last_loc =$request->last_loc;
        $live_chat=$request->live_chat;
        $footer_text = $request->footer;
        $country_code = $request->country_code;
        $number_length = $request->number_length;
        $check = DB::table('tbl_web_setting')
               ->first();
        $app_name = $request->app_name;
          $date = date('d-m-Y');
        if($check){
        $oldapplogo = $check->icon;
        $oldfavicon = $check->favicon;
        }
        
         if($request->hasFile('app_icon')){
             
                $image = $request->app_icon;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('app_icon');
                $filePath = '/app_icon/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('app_icon'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/app_logo/app_icon/'.$date.'/', $fileName);
            $filePath = '/images/app_logo/app_icon/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath = $oldapplogo;
        }
        if($check->favicon != NULL){
        
         if($request->hasFile('favicon')){
                $image = $request->favicon;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('favicon');
                $filePath1= '/favicon/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath1, fopen($request->file('favicon'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/app_logo/favicon/'.$date.'/', $fileName);
            $filePath1 = '/images/app_logo/favicon/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath1 = $oldfavicon;
        }
        }
        else{
            if($request->hasFile('favicon')){
           
                $image = $request->favicon;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('favicon');
                $filePath1 = '/favicon/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath1, fopen($request->file('favicon'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/app_logo/favicon/'.$date.'/', $fileName);
            $filePath1 = '/images/app_logo/favicon/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath1 = $oldapplogo;
        } 
        }
        
        $check2 = DB::table('country_code')
               ->first();
       if($check2){
        

        $updatecc = DB::table('country_code')
                ->update(['country_code'=> $country_code]);
    
      }
      else{
          $updatecc = DB::table('country_code')
                ->insert(['country_code'=> $country_code]);
      } 
        
      if($check){
        

        $update = DB::table('tbl_web_setting')
                ->update(['name'=> $app_name,'icon'=> $filePath, 'favicon'=>$filePath1, 'number_limit'=>$number_length,'last_loc'=>$last_loc,'footer_text'=>$footer_text,'live_chat'=>$live_chat]);
    
      }
      else{
          $update = DB::table('tbl_web_setting')
                ->insert(['name'=> $app_name,'icon'=> $filePath, 'favicon'=>$filePath1, 'number_limit'=>$number_length,'last_loc'=>$last_loc,'footer_text'=>$footer_text,'live_chat'=>$live_chat]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
          if($updatecc){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
             }
             else{
                 return redirect()->back()->withErrors(trans('keywords.Already Updated'));
             }
        
     }
    }
    
    
    
   
    public function updatemsg91(Request $request)
    {
         $sender = $request->sender_id;
        $api_key = $request->api;
        $this->validate(
            $request,
                [
                    'sender_id' => 'required',
                    'api'=>'required',
                ],
                [
                    'sender_id.required' => 'Enter Sender ID.',
                    'api.required' =>'Enter api key',
                ]
        );
        
        
        $check = DB::table('msg91')
               ->first();
       
    
      if($check){
        $update = DB::table('msg91')
                ->update(['sender_id'=> $sender,'api_key'=> $api_key,'active'=>1]);
    
      }
      else{
          $update = DB::table('msg91')
                ->insert(['sender_id'=> $sender,'api_key'=> $api_key,'active'=>1]);
      }
     if($update){
         $ue = DB::table('smsby')
                ->update(['msg91'=> 1,'twilio'=> 0,'status'=>1]);
         $deactivetwilio = DB::table('twilio')
                ->update(['active'=>0]);        
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Nothing to Update'));
     }
    }
    
    
  
 
    public function updatemap(Request $request)
    {
        $api_key = $request->api;
        $this->validate(
            $request,
                [
                    'api'=>'required',
                ],
                [
                    'api.required' =>'Enter api key',
                ]
        );
        
        
        $check = DB::table('map_api')
               ->first();
       
    
      if($check){
        

        $update = DB::table('map_api')
                ->update(['map_api_key'=> $api_key]);
    
      }
      else{
          $update = DB::table('map_api')
                ->insert(['map_api_key'=> $api_key]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
    }
     
  

    public function updatefcm(Request $request)
    {
        $fcm = $request->fcm;
         $fcm2 = $request->fcm2;
          $fcm3 = $request->fcm3;
        $this->validate(
            $request,
                [
                    'fcm'=>'required',
                    'fcm2'=>'required',
                    'fcm3'=>'required',
                ],
                [
                    'fcm.required' =>'Enter User App FCM server key',
                    'fcm2.required'=>'Enter Store App FCM server key',
                    'fcm3.required'=>'Enter Store App FCM server key',
                ]
        );
        
        
        $check = DB::table('fcm')
               ->first();
       
    
      if($check){
        

        $update = DB::table('fcm')
                ->update(['server_key'=> $fcm,
                'store_server_key'=>$fcm2,
                'driver_server_key'=>$fcm3]);
    
      }
      else{
          $update = DB::table('fcm')
                ->insert(['server_key'=> $fcm,
                'store_server_key'=>$fcm2,
                'driver_server_key'=>$fcm3]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
    }
  
 
    public function updatefirebase_iso(Request $request)
    {
        $iso_code = $request->iso_code;
        $this->validate(
            $request,
                [
                    'iso_code'=>'required',
                ],
                [
                    'iso_code.required' =>'Enter Firebase ISO code',
                ]
        );
        
        
        $check = DB::table('firebase_iso')
               ->first();
       
    
      if($check){
        

        $update = DB::table('firebase_iso')
                ->update(['iso_code'=> $iso_code]);
    
      }
      else{
          $update = DB::table('firebase_iso')
                ->insert(['iso_code'=> $iso_code]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
    }
     
        
    
 
    public function updatecurrency(Request $request)
    {
        $currency_sign = $request->currency_sign;
        $currency_name = $request->currency_name;
        $this->validate(
            $request,
                [
                    'currency_sign'=>'required',
                    'currency_name'=>'required',
                ],
                [
                    'currency_sign.required' =>'Enter Currency Sign',
                    'currency_name'=>'Enter Currency Name',
                ]
        );
        
        
        $check = DB::table('currency')
               ->first();
       
    
      if($check){
        

        $update = DB::table('currency')
                ->update(['currency_sign'=> $currency_sign, 'currency_name'=> $currency_name]);
    
      }
      else{
          $update = DB::table('currency')
                ->insert(['currency_sign'=> $currency_sign, 'currency_name'=> $currency_name]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
    }
     
         public function prv(Request $request)
    {
        
        $title="Edit Payout Request Validation";
       
        $admin_email=Auth::guard('admin')->user()->email;
     $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();  
                
            $prv = DB::table('payout_req_valid')
                ->first();   
         return view('admin.settings.payoutreq_validation',compact("admin_email","admin",'title','logo','prv'));
      

    }
 
    public function updateprv(Request $request)
    {
        $min_amt = $request->min_amt;
        $min_days = $request->min_days;
        $this->validate(
            $request,
                [
                    'min_amt' => 'required',
                    'min_days'=>'required',
                ],
                [
                    'min_amt.required' => 'Enter minimum amount.',
                    'min_days.required' =>'Enter minimum days',
                ]
        );
        
        
        $check = DB::table('payout_req_valid')
               ->first();
       
    
      if($check){
        

        $update = DB::table('payout_req_valid')
                ->update(['min_amt'=> $min_amt,'min_days'=> $min_days]);
    
      }
      else{
          $update = DB::table('payout_req_valid')
                ->insert(['min_amt'=> $min_amt,'min_days'=> $min_days]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
    } 
     
     
        public function updateincentive(Request $request)
    {
        $incentive = $request->incentive;
        $this->validate(
            $request,
                [
                    'incentive'=>'required',
                ],
                [
                    'incentive.required' =>'Enter Driver Incentive',
                ]
        );
        
        
        $check = DB::table('admin_driver_incentive')
               ->first();
       
    
      if($check){
        

        $update = DB::table('admin_driver_incentive')
                ->update(['incentive'=> $incentive]);
    
      }
      else{
          $update = DB::table('admin_driver_incentive')
                ->insert(['incentive' => $incentive]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
    }
    
    
     public function app_link(Request $request)
    {
         $an_link = $request->an_link;
         $ios_link = $request->ios_link;
        $this->validate(
            $request,
                [
                    'an_link' => 'required',
                    'ios_link'=>'required',
                ],
                [
                    'an_link.required' => 'Enter Android App Link.',
                    'ios_link.required' =>'Enter IOS app link',
                ]
        );
        
        
        $check = DB::table('app_link')
               ->first();
       
    
      if($check){
        $update = DB::table('app_link')
                ->update(['android_app_link'=> $an_link ,'ios_app_link'=> $ios_link]);
    
      }
      else{
          $update = DB::table('app_link')
                ->insert(['android_app_link'=> $an_link ,'ios_app_link'=> $ios_link]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Nothing to Update'));
     }
    }
     



    public function updatespace(Request $request)
    {
        $status = $request->status;
        $this->validate(
            $request,
                [
                    'status'=>'required',
                ],
                [
                    'status.required' =>'Select image space',
                ]
        );
        if($status=="do"){
            $do = 1;
            $aws = 0;
            $ss = 0;
        }elseif($status=="aws"){
            $do = 0;
            $aws = 1;
            $ss = 0;
        }else{
            $do = 0;
            $aws = 0;
            $ss = 1; 
        }
        
        
        $check = DB::table('image_space')
               ->first();
       
    
      if($check){
        

        $update = DB::table('image_space')
                ->update(['digital_ocean'=> $do, 'aws'=>$aws, 'same_server'=>$ss]);
    
      }
      else{
          $update = DB::table('image_space')
                ->insert(['digital_ocean'=> $do, 'aws'=>$aws, 'same_server'=>$ss]);
      }
     if($update){
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }
     else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
    }

}
