<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\carbon;
use Auth;
use Hash;
use Illuminate\Support\Facades\Storage;

class AdminController extends Controller
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
        $title = "Sub-Admin List";
        $admin_email=Auth::guard('admin')->user()->email;
       $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $url_aws = "";

                
        $subadmin = DB::table('admin')
                 ->where('role_id','!=',0)
                    ->get();
        $roles =DB::table('roles')
               ->get();
       
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        } 
            

        return view('admin.sub.sub.index', compact('title', "admin", "logo", "url_aws","subadmin","roles"));
    }

    
    public function Add(Request $request)
    {
        $title = "Add Sub Admin";
        $admin_email=Auth::guard('admin')->user()->email;

       $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $subadmin = DB::table('admin')
                 ->where('role_id','!=',0)
                    ->get();
                    
         $roles =DB::table('roles')
               ->get();
        return view('admin.sub.sub.add', compact("subadmin", "admin_email", "logo", "admin", "title","roles"));
    }
    
    public function AddNew(Request $request)
    {
      
        $name = $request->name;
        $password = Hash::make($request->password);
        $role_id = $request->role_id;
         $email = $request->email;
         $roles =DB::table('roles')
                ->where('role_id',$role_id)
               ->first();
        $role_name =$roles->role_name;      
       
       
     
        $this->validate(
            $request,
            [
                    
                    'name' => 'required',
                    'image' => 'required|mimes:jpeg,png,jpg|max:1024',
                    'password'=>'required',
                    'role_id'=>'required',
                    'email'=>'required'
                ],
            [
                    'name.required' => 'Enter name.',
                    'image.required' => 'Choose image.',
                     'password.required'=>'Enter Password',
                    'role_id.required'=>'select role',
                    'email.required'=>'Enter Email'
                ]
        );

        

        $date=date('Y-m-d');

        if ($request->hasFile('image')) {
            $category_image = $request->image;
            $fileName = $category_image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $category_image_name = $category_image->getClientOriginalName();
                $category_image = $request->file('image');
                $filePath = '/category/'.$category_image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
            $category_image->move('images/category/'.$date.'/', $fileName);
            $filePath = '/images/category/'.$date.'/'.$fileName;
        
            }


        } else {
            $filePath = 'N/A';
            $category_image = 'N/A';
        }

        $insertCategory = DB::table('admin')
                            ->insert([
                                'name'=>$name,
                                'email'=>$email,
                                'password'=>$password,
                                'role_id'=>$role_id,
                                'admin_image'=>$filePath,
                                'role_name'=>$role_name
                            ]);
        
        if ($insertCategory) {
            return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
    
    public function Edit(Request $request)
    {
        $id = $request->id;
        $title = "Edit Sub Amdin";
        $admin_email=Auth::guard('admin')->user()->email;;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $subadmin = DB::table('admin')
                 ->where('id',$id)
                  ->first();
                    
         $roles =DB::table('roles')
               ->get();
            
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        } 
           
        return view('admin.sub.sub.edit', compact("subadmin", "admin_email", "admin", "logo", "title","url_aws","roles"));
    }

    public function Update(Request $request)
    {
        $id = $request->id;
         $name = $request->name;
        $password = Hash::make($request->password);
        $role_id = $request->role_id;
         $email = $request->email;
         $roles =DB::table('roles')
                ->where('role_id',$role_id)
               ->first();
        $role_name =$roles->role_name;      
       
       
     
        $this->validate(
            $request,
            [
                    
                    'name' => 'required',
                    'password'=>'required',
                    'role_id'=>'required',
                    'email'=>'required'
                ],
            [
                    'name.required' => 'Enter name.',
                     'password.required'=>'Enter Password',
                    'role_id.required'=>'select role',
                    'email.required'=>'Enter Email'
                ]
        );

        
 $date=date('Y-m-d');
        
 $getCategory = DB::table('admin')
                    ->where('id', $id)
                    ->first();

        $image = $getCategory->admin_image;

        if ($request->hasFile('image')) {
            $this->validate(
                $request,
                [
                    'cat_image' => 'required|mimes:jpeg,png,jpg|max:1024',
                ],
                [
                    'cat_image.required' => 'Choose category image.',
                ]
            );


            $category_image = $request->image;
            $category_image_name = $category_image->getClientOriginalName();
            $category_image = $request->file('cat_image');
           
               
             
           
            if($this->storage_space != "same_server"){
                 $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
                 $filePath = '/category/'.$category_image_name;
                Storage::disk($this->storage_space)->delete($url_aws.$getCategory->admin_image);
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else {
            $fileName = $category_image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
            $category_image->move('images/category/'.$date.'/', $fileName);
            $category_image_name = $category_image->getClientOriginalName();
            $filePath = '/images/category/'.$date.'/'.$fileName;
            }


        } else {
            $filePath = $image;
        }

        $insertCategory = DB::table('admin')
                            ->where('id', $id)
                            ->update([
                                'name'=>$name,
                                'email'=>$email,
                                'password'=>$password,
                                'role_id'=>$role_id,
                                'admin_image'=>$filePath,
                                'role_name'=>$role_name
                            ]);
        
        if ($insertCategory) {
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
        
     
    }
    
    
    
    public function Delete(Request $request)
    {
        $id=$request->id;

        $delete=DB::table('admin')->where('id', $id)->delete();
        if ($delete) {
         
            return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Nothing to Update'));
        }
    }
}
