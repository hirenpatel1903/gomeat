<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Illuminate\Support\Facades\Storage;

class StproductController extends Controller
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
    
         $store_id=$request->store_id;
          $seachstring= $request->searchstring; 
       $prodsssss = DB::table('product')
                    ->join('categories','product.cat_id','=','categories.cat_id')
                    ->join('categories as catttt','categories.parent','=','catttt.cat_id')
                    ->select('product.*')
                    ->where('product.added_by', $store_id)
                    ->where('product.product_name', 'like', $seachstring.'%')
                    ->paginate(20);
       
       
     
         
        $prodsd = $prodsssss->unique('product_id'); 
        
        
         $prod = NULL;
        foreach($prodsd as $store)
        {
           
                $prod[] = $store; 
            
        }
         
        if($prod != NULL){
            $result =array();
            $i = 0;
            $j = 0;
            foreach ($prod as $prods) {
                array_push($result, $prods);

                $app = json_decode($prods->product_id);
                $apps = array($app);
                $app =  DB::table('product_varient')
                 ->Leftjoin('deal_product','product_varient.varient_id','=','deal_product.varient_id')
                         ->select('product_varient.ean','product_varient.added_by','product_varient.varient_id', 'product_varient.description', 'product_varient.base_price as price', 'product_varient.base_mrp as mrp', 'product_varient.varient_image','product_varient.unit','product_varient.quantity','deal_product.deal_price', 'deal_product.valid_from', 'deal_product.valid_to')
                         ->where('product_varient.added_by', $store_id)
                        ->whereIn('product_varient.product_id', $apps)
                        ->get();
                $tag = DB::table('tags')
                 ->whereIn('product_id', $apps)
                ->get();
                $result[$j]->tags = $tag;  
                $j++;
                $result[$i]->varients = $app;
                $i++; 
             
            }

    
        	$message = array('status'=>'1', 'message'=>'Store Products', 'data'=>$prod);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Products not found', 'data'=>[]);
	        return $message;
    	} 
       
    }

       public function category_list(Request $request)
    {
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
        if(count($category)>0){
        	$message = array('status'=>'1', 'message'=>'Category List', 'data'=>$category);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Category not found', 'data'=>[]);
	        return $message;
    	} 
       
    }
     
    
     public function st_addproduct(Request $request)
    {
        $store_id = $request->store_id;
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
                                'added_by'=>$store_id,
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
                'added_by'=>$store_id
               
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

            $message = array('status'=>'1', 'message'=>trans('keywords.Added Successfully'));
	        return $message;
          
        }
        else{
             $message = array('status'=>'0', 'message'=>trans('keywords.Something Wents Wrong'));
	        return $message;
        }
      
    }
    
    public function St_updateproduct(Request $request)
    {
         $product_id = $request->product_id;
        $product_name = $request->product_name;
        $date=date('d-m-Y');
        $product_image = $request->product_image;
         $tags = explode(",", $request->tags);
          $images = $request->images;
        
         $type =$request->type;
       

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

                            
         if(!empty($request->tags)){
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
            }else{
                $enternew=1;
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
        
        
        if($insertproduct || $enternew){
            $message = array('status'=>'1', 'message'=>trans('keywords.Updated Successfully'));
	        return $message;
          
        }
        else{
             $message = array('status'=>'0', 'message'=>trans('keywords.Something Wents Wrong'));
	        return $message;
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
         
         
            $message = array('status'=>'1', 'message'=>trans('keywords.Deleted Successfully'));
	        return $message;
          
        }
        else{
             $message = array('status'=>'0', 'message'=>trans('keywords.Something Wents Wrong'));
	        return $message;
        }
    }

    
}
