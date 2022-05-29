@extends('store.layout.app')
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
    <div class="row">
    <div class="col-md-6">
      <h1 class="card-title"><b>{{ __('keywords.Coupon')}} {{ __('keywords.List')}}</b></h1>
      </div>
       <div class="col-md-6">
      <a href="{{route('coupon')}}" class="btn btn-primary p-1 ml-auto" style="width:15%;float:right;padding: 3px 0px 3px 0px;">{{ __('keywords.Add')}}</a>
      </div>
       </div>
    </div>
<div class="container"><br>
<table id="datatableDefault" class="table text-nowrap w-100 table-striped">
    <thead class="thead-light">
        <tr>
            <th>#</th>
            <th>{{ __('keywords.Coupon Name')}}</th>
            <th>{{ __('keywords.Discount')}}</th>
            <th>{{ __('keywords.Amount')}}</th>
            <th>{{ __('keywords.From Date')}}</th>
            <th>{{ __('keywords.To Date')}}</th>
            <th>{{ __('keywords.Uses Limit Per User')}}</th>
            <th>{{ __('keywords.Cart Value')}}</th>
            <th class="text-center">{{ __('keywords.Actions')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($coupon)>0)
          @php $i=1; @endphp
          @foreach($coupon as $cities)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$cities->coupon_name}}</td>
            <td>{{$cities->amount}}</td>
            <td>{{$cities->type}}</td>
            <td>{{$cities->start_date}}</td>
            <td>{{$cities->end_date}}</td>
            <td>{{$cities->uses_restriction}}</td>
            <td>{{$cities->cart_value}}</td>

            <td class="td-actions text-center">
                <a href="{{route('editcoupon',$cities->coupon_id)}}" rel="tooltip" class="btn btn-success">
                    <i class="material-icons">edit</i>
                </a>
               <a href="{{route('deletecoupon',$cities->coupon_id)}}" onClick="return confirm('Are you sure you want to permanently remove this Coupon.')" rel="tooltip" class="btn btn-danger">
                    <i class="material-icons">close</i>
                </a>
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
  {{ $coupon->render("pagination::bootstrap-4") }}
</div>
</div>
</div>
</div>
</div>
</div>
<div>
    </div>

    @endsection
</div>