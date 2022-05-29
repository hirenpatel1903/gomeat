@extends('store.layout.app')
<style>
        .collo {
      overflow-y: hidden;
      overflow-x: scroll;
      -webkit-overflow-scrolling: touch;
    }


</style>
@section ('content')
<div class="container-fluid">
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
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Order')}} {{ __('keywords.List')}} ({{ __('keywords.Next Day')}})</h4>
    </div>
<div class="container"> <br> 
<table id="datatableDefault" class="table text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
            <th>{{ __('keywords.Cart_id')}}</th>
            <th>{{ __('keywords.Cart price')}}</th>
            <th>{{ __('keywords.User')}}</th>
            <th>{{ __('keywords.Delivery_Date')}}</th>
       <th>{{ __('keywords.Delivery Boy')}}</th>
            <th>{{ __('keywords.Cart Products')}}</th>
            <th>{{ __('keywords.Payment')}}</th>
            <th class="text-right">{{ __('keywords.Confirmation')}}</th>
            <th>{{ __('keywords.Reassign Dboy')}}</th>
            <th>{{ __('keywords.Invoice')}}</th>
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
            <td>{{$ords->name}}({{$ords->user_phone}})</td>
             <td>{{$ords->delivery_date}}</td>
       @if($ords->boy_name!= NULL)
             <td>{{$ords->boy_name}}<p style="font-size:14px">({{$ords->boy_phone}})</p></td>
        @else
        <td>{{ __('keywords.Order Not confirmed yet')}}</td>
              @endif
            <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal1{{$ords->cart_id}}">Details</button></td>
            @if($ords->payment_status == 'success' || $ords->payment_status == 'Success')
            <td>{{$ords->payment_method}} | {{ __('keywords.Paid')}} </td>
            @endif
             @if($ords->payment_status == 'failed' || $ords->payment_status == 'Failed')
            <td>{{$ords->payment_method}} | {{ __('keywords.Failed')}} </td>
            @endif
             @if($ords->payment_status == 'cod' || $ords->payment_status == 'COD' || $ords->payment_status == 'Cod')
            <td>{{ __('keywords.Cash on Delivery')}}</td>
            @endif
                <td class="td-actions text-right">
         @if($ords->order_status == 'Pending')
                 <a href="{{route('store_confirm_order', $ords->cart_id)}}" data-toggle="modal" data-target="#exampleModal1{{$ords->order_id}}" rel="tooltip" class="btn btn-success">
                {{ __('keywords.Confirm/Assign')}}
                </a>
               <a href="{{route('store_reject_order' , $ords->cart_id)}}" rel="tooltip" class="btn btn-danger">
               Reject
                </a>
                @endif
              
                @if($ords->order_status == 'Confirmed'||$ords->order_status == 'confirmed'||$ords->order_status == 'Confirm'||$ords->order_status == 'confirm')
                <p style="color:orange !important">{{ __('keywords.Confirmed')}}</p>
                @endif
                @if($ords->order_status == 'Out_For_Delivery'||$ords->order_status == 'out_for_delivery'||$ords->order_status == 'delivery_out'||$ords->order_status == 'Delivery_out')
                <p style="color:yellowgreen !important">{{ __('keywords.Out For Delivery')}}</p>
                @endif
                 @if($ords->order_status == 'completed'||$ords->order_status == 'Completed'||$ords->order_status == 'Complete'||$ords->order_status == 'complete')
                <p style="color:green !important">{{ __('keywords.Completed')}}</p>
                @endif
            </td>
            <td>
                @if($ords->order_status == 'Confirmed'||$ords->order_status == 'confirmed'||$ords->order_status == 'Confirm'||$ords->order_status == 'confirm')
                 <a href="{{route('store_confirm_order', $ords->cart_id)}}" data-toggle="modal" data-target="#exampleModal1{{$ords->order_id}}" rel="tooltip" class="btn btn-success">
                {{ __('keywords.ReAssign Dboy')}}
                </a>
             @else
       <p>Order Not confirmed yet</p>
              @endif
            </td>
            <td><a target="_blank" rel="noopener noreferrer" style="margin-right: 10px; !important" href="{{route('invoice', $ords->cart_id)}}" class="btn btn-success">
              Invoice
                </a>&nbsp; &nbsp;<a target="_blank" rel="noopener noreferrer"  href="{{route('a4invoice', $ords->cart_id)}}" class="btn btn-success">
               A4 Invoice
                </a></td>
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

<!--/////////dboy assign model//////////-->
@foreach($ord as $ords)
        <div class="modal fade" id="exampleModal1{{$ords->order_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">{{ __('keywords.Delivery Boy')}} {{ __('keywords.Assign')}} (<b>{{$ords->cart_id}}</b>)</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <!--//form-->
              <form class="forms-sample" action="{{route('store_reassign_order', $ords->cart_id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
              <div class="row">
                <div class="col-md-3" align="center"></div>  
                      <div class="col-md-6" align="center">
                        <div class="form-group">
                  <select name="dboy_id" class="form-control">
                  <option disabled selected>{{ __('keywords.Select')}} {{ __('keywords.Delivery Boy')}}</option>
                  @foreach($nearbydboy as $nearbydboys)
                   <option value="{{$nearbydboys->dboy_id}}">{{$nearbydboys->boy_name}}({{$nearbydboys->distance}} KM away)</option>
                  @endforeach
              </select>
              </div>
              <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
              </div>
              </div>
                
                    <div class="clearfix"></div>
              </form>
              <!--//form-->
            </div>
          </div>
        </div>
 @endforeach
    @endsection
</div>