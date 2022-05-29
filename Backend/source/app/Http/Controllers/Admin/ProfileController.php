<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use Session;
use Hash;
use App\Models\Admin;
use Auth;
use Illuminate\Support\Facades\Storage;

class ProfileController extends Controller
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
    public function adminProfile(Request $request)
    {
    	 $title = "Edit Profile";
    	   $admin_email=Auth::guard('admin')->user()->email;
    	    $admin11= DB::table('admin')
    	 		 ->where('email',$admin_email)
    	 		   ->first();
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	$admin->id=$admin11->id; 	
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();		   
    	
           return view('admin.profile.profile',compact("admin_email","admin",'logo',"title"));

    }
   

    public function adminUpdateProfile(Request $request)
    {
        $admin_id = $request->id;
        $admin_name = $request->admin_name;
        $admin_email = $request->admin_email;
        $old_admin_image = $request->old_admin_image;
        $updated_at = date("d-m-y h:i a");
        $date=date('d-m-y');
        
        $this->validate(
            $request,
                [
                    'admin_name' => 'required',
                    'admin_email' => 'required'
                ],
                [
                    'admin_name.required' => 'Enter your name.',
                    'admin_email.required' => 'Enter new email.'
                ]
        );

        $getImage = DB::table('admin')
                        ->where('id', $admin_id)
                        ->first();

        $image = $getImage->admin_image;  

        if($request->hasFile('admin_image')){
             $image = $request->admin_image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('admin_image');
                $filePath = '/admin/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('admin_image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/admin/'.$date.'/', $fileName);
            $filePath = '/images/admin/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath = $image;
        }

        $adminChangeProfile = DB::table('admin')
                                ->where('id', $admin_id)
                                ->update(['name'=>$admin_name, 'email'=>$admin_email,'admin_image'=>$filePath]);

        if($adminChangeProfile){

             session::put('bamaAdmin',$admin_email);

            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }

    public function adminChangePass(Request $request)
    {
        $title = "Change Password";
          $admin_email=Auth::guard('admin')->user()->email;
      $admin11= DB::table('admin')
    	 		 ->where('email',$admin_email)
    	 		   ->first();
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	$admin->id=$admin11->id; 	
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();	
           return view('admin.profile.change_pass',compact("admin_email","admin","logo","title"));
           
       
    }


   public function adminChangePassword(Request $request)
    {
        $this->validate(
            $request,
                [
                    'current_pass' => 'required',
                    'new_pass' => 'required',
                ],
                [
                    'current_pass.required' => 'Enter current password.',
                    'new_pass.required' => 'Enter new password.',
                ]
           );

        $admin_id = $request->id;
        $current_pass = $request->current_pass;
        // $current_pass =Hash::make($current_pass1);
        $getAdmin = DB::table('admin')
                    ->where('id', $admin_id)
                    ->first();

        if(Hash::check($current_pass,$getAdmin->password))
            {
            $new_pass = Hash::make($request->new_pass);
            $updated_at = date("d-m-y h:i a");

            $adminChangePassword = DB::table('admin')
                                    ->where('id', $admin_id)
                                    ->update(['password'=>$new_pass]);

            if($adminChangePassword)
            {
                return redirect()->back()->withSuccess(trans('keywords.Password Changed!'));
            }
            else{
                return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
            }
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Current Password Does Not Match'));
        }
     }
     public function adminLogout(Request $request)
     {
           Auth::guard('admin')->logout();
           return redirect()->route('adminlogin')->withSuccess(trans('keywords.Logout Successfully'));

     }
}

 