<?php

namespace App\Http\Controllers\Admin;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Mail;
use DB;
use Hash;
use App\Traits\SendInapp;
use App\Traits\SendMail;
use Carbon\Carbon;
use App\Traits\SendSms;
class AuthController extends Controller
{


    use SendMail;
    use SendSms;
    use SendInapp;


  
  
    public function reset_pass(Request $request)
    {
        $logo = DB::table('tbl_web_setting')
             ->first();
       $app_name = $logo->name;
        return view('auth.passwords.email',compact('logo','app_name'));
        }
       
  

 
    
   


 public function validatePasswordRequest(Request $request) {

        $app = DB::table('tbl_web_setting')
             ->first();
        $app_name= $app->name;     
        $user_email = $request->email;
        $chars = "abcdefghijklmnopqrstuvwxyz0123456789";
                $val = "";
                for ($i = 0; $i < 50; $i++){
                    $val .= $chars[mt_rand(0, strlen($chars)-1)];
                }
        $check = DB::table('admin')
                ->where('email',$user_email)
                ->first();
                
                
        $tokenData = DB::table('password_resets')
            ->where('email', $request->email)->delete();        
         //Create Password Reset Token
        DB::table('password_resets')->insert([
            'email' => $request->email,
            'token' => $val,
            'created_at' => Carbon::now()
        ]);
        //Get the token just created above
        $tokenData = DB::table('password_resets')
            ->where('email', $request->email)->first();         
        if($check){      
            
        $this->sendResetEmail($request->email, $tokenData->token);
            
        
        
    return redirect(route('adminLogin'))->withSuccess(trans('keywords.Email Reset Link Has Been Sent to').' '.$user_email.' '.trans('keywords.Please Check'));
        }else{
           return redirect()->back()->withErrors(trans('keywords.User Email not Registered'));
        }
    }
  
  
  public function forgot_passwordadmin(Request $request)
    {
      
      $password=$request->password;
      $password1=$request->password2;
      $id= $request->token; 
       $tokenData = DB::table('password_resets')
            ->where('token', $id)->first();   
     if($tokenData){  
            
        $email =    $tokenData->email; 

    if($password != NULL || $password1 != NULL){
      if($password==$password1){
        $insertcategories = DB::table('admin')
                            ->where('email',$email)
                            ->update([
                                'password'=> \Hash::make($password)
                            ]);
        
        if($insertcategories){
            
              $tokenData = DB::table('password_resets')
            ->where('token', $id)->delete();   
              return redirect(route('adminLogin'))->withSuccess(trans('keywords.Password Has Been Changed! Login with New Password'));
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Something Wents Wrong'));
        }
      }
      else{
          return redirect()->back()->withErrors(trans('keywords.Password did Not Match'));
      }
        }
        else{
            return redirect()->back()->withErrors(trans('keywords.Enter password in both fields'));
        }
     }else{
           return redirect(route('adminLogin'))->withErrors(trans('keywords.Token Has Been Expired'));
     }
    }
 
    

         public function change_pass2(Request $request) {
             
             $logo = DB::table('tbl_web_setting')
             ->first();
        $id= $request->token;
        
        $tokenData = DB::table('password_resets')
            ->where('token', $id)->first();   
          if($tokenData){  
            
        $email =    $tokenData->email; 
        
        $user = DB::table('admin')
            ->where('email',$email)
            ->first();
        return view('admin.forgetpassword.changepassadmin', compact('user','logo','id'));
          }
          else{
               return redirect(route('adminLogin'))->withErrors(trans('keywords.Token Has Been Expired'));
          }
    }   
    
   


    
}