@extends('store.layout.app')

@section ('content')


        <div class="content-wrapper">
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
            
            <div class="col-md-12 grid-margin stretch-card">
              <div class="card">
                  <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Add')}} {{ __('keywords.Home Category')}} {{ __('keywords.Group')}}</h4>
                  
                </div>
                <div class="card-body">
                  <form class="forms-sample" action="{{route('storeUpdateHomeCategory', [$category->homecat_id])}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                    <div class="form-group">
                      <label class="bmd-label-floating" for="exampleInputName1">{{ __('keywords.Home Category')}} {{ __('keywords.Title')}}</label>
                      <input type="text" class="form-control" id="exampleInputName1" name="category_name" value="{{$category->homecat_name}}" required>
                    </div>
                    
                    <div class="form-group">
                      <label class="bmd-label-floating">{{ __('keywords.Home Category')}} {{ __('keywords.Group')}} {{ __('keywords.Order')}}(1 {{ __('keywords.to')}} 10)</label>
                     
                      <div class="input-group col-xs-12">
                      <input type="text" name="category_order" value="{{$category->order}}" class="form-control file-upload-default" required>
                     
                      </div>
                    </div>
                     <div class="form-group">
                      <label class="bmd-label-floating">{{ __('keywords.Display in Homepage')}}</label></label>
                      <input type="checkbox" name="category_status" value="1" <?php if($category->homecat_status==1){?> checked <?php } ?> ><br>
                    </div>
                    <button type="submit" class="btn btn-success mr-2">{{ __('keywords.Submit')}}</button>
                    <a href="{{route('storehomecate')}}" class="btn btn-light">{{ __('keywords.Close')}}</a>
                  </form>
                </div>
              </div>
            </div>
            
		  </div>
     
          </div>
        </div>
</div>
 @endsection