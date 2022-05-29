<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
use Illuminate\Support\Facades\Storage;


class ApprovalController extends Controller
{
      public function __construct(){
        $storage =  DB::table('image_space')
                    ->first();

        if($storage->aws == 1){
            $this->storage_space = "s3.aws";
        }
        else if($storage->digital_ocean == 1){
            $this->storage_space = "s3.digitalocean";
        }else{
            $this->storage_space ="same_server";
        }

    }
    public function storeclist(Request $request)
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
        
        $city = DB::table('store')
                ->where('admin_approval', 0)
                ->paginate(10);
          if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }        
                      
        return view('admin.store.approval_wait', compact('title','city','admin','logo','url_aws'));    
        
        
    }
    
    public function storeapproved(Request $request)
    {
  
        $store_id = $request->id;
        $getstore = DB::table('store')
                ->where('id',$store_id)
                ->first();
         $store = DB::table('store')
                ->where('id',$store_id)
                ->update(['admin_approval'=>1]);
    if($store){  
        
         $society=DB::table('society')
                  ->where('city_id',$getstore->city_id)
                  ->get();
                  
          foreach($society as $s){
              $ser_area=DB::table('service_area')
                       ->insert(['store_id'=>$store_id,
                       'society_name'=>$s->society_name,
                       'society_id'=>$s->society_id,
                       'delivery_charge'=>0,
                       'added_by'=>0,
                        'city_id'=>$s->city_id]);
          }          
    return redirect()->back()->withSuccess(trans('keywords.Store Approved Successfully'));
    }
    else{
      return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));   
    }
    }
}