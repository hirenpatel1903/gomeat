@extends('admin.layout.app')
<style>
sup {
    color:red;
    position: initial;
    font-size: 111%;
}
</style>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>  
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> 
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-tagsinput/0.8.0/bootstrap-tagsinput.js"></script>       
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
            <div class="col-md-12">
              <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Update')}} {{ __('keywords.Varient')}}</h4>
                  <form class="forms-sample" action="{{route('update-varient', $varient_id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                   
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label for="exampleInputName1">{{ __('keywords.MRP')}}</label>
                           <input type="hidden" name="id" value="{{$varient_id}}">
                          <input type="number" step="0.01" class="form-control" id="exampleInputName1" name="mrp" value="{{$product->base_mrp}}">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Price')}}</label>
                          <input type="number" step="0.01" name="price" class="form-control" value="{{$product->base_price}}">
                        </div>
                      </div>

                    </div>
                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Quantity')}}</label>
                          <input type="number" name="quantity" class="form-control" value="{{$product->quantity}}">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Unit')}} (G/KG/Ltrs/Ml)</label>
                          <input type="text" name="unit" class="form-control" pattern="[A-Za-z]{1-10}" value="{{$product->unit}}" title="KG/G/Ltrs/Ml etc" required>
                        </div>
                      </div>
                    </div>
                    
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.EAN Code')}}</label>
                          <input type="text" name="ean" class="form-control" value="{{$product->ean}}" required>
                        </div>
                      </div>
                     
                    </div>
                    
                     <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Description')}}</label>
                          <textarea type="text" name="description" class="form-control">{{$product->description}}</textarea>
                        </div>
                      </div>
                    </div><br>


                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <a href="{{route('varient',$product->product_id)}}" class="btn">{{ __('keywords.Close')}}</a>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>       

@endsection