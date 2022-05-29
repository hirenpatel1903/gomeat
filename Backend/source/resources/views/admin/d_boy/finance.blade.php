@extends('admin.layout.app')
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
<div class="card">    
<div class="card-header card-header-primary">
      <h4 class="card-title ">{{ __('keywords.Incentive')}} {{ __('keywords.Payouts')}}</h4>
     
    </div>
<div class="container"> <br> 
<table id="datatableDefault" class="table text-nowrap w-100 table-striped">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
                      <!--<th>ID</th>-->
                      <th style="width:10%">{{ __('keywords.Delivery Boy')}}</th>
                      <th style="width:15%">{{ __('keywords.Address')}}</th>
                       <th style="width:15%">{{ __('keywords.Bank/UPI')}}</th>
                      <th style="width:15%">{{ __('keywords.Total Incentive')}}</th>
                      <th style="width:15%">{{ __('keywords.Paid Incentive')}}</th>
                      <th style="width:15%">{{ __('keywords.Pending Incentive')}}</th>
                       <th style="width:15%">{{ __('keywords.Action')}}</th>
                    </thead>
                    <tbody>
                         @if(count($total_earnings)>0)
                          @php $i=1; @endphp
                          @foreach($total_earnings as $total_earning)
                            <tr>
                                <td class="text-center">{{$i}}</td>
                                <td>{{$total_earning->boy_name}}<p style="font-size:14px">({{$total_earning->boy_phone}})</p></td>
                                <td>{{$total_earning->boy_loc}}</td>
                                 <td>@if($total_earning->holder_name != NULL)<b>{{ __('keywords.A/C Holder')}} :</b> {{$total_earning->holder_name}},<br>@endif @if($total_earning->ac_no != NULL)<b>{{ __('keywords.A/C No.')}} :</b>{{$total_earning->ac_no}},<br>@endif @if($total_earning->bank_name != NULL)<b>{{ __('keywords.Bank Name')}} :</b>{{$total_earning->bank_name}},<br>@endif @if($total_earning->ifsc != NULL)<b>{{ __('keywords.IFSC')}} :</b>{{$total_earning->ifsc}},<br>@endif
                                 @if($total_earning->upi != NULL)<b>{{ __('keywords.UPI')}} :</b> {{$total_earning->upi}}@endif</td>
                                <td>{{$total_earning->earned_till_now}}</td>
                                <td>{{$total_earning->paid_till_now}}</td>
                                <td>{{$total_earning->remaining}}</td>
                                <td class="td-actions text-center">
                                    @if($total_earning->remaining == 0)
                                    <span style="color:green">Paid</span>
                                    @else
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal1{{$total_earning->dboy_id}}">{{ __('keywords.Pay')}}</button>
                                    @endif
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
<br>
<div class="pull-right mb-1" style="float: right;">
  {{ $total_earnings->render("pagination::bootstrap-4") }}
</div>
   @foreach($total_earnings as $total_earning)
        <div class="modal fade" id="exampleModal1{{$total_earning->dboy_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        	<div class="modal-dialog" role="document">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title" id="exampleModalLabel"><b>{{$total_earning->boy_name}}</b></h5>
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
        						<span aria-hidden="true">&times;</span>
        					</button>
        			</div>
        			<br>
        			<!--//form-->
        			<form class="forms-sample" action="{{route('incentive_pay', $total_earning->dboy_id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
        			<div class="row">
        			    
        			  <div class="col-md-3" align="center"></div>  
                      <div class="col-md-6" align="center">
                        <div class="form-group">
                        <label>{{ __('keywords.Enter Amount')}}</label>        
        		     	<input class="form-control" type="number" min="10" step="0.01" value="{{$total_earning->remaining}}" step ="0.01" max="{{$total_earning->remaining}}"  name="amt"/>
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
</div>
</div>
</div>
</div>
</div>
<div>
 </div>

    @endsection
</div>