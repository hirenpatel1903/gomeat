<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
class HideController extends Controller
{
    
     public function hideproduct(Request $request)
    {
        $product_id = $request->product_id;
        $status =$request->status;
        $pro = DB::table('product')
             ->where('product_id',$product_id)
             ->update(['hide'=>$status]);

        
        
  
        return response()->json(['success'=>trans('keywords.Status change successfully')]);
    }
    
     public function updatefirebase(Request $request)
    {
    
        $status =$request->status;
        $pro = DB::table('firebase')
             ->update(['status'=>$status]);

        
        
  
        return response()->json(['success'=>trans('keywords.Status change successfully')]);
    }
}