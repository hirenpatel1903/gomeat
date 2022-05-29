<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\carbon;
use Auth;
use Illuminate\Support\Facades\Storage;

class MemberController extends Controller
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

    public function list(Request $request)
    {
        $title = "Membership Plan List";
        $admin_email=Auth::guard('admin')->user()->email;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }       

                
        $member = DB::table('membership_plan')
                 ->where('hide',0)
                    ->get();
     
            

        return view('admin.member.index', compact('title', "admin", "logo", "member","url_aws"));
    }

    
    public function AddMember(Request $request)
    {
        $title = "Add Membership Plan";
        $admin_email=Auth::guard('admin')->user()->email;

        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $member = DB::table('membership_plan')
                    ->get();
             
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        } 
                
        return view('admin.member.add', compact("member", "admin_email", "logo", "admin", "title","url_aws"));
    }
    
    public function AddNewMember(Request $request)
    {
        $plan_name= $request->plan_name;
        $free_delivery = $request->free_delivery;
        $reward = $request->reward;
        $instant_delivery=$request->instant_delivery;
        $description = $request->description;
        $days=$request->days;
        $price=$request->price;
        if ($description==null) {
            $description= $plan_name;
        }
       $date=date('Y-m-d');
     
        $this->validate(
            $request,
            [
                    
                    'plan_name' => 'required',
                    'free_delivery' => 'required',
                    'instant_delivery'=>'required',
                    'reward'=>'required',
                    'description'=>'required',
                    'days'=>'required',
                    'price'=>'required',
                     'image' => 'required|mimes:jpeg,png,jpg|max:1000',
                ],
            [
                    'plan_name.required' => 'Enter plan name.',
                    'free_delivery.required' => 'select free delivery option value yes or no',
                    'instant_delivery.required' => 'select instant delivery option value yes or no',
                    'description.required'=>'add a description for your plan',
                    'reward.required'=>'select reward values',
                    'days.required'=>'enter plan days',
                    'price.required'=>'enter membership price',
                    'image.required'=>'Select Image',
                ]
        );

        

    if($request->hasFile('image')){
          $image = $request->image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('image');
                $filePath = '/coupon/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/coupon/'.$date.'/', $fileName);
            $filePath = '/images/coupon/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath = 'N/A';
        }

        $insertCategory = DB::table('membership_plan')
                            ->insert([
                                'plan_name'=>$plan_name,
                                'free_delivery'=>$free_delivery,
                                'instant_delivery'=>$instant_delivery,
                                'plan_description'=>$description,
                                'reward'=>$reward,
                                'days'=>$days,
                                 'price'=>$price,
                                 'image'=>$filePath
                            ]);
        
        if ($insertCategory) {
            return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    
    public function EditMember(Request $request)
    {
        $category_id = $request->plan_id;
        $title = "Edit Membership Plan";
        $admin_email=Auth::guard('admin')->user()->email;;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
      
        $member=  DB::table('membership_plan')
            ->where('plan_id', $category_id)
            ->first();
            
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        } 
                
 
        return view('admin.member.edit', compact("member", "admin_email", "admin", "logo", "title","url_aws"));
    }

    public function UpdateMember(Request $request)
    {
        $category_id = $request->plan_id;
        $date=date('Y-m-d');
        $plan_name= $request->plan_name;
        $free_delivery = $request->free_delivery;
        $reward = $request->reward;
        $instant_delivery=$request->instant_delivery;
        $description = $request->description;
           $price=$request->price;
        if ($description==null) {
            $description= $plan_name;
        }
       $days=$request->days;
     
        $this->validate(
            $request,
            [
                    
                    'plan_name' => 'required',
                    'free_delivery' => 'required',
                    'instant_delivery'=>'required',
                    'reward'=>'required',
                    'description'=>'required',
                     'days'=>'required',
                     'price'=>'required'
                ],
            [
                    'plan_name.required' => 'Enter plan name.',
                    'free_delivery.required' => 'select free delivery option value yes or no',
                    'instant_delivery.required' => 'select instant delivery option value yes or no',
                    'description.required'=>'add a description for your plan',
                    'reward.required'=>'select reward values',
                    'days.required'=>'enter plan days',
                    'price.required'=>'enter membership price',
                ]
        );

        
      if($request->hasFile('image')){
              
                  
      $this->validate(
            $request,
                [
                    'image' => 'required|mimes:jpeg,png,jpg|max:1000',
                ],
                [
                    'image.required'=>'Select Image',

                ]
        );
          $image = $request->image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('image');
                $filePath = '/coupon/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/coupon/'.$date.'/', $fileName);
            $filePath = '/images/coupon/'.$date.'/'.$fileName;
        
            }
        }
        else{
             $check=DB::table('membership_plan')
                 ->where('plan_id',$category_id)
                 ->first();
            $filePath = $check->image;
        }
        

        $insertCategory = DB::table('membership_plan')
                            ->where('plan_id',$category_id)
                            ->update([
                                'plan_name'=>$plan_name,
                                'free_delivery'=>$free_delivery,
                                'instant_delivery'=>$instant_delivery,
                                'plan_description'=>$description,
                                'reward'=>$reward,
                               'days'=>$days,
                               'price'=>$price,
                               'image'=>$filePath
                            ]);
        
        if ($insertCategory) {
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    
    
    
    public function DeleteMember(Request $request)
    {
        $category_id=$request->plan_id;

        $delete=DB::table('membership_plan')->where('plan_id', $request->plan_id)->update(['hide'=>1]);
        if ($delete) {
           
            return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Nothing to Update'));
        }
    }
}
