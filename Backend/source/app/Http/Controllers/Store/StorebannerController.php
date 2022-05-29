<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;
use Illuminate\Support\Facades\Storage;

class StorebannerController extends Controller
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
    public function bannerlist(Request $request)
    {
        $title = "Banner";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $city = DB::table('store_banner')
               ->join('categories', 'store_banner.cat_id','=', 'categories.cat_id') 
               ->where('store_banner.store_id', $store->id)
                ->get();
                
         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }        
                
        return view('store.banner.bannerlist', compact('title','city','store','logo','email','url_aws'));    
        
        
    }
    public function banner(Request $request)
    {
        $title = "Add Store Banner";
         $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        
        $city = DB::table('store_banner')
        ->where('store_id', $store->id)
                ->get();
                
        $category = DB::table('categories')
          ->join('product','categories.cat_id', '=', 'product.cat_id' )
          ->join('product_varient','product.product_id', '=', 'product_varient.product_id' )
          ->join('store_products','product_varient.varient_id', '=', 'store_products.varient_id' )
          ->select('categories.title','categories.cat_id','categories.image', 'categories.description')
          ->groupBy('categories.title','categories.cat_id','categories.image', 'categories.description')
          ->where('categories.level', 1)
          ->where('store_products.store_id', $store->id)
          ->get();         
        return view('store.banner.addbanner', compact('title','city','store','logo', 'category','email'));    
        
        
    }
    public function banneradd(Request $request)
    {
        $title = "Home";
        
        $banner = $request->banner;
        $image = $request->image;
        $type = $request->type;
        $cat_id = $request->cat_id;
         $date=date('d-m-Y');
        $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
        
        $this->validate(
            $request,
                [
                    
                    'banner'=>'required',
                    'image'=>'required|mimes:jpeg,png,jpg|max:2048',
                    'cat_id'=>'required'
                ],
                [
                    
                    'banner.required'=>'Banner Name Required',
                    'image.required'=>'Image Required',
                    'cat_id.required'=>'Select category'

                ]
        );



              if ($request->hasFile('image')) {
           $image = $request->image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('image');
                $filePath = '/banner/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/banner/'.$date.'/', $fileName);
            $filePath = '/images/banner/'.$date.'/'.$fileName;
        
            }


        } else {
            $filePath = 'N/A';
        }
        
        
    	 $insert = DB::table('store_banner')
                    ->insert([
                        'banner_name'=>$banner,
                        'banner_image'=>$filePath,
                        'cat_id'=>$cat_id,
                        'store_id'=>$store->id
                        ]);
     if($insert){
         return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
     }else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }

    }
    
    public function banneredit(Request $request)
    {
         $title = "Edit Store Banner";
          $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $banner_id = $request->banner_id;
        
        $city = DB::table('store_banner')
         ->join('categories', 'store_banner.cat_id','=', 'categories.cat_id')
                ->where('store_banner.banner_id',$banner_id)
                ->where('store_banner.store_id', $store->id)
                ->first();
         $category = DB::table('categories')
          ->join('product','categories.cat_id', '=', 'product.cat_id' )
          ->join('product_varient','product.product_id', '=', 'product_varient.product_id' )
          ->join('store_products','product_varient.varient_id', '=', 'store_products.varient_id' )
          ->select('categories.title','categories.cat_id','categories.image', 'categories.description')
          ->groupBy('categories.title','categories.cat_id','categories.image', 'categories.description')
          ->where('categories.level', 1)
          ->where('store_products.store_id', $store->id)
          ->get();  

         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }      


        return view('store.banner.banneredit', compact('title','city','store','email','category','logo','url_aws'));    
        
        
    }
    
    public function bannerupdate(Request $request)
    {
        $title = "Home";
          $email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$email)
    	 		   ->first();
        $banner_id = $request->banner_id;
        $banner = $request->banner;
       $old_reward_image=$request->old_image;
        $type = $request->type;
       $cat_id = $request->cat_id;
        
        
         $this->validate(
            $request,
                [
                    
                    'banner'=>'required',
                    'cat_id'=>'required'
                ],
                [
                    
                    'banner.required'=>'Banner Name Required',
                    'cat_id.required'=>'Select category'

                ]
        );
        
        $getBanner = DB::table('store_banner')
                        ->where('banner_id', $banner_id)
                        ->first();
        if($getBanner->banner_image != NULL){
        $image = $getBanner->banner_image;
        }else{
          $image = 'N/A'; 
        }
        if($request->hasFile('image')){
               $this->validate(
            $request,
                [
                    'image' => 'required|mimes:jpeg,png,jpg|max:2048',
                ],
                [
                    'image.required' => 'Choose Banner image.',
                ]
              );
            if(file_exists($image)){
                unlink($image);
            }
             $image = $request->image;
            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $image_name = $image->getClientOriginalName();
                $image = $request->file('image');
                $filePath = '/banner/'.$image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('image'), 'r+'), 'public');
            }
            else{
           
           $image->move('images/banner/'.$date.'/', $fileName);
            $filePath = '/images/banner/'.$date.'/'.$fileName;
        
            }


        }
        else{
            $filePath = $getBanner->banner_image;
        }

        
    	 $insert = DB::table('store_banner')
    	            ->where('banner_id',$banner_id)
                    ->update([
                        'banner_name'=>$banner,
                        'banner_image'=>$filePath,
                        'cat_id' => $cat_id,
                         'store_id'=>$store->id
                        ]);
     
   if($insert){
         return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
     }else{
         return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }

    }
    
    public function bannerdelete(Request $request)
    {
        $banner_id = $request->banner_id;

    	$delete=DB::table('store_banner')->where('banner_id',$banner_id)->delete();
        if($delete){
             return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
         }else{
             return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }
    }
}