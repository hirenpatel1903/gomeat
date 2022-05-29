<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\carbon;
use Auth;
use Illuminate\Support\Facades\Storage;

class SubController extends Controller
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
        $title = "Sub Category List";
        $admin_email=Auth::guard('admin')->user()->email;
       $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $url_aws = "";

                
        $category = DB::table('categories')
                    ->leftJoin('categories as catt', 'categories.parent', '=', 'catt.cat_id')
                    ->select('categories.*', 'catt.title as tttt')
                    ->where('categories.level', 1)
                    ->paginate(10);
                    
        $adminTopApp =  DB::table('categories')
                  ->get();
        
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        } 
            

        return view('admin.category.sub.index', compact('title', "admin", "logo", "category", "adminTopApp", "url_aws"));
    }

    
    public function AddCategory(Request $request)
    {
        $title = "Add Category";
        $admin_email=Auth::guard('admin')->user()->email;

      $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $category = DB::table('categories')
                    ->where('level', 0)
                    ->get();

        return view('admin.category.sub.add', compact("category", "admin_email", "logo", "admin", "title"));
    }
    
  
    
    public function EditCategory(Request $request)
    {
        $category_id = $request->category_id;
        $title = "Edit Category";
        $admin_email=Auth::guard('admin')->user()->email;;
        $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $category = DB::table('categories')
                    ->where('cat_id', '!=', $category_id)
                    ->get();
                    
        $cat=  DB::table('categories')
            ->where('cat_id', $category_id)
            ->first();
          if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        } 
            
        return view('admin.category.sub.edit', compact("category", "admin_email", "admin", "logo", "cat", "title","url_aws"));
    }

   
    
    public function DeleteCategory(Request $request)
    {
        $category_id=$request->category_id;

        $delete=DB::table('categories')->where('cat_id', $request->category_id)->delete();
        if ($delete) {
            $deleteproduct=DB::table('product')
          ->where('cat_id', $request->category_id)->delete();
          
            $deletechild=DB::table('categories')
          ->where('parent', $request->category_id)->delete();
            return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Nothing to Update'));
        }
    }
}
