@extends('admin.layout.app')
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

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
<div class="col-lg-6" style="float:left">
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Order History')}}</h4>
    </div>
   
<div class="container"> <br> 
<table id="datatableDefault" class="table table-striped text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
            <th>{{ __('keywords.Cart_id')}}</th>
            <th>{{ __('keywords.Cart price')}}</th>
             <th>{{ __('keywords.Status')}}</th>
            <th>{{ __('keywords.Details')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($ord)>0)
          @php $i=1; @endphp
          @foreach($ord as $ords)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$ords->cart_id}}</td>
            <td>{{$ords->total_price}}</td>
              @if($ords->order_status==NULL || $ords->order_status=="")
             <td><p><span class="dot" style="color:orange"></span><b style="color:orange">NOT PLACED</b></p></td>
            @endif 
               @if($ords->order_status == "Pending" || $ords->order_status == "pending")
             <td><p><span class="dot" style="color:orange"></span><b style="color:orange">Pending</b></p></td>
            @endif 
             @if($ords->order_status=="Confirmed" || $ords->order_status=="confirmed")
             <td><p><span class="dot" style="color:purple"></span><b style="color:purple">Confirmed</b></p></td>
            @endif
             @if($ords->order_status=="out_for_delivery" || $ords->order_status=="Out_For_Delivery")
             <td><p><span class="dot" style="color:orange"></span><b style="color:orange">Out For Delivery</b></p></td>
            @endif
             @if($ords->order_status=="Cancelled" || $ords->order_status=="cancelled")
             <td><p><span class="dot" style="color:red"></span><b style="color:red">Cancelled</b></p></td>
            @endif
             @if($ords->order_status=="Completed" || $ords->order_status=="completed")
             <td><p><span class="dot" style="color:green"></span><b style="color:green">Completed</b></p></td>
            @endif
             
            <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal1{{$ords->cart_id}}">{{ __('keywords.Details')}}</button></td>
        </tr>
          @php $i++; @endphp
                 @endforeach
                  @else
                    <tr>
                      <td colspan="5">{{ __('keywords.No data found')}}</td>
                    </tr>
                  @endif
    </tbody>
</table><br>
<div class="pull-right mb-1" style="float: right;">
  {{ $ord->render("pagination::bootstrap-4") }}
</div>
</div>  
</div>
</div>
<div class="col-lg-6" style="float:left">
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.User')}}</h4>
    </div>
   
<div class="container">
<div class="card-body">
        <div class="row">
            <div class="col-md-2">
             <img src="{{url($userr->user_image)}}" style="width:50px;height:50px;border-radius:50%;" alt="image"></div>
              <div class="col-md-10"><br><h3><b>{{$userr->name}}</b></h3></div>
        </div>
    </div>
</div>  
<div class="card-header card-header-primary">
      <h2 class="card-title ">{{ __('keywords.Contact Information')}}</h2>
    </div>
<div class="card-body">
        <div class="row">
            <div class="col-md-12">
                <h3><b>{{$userr->user_phone}}</b></h3>
             </div><br>
              <div class="col-md-12"><h3><b>{{$userr->email}}</b></h3></div>
        </div><br><hr><br>
         <strong> {{ __('keywords.Delivery Address')}} </strong><br />
              @foreach($address as $addresss) 
              <div class="container card">
            <b>{{$addresss->type}} :</b> {{$addresss->house_no}},{{$addresss->society}},<br>@if($addresss->landmark !=NULL) {{$addresss->landmark}},<br>@endif {{$addresss->city}},{{$addresss->state}},<br>
              {{$addresss->pincode}}</div><br>
             @endforeach 
    </div>
</div>
@if(count($users)>0)
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Membership Rechage History')}}</h4>
    </div>
   
