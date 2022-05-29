<?php

namespace App\Http\Controllers\Store;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use DB;
use Illuminate\Support\Facades\Storage;
use App\Models\Store;
use Auth;
use Session;

class StoreLoginController extends Controller
{
    use AuthenticatesUsers;

    public function __construct()
    {
         $result = dbConnection();
        if (!$result){
            return redirect('/');
        }
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
        $this->middleware('guest:store')->except('logout');
    }

    public function storeLogin(Request $request)
    {
        if (Auth::guard('store')->check()) {
            return redirect()->route('storeHome');
        }
         if($this->storage_space != "same_server"){
           $url_aws =  rtrim(Storage::disk($this->storage_space)->url('/'),"/");
        }          
        else{
            $url_aws=url('/');
        }        
        $logo = DB::table('tbl_web_setting')
                ->where('set_id', '1')
                ->first();
                
        return view('store.auth.login', compact('logo','url_aws'));
    }

    public function storeLoginCheck(Request $request)
    {
        $this->validate($request, [
            'email'   => 'required|email',
            'password' => 'required|min:6'
        ]); 

        $credentials = $request->only('email', 'password'); 
   
        if (Auth::guard('store')->attempt($credentials)) {

            
            return redirect()->route('storeHome');
        }
        else {
            return redirect()->route('storeLogin')->withErrors(trans('keywords.Email/Password Wrong'));
        }        
    }
    
    public function secretStoreLogin(Request $request)
    {
        $id=$request->id;
        if(Auth::guard('store')->check()){
         Auth::guard('store')->logout();  
        }
    	if(Auth::guard('store')->loginUsingId($id)){
           
           return redirect()->route('storeHome');
         
    	}else
         {
         	 return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
         }
    }
  
    public function logout(Request $request)
    {
        Auth::guard('store')->logout();
        return redirect()->route('storeLogin')->withErrors(trans('keywords.Store logged out'));
    }

    protected function guard()
    {
        return Auth::guard('store');
    }

}
