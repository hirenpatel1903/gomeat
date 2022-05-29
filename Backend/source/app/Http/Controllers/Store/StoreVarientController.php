<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;

use App\Http\Controllers\Controller;
use DB;
use Session;
use Auth;

class StoreVarientController extends Controller
{
    public function varient(Request $request)
    {
         $id = $request->id;
          $p= DB::table('product')
                 ->where('product_id', $id)
                ->first();
         
        $title=$p->product_name." Varient";
       
       $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
          $logo = DB::table('tbl_web_setting')
                ->first();
        $product= DB::table('product_varient')
                 ->where('added_by', $store->id)
                 ->where('product_id', $id)
                ->get();
        $currency =  DB::table('currency')
               ->select('currency_sign')
                ->get();           
        return view('store.store_product.varient.show_varient',compact("email","product","store","currency","id",'title','logo'));
    }
    
     public function Addproduct(Request $request)
    {
        $id = $request->id;  
        $p= DB::table('product')
                 ->where('product_id', $id)
                ->first();
         
        $title=$p->product_name." Varient Addition";
       
      $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
          $logo = DB::table('tbl_web_setting')
                ->first();
        $product= DB::table('product_varient')
                 ->where('product_id', $id)
                ->get();
        $currency =  DB::table('currency')
               ->select('currency_sign')
                ->get(); 
        
                
            // echo $id;
         return view('store.store_product.varient.addvarient',compact("email","store","id",'title','logo'));
    }
    
    
   public function AddNewproduct(Request $request)
    {
        $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
         
        $id = $request->id;
        $mrp = $request->mrp;
        $price=$request->price;
        $unit=$request->unit;
        $quantity=$request->quantity;
        $description =$request->description;
        $date = date('d-m-Y');
        $created_at=date('d-m-Y h:i a');
        $tags = explode(",", $request->tags);
         $ean = $request->ean;
          
        $this->validate(
            $request,
                [
                    'mrp'=>'required',
                    'description'=>'required',
                    'quantity'=>'required',
                    'unit'=>'required',
                    'price'=>'required',
                    'ean'=>'required'
                ],
                [
                    'mrp.required'=>'enter mrp',
                    'description.required'=>'enter description about product',
                    'mrp.required'=>'enter product MRP',
                    'quantity.required'=>'enter quantity',
                    'unit.required'=>'enter unit',
                    'ean.required'=>'Enter Ean Code'
                ]
        );
                
 
            $image = 'N/A';
        

        
        
        $insert =  DB::table('product_varient')
                        ->insertGetId(['product_id'=>$id,'base_mrp'=>$mrp, 'base_price'=>$price,'varient_image'=>$image, 'unit'=>$unit, 'quantity'=>$quantity,'description'=>$description, 'ean'=>$ean,'approved'=>0,'added_by'=>$store->id]);
     if($insert){
       
         return redirect()->back()->withSuccess(trans('keywords.Added Successfully'));
     }
     else{
     return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
     }
  
    }
    
    public function Editproduct(Request $request)
    {
 
       $varient_id=$request->id;

       $email=Auth::guard('store')->user()->email;
         $store= DB::table('store')
                   ->where('email',$email)
                   ->first();
          $logo = DB::table('tbl_web_setting')
                ->first();
        $product= DB::table('product_varient')
                 ->where('varient_id', $varient_id)
                ->first();
          
        $p= DB::table('product')
                 ->where('product_id', $product->product_id)
                ->first();
         $title=$p->product_name." Varient Update";
         
       return view('store.store_product.varient.editvarient',compact("email","store","product","varient_id",'title','logo'));
   }
    public function Updateproduct(Request $request)
   {
     
        $product_id=$request->id;
        $id = $request->id;
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
                            ->update(['base_mrp'=>$mrp, 'base_price'=>$price,'varient_image'=>$varient_image, 'unit'=>$unit, 'quantity'=>$quantity,'description'=>$description,'ean'=>$ean,'approved'=>0]);

        if($varient_update){
          

            return redirect()->back()->withSuccess(trans('keywords.Updated Successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }
  public function deleteproduct(Request $request)
    {
        $varient_id=$request->id;
        $getmain = DB::table('product_varient')->where('varient_id',$request->id)->first();
         $getall = DB::table('product_varient')->where('product_id',$getmain->product_id)->get();
          if(count($getall)==1){
              $delete=DB::table('product_varient')->where('varient_id',$request->id)->delete();
             $deleteprod=DB::table('product')->where('product_id',$getmain->product_id)->delete();
              $deleteold = DB::table('tags')
              ->where('product_id', $getmain->product_id)
              ->delete();
            
          return redirect('store/special/product/list')->withSuccess(trans('keywords.Deleted Successfully'));
        
         }else{
               $delete=DB::table('product_varient')->where('varient_id',$request->id)->delete();
         }
       
    
        if($delete)
        {
          
        return redirect()->back()->withSuccess(trans('keywords.Deleted Successfully'));

        }
        else
        {
          return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong')); 
        }

    }
  
    
}
