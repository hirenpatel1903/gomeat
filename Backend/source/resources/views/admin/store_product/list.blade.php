@extends('admin.layout.app')
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
      <h4 class="card-title ">{{ __('keywords.Store')}} {{ __('keywords.Products')}} ({{ __('keywords.For Approval') }})</h4>
    </div>
   
<div class="container"> <br> 
<table id="datatableDefault" class="table w-100 table-responsive table-striped">
    <thead class="thead-light">
        <tr>
            <th>#</th>
             <th>{{ __('keywords.Image')}}</th>
            <th>{{ __('keywords.Product')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.price')}}</th>
            <th>{{ __('keywords.MRP')}}</th>
            <th>{{ __('keywords.Store')}}</th>
            <th class="td-actions text-right">{{ __('keywords.Approve/Reject')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($product)>0)
          @php $i=1; @endphp
          @foreach($product as $products)
        <tr>
            <td class="text-center">{{$i}}</td>
             <td><img src="{{url($products->product_image)}}" alt="{{$products->product_name}}" style="width:50px;height:50px; border-radius:50%"></td>
            <td>{{$products->product_name}}({{$products->quantity}}{{$products->unit}})</td>
            <td>{{$products->base_price}}</td>
            <td>{{$products->base_mrp}}</td>
            <td>{{$products->store_name}}({{$products->city}}),<br><b>{{$products->phone_number}}</b></td>
               
            <td class="td-actions text-right">
                 @if($products->approved==1)
               <p><b style="color:green">{{ __('keywords.Approved')}}</b></p>
               @elseif($products->approved==2)
               <p><b style="color:red">{{ __('keywords.Rejected')}}</b></p>
                @else
                <a href="{{route('st_p_approve',$products->varient_id)}}"  onclick="return confirm('Are you sure you want to approve this product ?')" rel="tooltip" class="btn btn-primary">
                  {{ __('keywords.Approve')}}
                </a>
                 <a href="{{route('st_p_reject',$products->varient_id)}}" rel="tooltip" onclick="return confirm('Are You sure! It will be rejected ?')" class="btn btn-danger">
                   {{ __('keywords.Reject')}}
                </a>
                @endif
                
            </td>
        </tr>
          @php $i++; @endphp
                 @endforeach
                  @else
                    <tr>
                      <td colspan="7">{{ __('keywords.No data found')}}</td>
                    </tr>
                  @endif
    </tbody>
</table>
<div class="pull-right mb-1" style="float: right;">
  {{ $product->render("pagination::bootstrap-4") }}
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