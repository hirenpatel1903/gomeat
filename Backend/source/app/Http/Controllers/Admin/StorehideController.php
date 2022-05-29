<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;

class StorehideController extends Controller
{
     public function off(Request $request)
    {
        
        $store_id = $request->id;
        
        $cause = $request->cause;
          $this->validate(
            $request,
                [
                    'cause'=>'required',
                ],
                [
                    
                    'cause.required'=>'Store Inactive Reason required'

                ]
        );
         $users = DB::table('store')
                ->where('id',$store_id)
                ->update(['store_status'=>0,
                'inactive_reason'=> $cause]);
    if($users){   
    return redirect()->back()->withSuccess(trans('keywords.Store Successfully Set To Inactive Mode'));
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
    
     public function on(Request $request)
    {
        
       $store_id = $request->id;
         $users = DB::table('store')
                ->where('id',$store_id)
                ->update(['store_status'=>1]);
    if($users){   
    return redirect()->back()->withSuccess(trans('keywords.Store Successfully Set To Active Mode'));
    
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
    

}