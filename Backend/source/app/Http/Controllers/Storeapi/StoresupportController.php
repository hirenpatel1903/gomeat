<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use App\Setting;
use Carbon\Carbon;

class StoresupportController extends Controller
{
   public function feedback(Request $request)
    {  
        $query = $request->feedback;
        $store_id = $request->store_id;
        $type='store';
        $created_at = Carbon::now();
        $update = DB::table('user_support')
                ->insert(['query'=>$query,
                'id'=>$store_id,
                'type'=>$type,
                'created_at'=>$created_at]);
                   
         if($update){
            $message = array('status'=>'1', 'message'=>'Feedback/Query Submitted');
            return $message;
            }
        else{
            $message = array('status'=>'0', 'message'=>'No currency Found', 'data'=>[]);
            return $message;
        }
    }

}