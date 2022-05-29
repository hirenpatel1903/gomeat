<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
class UserwalletController extends Controller
{
    public function list(Request $request)
    {
        $title = "wallet_recharge_history";
        $admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
           $users = DB::table('wallet_recharge_history')
                   ->join('users','wallet_recharge_history.user_id','=','users.id')
                   ->select('wallet_recharge_history.*', 'users.name', 'users.user_phone','users.wallet')
                   ->orderBy('wallet_recharge_history', 'DESC')
                    ->paginate(10);
        
    	return view('admin.user.wallet', compact('title',"admin", "logo","users"));
    }


      public function pay(Request $request)
    {
        $req_id = $request->id;
        
        $st = DB::table('users')
            ->where('id',$req_id) 
            ->first();
       
        
        if($st){
           $store_id=$st->id;
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $amt = $request->amt;
       $wallet = $st->wallet;
       $add = $wallet+$amt;
       
        $update = DB::table('users')
                ->where('id',$req_id)
                ->update(['wallet'=>$add]);
       
            
            
             return redirect()->back()->withSuccess(trans('keywords.Amount of').' '.$amt.' '.trans('keywords.recharged on user wallet.'));
        }
        else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }

  }