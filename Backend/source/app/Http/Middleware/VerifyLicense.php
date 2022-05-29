<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Installer\LicenseBoxController;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;
use Illuminate\Routing\UrlGenerator;

use Session;



class VerifyLicense
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {         
            
            $result = dbConnection();

            if ($result){
    
                if(Schema::hasTable('licensebox')){
                    $license= DB::table('licensebox')->first();

                    if (!$license && (Session::get('status'))) {
                        $result = DB::table('licensebox')->insert(
                            [
                            'status' =>  'active',
                            'message' => Session::get('message'),
                            'license' => Session::get('license'),
                            'client' => Session::get('client') ]
                        );    

                        Session::forget('message');
                        Session::forget('status');
                        Session::forget('license');
                        Session::forget('client');
                    }
                    
                    if ($license) {

                        $date2 = \Carbon\Carbon::now();
                        $final_date = \Carbon\Carbon::createFromFormat('Y-m-d H:s:i', $license->updated_at)->addDays(5);
                        $diff_in_days = $date2->diffInDays($final_date);

                        if ($license->status == "inactive" || $diff_in_days>7) {
                            return redirect('verifyLicense');
                        } else {
                            if (!session()->has('licenseStatus')) {
                                Session::put('licenseStatus', $license->status);
                            }
                            else if($request->route()->uri == "/") {
                                return redirect('login');
                            }  
                        }
                    }
                }                
            }

            if (!$result) {                
                 if(Str::contains($request->route()->uri,"") || Str::contains($request->route()->uri,"store") ) {
                    return redirect('/');
                }                 
            }                

            return $next($request);

        
    }
}
