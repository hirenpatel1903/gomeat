@extends('admin.layout.app')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/switchery/0.8.2/switchery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/switchery/0.8.2/switchery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js" ></script>
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

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
      <h1 class=""><b>{{ __('keywords.Product')}} {{ __('keywords.List')}}</b></h1>
      </div>
       <div class="col-md-6">
      <a href="{{route('AddProduct')}}" class="btn btn-primary p-1 ml-auto" style="width:15%;float:right;padding: 3px 0px 3px 0px;">{{ __('keywords.Add')}}</a>
      </div>
       </div>
    </div>
<div class="container"><br>    
<table id="datatableDefault" class="table table-striped text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
            <th>{{ __('keywords.Product')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.Product Id')}}</th>
            <th>{{ __('keywords.Category')}}</th>
            <th>{{ __('keywords.Type')}}</th>
            <th>{{ __('keywords.Product')}} {{ __('keywords.Image')}}</th>
            <th>Hide</th>
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
             <td> {{$products->type}}</td>
            <td class="text-center"><img src="{{$url_aws.$products->product_image}}" alt="image"  style="width:50px;height:50px; border-radius:50%"/></td>
            <td><input type="checkbox" data-id="{{ $products->product_id }}" name="status" class="js-switch" {{ $products->hide == 1 ? 'checked' : '' }}></td>
            <td class="td-actions text-right">
                <a href="{{route('EditProduct',$products->product_id)}}" rel="tooltip" class="btn btn-success">
                    <i class="fa fa-edit"></i>
                </a>
                <a href="{{route('varient',$products->product_id)}}" rel="tooltip" class="btn btn-primary">
                    <i class="fa fa-cubes"></i>
                </a>
                <a href="{{route('DeleteProduct',$products->product_id)}}" onClick="return confirm('Are you sure you want to permanently remove this Product.')" rel="tooltip" class="btn btn-danger">
                    <i class="fa fa-trash"></i>
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
    $(document).ready(function(){
    $('.js-switch').change(function () {
        let status = $(this).prop('checked') === true ? 1 : 0;
        let product_id = $(this).data('id');
        $.ajax({
            type: "GET",
            dataType: "json",
            url: '{{ route("hideprod") }}',
            data: {'status': status, 'product_id': product_id},
            success: function (data) {
                console.log(data.message);
            }
        });
    });
});
</script>
     
    <script>
    let elems = Array.prototype.slice.call(document.querySelectorAll('.js-switch'));

    elems.forEach(function(html) {
    let switchery = new Switchery(html,  { size: 'small' });
    });
    </script>

     
    @endsection
</div>