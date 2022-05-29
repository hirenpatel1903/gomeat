<?php

namespace App\Http\Controllers\Store;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Session;
use Carbon\Carbon;
use Auth;

class DealController extends Controller
{
    public function list(Request $request)
    {
        $title = "Deal Product List";
        $currentdate = Carbon::now();
       	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
           $deal_p = DB::table('deal_product')
                    ->join('product_varient','deal_product.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->where('deal_product.store_id', $store->id)
                    ->paginate(10);
        
    	return view('store.deal_product.list', compact('title',"store","store_email", "logo","deal_p","currentdate"));
    }

    
     public function AddDeal(Request $request)
    {
    
        $title = "Add Deal Product";
          	$store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
                
           $deal = DB::table('store_products')
                ->join('product_varient','product_varient.product_id','=','product_varient.product_id')
                ->join('product','product_varient.product_id','=','product.product_id')
                ->select('product_varient.quantity','product_varient.unit','product_varient.varient_id','product.product_name')
                ->groupBy('product_varient.quantity','product_varient.unit','product_varient.varient_id','product.product_name')
                ->where('store_products.store_id', $store->id)
                ->where('product_varient.approved',1)
                ->get();
        
        
        
        return view('store.deal_product.add',compact("deal", "store_email","logo", "store", "title"));
     }
    
     public function AddNewDeal(Request $request)
    {
         $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
        $varient_id = $request->varient_id;
        $deal_price = $request->deal_price;
        $valid_from = $request->valid_from;
        $valid_to = $request->valid_to;
        $date=date('d-m-Y');
 
    
        
        $this->validate(
            $request,
                [
                    
                    'varient_id' => 'required',
                    'deal_price' => 'required',
                    'valid_from' => 'required',
                    'valid_to'=>'required',
                ],
                [
                    'varient_id.required' => 'Select Varient',
                    'deal_price.required' => 'Enter Deal Price',
                    'valid_from.required' => 'Choose valid from date',
                    'valid_to.required'=> 'Choose valid from date',
                ]
        );


        $insertCategory = DB::table('deal_product')
                            ->insert([
                                'varient_id'=>$varient_id,
                                'deal_price'=>$deal_price,
                                'valid_from'=>$valid_from,
                                'valid_to'=>$valid_to,
                                'status'=>1,
                                'store_id'=>$store->id
                               
                            ]);
        
        if($insertCategory){
            return redirect()->back()->withSuccess(trans('keywords.Added successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
      
    }
    
    public function EditDeal(Request $request)
    {
         $deal_id = $request->id;
         $title = "Edit Deal Products";
     
        $store_email=Auth::guard('store')->user()->email;
    	 $store= DB::table('store')
    	 		   ->where('email',$store_email)
    	 		   ->first();
    	 $deal = DB::table('store_products')
                ->join('product_varient','product_varient.product_id','=','product_varient.product_id')
                ->join('product','product_varient.product_id','=','product.product_id')
                  ->select('product_varient.quantity','product_varient.unit','product_varient.varient_id','product.product_name')
                ->groupBy('product_varient.quantity','product_varient.unit','product_varient.varient_id','product.product_name')
                ->where('store_products.store_id', $store->id)
                 ->where('product_varient.approved',1)
                ->get();
        
    	  $logo = DB::table('tbl_web_setting')
                ->first();	
          $deal_p = DB::table('deal_product')
                    ->join('product_varient','deal_product.varient_id','=','product_varient.varient_id')
                    ->join('product','product_varient.product_id','=','product.product_id')
                    ->where('deal_id',$deal_id)
                    ->first();

        return view('store.deal_product.edit',compact("deal_p","store_email","store","logo","deal", "title"));
    }

    public function UpdateDeal(Request $request)
    {
        $deal_id = $request->id;
       $varient_id = $request->varient_id;
        $deal_price = $request->deal_price;
        $valid_from = $request->valid_from;
        $valid_to = $request->valid_to;
        $date=date('d-m-Y');
 
    
        
        $this->validate(
            $request,
                [
                    
                    'varient_id' => 'required',
                    'deal_price' => 'required',
                    'valid_from' => 'required',
                    'valid_to'=>'required',
                ],
                [
                    'varient_id.required' => 'Select Varient',
                    'deal_price.required' => 'Enter Deal Price',
                    'valid_from.required' => 'Choose valid from date',
                    'valid_to.required'=> 'Choose valid from date',
                ]
        );


        $updateDeal = DB::table('deal_product')
                    ->where('deal_id', $deal_id)
                            ->update([
                                'varient_id'=>$varient_id,
                                'deal_price'=>$deal_price,
                                'valid_from'=>$valid_from,
                                'valid_to'=>$valid_to,
                                'status'=>1,
                               
                            ]);
        
        if($updateDeal){
            return redirect()->back()->withSuccess(trans('keywords.Updated successfully'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
    }

 public function DeleteDeal(Request $request)
    {
        $deal_id=$request->id;

    	$delete=DB::table('deal_product')->where('deal_id',$deal_id)->delete();
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