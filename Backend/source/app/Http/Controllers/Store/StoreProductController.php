<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;
use Illuminate\Support\Facades\Storage;
class StoreProductController extends Controller
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
        $title = "Product List"; 
          $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
          $logo = DB::table('tbl_web_setting')
                ->first();
           $product = DB::table('product')
                    ->join('categories','product.cat_id','=','categories.cat_id')
                    ->join('categories as catttt','categories.parent','=','catttt.cat_id')
                    ->select('product.*', 'categories.title as sub','catttt.title')
                    ->where('product.added_by', $store->id)
                    ->paginate(10);
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }                
        return view('store.store_product.list', compact('title',"store", "logo","product","url_aws"));
    }

    
     public function AddProduct(Request $request)
    {
    
        $title = "Add Product";
           $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
          $logo = DB::table('tbl_web_setting')
                ->first();
           $cat = DB::table('categories')
                   ->select('parent')
                   ->get();
                   
        if(count($cat)>0){           
        foreach($cat as $cats) {
            $a = $cats->parent;
           $aa[] = array($a); 
        }
        }
        else{
            $a = 0;
           $aa[] = array($a);
        }
        
         $category = DB::table('categories')
                  ->where('level', '!=', 0)
                  ->WhereNotIn('cat_id',$aa)
                    ->get();
   
        
        return view('store.store_product.add',compact("category", "email","logo", "store","title"));
     }
    
     public function AddNewProduct(Request $request)
    {

          $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
       
        $category_id=$request->cat_id;
        $product_name = $request->product_name;
        $quantity = $request->quantity;
        $unit = $request->unit;
        $price = $request->price;
        $description = $request->description;
        $date=date('d-m-Y');
        $mrp = $request->mrp;
        $ean = $request->ean;
       $images = $request->images;
         $type =$request->type;
      $this->validate(
            $request,
                [
                    'cat_id'=>'required',
                    'product_name' => 'required',
                    'product_image' => 'required|mimes:jpeg,png,jpg|max:1000',
                    'quantity'=> 'required',
                    'unit'=> 'required',
                    'price'=> 'required',
                    'mrp'=>'required',
                    'tags' => 'required',
                    'ean'=>'required',
                    'type'=>'required'
                ],
                [
                    'cat_id.required'=>'Select category',
                    'product_name.required' => 'Enter product name.',
                    'product_image.required' => 'Choose product image.',
                    'quantity.required' => 'Enter quantity.',
                    'unit.required' => 'Choose unit.',
                    'price.required' => 'Enter price.',
                    'mrp.required'=>'Enter MRP.',
                    'tags.required'=> 'Enter Tags',
                    'ean.required'=>'Enter Ean Code',
                    'type.required'=>'Select Product Type'
                ]
        );

         $tags = explode(",", $request->tags);


        if($request->hasFile('product_image')){
          $product_image = $request->product_image;
            $fileName = $product_image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $product_image_name = $product_image->getClientOriginalName();
                $product_image = $request->file('product_image');
                $filePath = '/product/'.$product_image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('product_image'), 'r+'), 'public');
            }
            else{
           
           $product_image->move('images/product/'.$date.'/', $fileName);
            $filePath = '/images/product/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath = 'N/A';
        }

        $insertproduct = DB::table('product')
                            ->insertGetId([
                                'cat_id'=>$category_id,
                                'product_name'=>$product_name,
                                'product_image'=>$filePath,
                                'added_by'=>$store->id,
                                'type'=>$type,
                                'approved'=>0
                               
                            ]);
        
        if($insertproduct){
              $main_image = DB::table('product_images')
            ->insert([
                'product_id'=>$insertproduct,
                'image'=>$filePath,
                'type'=>1
               
            ]);

            $id = DB::table('product_varient')
            ->insertGetId([
                'product_id'=>$insertproduct,
                'quantity'=>$quantity,
                'varient_image'=>'N/A',
                'unit'=>$unit,
                'ean'=>$ean,
                'base_price'=>$price,
                'base_mrp'=>$mrp,
                'description'=>$description,
                'approved'=>0,
                'added_by'=>$store->id
               
            ]);
            
            foreach($tags as $tag){
             $tag1 = ucfirst($tag);
             DB::table('tags')
            ->insertGetId([
                'product_id'=>$insertproduct,
                'tag'=>$tag1
            ]);
             }
            if($images != NULL){
              foreach($images as $image){

            $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $product_image_name = $image->getClientOriginalName();
                $product_image = $request->file('product_image');
                $filePath1 = '/product/'.$product_image_name;
                Storage::disk($this->storage_space)->put($filePath1, fopen($image, 'r+'), 'public');
            }
            else{
           
            $image->move('images/product/'.$date.'/', $fileName);
            $filePath1 = '/images/product/'.$date.'/'.$fileName;
        
            }

              
             $images= DB::table('product_images')
            ->insert([
                'product_id'=>$insertproduct,
                'image'=>$filePath1
            ]);
             }
             }
            return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
      
    }
    
    public function EditProduct(Request $request)
    {
         $product_id = $request->product_id;
         $title = "Edit Product";
       $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
          $logo = DB::table('tbl_web_setting')
                ->first();
          $product = DB::table('product')
                   ->where('product_id',$product_id)
                    ->first();
            $tags = DB::table('tags')
                 ->get();          
                   $images = DB::table('product_images')
           ->where('product_id',$product_id)
           ->get();
        if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/').'/';
        }           
           
        return view('store.store_product.edit',compact("email","store","logo","title","product","tags","url_aws"));
    }

    public function UpdateProduct(Request $request)
    {
         $product_id = $request->product_id;
        $product_name = $request->product_name;
        $date=date('d-m-Y');
        $product_image = $request->product_image;
         $tags = explode(",", $request->tags);
          $images = $request->images;
        
         $type =$request->type;
        $this->validate(
            $request,
                [
                    
                    'product_name' => 'required',
                    'type'=>'required'
                ],
                [
                    'product_name.required' => 'Enter product name.',
                    'type.required'=>'Select Type'
                ]
        );

       $getProduct = DB::table('product')
                    ->where('product_id',$product_id)
                    ->first();

        $image = $getProduct->product_image;

        if($request->hasFile('product_image')){
               $this->validate(
            $request,
                [
                    'product_image' => 'required|mimes:jpeg,png,jpg|max:1000',
                ],
                [
                    'product_image.required' => 'Choose Product image.',
                ]
              );
            $product_image = $request->product_image;
            $fileName = $product_image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $product_image_name = $product_image->getClientOriginalName();
                $product_image = $request->file('product_image');
                $filePath = '/product/'.$product_image_name;
                Storage::disk($this->storage_space)->put($filePath, fopen($request->file('product_image'), 'r+'), 'public');
            }
            else{
           
           $product_image->move('images/product/'.$date.'/', $fileName);
            $filePath = '/images/product/'.$date.'/'.$fileName;
        
            }
        }
        else{
            $filePath = $image;
        }

        $insertproduct = DB::table('product')
                       ->where('product_id', $product_id)
                            ->update([
                                'product_name'=>$product_name,
                                'product_image'=>$filePath,
                                 'type'=>$type
                            ]);

         
             $delete_main_image = DB::table('product_images')
                       ->where('product_id', $product_id)
                       ->where('type', 1)
                       ->delete();               

             $main_image = DB::table('product_images')
            ->insert([
                'product_id'=> $product_id,
                'image'=>$filePath,
                'type'=>1
               
            ]);

                            
         if($request->tags != NULL){
               $deleteold = DB::table('tags')
               ->where('product_id', $product_id)
               ->delete();

            foreach($tags as $tag){
            $tag1 = ucfirst($tag);
            $enternew =  DB::table('tags')
                    ->insert([
                        'product_id'=>$product_id,
                        'tag'=>$tag1
                    ]);
             }
            }
        
          $enternewim = NULL; 
        if($request->images != NULL){
               $deleteold = DB::table('product_images')
               ->where('product_id', $product_id)
               ->delete();
      
            foreach($images as $image){

           $fileName = $image->getClientOriginalName();
            $fileName = str_replace(" ", "-", $fileName);
           

           if($this->storage_space != "same_server"){
                $product_image_name = $image->getClientOriginalName();
                $product_image = $request->file('product_image');
                $filePath1 = '/product/'.$product_image_name;
                Storage::disk($this->storage_space)->put($filePath1, fopen($image, 'r+'), 'public');
            }
            else{
           
            $image->move('images/product/'.$date.'/', $fileName);
            $filePath1 = '/images/product/'.$date.'/'.$fileName;
        
            }
              
             $enternewim= DB::table('product_images')
            ->insert([
                'product_id'=>$product_id,
                'image'=>$filePath1
            ]);
             }
            }
        
       
        if($insertproduct || $enternew != NULL || $enternewim != NULL){
            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
       
       
       
       
    }
    
    
    
 public function DeleteProduct(Request $request)
    {
        $product_id=$request->product_id;

        $delete=DB::table('product')->where('product_id',$request->product_id)->delete();
        if($delete)
        {
         $delete=DB::table('product_varient')->where('product_id',$request->product_id)->delete();  
       
           $deleteold = DB::table('tags')
               ->where('product_id', $product_id)
               ->delete();
         
        return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));
        }
        else
        {
           return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
        }
    }

}