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
                  <h4 class="card-title">{{ __('keywords.Add')}} {{ __('keywords.Membership')}}</h4>
                  <form class="forms-sample" action="{{route('AddNewMember')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">

                   

                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Plan Name')}}</label>
                          <input type="text" name="plan_name" class="form-control" value="{{old('plan_name')}}">
                        </div>
                      </div>
                         <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Plan Days')}}</label>
                          <input type="number" name="days" class="form-control" value="{{old('days')}}">
                        </div>
                      </div>
                    </div>
                    
                     <div class="row">
                         <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Plan Price')}}</label>
                          <input type="number" name="price" class="form-control" value="{{old('price')}}">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Reward Point')}} ({{ __('keywords.like 2 for 2x ,3 for 3x etc')}})</label>
                          <input type="number" name="reward" class="form-control" value="{{old('reward')}}">
                        </div>
                      </div>

                    </div>
                     
                     <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Free Delivery')}}</label>
                          <select name="free_delivery" class="form-control">
                              <option value="1">{{ __('keywords.Yes')}}</option>
                              <option value="0">{{ __('keywords.No')}}</option>
                          </select>
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Instant Delivery')}}</label>
                          <select name="instant_delivery" class="form-control">
                              <option value="1">{{ __('keywords.Yes')}}</option>
                              <option value="0">{{ __('keywords.No')}}</option>
                          </select>
                        </div>
                      </div>

                    </div>
                       <div class="row">
                      <div class="col-md-12">
                         
                        <label class="bmd-label-floating">{{ __('keywords.Image')}} <b>({{ __('keywords.It Should Be Less Then 1000 KB')}})</b></label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="image" accept="image/*" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>

                       
                      </div>
                      </div>
                      <div class="row">
                      <div class="col-md-12">
                        <div class="form">
                          <label class="bmd-label-floating">{{ __('keywords.Description')}}</label>
                          <textarea name="description" id="summary-ckeditor" class="form-control">{{old('description')}}</textarea>
                         
                          <script src="{{ url('assets/ckeditor/ckeditor.js') }}"></script>
                          <script>
                              CKEDITOR.replace( 'summary-ckeditor' );
                          </script>
                        </div>
                      </div>

                    </div>
                    <br>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <a href="{{route('memlist')}}" class="btn">{{ __('keywords.Close')}}</a>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
@endsection




