<?php

namespace App\Http\Controllers\Storeapi;

use Illuminate\Http\Request;

use App\Http\Controllers\Controller;
use DB;
use Session;

class StvarientController extends Controller
{
    public function varient_list(Request $request)
    {
         $id = $request->product_id;
          $p= DB::table('product')
                 ->where('product_id', $id)
                ->first();

       $store_id = $request->store_id;
      
        $product= DB::table('product_varient')
                 ->where('added_by', $store_id)
                 ->where('product_id', $id)
                ->get();
        $currency =  DB::table('currency')
               ->select('currency_sign')
                ->get();  
                
        if(count($product)>0){
        	$message = array('status'=>'1', 'message'=>'Product Varient', 'data'=>$product);
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Varients not found', 'data'=>[]);
	        return $message;
    	}  
    }
    
  
    
    
   public function AddNewproduct(Request $request)
    {
        $store_id = $request->store_id;
        $id = $request->product_id;
        $mrp = $request->mrp;
        $price=$request->price;
        $unit=$request->unit;
        $quantity=$request->quantity;
        $description =$request->description;
        $date = date('d-m-Y');
        $created_at=date('d-m-Y h:i a');
   
         $ean = $request->ean;
          
       
 
            $image = 'N/A';
        

        
        
        $insert =  DB::table('product_varient')
                        ->insertGetId(['product_id'=>$id,'base_mrp'=>$mrp, 'base_price'=>$price,'varient_image'=>$image, 'unit'=>$unit, 'quantity'=>$quantity,'description'=>$description, 'ean'=>$ean,'approved'=>0,'added_by'=>$store_id]);

      if($insert){
        	$message = array('status'=>'1', 'message'=>'Product Varient Added');
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Something Wents Wrong');
	        return $message;
    	}  
  
    }
    
   
    public function Updateproduct(Request $request)
   {
       $store_id = $request->store_id;
        $product_id=$request->varient_id;
        $id = $request->product_id;
        $mrp = $request->mrp;
        $price=$request->price;
        $unit=$request->unit;
        $quantity=$request->quantity;
        $description =$request->description;
        $date = date('d-m-Y');
        $created_at=date('d-m-Y h:i a');
        $ean = $request->ean;

   
            $varient_image = 'N/A';
        

       $varient_update = DB::table('product_varient')
                            ->where('varient_id', $product_id)
                            ->update(['varient_image'=>$varient_image, 'unit'=>$unit, 'quantity'=>$quantity,'description'=>$description,'ean'=>$ean,'approved'=>0]);
        $st_varient_upd=DB::table('store_products')
                            ->where('varient_id', $product_id)
                            ->where('store_id', $store_id)  
                            ->first();
    if($st_varient_upd){                        
        $st_varient_update = DB::table('store_products')
                            ->where('varient_id', $product_id)
                            ->where('store_id', $store_id)
                            ->update(['price'=>$price, 'mrp'=>$mrp]);
    }else{
        $st_varient_update=DB::table('store_products')
                            ->where('varient_id', $product_id)
                            ->where('store_id', $store_id)  
                            ->first();
    }
        if($varient_update || $st_varient_update){
          
         	$message = array('status'=>'1', 'message'=>'Product Varient Updated');
	        return $message;
              }
    	else{
    		$message = array('status'=>'0', 'message'=>'Something Wents Wrong');
	        return $message;
    	}  
    }
  public function deleteproduct(Request $request)
    {
        $varient_id=$request->varient_id;
        $store_id=$request->store_id;
          $st_varient_upd=DB::table('store_products')
                            ->where('varient_id', $varient_id)
                            ->where('store_id', $store_id)  
                            ->first();
        if($st_varient_upd){
            
             $getmain = DB::table('product_varient')->where('varient_id',$varient_id)->first();
         $getall = DB::table('product_varient')->where('product_id',$getmain->product_id)->get();
          if(count($getall)==1){
              $editp= DB::table('product')->where('product_id',$getmain->product_id)->update(['added_by'=>0]);
             $delete=DB::table('store_products')->where('varient_id', $varient_id)
                            ->where('store_id', $store_id)->delete();
          }else{
          
                $delete=DB::table('store_products')->where('varient_id', $varient_id)
                            ->where('store_id', $store_id)->delete();
          }
        }else{
           
        $getmain = DB::table('product_varient')->where('varient_id',$varient_id)->first();
         $getall = DB::table('product_varient')->where('product_id',$getmain->product_id)->get();
          if(count($getall)==1){
             
              $delete=DB::table('product_varient')->where('varient_id',$varient_id)->delete();
             $deleteprod=DB::table('product')->where('product_id',$getmain->product_id)->delete();
              $deleteold = DB::table('tags')
              ->where('product_id', $getmain->product_id)
              ->delete();
        
        
        	$message = array('status'=>'1', 'message'=>trans('keywords.Deleted Successfully'));
	        return $message;
        
         }else{
              
               $delete=DB::table('product_varient')->where('varient_id',$varient_id)->delete();
         }
       }
    
        if($delete)
        {
          
       $message = array('status'=>'1', 'message'=>trans('keywords.Deleted Successfully'));
	        return $message;

        }
        else
        {
            $message = array('status'=>'1', 'message'=>trans('keywords.Something Wents Wrong'));
	        return $message;
        }

    }
  
    
}
