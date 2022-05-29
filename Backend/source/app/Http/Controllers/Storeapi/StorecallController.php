<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;

class StorecallController extends Controller
{
 
    public function call(Request $request)
    {
        
          $date = date('Y-m-d');
          $store_id = $request->store_id;
          $check = DB::table('store_callback_req')
                 ->where('store_id',$store_id)
                 ->where('processed',0)
                ->first();
                
          $store = DB::table('store')
                ->where('id',$store_id)
                ->first();
                
                
          if($check){ 
              $app1 = DB::table('store_callback_req')
                   ->where('store_id',$store_id)
                 ->where('processed',0)
                 ->delete();
          $app = DB::table('store_callback_req')
                ->insert(['store_name'=>$store->store_name,
                'store_phone'=>$store->phone_number,
                'date'=>$date,
                'store_id'=>$store_id ]);
          }    
          else{
              $app = DB::table('store_callback_req')
                ->insert(['store_name'=>$store->store_name,
                'store_phone'=>$store->phone_number,
                'date'=>$date,
                'store_id'=>$store_id]);
          }
        if($app)   { 
            $message = array('status'=>'1', 'message'=>'Callback requested successfully');
            return $message;
        }
        else{
            $message = array('status'=>'0', 'message'=>'Try again later', 'data'=>[]);
            return $message;
        }

        return $message;
    }
}