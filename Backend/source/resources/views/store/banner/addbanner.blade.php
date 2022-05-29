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
                  <h4 class="card-title">{{ __('keywords.Add')}} {{ __('keywords.Banner')}}</h4>
                  
                </div>
                <div class="card-body">
                  <form class="forms-sample" action="{{route('storebanneradd')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}

                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Title')}}</label>
                          <input type="text" name="banner" class="form-control">
                        </div>
                        <div class="row">
                      <div class="col-md-12">
                        <div class="form">
                          <label class="bmd-label-floating"> {{ __('keywords.Image')}}</label>
                         <label class="btn btn-default btn-sm center-block btn-file">
                              <i class="fa fa-upload fa-2x" aria-hidden="true"></i>
                              <input type="file" name="image" style="display: none;">
                            </label>
                        </div>
                      </div>
                    </div>
                    </div>
                   <div class="col-md-12">    
                      <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Select')}} {{ __('keywords.Category')}}</label>
                          <select name="cat_id" class="form-control">
                              <option disabled selected>{{ __('keywords.Select')}} {{ __('keywords.Category')}}</option>
                              @foreach($category as $categorys)
        		          	<option value="{{$categorys->cat_id}}">{{$categorys->title}}</option>
        		              @endforeach
                              
                          </select>
                        </div>
                        </div>

                    <br>
                    

                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
@endsection          