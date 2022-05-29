<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;

class RewardController extends Controller
{
    public function RewardList(Request $request)
    {
         $title = "Reward Point List";
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $reward = DB::table('reward_points')
                ->get();
                
        return view('admin.reward.rewardlist', compact('title','reward','admin','logo'));    
        
        
    }
    public function reward(Request $request)
    {
        $title = "Add Reward Point";
          $admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
         $reward = DB::table('reward_points')
                ->get();
                
        return view('admin.reward.rewardadd', compact('title','reward','admin','logo'));    
        
        
    }
    public function rewardadd(Request $request)
    {
        $title = "Home";
        
        $min_cart_value = $request->min_cart_value;
        $reward_value = $request->reward_points;
        
        
        $this->validate(
            $request,
                [
                    
                    'min_cart_value'=>'required',
                    'reward_points'=>'required',
                   
                   
                ],
                [
                    
                    'min_cart_value.required'=>'Minimum Value Required',
                    'reward_points.required'=>'Reward Point Required',
                   
                   

                ]
        );
        
    	$insert = DB::table('reward_points')
                    ->insertgetid([
                        'min_cart_value'=>$min_cart_value,
                        'reward_point'=>$reward_value,
                        
                        ]);
                        
      if($insert){
        return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
      }else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
      }

    }
    
    public function rewardedit(Request $request)
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
        
        $reward_id = $request->reward_id;

        $reward = DB::table('reward_points')
                ->where('reward_id',$reward_id)
                ->first();
                
        return view('admin.reward.rewardedit', compact('title','reward','admin','logo'));    
        
        
    }
    
    public function rewardupate(Request $request)
    {
        $min_cart_value = $request->min_cart_value;
        $reward_value = $request->reward_points;
       
        $reward_id = $request->reward_id;
        
        $this->validate(
            $request,
                [
                    
                    'min_cart_value'=>'required',
                    'reward_points'=>'required',
                    
                   
                ],
                [
                    
                    'min_cart_value.required'=>'Minimum Value Required',
                    'reward_points.required'=>'Reward Point Required',
                    
                   

                ]
        );
        
    	 $insert = DB::table('reward_points')
    	            ->where('reward_id',$reward_id)
                    ->update([
                        'min_cart_value'=>$min_cart_value,
                        'reward_point'=>$reward_value,
                       
                        ]);
                    
     
        return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
    }
    
    public function rewarddelete(Request $request)
    {
        
        $reward_id=$request->reward_id;

    	$delete=DB::table('reward_points')->where('reward_id',$reward_id)->delete();
        if($delete)
        {
        return redirect()->back()->withSuccess(trans('keywords.Deleted successfully'));

        }
        else
        {
           return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
        }
    }
}