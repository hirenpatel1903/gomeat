@extends('store.layout.app')
<?php use Carbon\carbon;
?>
<style>

    .material-icons{
        margin-top:0px !important;
        margin-bottom:0px !important;
    }
</style>
@section ('content')
<div class="container-fluid">
 <div class="row">
<div class="col-lg-12">
@if (session()->has('success'))
<div class="alert alert-success">
@if(is_array(session()->get('success')))
        <ul>
            @foreach (session()->get('success') as $message)
                <li>{{ $message }}</li>
            @endforeach
        </ul>
        @else
            {{ session()->get('success') }}
        @endif
    </div>
@endif
 @if (count($errors) > 0)
  @if($errors->any())
    <div class="alert alert-danger" role="alert">
      {{$errors->first()}}
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">×</span>
      </button>
    </div>
  @endif
@endif
</div>
<div class="col-lg-12">
    <div class="separator"><h4 style="color:grey">{{ __('keywords.Delivery Boy')}} {{ __('keywords.Reports')}}</h4></div><hr>
</div>
<div class="col-lg-5">
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Top Delivery Boys')}}</h4>
     
    </div>
<div class="container"> <br> 
<table id="datatableDefault" class="table text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
                      <!--<th>ID</th>-->
                      <th>{{ __('keywords.Delivery Boy')}}</th>
                      <th>{{ __('keywords.Last 30 Days')}} {{ __('keywords.Orders')}}</th>
                    </thead>
                    <tbody>
                         @if(count($orddboy)>0)
                          @php $i=1; @endphp
                          @foreach($orddboy as $orddboys)
                            <tr>
                                <td class="text-center">{{$i}}</td>
                                <td>{{$orddboys->boy_name}}<p style="font-size:14px">({{$orddboys->boy_phone}})</p></td>
                                     
                                <td>{{$orddboys->count}}</td>
                              
                            </tr>      
                        @php $i++; @endphp
                        @endforeach
                      @else
                        <tr>
                          <td>{{ __('keywords.No data found')}}</td>
                        </tr>
                      @endif  
                    </tbody>
</table>

</div>
</div>
</div>
<div class="col-lg-7">
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Delivery Boy')}} {{ __('keywords.Orders')}} {{ __('keywords.Reports')}}</h4>
     
    </div>
<div class="container"> <br> 
<table id="datatableDefaults" class="table text-nowrap w-100  table-responsive">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
                      <!--<th>ID</th>-->
                      <th>{{ __('keywords.Delivery Boy')}}</th>
                      <th>{{ __('keywords.Last 30 Days')}} {{ __('keywords.Orders')}}</th>
                      <th>{{ __('keywords.Previous Month')}} {{ __('keywords.Orders')}}</th>
                      <th>{{ __('keywords.Last 3 Months')}} {{ __('keywords.Orders')}}</th>
                     
                    </thead>
                    <tbody>
                         @if(count($dboy)>0)
                          @php $i=1; @endphp
                          @foreach($dboy as $dboys)
                            <tr>
                                <td class="text-center">{{$i}}</td>
                                <td>{{$dboys->boy_name}}<p style="font-size:14px">({{$dboys->boy_phone}})</p></td>
                                <?php  
                                
                                $ordthirty =DB::table('orders')
                                         ->select('dboy_id', 'cart_id')
                                         ->whereDate('delivery_date', '>', Carbon::now()->subDays(30))
                                         ->where('payment_method','!=', NULL)
                                         ->where('order_status', 'Completed')
                                          ->where('dboy_id', $dboys->dboy_id)
                                         ->count();
             
                                  $ordmonth =DB::table('orders')
                                     ->select('dboy_id', 'cart_id')
                                     ->whereMonth('delivery_date', '=', Carbon::now()->subMonth()->month)
                                     ->where('payment_method','!=', NULL)
                                     ->where('order_status', 'Completed')
                                      ->where('dboy_id', $dboys->dboy_id)
                                     ->count();   
                                   
                                    $ord3month =DB::table('orders')
                                     ->select('dboy_id', 'cart_id')
                                     ->whereMonth('delivery_date', '=', Carbon::now()->subMonth(3)->month)
                                     ->where('payment_method','!=', NULL)
                                     ->where('order_status', 'Completed')
                                      ->where('dboy_id', $dboys->dboy_id)
                                     ->count();   
                                     ?>
                                     
                                <td>{{$ordthirty}}</td>
                                <td>{{ $ordmonth}}</td>
                                <td>{{ $ord3month}}</td>
                              
                            </tr>      
                        @php $i++; @endphp
                        @endforeach
                      @else
                        <tr>
                          <td>{{ __('keywords.No data found')}}</td>
                        </tr>
                      @endif  
                    </tbody>
</table>

</div>
</div>
</div>
<div class="col-lg-12">
    <hr><br><br>
    </div>
