<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
use Hash;
class UserController extends Controller
{
    public function list(Request $request)
    {
        $title = "App User List";
        $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $users = DB::table('users')
                   ->join('city','users.user_city','=','city.city_id')
                   ->join('society','users.user_area','=','society.society_id')
                   ->orderBy('users.reg_date','desc')
                    ->paginate(10);
        
    	return view('admin.user.list', compact('title',"admin", "logo","users"));
    }
    
      public function mem_list(Request $request)
    {
        $title = "App User List";
        $user_id = $request->id;
        $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $userr= DB::table('users')
                   ->where('id',$user_id)
                    ->first();  
        $address= DB::table('address')
                   ->where('user_id',$user_id)
                    ->get();                   
           $users = DB::table('membership_bought')
                   ->join('users','membership_bought.user_id','=','users.id')
                   ->join('membership_plan','membership_bought.mem_id','=','membership_plan.plan_id')
                   ->select('membership_bought.*','users.name','users.user_phone','membership_plan.plan_name')
                   ->orderBy('membership_bought.buy_id','desc')
                   ->where('membership_bought.user_id',$user_id)
                    ->get();
         $ord =DB::table('orders')
              ->join('store','orders.store_id','=','store.id')
             ->join('users', 'orders.user_id', '=','users.id')
             ->join('address', 'orders.address_id', '=','address.address_id')
             ->orderBy('orders.delivery_date','DESC')
             ->where('orders.user_id',$user_id)
             ->paginate(10);
             
         $details  =   DB::table('orders')
                        ->join('store_orders', 'orders.cart_id', '=', 'store_orders.order_cart_id') 
                       ->where('store_orders.store_approval',1)
                       ->get();
    	return view('admin.user.mem', compact('title',"admin", "logo","users","ord","details","userr","address"));
    }
    
     public function ed_user(Request $request)
    {
        $title = "App User Edit";
        $id = $request->id;
        $admin_email=Auth::guard('admin')->user()->email;
    $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        $city= DB::table('city')
            ->join('society','city.city_id','=','society.city_id')
                  ->get();
         $society = DB::table('society')
                           ->get();
           $user = DB::table('users')
                   ->where('id', $id)
                   ->orderBy('reg_date','desc')
                    ->first();
        
    	return view('admin.user.edit', compact('title',"admin", "logo","user","city", "society"));
    }
    
    
     public function up_user(Request $request)
    {
          $id = $request->id;
        $name = $request->name;
        $email = $request->email;
        $phone= $request->phone;
        $city = $request->city;
        $society = $request->society;
        $wallet = $request->wallet;
        $reward = $request->reward;
        $password1 = $request->password;
        $date=date('d-m-Y');
      
         
        
        $this->validate(
            $request,
                [
                    
                    'name' => 'required',
                    'email'=>'required',
                    'phone'=>'required',
                    'city'=>'required',
                    'society'=>'required',
                    'wallet'=>'required',
                    'reward'=>'required'
                ],
                [
                    'name.required'=> 'Enter user name.',
                    'email.required'=> 'Enter user email.',
                    'phone.required'=> 'Enter user phone.',
                    'city.required'=> 'Enter user city.',
                    'society.required'=> 'Enter user society.',
                    'wallet.required'=> 'Enter user wallet.',
                    'reward.required'=> 'Enter user reward.'
                ]
        );

$user =  DB::table('users')
       ->where('id', $id)
       ->first();
       
       if($password1 != NULL){
           $password =bcrypt($password1);
       }else{
           $password =$user->password;
       }

        $insertuser = DB::table('users')
                       ->where('id', $id)
                            ->update([
                                'name'=>$name,
                                'email'=>$email,
                                'password'=>$password,
                                'user_phone'=>$phone,
                                'user_city'=>$city,
                                'user_area'=>$society,
                                'wallet'=>$wallet,
                                'rewards'=>$reward
                            ]);


       
        if($insertuser){
            
            
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Already Updated'));
        }
       
    }
    
    public function daywise(Request $request)
    {
         $date = $request->sel_date; 
         $to_date = $request->to_date;
         $next_date = date('Y-m-d', strtotime($date));
         $next_date2 = date('Y-m-d', strtotime($to_date));
         $title = " User Registrations on ".$next_date." - ".$next_date2;
        $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $users = DB::table('users')
                  ->join('city','users.user_city','=','city.city_id')
                   ->join('society','users.user_area','=','society.society_id')
                   ->where('reg_date','>=', $next_date)
                   ->where('reg_date','<', $next_date2)
                    ->paginate(10);
        
    	return view('admin.user.daywiselist', compact('title',"admin", "logo","users"));
    }
    
     public function block(Request $request)
    {
        
        $user_id = $request->id;
         $users = DB::table('users')
                ->where('id',$user_id)
                ->update(['block'=>1]);
    if($users){   
    return redirect()->back()->withSuccess(trans('keywords.User Blocked Successfully'));
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
    
     public function unblock(Request $request)
    {
        
        $user_id = $request->id;
         $users = DB::table('users')
                ->where('id',$user_id)
                ->update(['block'=>2]);
                
     if($users){   
    return redirect()->back()->withSuccess(trans('keywords.User Unblocked Successfully'));
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
    
     public function del_user(Request $request)
    {
        
        $user_id = $request->id;
         $users = DB::table('users')
                ->where('id',$user_id)
                ->delete();
                
     if($users){  
         $address = DB::table('address')
                  ->where('user_id',$user_id)
                ->delete();
         $orders = DB::table('orders')
                 ->where('user_id',$user_id)
                 ->delete();
         
    return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
}