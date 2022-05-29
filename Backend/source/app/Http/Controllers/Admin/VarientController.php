<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;

use App\Http\Controllers\Controller;
use DB;
use Session;
use App\Models\Admin;
use Auth;
class VarientController extends Controller
{
    public function varient(Request $request)
    {
         $id = $request->id;
          $p= DB::table('product')
                 ->where('product_id', $id)
                ->first();
         
        $title=$p->product_name." Varient";
    	 
    	$admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $product= DB::table('product_varient')
                 ->where('product_id', $id)
                 ->where('approved',1)
                ->paginate(10);
        $currency =  DB::table('currency')
               ->select('currency_sign')
                ->get();           
        return view('admin.product.varient.show_varient',compact("admin_email","product","admin","currency","id",'title','logo'));
    }
    
     public function Addproduct(Request $request)
    {
        $id = $request->id;  
        $p= DB::table('product')
                 ->where('product_id', $id)
                ->first();
         
        $title=$p->product_name." Varient Addition";
    	 
    	$admin_email=Auth::guard('admin')->user()->email;
    	$admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $product= DB::table('product_varient')
                 ->where('product_id', $id)
                ->get();
        $currency =  DB::table('currency')
               ->select('currency_sign')
                ->get(); 
        
                
            // echo $id;
         return view('admin.product.varient.addvarient',compact("admin_email","admin","id",'title','logo'));
    }
    
    
   public function AddNewproduct(Request $request)
    {
         
        $id = $request->id;
        $mrp = $request->mrp;
        $price=$request->price;
        $unit=$request->unit;
        $quantity=$request->quantity;
        $description =$request->description;
        $date = date('d-m-Y');
        $created_at=date('d-m-Y h:i a');
      
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
                        ->insertGetId(['product_id'=>$id,'base_mrp'=>$mrp, 'base_price'=>$price,'varient_image'=>$image, 'unit'=>$unit, 'quantity'=>$quantity,'description'=>$description, 'ean'=>$ean]);
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

    	$admin_email=Auth::guard('admin')->user()->email;
    	 $admin= DB::table('admin')
    	         ->leftJoin('roles','admin.role_id','=','roles.role_id')
    	 		 ->where('admin.email',$admin_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
        $product= DB::table('product_varient')
                 ->where('varient_id', $varient_id)
                ->first();
             
        $p= DB::table('product')
                 ->where('product_id', $product->product_id)
                ->first();
         $title=$p->product_name." Varient Update";
         
    	 return view('admin.product.varient.editvarient',compact("admin_email","admin","product","varient_id",'title','logo'));
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
        $varient_image = $request->varient_image;
         $ean = $request->ean;
        $getImage = DB::table('product_varient')
                     ->where('varient_id',$product_id)
                    ->first();

        $image = $getImage->varient_image;  


            $varient_image ='N/A';
        

       $varient_update = DB::table('product_varient')
                            ->where('varient_id', $product_id)
                            ->update(['base_mrp'=>$mrp, 'base_price'=>$price,'varient_image'=>$varient_image, 'unit'=>$unit, 'quantity'=>$quantity,'description'=>$description,'ean'=>$ean]);

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
            
          return redirect('product/list')->withSuccess(trans('keywords.Deleted Successfully'));
        
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