<div class="col-lg-12">
   <div class="separator"><h4 style="color:grey">{{ __('keywords.Users')}} {{ __('keywords.Reports')}}</h4></div><hr>
<style>
.separator {
    display: flex;
    align-items: center;
    text-align: center;
}
.separator::before, .separator::after {
    content: '';
    flex: 1;
    border-bottom: 1px solid #000;
}
.separator::before {
    margin-right: .25em;
}
.separator::after {
    margin-left: .25em;
}
</style>

</div>

<div class="col-lg-6">
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Top 10 Users')}} {{ __('keywords.Reports')}}</h4>
     
    </div>
<div class="container"> <br> 
<table id="datatableDefault3" class="table text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
                      <!--<th>ID</th>-->
                      <th>{{ __('keywords.User')}}</th>
                      <th>{{ __('keywords.Current Month')}}</th>
                      <th>{{ __('keywords.Previous Month')}}</th>
                      <th>{{ __('keywords.Difference')}}</th>
                     
                    </thead>
                    
                     <tbody>
                         @if(count($user)>0)
                          @foreach($user as $users)
                            <tr>
                                
                              <?php  
             
                                   $ordmonth2 =DB::table('orders')
                                     ->select('dboy_id', 'cart_id')
                                     ->whereMonth('delivery_date', '=', Carbon::now()->subMonth()->month)
                                     ->where('payment_method','!=', NULL)
                                     ->where('order_status', 'Completed')
                                     ->where('orders.store_id', $store->store_id)
                                     ->where('orders.user_id', $users->user_id)
                                     ->count();   
                                     
                                  if($ordmonth2==0){
                                      $ordmonth = 1;
                                  }else{
                                     $ordmonth =$ordmonth2;
                                  }
                                   if($users->count > $ordmonth2 ){
                                       $gettop = array($users);
                                       if(sizeof($gettop)<10){
                                       $i=1;
                                       
                                        if($ordmonth2==0){
                                      $difference = (($users->count/$ordmonth)*100);
                                        }else{
                                            $difference = (($users->count/$ordmonth)*100) -100;
                                        }
                                     ?>
                                <td class="text-center">{{$i}}</td>
                                <td>{{$users->user_name}}<p style="font-size:14px">({{$users->user_phone}})</p></td>
                               
                               <td>{{$users->count}}</td>
                                <td>{{ $ordmonth2}}</td>
                                <td><b style="color:red !important">{{$difference}}</b> %</td>
                                
                              <?php } } ?>
                            </tr>      
                        @php $i++; @endphp
                        @endforeach
                      @else
                        <tr>
                          <td>{{ __('keywords.No data found')}}</td>
                        </tr>
                      @endif  
                    </tbody>
</table>

</div>
</div>
</div>
<div class="col-lg-6">
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Worst 10 Users')}} {{ __('keywords.Reports')}}</h4>
     
    </div>
<div class="container"> <br> 
<table id="datatableDefault2" class="table text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
                      <!--<th>ID</th>-->
                     <th>{{ __('keywords.User')}}</th>
                      <th>{{ __('keywords.Current Month')}}</th>
                      <th>{{ __('keywords.Previous Month')}}</th>
                      <th>{{ __('keywords.Difference')}}</th>
                     
                    </thead>
                    <tbody>
                         @if(count($user2)>0)
                          @foreach($user2 as $userss)
                            <tr>
                                
                              <?php  
             
                                 $thismonth2 =DB::table('orders')
                                         ->select('dboy_id', 'cart_id')
                                        ->whereMonth('delivery_date', date('m'))
                                         ->whereYear('delivery_date', date('Y'))
                                         ->where('payment_method','!=', NULL)
                                         ->where('order_status', 'Completed')
                                         ->where('orders.store_id', $store->store_id)
                                         ->where('orders.user_id', $userss->user_id)
                                         ->count();
                                   if($thismonth2==0){
                                       $thismonth =1;
                                   }else{
                                        $thismonth =$thismonth2;
                                   }
                                   if($userss->count > $thismonth2 ){
                                         $gettop = array($userss);
                                       if(sizeof($gettop)<10){
                                           $i=1;
                                      $difference = (($userss->count/$thismonth)*100) -100;
                                     ?>
                                <td class="text-center">{{$i}}</td>
                                <td>{{$userss->user_name}}<p style="font-size:14px">({{$userss->user_phone}})</p></td>
                               
                                     
                                <td>{{$thismonth2}}</td>
                                <td>{{ $userss->count}}</td>
                                <td><b style="color:red !important">-{{$difference}}</b> %</td>
                                
                              <?php } } ?>
                            </tr>      
                        @php $i++; @endphp
                        @endforeach
                      @else
                        <tr>
                          <td>{{ __('keywords.No data found')}}</td>
                        </tr>
                      @endif  
                    </tbody>
</table>

</div>
</div>
</div>
</div>
</div>
<div>
 </div>

    @endsection
</div>
