<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\carbon;
use App;
use App\Models\Admin;
use Auth;
class OrderstatussController extends Controller
{

    public function change(Request $request)
    {
       $cart_id = $request->cart_id;
       
        $user = DB::table('orders')
              ->where('cart_id',$cart_id)
              ->first();
        $user_id1 = $user->user_id;
         $userwa1 = DB::table('users')
                     ->where('id',$user_id1)
                     ->first();
      $reason = 'Cancelled By Admin';
      $order_status = 'Cancelled';
      $updated_at = Carbon::now();
      $order = DB::table('orders')
                  ->where('cart_id', $cart_id)
                  ->update([
                        'cancelling_reason'=>$reason,
                        'order_status'=>$order_status,
                        'updated_at'=>$updated_at]);
      
       if($order){
        if($user->payment_method == 'COD' || $user->payment_method == 'Cod' || $user->payment_method == 'cod'){
            $newbal1 = $userwa1->wallet + $user->paid_by_wallet;  
            
            $userwalletupdate = DB::table('users')
             ->where('id',$user_id1)
             ->update(['wallet'=>$newbal1]);  
              }
          else{
              if($user->payment_status=='success'){
                  $newbal1 = $userwa1->wallet + $user->rem_price + $user->paid_by_wallet;
                  
                  $userwalletupdate = DB::table('users')
               ->where('id',$user_id1)
               ->update(['wallet'=>$newbal1]);  
              }
              else{
                   $newbal1 = $userwa1->wallet;    
              }
             }                 
           
        	 return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    
    
    
    
       public function assigndboy(Request $request)
    {
         $date = date('Y-m-d');
         $day = 1;
         $next_date = date('Y-m-d', strtotime($date.' + '.$day.' days'));
         $cart_id=$request->id;
         $d_boy = $request->d_boy;
         $boy = DB::table('delivery_boy')
              ->where('dboy_id',$d_boy)
              ->first();
         $admin_email=Auth::guard('admin')->user()->email;
         $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
      
          $ord =DB::table('orders')
             ->where('cart_id', $cart_id)
             ->update(['dboy_id'=>$d_boy, 'time_slot'=>'anytime','delivery_date'=>$next_date,'order_status'=>'Confirmed']);
             
      
      return redirect()->back()->withSuccess(trans('keywords.Assigned to').' '.$boy->boy_name.' '. trans('keywords.Successfully'));
    }
}