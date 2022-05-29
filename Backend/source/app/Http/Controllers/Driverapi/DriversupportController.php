<?php

namespace App\Http\Controllers\Driverapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;

class DriversupportController extends Controller
{
   public function feedback(Request $request)
    {  
        $query = $request->feedback;
        $dboy_id = $request->dboy_id;
        $type= 'driver';
        $created_at = Carbon::now();
        $update = DB::table('user_support')
                ->insert(['query'=>$query,
                'id'=>$dboy_id,
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