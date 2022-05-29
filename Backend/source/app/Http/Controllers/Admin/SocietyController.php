<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;

class SocietyController extends Controller
{
    public function societylist(Request $request)
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
        
        $city = DB::table('society')
                ->join('city','society.city_id','=','city.city_id')
                ->get();
                
        return view('admin.society.societylist', compact('title','city','logo','admin'));    
        
        
    }
    public function society(Request $request)
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
        
        $city = DB::table('city')
                ->get();
            
          $map1 = DB::table('map_api')
             ->first();
         $map = $map1->map_api_key;     
         $mapset = DB::table('map_settings')
                 ->first();
                 
        $mapbox = DB::table('mapbox')
                ->first();
        return view('admin.society.societyadd', compact('title','city','admin','logo','map','mapset','mapbox'));    
        
        
    }
    public function societyadd(Request $request)
    {
        $title = "Home";
        
        $society = $request->society;
        $city = $request->city;
        
        $this->validate(
            $request,
                [
                    
                    'society'=>'required',
                ],
                [
                    
                    'society.required'=>'Society Name Required',

                ]
        );
       $check = DB::table('society')
              ->where('society_name',$society)
              ->first();
        if($check){
            return redirect()->back()->withErrors(trans('keywords.Already Added'));
        }      
        
    	 $insert = DB::table('society')
                    ->insertGetId([
                        'society_name'=>$society,
                        'city_id'=>$city,
                        ]);
     if($insert){                   
        $store = DB::table('store')
               ->where('city_id',$city)
               ->get();
               
        foreach($store as $stores)
          {
              $serveareas = DB::table('service_area')
                          ->insert(['society_id'=>$insert,
                          'society_name'=>$society,
                          'store_id'=>$stores->id,
                          'city_id'=>$city]);
          }
     }
        return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));

    }
    
    public function societyedit(Request $request)
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
        $society_id = $request->society_id;
        
        $cities = DB::table('city')
                ->get();
        
        $city = DB::table('society')
                ->where('society_id',$society_id)
                ->first();
          $map1 = DB::table('map_api')
             ->first();
         $map = $map1->map_api_key;   
          $mapset = DB::table('map_settings')
                 ->first();
                 
        $mapbox = DB::table('mapbox')
                ->first();
        return view('admin.society.societyedit', compact('title','city','cities','admin','logo','map','mapset','mapbox'));    
        
        
    }
    
    public function societyupdate(Request $request)
    {
        $title = "Home";
        $society_id = $request->society_id;
        $society = $request->society;
        $city = $request->city;
        
         $this->validate(
            $request,
                [
                    
                    'society'=>'required',
                ],
                [
                    
                    'society.required'=>'Society Name Required',

                ]
        );
        
        
         $check = DB::table('society')
              ->where('society_name',$society)
              ->where('society_id','!=',$society_id)
              ->first();
        if($check){
            return redirect()->back()->withErrors(trans('keywords.Already Added'));
        }   
        
        	 $check = DB::table('society')
    	            ->where('society_id',$society_id)
    	            ->first();
        
    	 $insert = DB::table('society')
    	            ->where('society_id',$society_id)
                    ->update([
                        'society_name'=>$society,
                        'city_id'=>$city,
                        ]);
     
     
        if($insert){
            
           DB::table('address')
            ->where('society',$check->society_name)
            ->update(['society'=>$society]);
            
         DB::table('service_area')
            ->where('society_name',$check->society_name)
            ->update(['society'=>$society]);
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    
    public function societydelete(Request $request)
    {
        
                    $society_id=$request->society_id;
            
                    $city= DB::table('society')
                            ->where('society_id',$society_id)
                            ->first();
                    
                	$delete=DB::table('society')->where('society_id',$request->society_id)->delete();
                    if($delete)
                    {
                      DB::table('address')
                        ->where('society',$city->society_name)
                        ->delete();
                     
                       DB::table('service_area')
                            ->where('society_name',$city->society_name)
                            ->delete();    
                    return redirect()->back()->withSuccess(trans('keywords.Deleted successfully'));
            
                    }
                    else
                    {
                       return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
                    }
    }
}