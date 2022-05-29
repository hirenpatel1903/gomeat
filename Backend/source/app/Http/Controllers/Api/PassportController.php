<?php
 
namespace App\Http\Controllers\Api;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

 
class PassportController extends Controller
{

    public function validates(Request $request)
    {
      
            return response()->json(['error' => 'UnAuthorised'], 401);
        
    }
 
 
}