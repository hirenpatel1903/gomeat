<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;

class AreaController extends Controller
{
    public function societylist(Request $request)
    {
         $title = "Home";
        	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
        $city = DB::table('service_area')
                ->join('city','service_area.city_id','=','city.city_id')
                ->where('service_area.store_id',$store->id)
                ->get();
    if(count($city)>0){            
        foreach($city as $cities){        
         $ar_id[]= $cities->society_id;      
        }      
        $area =DB::table('society')
              ->WhereNotIn('society_id',$ar_id)
              ->where('city_id',$store->city_id)
              ->get();
    }else{
        $area =DB::table('society')
        ->where('city_id',$store->city_id)
              ->get();
    }         
        return view('store.area.societylist', compact('title','city','logo','store','store_email','area'));    
        
        
    }
 
 
    
    public function societyedit(Request $request)
    {
         $title = "Home";
      	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $society_id = $request->ser_id;
        
   
        
        $city = DB::table('service_area')
                 ->join('city','service_area.city_id','=','city.city_id')
                ->where('ser_id',$society_id)
                ->first();
  
        return view('store.area.societyedit', compact('title','city','logo','store','store_email'));    
        
        
    }
    
    public function societyupdate(Request $request)
    {
        $title = "Home";
        $society_id = $request->ser_id;
        $charge = $request->charge;
       
        
         $this->validate(
            $request,
                [
                    
                    'charge'=>'required',
                ],
                [
                    
                    'charge.required'=>'Delivery Charge Required',

                ]
        );
        
        
        
    	 $insert = DB::table('service_area')
    	           ->where('ser_id',$society_id)
                    ->update([
                        'delivery_charge'=>$charge
                        ]);
     
     
        if($insert){
            
         
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    
    public function societydelete(Request $request)
    {
        
                    $society_id=$request->ser_id;
            
                	$delete=DB::table('service_area')->where('ser_id',$society_id)->update(['enabled'=>0]);
                    if($delete)
                    {
                    
                    return redirect()->back()->withSuccess(trans('keywords.Deleted successfully'));
            
                    }
                    else
                    {
                       return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
                    }
    }
    
    public function societyenable(Request $request)
    {
        
                    $society_id=$request->ser_id;
            
                	$delete=DB::table('service_area')->where('ser_id',$society_id)->update(['enabled'=>1]);
                    if($delete)
                    {
                    
                    return redirect()->back()->withSuccess(trans('keywords.Enabled successfully'));
            
                    }
                    else
                    {
                       return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
                    }
    }
    
      public function societyadd(Request $request)
    {
        $title = "Home";
        	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
        $society_id = $request->society;
        $charge =0;
          if($society_id == array()){
        return redirect()->back()->withErrors(trans('keywords.Please select at least one area'));
    }
    else{
    $countprod = count($society_id);

    for($i=0;$i<=($countprod-1);$i++)
        {
            $society_id = $society_id[$i];
            $pr= DB::table('society')
                 ->where('society_id',$society_id)
                 ->first();
                 
            $insert2 = DB::table('service_area')
                  ->insert(['store_id'=>$store->id,'city_id'=>$pr->city_id, 'society_name'=>$pr->society_name, 'society_id'=>$pr->society_id,'delivery_charge'=>$charge,'added_by'=>0,'enabled'=>1]);
        }     
       
        
     
     
        if($insert2){
            
         
            return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
        }else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    }
}