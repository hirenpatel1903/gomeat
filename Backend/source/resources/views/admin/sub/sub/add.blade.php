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
                  <h4 class="card-title">{{ __('keywords.Add')}} {{ __('keywords.Sub-Admin')}}</h4>
                  <form class="forms-sample" action="{{route('AddNewSubadmin')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Sub Admin Name')}}</label>
                          <input type="text" name="name" class="form-control" value="{{old('name')}}">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Email')}}</label>
                          <input type="email" name="email" class="form-control" value="{{old('email')}}">
                        </div>
                      </div>
                      
                      

                    </div>
                    
                     <div class="row">
                      <div class="col-md-6">
                        <label class="bmd-label-floating">{{ __('keywords.Image')}}</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="image"/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                      </div>
                       <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Role Name')}}</label>
                            <select name="role_id" class="form-control">
                               <option disabled selected>{{ __('keywords.Select')}} {{ __('keywords.Role Name')}}</option>
                              @foreach($roles as $role) 
                              <option value="{{$role->role_id}}">{{$role->role_name}}</option>
                               @endforeach
                          </select>
                        </div>
                    </div></div>
                      <div class="row">
                     <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Password')}}</label>
                          <input type="text" name="password" class="form-control"  value="{{old('password')}}">
                        </div>
                      </div>
                       
                      </div>

                   
                    
                    <br>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <a href="{{route('subadminlist')}}" class="btn">{{ __('keywords.Close')}}</a>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
@endsection




