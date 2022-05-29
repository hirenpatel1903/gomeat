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
      <h4 class="card-title ">{{ __('keywords.Order List')}} ({{ __('keywords.Today')}}</h4>
</div>
<div class="card-header card-header-secondary">
    <form class="forms-sample" action="{{route('store_datewise_orders')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                     <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <label style="margin-bottom: 13px;margin-top: 10px;">{{ __('keywords.Payment Method')}}</label>
                          <select name="payment_method" class="form-control">
                              <option disabled selected>{{ __('keywords.Select')}} {{ __('keywords.Payment Method')}}</option>
                              <option value="all">{{ __('keywords.All')}}</option>
                              <option value="COD">{{ __('keywords.COD')}}</option>
                              <option value="online">{{ __('keywords.Online')}}</option>
                              <option value="wallet">{{ __('keywords.Wallet')}}</option>
                              
                          </select>
                        </div>
                      </div>
                       <div class="col-md-3"><br>
                        <div class="form-group">
                          <label>{{ __('keywords.From Date')}}</label><br>
                          <input type="date" name="sel_date" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-3"><br>
                        <div class="form-group">
                          <label>{{ __('keywords.To Date')}}</label><br>
                          <input type="date" name="to_date" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-2">
                        <div class="form-group">
                          <button type="submit"  style="margin-bottom: 13px;margin-top: 10px;" class="btn btn-primary">{{ __('keywords.Show Orders')}}</button>
                        </div>
                      </div>
                    </div>  
            </form>
       </div><hr>
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
            <th class="text-right">{{ __('keywords.Order Status')}}</th>
            <th>{{ __('keywords.Store')}}</th>
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
			  <td>Order Not confirmed yet</td>
              @endif
            <td><button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal1{{$ords->cart_id}}">Details</button></td>
            @if($ords->payment_status == 'success' || $ords->payment_status == 'Success')
            <td>{{$ords->payment_method}} | {{ __('keywords.Paid')}} </td>
            @endif
             @if($ords->payment_status == 'cod' || $ords->payment_status == 'COD' || $ords->payment_status == 'Cod')
            <td>{{ __('keywords.Cash on Delivery')}}</td>
            @endif
                <td class="td-actions text-right">
                <p style="color:green !important">{{$ords->order_status}}</p>
            </td>
            <td class="td-actions text-right">
                <p>{{$ords->store_name}}({{$ords->phone_number}})</p>
            </td>
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
        <div class="modal fade" id="exampleModal1{{$ords->cart_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        	<div class="modal-dialog" role="document">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title" id="exampleModalLabel">{{ __('keywords.Order Details')}} (<b>{{$ords->cart_id}}</b>)</h5>
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
        						<span aria-hidden="true">&times;</span>
        					</button>
        			</div>
        			<!--//form-->
        			<table class="table table-bordered" id="example2" width="100%" cellspacing="0">
                      <thead>
                        <tr>
                        <th>{{ __('keywords.product details')}}</th>
                        <th>{{ __('keywords.Order Qty')}}</th>
                        <th>{{ __('keywords.Price')}}</th>
                             @if($ords->order_status == 'Pending') <th>{{ __('keywords.Remove')}}</th> @endif
                        </tr>
                      </thead>
                      
                      <tbody>
                      @if(count($details)>0)
                                      @php $i=1; @endphp
                                      
                          <tr>             
                        @foreach($details as $detailss)
                          @if($detailss->cart_id==$ords->cart_id)
    		          	   
                            <td><p><img style="width:25px;height:25px; border-radius:50%" src="{{url($detailss->varient_image)}}" alt="$detailss->product_name">  {{$detailss->product_name}}({{$detailss->quantity}}{{$detailss->unit}})</p>
                            </td>
                            <td>{{$detailss->qty}}</td>
                            <td> 
                            <p><span style="color:grey">{{$detailss->price}}</span></p>
                           </td>
                             @if($ords->order_status == 'Pending')
                           <td align="center">
                           <a href="{{route('store_cancel_product', $detailss->store_order_id)}}" rel="tooltip">
                            <i class="material-icons" style="color:red">close</i>
                            </a>
                        </td> 
                         @endif
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
        </div>
 @endforeach
    @endsection
</div>