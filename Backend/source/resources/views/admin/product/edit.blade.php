@extends('admin.layout.app')
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
                  <h4 class="card-title">{{ __('keywords.Edit')}} {{ __('keywords.Product')}}</h4>
                  <form class="forms-sample" action="{{route('UpdateProduct', $product->product_id)}}" method="post" enctype="multipart/form-data">
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
                              
        		          	<option value="{{$categorys->cat_id}}"  @if($categorys->cat_id ==$product->cat_id)selected @endif >@if($categorys->level==1)-@endif{{$categorys->title}}</option>
        		              @endforeach
                              
                          </select>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Type')}}</label>
                          <select name="type" class="form-control">
                              <option disabled selected>{{ __('keywords.Select')}} {{ __('keywords.Type')}}</option>
                              <option value="Regular" @if($product->type=="Regular") selected @endif>{{ __('keywords.Regular')}}</option>
                              <option value="In Season" @if($product->type=="In Season") selected @endif>{{ __('keywords.In Season')}}</option>
                              
                          </select>
                        </div>
                      </div>


                    </div>
                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Product')}} {{ __('keywords.Name')}}</label>
                          <input type="text" value="{{$product -> product_name}}" name="product_name" class="form-control">
                        </div>
                      </div>
                       <div class="col-md-6">
                      <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Tags')}}</label>
                           <input type="text" data-role="tagsinput" class="form-control" name="tags">
                           <strong>Tags:</strong>
                          @foreach($tags as $tagssss)
                               @if($tagssss->product_id == $product -> product_id)
                              <label class="label label-info">{{$tagssss->tag}}</label>
                              @endif
                          @endforeach
                        </div>
                        </div>
                    </div>
                    <img src="{{$url_aws.$product->product_image}}" alt="image" name="old_image" style="width:100px;height:100px; border-radius:50%">
                     <div class="row">
                      <div class="col-md-12">
                        <div class="form">
                          <label class="bmd-label-floating">{{ __('keywords.Product')}} {{ __('keywords.Image')}} <b>({{ __('keywords.It Should Be Less Then 1000 KB')}})</b></label>
                             <div class="custom-file" style="margin-top:10px">
                            <input type="file" class="custom-file-input" id="customFile" name="product_image" accept="image/*" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                        </div>
                      </div>
                       
                    </div><br>
                    <div class="row">
                      
                       
                         <div class="col-md-12">
                         @foreach($images as $im)
                              <img src="{{$url_aws.$im->image}}" alt="image" style="width:50px;height:50px; border-radius:50%;border:2px solid black;float: left;">
                          @endforeach
                        </div><br>
                         <div class="col-md-12"><br>
                              <label class="bmd-label-floating"> {{ __('keywords.Product')}} {{ __('keywords.Images')}}<b>({{ __('keywords.Each Should Be Less Then 1000 KB')}})</b></label>
                        <div class="custom-file" style="margin-top:10px">
                            <input type="file" class="custom-file-input" id="customFile" name="images[]" accept="image/*" multiple/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>

                        </div>
                      </div> <br>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                     <a href="{{route('productlist')}}" class="btn">{{ __('keywords.Close')}}</a>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
@endsection




