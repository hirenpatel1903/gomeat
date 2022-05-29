<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;

class ReedemController extends Controller
{

    public function reedem(Request $request)
    {
        $title = "Update Redeem Values";
      $admin_email=Auth::guard('admin')->user()->email;
    $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $reedem_id = $request->reedem_id;
        
        $reedem = DB::table('reedem_values')
                
                ->first();
                
                
        return view('admin.reward.reedemedit', compact('title',"reedem",'logo','admin'));    
        
        
    }

    
    public function reedemupdate(Request $request)
    {
        $reward_point = $request->reward_point;
        $value = $request->value;
    	 $insert = DB::table('reedem_values')
                    ->update([
                        'reward_point'=>$reward_point,
                        'value'=>$value,
                        ]);
     
    return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));

    }

}