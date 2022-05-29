<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use App\Models\Admin;
use Auth;
use Illuminate\Support\Facades\Storage;
class NotificationController extends Controller
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
     public function usernotlist(Request $request)
    {
        $title = "Users Notifications";
        $admin_email=Auth::guard('admin')->user()->email;

        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $notification = DB::table('user_notification')
             ->join('users', 'user_notification.user_id','=', 'users.id')
             ->select('users.name','user_notification.*')
             ->paginate(20);  
          if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }
        return view('admin.notifications.userlist',compact("title","admin","logo","admin","notification","url_aws"));
    }
    
    
      public function delete_all_user(Request $request)
    {
           $notification = DB::table('user_notification')
             ->delete();  
        if($notification){
         return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
            }
            else
            {
               return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
            }
    }
        public function delete_read_user(Request $request)
    {
        
       
           $notification = DB::table('user_notification')
                 ->where('read_by_user',1)
                 ->delete();  
        if($notification){
         return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
            }
            else
            {
               return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
            }
    }
    
       public function delete_all_store(Request $request)
    {
        
       
           $notification = DB::table('store_notification')
             ->delete();  
        if($notification){
         return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
            }
            else
            {
               return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
            }
    }
    
       public function delete_all_driver(Request $request)
    {
        
      
           $notification = DB::table('driver_notification')
             ->delete();  
        if($notification){
         return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
            }
            else
            {
               return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
            }
    }
    
     public function storenotlist(Request $request)
    {
        $title = "Stores Notifications";
        $admin_email=Auth::guard('admin')->user()->email;

        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $notification = DB::table('store_notification')
             ->join('store', 'store_notification.store_id','=', 'store.id')
             ->select('store.store_name','store_notification.*')
             ->paginate(20);  
          if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }
        return view('admin.notifications.storelist',compact("title","admin","logo","admin","notification","url_aws"));
    }
     public function drivernotlist(Request $request)
    {
        $title = "Drivers Notifications";
        $admin_email=Auth::guard('admin')->user()->email;

        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $notification = DB::table('driver_notification')
             ->join('delivery_boy', 'driver_notification.dboy_id','=', 'delivery_boy.dboy_id')
             ->select('delivery_boy.boy_name','driver_notification.*')
             ->paginate(20);  
          if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }
        return view('admin.notifications.driverlist',compact("title","admin","logo","admin","notification","url_aws"));
    }
    
     public function adminNotificationuser(Request $request)
    {
        $title = "To Users";
        $admin_email=Auth::guard('admin')->user()->email;

        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }
           $users = DB::table('users')
             ->join('city', 'users.user_city','=', 'city.city_id')
             ->join('society', 'users.user_area','=', 'society.society_id')
             ->join('store', 'city.city_name','=', 'store.city')
             ->select('users.name', 'users.id','city.city_name','society.society_name')
             ->groupBy('users.name', 'users.id','city.city_name','society.society_name')
             ->get();  

        return view('admin.settings.usernotification',compact("title","admin","logo","admin","users","url_aws"));
    }
    
  

    public function userNotificationSend(Request $request)
    {
           $this->validate(
            $request,
                [
                'title' => 'required',
                'text' => 'required',
                'image' => 'mimes:jpeg,png,jpg|max:1000',
                ],
                [
                'title.required' => 'Enter notification title.',
                'text.required' => 'Enter notification text.',
                ]
        );
          $admin_email=Auth::guard('admin')->user()->email;

        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $date = date('d-m-Y');
         $user = $request->user;
          if($user == NULL){
             return redirect()->back()->withErrors(trans('keywords.Please Select any User(s)'));
        }
        $countuser = count($user);
       
        $date = date('d-m-Y');
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }      
        if($request->hasFile('image')){
              $image = $request->image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('image');
                $filePath = '/notification/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
                 $notify_image = $url_aws.$filePath;
            }
            else{
           
           $image->move('images/notification/'.$date.'/', $fileName);
            $filePath = '/images/notification/'.$date.'/'.$fileName;
             $notify_image = $url_aws.$filePath;
        
            }
        }
        else{
            $notify_image = "N/A";
            $filePath="N/A";
        }
         

        $notification_title = $request->title;
        $notification_text = $request->text;
        
        $date = date('d-m-Y');
          
        $created_at = Carbon::now();
        
        $getFcm = DB::table('fcm')
                    ->first();
                    
        $getFcmKey = $getFcm->server_key;
        
          if($countuser >= 600){
              $userin = DB::table('users')
             ->join('city', 'users.user_city','=', 'city.city_id')
             ->join('society', 'users.user_area','=', 'society.society_id')
             ->join('store', 'city.city_name','=', 'store.city')
             ->select('users.device_id','users.name','users.id')
             ->get();
          }
          else{
      $userin = DB::table('users')->select('device_id','name','id')
                        ->WhereIn('id', $user)
                        ->get();
          }         
         $getFcm = DB::table('fcm')
                    ->where('id', '1')
                    ->first();
                    
        $getFcmKey = $getFcm->server_key;
        
        

         
        foreach($userin as $us){
        $get_device_id[] = $us;
        }
        $loop =  count(array_chunk($get_device_id,600));  // count array chunk 1000
        $arrayChunk = array_chunk($get_device_id,600);   // devide array in 1000 chunk
        $device_id = array();
        
    
        for($i=0; $i<$loop ;$i++)
        {
            foreach($arrayChunk[$i] as $all_device_id)
            {       
                   
                        $device_id[] =  $all_device_id->device_id;
                        
                                    $insertNotification = DB::table('user_notification')
                                    ->insert([
                                        'user_id'=>$all_device_id->id,
                                        'noti_title'=>$notification_title,
                                         'image'=>$filePath,
                                        'noti_message'=>$notification_text,
                                      
                                    ]);
            }
             $url = 'https://fcm.googleapis.com/fcm/send';
            $body=$notification_text;
            $customData=$url;
            $json_data = 
                [
                    "registration_ids" => $device_id,
                    "notification" => [
                        "body" => $body,
                        "title" => $notification_title,
                        "image"=>$notify_image
                    ],
                    "data" => [
                        "extra" => $customData
                    ]
                ];
         $data = json_encode($json_data); 
       
        //api_key in Firebase Console -> Project Settings -> CLOUD MESSAGING -> Server key
        $server_key = $getFcmKey;
        //header with content_type api key
        $headers = array(
            'Content-Type:application/json',
            'Authorization:key='.$server_key
        );
        // CURL request to route notification to FCM connection server (provided by Google)
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, $url);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
            $result = curl_exec($ch);
            if ($result === FALSE) {
                die('Oops! FCM Send Error: ' . curl_error($ch));
            }
            curl_close($ch);
            unset($device_id); // unset the array value 

        }
        return redirect()->back()->withSuccess(trans('keywords.Notification Sent to user Successfully'));

    }
    
    
    
    
    
    
    
    
    public function adminNotification(Request $request)
    {
        $title = "To Stores";
        $admin_email=Auth::guard('admin')->user()->email;

        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $store = DB::table('store')
                 ->get();     

        return view('admin.settings.notification',compact("title","admin","logo","admin","store"));
    }


    public function Notification_to_store_Send(Request $request)
    {
        $this->validate(
            $request,
                [
                'notification_title' => 'required',
                'notification_text' => 'required',
                'notify_image' => 'mimes:jpeg,png,jpg|max:400',
                ],
                [
                'notification_title.required' => 'Enter notification title.',
                'notification_text.required' => 'Enter notification text.',
                ]
        );

        $notification_title = $request->notification_title;
        $notification_text = $request->notification_text;
        $st = $request->st;
       if($st == NULL){
             return redirect()->back()->withErrors(trans('keywords.Please Select any Store(s)'));
        }
         $countstore = count($st);
        $date = date('d-m-Y');
         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }   
        if($request->hasFile('notify_image')){
              $image = $request->notify_image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('notify_image');
                $filePath = '/notification/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('notify_image'), 'r+'), 'public');
                 $notify_image = $url_aws.$filePath;
            }
            else{
           
           $image->move('images/notification/'.$date.'/', $fileName);
            $filePath = '/images/notification/'.$date.'/'.$fileName;
            $notify_image = $url_aws.$filePath;
        
            }
        }
        else{
            $notify_image = "N/A";
            $filePath=NULL;
        }
         
        $created_at = Carbon::now();

     
        
        $getFcm = DB::table('fcm')
                    ->select('store_server_key')
                    ->where('id', '1')
                    ->first();
                    
        $getFcmKey = $getFcm->store_server_key;
        
        for($i=0;$i<=($countstore-1);$i++)
        {
            
            $getDevice = DB::table('store')
                        ->select('device_id','store_name')
                        ->where('id', $st[$i])
                        ->first();
                        
             $store_name = $getDevice->store_name;  
            $fcmUrl = 'https://fcm.googleapis.com/fcm/send';
            $token = $getDevice->device_id;;
            

            $notification = [
                'title' => "Hey ".$store_name.", ".$notification_title,
                'body' => $notification_text,
                'image' => $notify_image,
                'sound' => true,
            ];
            
           $extraNotificationData = ["message" => $notification, 'image' => $notify_image,];

            $fcmNotification = [
                'to'        => $token, //single token
                'notification' => $notification,
                'data' => $extraNotificationData,
            ];

            $headers = [
                'Authorization: key='.$getFcmKey,
                'Content-Type: application/json'
            ];

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL,$fcmUrl);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fcmNotification));
            $result = curl_exec($ch);
            curl_close($ch);
        
            $insertNotification = DB::table('store_notification')
                                    ->insert([
                                        'store_id'=>$st[$i],
                                        'not_title'=>$notification_title,
                                        'not_message'=>$notification_text,
                                         'image'=>$filePath,
                                    ]);
        }
        $results = json_decode($result);

        return redirect()->back()->withSuccess(trans('keywords.Notification Sent to Store Successfully'));
    }
    
    
    
   public function adminNotificationdriver(Request $request)
    {
        $title = "To Driver";
        $admin_email=Auth::guard('admin')->user()->email;
       $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $delivery = DB::table('delivery_boy')
                 ->where('added_by','admin')
                 ->get();     

        return view('admin.settings.notification_to_driver',compact("title","admin","logo","admin","delivery"));
    }


    public function Notification_to_driver_Send(Request $request)
    {
        $this->validate(
            $request,
                [
                'notification_title' => 'required',
                'notification_text' => 'required',
                'notify_image' => 'mimes:jpeg,png,jpg|max:400',
                ],
                [
                'notification_title.required' => 'Enter notification title.',
                'notification_text.required' => 'Enter notification text.',
                ]
        );

        $notification_title = $request->notification_title;
        $notification_text = $request->notification_text;
        $st = $request->st;
        if($st == NULL){
             return redirect()->back()->withErrors(trans('keywords.Please Select any Driver(s)'));
        }
         $countstore = count($st);
        $date = date('d-m-Y');
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }   
        if($request->hasFile('notify_image')){
             $image = $request->notify_image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('notify_image');
                $filePath = '/notification/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('notify_image'), 'r+'), 'public');
                 $notify_image = $url_aws.$filePath;
            }
            else{
           
           $image->move('images/notification/'.$date.'/', $fileName);
            $filePath = '/images/notification/'.$date.'/'.$fileName;
            $notify_image = $url_aws.$filePath;
        
            }
        }
        else{
            $notify_image = "N/A";
            $filePath=NULL;
        }
        $created_at = Carbon::now();

     
        
        $getFcm = DB::table('fcm')
                    ->select('driver_server_key')
                    ->where('id', '1')
                    ->first();
                    
        $getFcmKey = $getFcm->driver_server_key;
        
        for($i=0;$i<=($countstore-1);$i++)
        {
            
            $getDevice = DB::table('delivery_boy')
                        ->select('device_id','boy_name')
                        ->where('dboy_id', $st[$i])
                        ->first();
                        
             $store_name = $getDevice->boy_name;  
            $fcmUrl = 'https://fcm.googleapis.com/fcm/send';
            $token = $getDevice->device_id;;
            

            $notification = [
                'title' => "Hey ".$store_name.", ".$notification_title,
                'body' => $notification_text,
                'image' => $notify_image,
                'sound' => true,
            ];
            
           $extraNotificationData = ["message" => $notification, 'image' => $notify_image,];

            $fcmNotification = [
                'to'        => $token, //single token
                'notification' => $notification,
                'data' => $extraNotificationData,
            ];

            $headers = [
                'Authorization: key='.$getFcmKey,
                'Content-Type: application/json'
            ];

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL,$fcmUrl);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fcmNotification));
            $result = curl_exec($ch);
            curl_close($ch);
        
            $insertNotification = DB::table('driver_notification')
                                    ->insert([
                                        'dboy_id'=>$st[$i],
                                        'not_title'=>$notification_title,
                                        'not_message'=>$notification_text,
                                         'image'=>$filePath,
                                    ]);
        }
        $results = json_decode($result);

        return redirect()->back()->withSuccess(trans('keywords.Notification Sent to Driver Successfully'));
    }
      
    
    
    
    
}
