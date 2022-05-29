<?php
namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use App\Setting;
use Session;
use Carbon\Carbon;

class PayController extends Controller
{

    public function updatepymntvia($store = '',Request $request)
    {
       
		    foreach($_POST as $key => $value){
				 if($key == "_token"){
					 continue;
				 }
				 
				 $data = array();
				 $data['value'] = $value; 
				 $data['updated_at'] = Carbon::now();
				 if(Setting::where('name', $key)->exists()){				
					Setting::where('name','=',$key)->update($data);			
				 }else{
					$data['name'] = $key; 
					$data['created_at'] = Carbon::now();
					Setting::insert($data); 
				 }
		    } //End Loop
       return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
    }
    
     public function gateway_status(Request $request)
    {  
        $get_status = $request->gateway;
        if($get_status=='razorpay'){
            $update1 = DB::table('settings')
                    ->where('name','paypal_active')
                    ->update(['value'=>'No']);
            $update2 = DB::table('settings')
                    ->where('name','razorpay_active')
                    ->update(['value'=>'Yes']);
            $update3 = DB::table('settings')
                    ->where('name','stripe_active')
                    ->update(['value'=>'No']);
            $update4 = DB::table('settings')
                    ->where('name','paystack_active')
                    ->update(['value'=>'No']);
                    
        }elseif($get_status=='paypal'){
            $update1 = DB::table('settings')
                    ->where('name','paypal_active')
                    ->update(['value'=>'Yes']);
            $update2 = DB::table('settings')
                    ->where('name','razorpay_active')
                    ->update(['value'=>'No']);
            $update3 = DB::table('settings')
                    ->where('name','stripe_active')
                    ->update(['value'=>'No']);
            $update4 = DB::table('settings')
                    ->where('name','paystack_active')
                    ->update(['value'=>'No']);
        }elseif($get_status=='stripe'){
            $update1 = DB::table('settings')
                    ->where('name','paypal_active')
                    ->update(['value'=>'No']);
            $update2 = DB::table('settings')
                    ->where('name','razorpay_active')
                    ->update(['value'=>'No']);
            $update3 = DB::table('settings')
                    ->where('name','stripe_active')
                    ->update(['value'=>'Yes']);
            $update4 = DB::table('settings')
                    ->where('name','paystack_active')
                    ->update(['value'=>'No']);
        }else{
            $update1 = DB::table('settings')
                    ->where('name','paypal_active')
                    ->update(['value'=>'No']);
            $update2 = DB::table('settings')
                    ->where('name','razorpay_active')
                    ->update(['value'=>'No']);
            $update3 = DB::table('settings')
                    ->where('name','stripe_active')
                    ->update(['value'=>'No']);
            $update4 = DB::table('settings')
                    ->where('name','paystack_active')
                    ->update(['value'=>'Yes']);
        }
        
                   
        if($update1 || $update2 || $update3 || $update4)   { 
         return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }            
     else{
          return redirect()->back()->withErrors(trans('keywords.Nothing to Update'));
     }

    }
    
}