@extends('store.layout.app')

@section ('content')
<style>
input.form-control.file-upload-info {
    padding: 3px;
    border: 0px;
}
</style>

        <div class="content-wrapper">
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
                
                  <form class="forms-sample" action="{{route('storeInsertHomeCategory')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                    <div class="form-group">
                      <label class="bmd-label-floating" for="exampleInputName1">{{ __('keywords.Home Category')}} {{ __('keywords.Title')}}</label>
                      <input type="text" class="form-control" id="exampleInputName1" name="category_name" requirment>
                    </div>
                    <div class="form-group">
                      <label class="bmd-label-floating">{{ __('keywords.Home Category')}} {{ __('keywords.Order')}}(1 to 10)</label>
                      <input type="text" name="category_order" class="form-control" requirment>
                
                    </div>
                    <div class="form-group">
                      <label class="bmd-label-floating">{{ __('keywords.Display In homepage')}}</label></label>
                      <input type="checkbox" name="category_status" value="1" ><br>
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