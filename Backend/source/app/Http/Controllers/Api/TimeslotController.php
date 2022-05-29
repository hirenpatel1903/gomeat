<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use Carbon\Carbon;
use DateTime;

class TimeslotController extends Controller
{
  public function timeslot(Request $request)
    {
     $store_id = $request->store_id;       
    $current_time = Carbon::Now();
    $date = date('Y-m-d');
    $date2 = "12:00";
    $tes2 = date("h:i a",strtotime($date2));
     $time_slot = DB::table('store')
               ->where('id',$store_id)
               ->first();
    $starttime  = $time_slot->store_opening_time;
    $endtime  = $time_slot->store_closing_time;
    $duration  = $time_slot->time_interval;
    $selected_date  = $request->selected_date;
    $orders= $time_slot->orders; 
    $array_of_time = array ();
    $array_of_time1 = array ();
    $min = 10;
    $currenttime = strtotime ("+".$min." minutes", strtotime($current_time));
    $start_time    = strtotime ($starttime); //change to strtotime
    $end_time      = strtotime ($endtime); //change to strtotime

    $add_mins  = $duration * 60;
if(strtotime($date)==strtotime($selected_date)){
    if(strtotime($tes2)<=$currenttime){
         $message = array('status'=>'0', 'message'=>'Oops No time slot present', 'data'=>$current_time);
            return $message;
    }
    while ($start_time <= $currenttime) // loop between time
    {
       $array_of_time[] = date ("h:i a", $start_time);
       $start_time += $add_mins; // to check endtie=me
    }

    $new_array_of_time = array ();
    for($i = 0; $i < count($array_of_time) - 1; $i++)
    {
        $new_array_of_time[] = '' . $array_of_time[$i] . ' - ' . $array_of_time[$i + 1];
      
    }
    
$items=last($new_array_of_time);
$numbers = explode('-', $items);
$last_Number = end($numbers);
 $lastNumber    = strtotime ($last_Number);
 if($last_Number!= NULL){
while ($lastNumber <= $end_time) // loop between time
    {
       $array_of_time1[] = date ("h:i a", $lastNumber);
       $lastNumber += $add_mins; // to check endtie=me
    }
     
    $new_array_of_time1 = array ();
    for($i = 1; $i < count($array_of_time1) - 1; $i++)
    {
        $tes = date("h:i a", strtotime($array_of_time1[$i + 1]));
       $tes2 = date("h:i a",strtotime($date2));

        if(strtotime($tes)>=strtotime($tes2)){
          break;
        }
         $totorders = DB::table('orders')
               ->where('delivery_date',$selected_date)
               ->where('time_slot',$array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1])
               ->count();
       
        if($orders > $totorders){
            
            $new_array_of_time1[] =array('timeslot'=>'' . $array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1], 'availibility'=>'available');
            
        }
        else{

             $new_array_of_time1[] =array('timeslot'=>'' . $array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1], 'availibility'=>'unavailable');
        }
        
    }
 }
 else{
     while ($start_time <= $end_time) // loop between time
    {
       $array_of_time1[] = date ("h:i a", $start_time);
       $start_time += $add_mins; // to check endtie=me
    }

    $new_array_of_time1 = array ();
    for($i = 1; $i < count($array_of_time1) - 1; $i++)
    {
         $totorders = DB::table('orders')
               ->where('delivery_date',$selected_date)
               ->where('time_slot',$array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1])
               ->count();
       
        if($orders > $totorders){
            
            $new_array_of_time1[] =array('timeslot'=>'' . $array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1], 'availibility'=>'available');
            
        }
        else{

             $new_array_of_time1[] =array('timeslot'=>'' . $array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1], 'availibility'=>'unavailable');
        }
    }
 }
    
}
elseif(strtotime($date)>strtotime($selected_date)){
   
                $message = array('status'=>'0', 'message'=>"You can't select the back date", 'data'=>$current_time);
            return $message; 
}
else{
    while ($start_time <= $end_time) // loop between time
    {
       $array_of_time1[] = date ("h:i a", $start_time);
       $start_time += $add_mins; // to check endtie=me
    }

    $new_array_of_time1 = array ();
    for($i = 0; $i < count($array_of_time1) - 1; $i++)
    {
         $totorders = DB::table('orders')
               ->where('delivery_date',$selected_date)
               ->where('time_slot',$array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1])
               ->count();
       
        if($orders > $totorders){
            
            $new_array_of_time1[] =array('timeslot'=>'' . $array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1], 'availibility'=>'available');
            
        }
        else{

             $new_array_of_time1[] =array('timeslot'=>'' . $array_of_time1[$i] . ' - ' . $array_of_time1[$i + 1], 'availibility'=>'unavailable');
        }
    }
    
}
    if(count($new_array_of_time1)>0){
       
  
        
            $message = array('status'=>'1', 'message'=>'Present time Slot', 'data'=>$new_array_of_time1);
            return $message;
            }
            else
            {
                $message = array('status'=>'0', 'message'=>'Oops No time slot present', 'data'=>$current_time);
            return $message;
            }
    
    }
            
            
            
            
    
    
    
 
}