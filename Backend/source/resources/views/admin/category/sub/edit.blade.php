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
            <div class="col-md-12">
              <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Edit')}} {{ __('keywords.Sub Category')}}</h4>
                  <form class="forms-sample" action="{{route('UpdateCategory', $cat->cat_id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">

                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Parent Category')}}</label>
                         <select name="parent_id" class="form-control">
                              @foreach($category as $categorys)
        		          	<option value="{{$categorys->cat_id}}" @if ( $categorys->cat_id == $cat->parent) selected @endif>{{$categorys->title}}</option>
        		              @endforeach
                              
                          </select>
                        </div>
                      </div>
                      
                    </div>

                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Title')}}</label>
                          <input type="text" value="{{$cat->title}}" name="cat_name" class="form-control">
                        </div>
                      </div>

                    </div>
                    <img src="{{url($cat->image)}}" alt="image" name="old_image" style="width:100px;height:100px; border-radius:50%">
                     <div class="row">
                       
                      <div class="col-md-6">
                        <label class="bmd-label-floating">{{ __('keywords.Image')}} <b>({{ __('keywords.It Should Be Less Then 1000 KB')}})</b></label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="cat_image" accept="image/*"/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                      </div>
                
                    </div>
                       <div class="row">
                      <div class="col-md-6">
                        <div class="form">
                          <label class="bmd-label-floating">{{ __('keywords.Description')}}</label>
                          <textarea name="desc" class="form-control">{{$cat ->description}}</textarea>
                        </div>
                      </div>
                    </div><br>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <a href="{{route('subcatlist')}}" class="btn">{{ __('keywords.Close')}}</a>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
@endsection




