<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Traits\SendMail;
use Auth;

class DriverfinanceController extends Controller
{
    use SendMail;
     public function boy_incentive(Request $request)
    {
         $title = "Driver Incentive";
          $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
          $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();  
        
         $total_earnings=DB::table('driver_incentive')
                           ->leftJoin('delivery_boy','driver_incentive.dboy_id','=','delivery_boy.dboy_id')
                           ->leftJoin('orders','delivery_boy.dboy_id','=','orders.dboy_id')
                           ->leftJoin('driver_bank','delivery_boy.dboy_id','=','driver_bank.driver_id')
                           ->select('delivery_boy.dboy_id','delivery_boy.boy_name','delivery_boy.boy_phone','delivery_boy.boy_loc','delivery_boy.boy_city','driver_incentive.earned_till_now','driver_incentive.paid_till_now','driver_incentive.remaining','driver_bank.bank_name','driver_bank.ac_no','driver_bank.holder_name','driver_bank.ifsc','driver_bank.upi',DB::raw('COUNT(orders.order_id) as count'))
                           ->groupBy('delivery_boy.dboy_id','delivery_boy.boy_name','delivery_boy.boy_phone','delivery_boy.boy_loc','delivery_boy.boy_city','driver_incentive.earned_till_now','driver_incentive.paid_till_now','driver_incentive.remaining','driver_bank.bank_name','driver_bank.ac_no','driver_bank.holder_name','driver_bank.ifsc','driver_bank.upi')
                           ->where('delivery_boy.added_by','store')
                           ->where('orders.order_status','Completed')
                           ->where('delivery_boy.store_id',$store->id)
                           ->paginate(10);
                        
    	return view('store.d_boy.finance', compact('title',"store", "logo","total_earnings"));
    }
    
    
     public function incentive_pay(Request $request)
    {
        
        $dboy_id=$request->dboy_id;
       $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
     $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();  
        $amt = $request->amt;
        $check = DB::table('driver_incentive')
                ->where('dboy_id',$dboy_id)
                ->first();
        $check2 = DB::table('delivery_boy')
                ->where('dboy_id',$dboy_id)
                ->first();        

        $new_amount = $check->paid_till_now + $amt; 
        $new_rem = $check->remaining - $amt;
        $update = DB::table('driver_incentive')
                ->where('dboy_id',$dboy_id)
                ->update(['paid_till_now'=>$new_amount,
                'remaining'=>$new_rem]);
       
        if($update){
                $boy_name = $check2->boy_name;
                $boy_phone = $check2->boy_phone;  
                $app_name = $logo->name;
                $Msg1 = 'Amount of '.$amt.' marked paid successfully to '.$check2->boy_name.'.'; 
                               
                  

            
            
             return redirect()->back()->withSuccess(trans('keywords.Amount of').' '.$amt.' '.trans('keywords.marked paid successfully to').' '.$check2->boy_name);
        }
        else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
       
}
