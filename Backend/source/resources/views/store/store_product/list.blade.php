@extends('store.layout.app')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/switchery/0.8.2/switchery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/switchery/0.8.2/switchery.min.js"></script>

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
      <h1 class="card-title"><b>{{ __('keywords.Product')}} {{ __('keywords.List')}}</b></h1>
      </div>
       <div class="col-md-6">
      <a href="{{route('storeAddProduct')}}" class="btn btn-primary p-1 ml-auto" style="width:15%;float:right;padding: 3px 0px 3px 0px;">{{ __('keywords.Add')}}</a>
      </div>
       </div>
    </div>
<div class="container"><br>    
<table id="datatableDefault" class="table text-nowrap w-100 table-striped">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
            <th>{{ __('keywords.Product')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.Product Id')}}</th>
            <th>{{ __('keywords.Category')}}</th>
            <th>{{ __('keywords.Product')}} {{ __('keywords.Image')}}</th>
            <th class="text-right">{{ __('keywords.Actions')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($product)>0)
          @php $i=1; @endphp
          @foreach($product as $products)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$products->product_name}}</td>
            <td>{{$products->product_id}}</td>
            <td> {{$products->title}}</td>
            <td><img src="{{$url_aws.$products->product_image}}"" alt="image"  style="width:50px;height:50px; border-radius:50%"/></td>
            <td class="td-actions text-right">
               
                <a href="{{route('storevarient',$products->product_id)}}" rel="tooltip" class="btn btn-primary">
                    <i class="fa fa-cubes"></i>
                </a>
             
            </td>
        </tr>
          @php $i++; @endphp
                 @endforeach
                  @else
                    <tr>
                      <td colspan="6">{{ __('keywords.No data found')}}</td>
                    </tr>
                  @endif
    </tbody>
</table>
<div class="pull-right mb-1" style="float: right;">
  {{ $product->links("pagination::bootstrap-4") }}
</div>
    </div>
    </div>
    </div>
    </div>
    </div>
    <div>
    </div>
    <script>
    let elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));

    elems.forEach(function(html) {
    let switchery = new Switchery(html,  { size: 'small' });
    });
    </script>

     
    @endsection
</div>