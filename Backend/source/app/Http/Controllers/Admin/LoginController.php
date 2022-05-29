<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use DB;
use Illuminate\Support\Facades\Storage;
use App\Models\Admin;
use Auth;
use Session;

class LoginController extends Controller
{
    use AuthenticatesUsers;

    protected $redirectTo = 'admin';

    public function __construct()
    {
         $result = dbConnection();
        if (!$result){
            return redirect('/verification');
        }
        
         $storage =  DB::table('image_space')
                    ->first();
        if($storage){
        if($storage->aws == 1){
            $this->storage_space = "s3.aws";
        }
        else if($storage->digital_ocean == 1){
            $this->storage_space = "s3.digitalocean";
        }else{
            $this->storage_space ="same_server";
        }
        }else{
            $this->storage_space ="same_server";
        }

        $this->middleware('guest:admin')->except('logout');
    }
    

    public function adminLogin(Request $request)
    {
         $result = dbConnection();
        if (!$result){
            return redirect('/verification');
        }
        if (Auth::guard('admin')->check()) {
            return redirect()->route('adminHome');
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
                
        return view('admin.auth.login', compact('logo','url_aws'));
    }

    public function adminLoginCheck(Request $request)
    {
        $this->validate($request, [
            'email'   => 'required|email',
            'password' => 'required|min:6'
        ]); 

        $credentials = $request->only('email', 'password'); 

        if (Auth::guard('admin')->attempt($credentials)) {
            //dd(Auth::guard('admin')->user()-email);
           
            return redirect()->route('adminHome');
        }
        else {
            return redirect()->route('adminLogin')->withErrors(trans('keywords.Email/Password Wrong'));
        } 

    }
  
  
    public function logout(Request $request)
    {
        Auth::guard('admin')->logout();
        
        return redirect()->route('adminLogin')->withErrors(trans('keywords.logged out'));
    }

    protected function guard()
    {
        return Auth::guard('admin');
    }
}
