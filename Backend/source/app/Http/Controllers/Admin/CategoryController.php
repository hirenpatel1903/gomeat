<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\carbon;
use Auth;
use Illuminate\Support\Facades\Storage;

class CategoryController extends Controller
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
        $title = "Category List";
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
                    ->where('parent',0)
                    ->paginate(10);
                    
        $adminTopApp =  DB::table('categories')
                  ->get();
        
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        } 
            

        return view('admin.category.index', compact('title', "admin", "logo", "category", "adminTopApp", "url_aws"));
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
        $tax =DB::table('tax_types')
             ->get();
        return view('admin.category.add', compact("category", "admin_email", "logo", "admin", "title","tax"));
    }
    
    public function AddNewCategory(Request $request)
    {
        $parent_id = $request->parent_id;
        $cat_id = $request->cat_id;
        $type = $request->type;
        if($type==NULL){
			$type=0;
		}
        $tax=$request->tax;
        if($tax==NULL){
			$tax=NULL;
            $tx_name=NULL;
		}else{
			$tx=DB::table('tax_types')
		   ->where('tax_id',$tax)
		   ->first();
          $tx_name=$tx->name;
		}
        $tax_per =$request->tax_per;
		 if($tax_per==NULL){
			$tax_per=0;
		}
        $category_name = $request->cat_name;
        $status = 1;
        $slug = str_replace(" ", '-', $category_name);
        $date=date('d-m-Y');
        $desc = $request->desc;
        $filePath = '';
        if ($desc==null) {
            $desc= $category_name;
        }
        $category = DB::table('categories')
                  ->where('cat_id', $parent_id)
                  ->first();

        $category_image_name = "";

                         
        if ($status=="") {
            $status=0;
        }
  
        if ($category) {
            if ($parent_id==$category->cat_id) {
                if ($category->level==0) {
                    $level = 1;
                } elseif ($category->level==1) {
                    $level = 2;
                }
            }
        } else {
            $level = 0;
        }
        
     
        $this->validate(
            $request,
            [
                    
                    'cat_name' => 'required',
                    'cat_image' => 'required|mimes:jpeg,png,jpg|max:1000',
                ],
            [
                    'cat_name.required' => 'Enter category name.',
                    'cat_image.required' => 'Choose category image.',
                ]
        );

        

        

        if ($request->hasFile('cat_image')) {
            $category_image = $request->cat_image;
            $fileName = $category_image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $category_image_name = $category_image->getClientOriginalName();
                $category_image = $request->file('cat_image');
                $filePath = '/category/'.$category_image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('cat_image'), 'r+'), 'public');
            }
            else{
           
            $category_image->move('images/category/'.$date.'/', $fileName);
            $filePath = '/images/category/'.$date.'/'.$fileName;
        
            }


        } else {
            $filePath = 'images/';
            $category_image = 'N/A';
        }

        $insertCategory = DB::table('categories')
                            ->insert([
                                'parent'=>$parent_id,
                                'title'=>$category_name,
                                'slug'=>$slug,
                                'level'=>$level,
                                'image'=>$filePath,
                                'status'=>$status,
                                'description'=>$desc,
                                'tax_type'=>$type,
                                'tx_id'=>$tax,
                                'tax_per'=>$tax_per,
                                'tax_name'=>$tx_name
                               
                            ]);
        
        if ($insertCategory) {
            return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
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
                    ->where('level', 0)
                    ->orWhere('level', 1)
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
            $tax =DB::table('tax_types')
             ->get();      
 
        return view('admin.category.edit', compact("category", "admin_email", "admin", "logo", "cat", "title","url_aws","tax"));
    }

    public function UpdateCategory(Request $request)
    {
        $category_id = $request->category_id;
          $type = $request->type;
       if($type==NULL){
			$type=0;
		}
        $tax=$request->tax;
        if($tax==NULL){
			$tax=NULL;
            $tx_name=NULL;
		}else{
			$tx=DB::table('tax_types')
		   ->where('tax_id',$tax)
		   ->first();
          $tx_name=$tx->name;
		}
        $tax_per =$request->tax_per;
		 if($tax_per==NULL){
			$tax_per=0;
		}
        $parent_id = $request->parent_id;
        $category_name = $request->cat_name;
        $status = 1;
        $slug = str_replace(" ", '-', $category_name);
        $date=date('d-m-Y');
        $desc = $request->desc;
        if ($desc==null) {
            $desc= $category_name;
        }

        $category_image_name = "";
        $filePath = "";
        
        $category = DB::table('categories')
                  ->where('cat_id', $parent_id)
                  ->first();
                         
        if ($status=="") {
            $status=0;
        }
  
        if ($category) {
            if ($parent_id==$category->cat_id) {
                if ($category->level==0) {
                    $level = 1;
                } elseif ($category->level==1) {
                    $level = 2;
                }
            }
        } else {
            $level = 0;
        }
        
    
        
       
        $this->validate(
            $request,
            [
                    
                    'cat_name' => 'required',
                ],
            [
                    'cat_name.required' => 'Enter category name.', 
                ]
        );

        $getCategory = DB::table('categories')
                    ->where('cat_id', $category_id)
                    ->first();

        $image = $getCategory->image;

        if ($request->hasFile('cat_image')) {
            $this->validate(
                $request,
                [
                    'cat_image' => 'required|mimes:jpeg,png,jpg|max:1000',
                ],
                [
                    'cat_image.required' => 'Choose category image.',
                ]
            );


            $category_image = $request->cat_image;
            $category_image_name = $category_image->getClientOriginalName();
            $category_image = $request->file('cat_image');
           
               
             
           
            if($this->storage_space != "same_server"){
                 $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
                 $filePath = '/category/'.$category_image_name;
                Storage::disk($this->storage_space)->delete($url_aws.$getCategory->image);
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('cat_image'), 'r+'), 'public');
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
$tx=DB::table('tax_types')
   ->where('tax_id',$tax)
   ->first();
        $insertCategory = DB::table('categories')
                       ->where('cat_id', $category_id)
                            ->update([
                                'parent'=>$parent_id,
                                'title'=>$category_name,
                                'slug'=>$slug,
                                'level'=>$level,
                                'image'=>$filePath,
                                'status'=>$status,
                                'description'=>$desc,
                               'tax_type'=>$type,
                                'tx_id'=>$tax,
                                'tax_per'=>$tax_per,
                                'tax_name'=>$tx_name
                            ]);
        
        if ($insertCategory) {
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        } else {
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
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
