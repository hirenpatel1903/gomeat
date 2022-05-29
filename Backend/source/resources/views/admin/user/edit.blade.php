@extends('admin.layout.app')
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
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
                  <h4 class="card-title">{{ __('keywords.Edit')}} {{ __('keywords.User')}}</h4>
                  <form class="forms-sample" action="{{route('up_user', $user->id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">

                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.City')}}</label>
                     
                            <select id="select1"  class="form-control" name="city">
                            @foreach($city as $c)    
                              <option value="{{$c->city_id}}" @if($user->user_city == $c->city_id) selected @endif>{{$c->city_name}}</option>
                             @endforeach 
                            </select>
                            


                        </div>
                      </div>
                       <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Society')}}</label>
                        <select id="select2" class="form-control" name="society">
                           @foreach($society as $sc)    
                              <option value="{{$sc->society_id}}" city="{{$sc->city_id}}" @if($user->user_area == $sc->society_id) selected @endif>{{$sc->society_name}}</option>
                             @endforeach 
                        </select>
                        </div>
                      </div>
                      
                    </div>

                     <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.User Name')}}</label>
                          <input type="text" value="{{$user->name}}" name="name" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.User Email')}}</label>
                          <input type="text" value="{{$user->email}}" name="email" class="form-control">
                        </div>
                      </div>

                    </div>
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.User phone')}}</label>
                          <input type="text" value="{{$user->user_phone}}" name="phone" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.User Password')}}</label>
                          <input type="password" placeholder="Enter New Password If you want to change" name="password" class="form-control">
                        </div>
                      </div>

                    </div>
                   
                      <div class="row">
                       <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Wallet Balance')}}</label>
                          <input type="text" value="{{$user->wallet}}" name="wallet" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.User Rewards')}}</label>
                          <input type="number" value="{{$user->rewards}}" name="reward" class="form-control">
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
          <script>
              $("#select1").change(function() {
  if ($(this).data('options') === undefined) {
    /*Taking an array of all options-2 and kind of embedding it on the select1*/
    $(this).data('options', $('#select2 option').clone());
  }
  var id = $(this).val();
  var options = $(this).data('options').filter('[city=' + id + ']');
  $('#select2').html(options);
});
          </script>
@endsection




