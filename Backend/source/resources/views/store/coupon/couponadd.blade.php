@extends('store.layout.app')

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
                  <h4 class="card-title">{{ __('keywords.Add Coupon')}}</h4>
                  <form class="forms-sample" action="{{route('addcoupon')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                  <form>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Coupon Name')}}</label>
                          <input type="text"name="coupon_name" class="form-control" value="{{old('coupon_name')}}">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Coupon Code')}}</label>
                          <input type="text" name="coupon_code" class="form-control" value="{{old('coupon_code')}}">
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Description')}}</label>
                          <input type="text" name="coupon_desc" class="form-control" value="{{old('coupon_desc')}}">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <label class="bmd-label-floating">{{ __('keywords.Coupon')}} {{ __('keywords.Image')}}<b>({{ __('keywords.It Should Be Less Then 1000 KB')}})</b></label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="image" accept="image/*" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>

                       
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <!--<label class="bmd-label-floating">Valid From</label>-->
                          <p class="card-description">{{ __('keywords.From Date')}}</p>
                          <input type="datetime-local" name="valid_to" class="form-control" value="{{old('valid_to')}}">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <p class="card-description">{{ __('keywords.To Date')}}</p>
                          <input type="datetime-local" name="valid_from" class="form-control" value="{{old('valid_from')}}">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <p class="card-description">{{ __('keywords.Minimum Cart Value')}}</p>
                          <input type="number" name="cart_value" class="form-control" value="{{old('cart_value')}}">
                        </div>
                      </div>
                    </div><br>
                    <div class="row">
                    <div class="col-md-6">
                    <div class="form-group">
                    <label for="exampleFormControlSelect3">{{ __('keywords.Discount')}}</label>
                    <select class="form-control form-control-sm img" id="exampleFormControlSelect3" name="coupon_type">
                       <option values="">{{ __('keywords.Select')}}</option>
                      <option value="percentage">{{ __('keywords.Percentage')}}</option>
                      <option value="price">{{ __('keywords.Price')}}</option>
                      
                    </select>
                     <input type="text" class="form-control des_price" id="exampleInputName1" name="coupon_discount" placeholder="Enter discount" value="{{old('coupon_discount')}}">
                    </div>
                </div>
                  <div class="col-md-6">
                        <div class="form-group">
                           <label for="exampleFormControlSelect3">{{ __('keywords.Uses Restriction')}}</label>
                          <input type="text" name="restriction" class="form-control" placeholder="maximum uses per user"  value="{{old('restriction')}}" required>
                        </div>
                      </div>
            </div>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
          
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
        	$(document).ready(function(){
        	
                $(".des_price").hide();
                
        		$(".img").on('change', function(){
        	        $(".des_price").show();
        			
        	});
        	});
</script>          
          @endsection