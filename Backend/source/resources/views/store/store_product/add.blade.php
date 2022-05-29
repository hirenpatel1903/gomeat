@extends('store.layout.app')
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
                  <h4 class="card-title">{{ __('keywords.Add Product')}}</h4>
                  <form class="forms-sample" action="{{route('storeAddNewProduct')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">

                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Category')}}</label>
                          <select name="cat_id" class="form-control">
                              <option disabled selected>{{ __('keywords.Select')}} {{ __('keywords.Category')}}</option>
                              @foreach($category as $categorys)
                              
        		          	<option value="{{$categorys->cat_id}}">@if($categorys->level==1)-@endif @if($categorys->level==2)--@endif {{$categorys->title}}</option>
        		              @endforeach
                              
                          </select>
                        </div>
                      </div>
                       <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Type')}}</label>
                          <select name="type" class="form-control">
                              <option disabled selected>{{ __('keywords.Select')}} {{ __('keywords.Type')}}</option>
                              <option value="Regular">{{ __('keywords.Regular')}}</option>
                              <option value="In Season">{{ __('keywords.In Season')}}</option>
                              
                          </select>
                        </div>
                      </div>

                    </div>

 
                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Product')}} {{ __('keywords.Name')}}</label>
                          <input type="text" name="product_name" class="form-control" value="{{old('product_name')}}" required>
                        </div>
                      </div>
                       <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Quantity')}}</label>
                          <input type="number" name="quantity" class="form-control" value="{{old('quantity')}}" required>
                        </div>
                      </div>
                    </div>
                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Unit')}} (G/KG/Ltrs/Ml)</label>
                          <input type="text" name="unit" class="form-control" pattern="[A-Za-z]{1-10}" title="KG/G/Ltrs/Ml etc" value="{{old('unit')}}" required>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.EAN Code')}}</label>
                          <input type="text" name="ean"  value="{{old('ean')}}" class="form-control" required>
                        </div>
                      </div>
                    </div>
                    
                    <div class="row">
                       <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.MRP')}}</label>
                          <input type="number" step="0.01" name="mrp" value="{{old('mrp')}}" class="form-control" required>
                        </div>
                      </div>
                        <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Price')}}</label>
                          <input type="number" step="0.01" name="price" value="{{old('price')}}" class="form-control" required>
                        </div>
                      </div>
                    </div>
              
                    
                     <div class="row">
                    <div class="col-md-6">
                        <label class="bmd-label-floating">{{ __('keywords.Main')}} {{ __('keywords.Product')}} {{ __('keywords.Image')}} <b>({{ __('keywords.It Should Be Less Then 1000 KB')}})</b></label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="product_image" accept="image/*" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                      </div>
                       <div class="col-md-6">
                      <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Tags')}}</label>
                           <input type="text" data-role="tagsinput" class="form-control" name="tags" value="{{old('tags')}}">
                        </div>
                        </div>
                    </div>
                    
                     <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Description')}}</label>
                          <textarea type="text" name="description" class="form-control" required>{{old('description')}}</textarea>
                        </div>
                      </div>
                    </div>

                        <div class="row">
                      
                        <label class="bmd-label-floating"> {{ __('keywords.Product')}} {{ __('keywords.Images')}}<b>({{ __('keywords.Each Should Be Less Then 1000 KB')}})</b></label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="images[]" accept="image/*" multiple/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>

                        
                      </div> 
                    <br>


                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <a href="{{route('storeproductlist')}}" class="btn">{{ __('keywords.Close')}}</a>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
@endsection