<div class="container"> <br> 
<table id="datatableDefault1" class="table text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th>#</th>
            <th>{{ __('keywords.User')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.User Phone')}}</th>
            <th>{{ __('keywords.Plan Name')}}</th>
            <th>{{ __('keywords.Buy Date')}}</th>
            <th>{{ __('keywords.Expiry Date')}}</th>
            <th>{{ __('keywords.Medium')}}</th>
            <th>{{ __('keywords.Membership Price')}}</th>
            <th>{{ __('keywords.Payment Status')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($users)>0)
          @php $i=1; @endphp
          @foreach($users as $user)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$user->name}}</td>
            <td>{{$user->user_phone}}</td>
            <td>{{$user->plan_name}}</td>
            <td>{{$user->buy_date}}</td>
             <td>{{$user->mem_end_date}}</td>
             <td>{{$user->payment_gateway}}</td>
              <td>{{$user->price}}</td>
             @if($user->payment_status=="success")
            <td><p style="color:green"><b>Success</b></p></td>
            @else
            <td><p style="color:red"><b>Failed</b></p></td>
            @endif
           
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
@endif
</div>

</div>
</div>
</div>
<div>
    </div>

<!--/////////details model//////////-->
@foreach($ord as $ords)
 <div id="printThis">
<div class="modal fade" id="exampleModal1{{$ords->cart_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="container">
     
    	<div class="modal-dialog" role="document">
    		<div class="modal-content">
    			<div class="modal-header">
    				<h5 class="modal-title" id="exampleModalLabel">{{ __('keywords.Order Details')}}</h5>
    					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
    						<span aria-hidden="true">&times;</span>
    					</button>
    			</div>
        <div class="material-datatables">
              <form role="form" method="post" action="" >
            <table id="datatables" class="table table-striped table-no-bordered table-hover" cellspacing="0" width="100%" style="width:100%" data-background-color="purple">

                
                <tbody>
                    <tr>
                        <td colspan="5">
                            <table class="table">
                                <tr>
                                    <td valign="top" style="width:50%">
                                    <strong> {{ __('keywords.Order_Id')}} : </strong> {{$ords->cart_id}}
                                    <br />
                                      <strong>{{ __('keywords.Customer_name')}} : </strong>{{$ords->receiver_name}}<br/>
                                        <strong>{{ __('keywords.Contact')}} : </strong>{{$ords->receiver_phone}}, @if($ords->user_phone != $ords->receiver_phone){{$ords->receiver_phone}}@endif <br/> 
                                    <strong>  {{ __('keywords.Delivery_Date')}} : </strong>{{$ords->delivery_date}}
                                    <br />
                                    <strong>  {{ __('keywords.Time_Slot')}} : </strong>{{$ords->time_slot}}
                                    <br />
                                    </td>
                                    <td  style="width:50%" align="right">
                                        <strong> {{ __('keywords.Delivery Address')}} </strong><br />
                                      
                                        <b>{{$ords->type}} :</b> {{$ords->house_no}},{{$ords->society}},<br>@if($ords->landmark !=NULL) {{$ords->landmark}},<br>@endif {{$ords->city}},{{$ords->state}},<br>
                                          {{$ords->pincode}}
                                     </td>
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>

                    <tr>
                        <th>{{ __('keywords.Product_Name')}}</th>
                        <th>{{ __('keywords.Qty')}}</th>
                        <th>{{ __('keywords.Tax')}}</th>
                        <th>{{ __('keywords.Price')}}</th>
                        <th>{{ __('keywords.Total_Price')}}</th>
                    </tr>
                    @if(count($details)>0)
                            @php $i=1; @endphp
                                      
                          <tr>             
                        @foreach($details as $detailss)
                          @if($detailss->cart_id==$ords->cart_id)
                         <td><p><img style="width:25px;height:25px; border-radius:50%" src="{{url($detailss->varient_image)}}" alt="$detailss->product_name">  {{$detailss->product_name}}({{$detailss->quantity}}{{$detailss->unit}})</p>
                            </td>
                            <td>{{$detailss->qty}}</td>
                             <td> @if($detailss->tx_per == 0 || $detailss->tx_per == NULL)0 @else {{$detailss->tx_per}}@endif % @if($detailss->tx_per != 0 && $detailss->tx_name != NULL)({{$detailss->tx_name}})@endif</td>
                             <td>
                            <p><span style="color:grey">@if($detailss->price_without_tax != NULL){{$detailss->price_without_tax}} @else {{$detailss->price}} @endif</span></p>
                           </td>
                            <td> 
                            <p><span style="color:grey">{{$detailss->price}}</span></p>
                           </td>
    		          	  @endif
                         </tr>
                            @php $i++; @endphp
                            @endforeach
                          @else
                            <tr>
                              <td>{{ __('keywords.No_data_found')}}</td>
                            </tr>
                                  @endif
                   
                   
                    <tr>
                        <td colspan="4" class="text-right"><strong class="pull-right">{{ __('keywords.Products_Price')}} : </strong></td>
                         <td  class="text-right" colspan="1">
                            <strong>{{$ords->price_without_delivery}}</strong>
                        </td>
                    </tr><tr>
                        <td colspan="4"  class="text-right"><strong class="pull-right">{{ __('keywords.Delivery_Charge')}} : </strong></td>
                         <td  class="text-right"  colspan="1">
                            <strong >+{{$ords->delivery_charge}}</strong>
                        </td>
                    </tr>@if($ords->paid_by_wallet > 0)
                    <tr>    
                        <td colspan="4"  class="text-right"><strong class="pull-right">{{ __('keywords.Paid_By_Wallet')}} : </strong></td>
                         <td  class="text-right" colspan="1">
                            <strong>-{{$ords->paid_by_wallet}}</strong>
                        </td>
                    </tr>@endif
                    @if($ords->coupon_discount > 0)
                    <tr>    
                        <td colspan="4" class="text-right"><strong class="pull-right">{{ __('keywords.Coupon_Discount')}} : </strong></td>
                         <td  class="text-right" colspan="1">
                            <strong class="">-{{$ords->coupon_discount}}</strong>
                        </td>
                    </tr>
                    @endif
                    <tr>
                        <td colspan="4" class="text-right"><strong class="pull-right">{{ __('keywords.Net_Total(Payable)')}}:</strong></td>
                        <td  class="text-right" colspan="1">{{$ords->rem_price}}</td>
                    </tr>
                </tbody>
            </table>
            </form>
        </div>
         <div class="modal-footer">
       <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">{{ __('keywords.Close')}}</button>
      </div>
    </div>
    
    <!-- end content-->
</div></div>
                            <!--  end card  -->
	
		</div>
	</div>
</div>

                                
         @endforeach    
<style>.buttons-html5 {
    color: white !important;
    background-color: #35d26d !important;
    border-radius: 5px;
    margin: 2px !important;
}
.buttons-print {
    color: white !important;
    background-color: #35d26d !important;
    border-radius: 5px;
    margin: 2px !important;
}</style>
<script>
     $('#myTable').DataTable( {
    dom: 'Bfrtip',
    buttons: [
        'copy', 'excel', 'pdf'
    ]
} );
    </script>
    
    
    @endsection
</div>