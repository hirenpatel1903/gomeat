@extends('store.layout.app')

@section ('content')

 <link href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/switchery/0.8.2/switchery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<style>
/* The container */
.radicont {
  display: block;
  position: relative;
  padding-left: 35px;
  margin-bottom: 12px;
  cursor: pointer;
  font-size: 22px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

/* Hide the browser's default radio button */
.radicont input {
  position: absolute;
  opacity: 0;
  cursor: pointer;
}

/* Create a custom radio button */
.radio {
  position: absolute;
  top: 0;
  left: 0;
  height: 25px;
  width: 25px;
  background-color: #eee;
  border-radius: 50%;
}

/* On mouse-over, add a grey background color */
.radicont:hover input ~ .radio {
  background-color: #ccc;
}

/* When the radio button is checked, add a blue background */
.radicont input:checked ~ .radio {
  background-color: #2196F3;
}

/* Create the indicator (the dot/circle - hidden when not checked) */
.radio:after {
  content: "";
  position: absolute;
  display: none;
}

/* Show the indicator (dot/circle) when checked */
.radicont input:checked ~ .radio:after {
  display: block;
}

/* Style the indicator (dot/circle) */
.radicont .radio:after {
  top: 9px;
  left: 9px;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: white;
}
</style>
@section ('content')
<br>
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
<!-- BEGIN container -->
      <div class="container">
        <!-- BEGIN row -->
        <div class="row justify-content-center">
          <!-- BEGIN col-10 -->
          <div class="col-xl-12">
            <!-- BEGIN row -->
            <div class="row">
              <!-- BEGIN col-9 -->
              <div class="col-xl-9">
                <!-- BEGIN #general -->
                <div id="general" class="mb-5">
                    <div class="card">
                  <form class="forms-sample" action="{{route('storetimeslotupdate')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                <div class="card-body">
                  <form>

                    <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <!--<label class="bmd-label-floating">Valid From</label>-->
                          <p class="card-description">{{ __('keywords.Store Opening Time')}}</p>
                         
                          <input type="time" name="open_hrs" value="{{$city->store_opening_time}}" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <!--<label class="bmd-label-floating">Valid To</label>-->
                          <p class="card-description">{{ __('keywords.Store Closing Time')}}</p>
                          <input type="time" name="close_hrs" value="{{$city->store_closing_time}}" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <!--<label class="bmd-label-floating">Minimum Cart Value</label>-->
                          <p class="card-description">{{ __('keywords.Interval (Minutes)')}}</p>
                          <input type="number" name="interval" value="{{$city->time_interval}}" class="form-control">
                        </div>
                      </div>
                    </div>

                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
                  
                  
                </div>
                <!-- END #general -->
                <hr>
                <!-- BEGIN #notifications -->
                <div id="sms" class="mb-5">
                 <div class="card col-md-12 col-sm-12">
               
                  <form class="forms-sample" action="{{route('updatedel_charge')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                
                <div class="card-body">
                     <div class="row">
                       <div class="col-md-12">
                        <div class="form-group">
                          <label>{{ __('keywords.Free delivery cart value(Min)')}}</label>
                          <input type="text" name="min_cart_value" @if($del_charge) value="{{($del_charge->min_cart_value)}}" @else placeholder="{{ __('keywords.enter minimum cart value')}}" @endif class="form-control">
                        </div>
                      </div>
                    </div>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.UPDATE')}}</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>

                </div>
                <!-- END #notifications -->
                <hr>
              <!-- BEGIN #app_settings -->
                <div id="appsettings" class="mb-5">
                  
                  <div class="card col-md-12 col-sm-12">
              
                  <form class="forms-sample" action="{{route('amountupdate')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                <div class="card-body">
                  <form>

                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
                          <label>{{ __('keywords.Minimum Value')}}</label>
                          
                          <input type="text"name="min_value" @if($minmax) value="{{$minmax->min_value}}" @else placeholder="{{ __('keywords.enter minimum order value')}}" @endif class="form-control">
                        </div>
                      </div>
                      <div class="col-md-6" style=>
                        <div class="form-group">
                          <label>{{ __('keywords.Maximum Value')}}</label>
                          <input type="text" name="max_value" @if($minmax) value="{{$minmax->max_value}}" @else placeholder="{{ __('keywords.enter maximum order value')}}" @endif class="form-control">
                        </div>
                      </div>
                    </div>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.UPDATE')}}</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
                              </div>
                <!-- END App Settings -->
                <hr>
              		<!-- BEGIN #Incentive -->
								<div id="incentive" class="mb-5">
									<div class="card">
                                    <div class="card-header card-header-primary">
                                      <h4 class="card-title">{{ __('keywords.Driver Incentive')}} ({{$currency->currency_sign}})</h4>
                                      <form class="forms-sample" action="{{route('up_store_incentive')}}" method="post" enctype="multipart/form-data">
                                          {{csrf_field()}}
                                    </div>
                                    <div class="card-body">
                                         <div class="row">
                                           <div class="col-md-12">
                                            <div class="form-group">
                                              <label>{{ __('keywords.Driver Incentive')}} {{ __('keywords.Per Order')}}</label>
                                              <input type="number" name="incentive" @if($incentive) value="{{$incentive->incentive}}" @endif  class="form-control">
                                            </div>
                                          </div>
     
                                        </div><br>
                                        <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Update')}}</button>
                                        <div class="clearfix"></div>
                                    </div>
                                      </form>
                                  </div>
								</div>
          
              </div>
              <!-- END col-9-->
              <!-- BEGIN col-3 -->
              <div class="col-xl-3">
                <!-- BEGIN #sidebar-bootstrap -->
                <nav id="sidebar-bootstrap" class="navbar navbar-sticky d-none d-xl-block">
                  <nav class="nav">
                    <a class="nav-link" href="#general" data-toggle="scroll-to">{{ __('keywords.Store Time Slot')}}</a>
                    <a class="nav-link" href="#sms" data-toggle="scroll-to">{{ __('keywords.Delivery Charge Setting')}}</a>
                    <a class="nav-link" href="#appsettings" data-toggle="scroll-to">{{ __('keywords.Order Value')}}</a>
                    	<a class="nav-link" href="#incentive" data-toggle="scroll-to">{{ __('keywords.Driver Incentive')}}({{ __('keywords.Per Order')}})</a>
                  </nav>
                </nav>
                <!-- END #sidebar-bootstrap -->
              </div>
              <!-- END col-3 -->
            </div>
            <!-- END row -->
          </div>
          <!-- END col-10 -->
        </div>
        <!-- END row -->
      </div>
      <!-- END container -->
          

          @endsection



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
                  <h4 class="card-title">Store Time Slot</h4>
                  <form class="forms-sample" action="{{route('storetimeslotupdate')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                  <form>

                    <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <!--<label class="bmd-label-floating">Valid From</label>-->
                          <p class="card-description">Store Opening Time</p>
                         
                          <input type="time" name="open_hrs" value="{{$city->store_opening_time}}" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <!--<label class="bmd-label-floating">Valid To</label>-->
                          <p class="card-description">Store Closing Time</p>
                          <input type="time" name="close_hrs" value="{{$city->store_closing_time}}" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <!--<label class="bmd-label-floating">Minimum Cart Value</label>-->
                          <p class="card-description">Interval (Min)</p>
                          <input type="number" name="interval" value="{{$city->time_interval}}" class="form-control">
                        </div>
                      </div>
                    </div>

                    <button type="submit" class="btn btn-primary pull-center">Submit</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
              
                <div class="card col-md-12 col-sm-12">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">Delivery Charge Setting</h4>
                  <form class="forms-sample" action="{{route('updatedel_charge')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                     <div class="row">
                       <div class="col-md-5">
                        <div class="form-group">
                          <label>Free delivery cart value(Min)</label>
                          <input type="text" name="min_cart_value" @if($del_charge) value="{{($del_charge->min_cart_value)}}" @else placeholder="enter minimum cart value" @endif class="form-control">
                        </div>
                      </div>
                       <div class="col-md-5">
                        <div class="form-group">
                          <label>Delivery Charge</label>
                          <input type="text" name="del_charge"@if($del_charge) value="{{($del_charge->del_charge)}}" @else placeholder="enter delivery charge" @endif class="form-control">
                        </div>
                      </div>
                    </div>
                    <button type="submit" class="btn btn-primary pull-center">UPDATE</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            <div class="card col-md-12 col-sm-12">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">Order Value</h4>
                  <p>Set minimum and maximum cart value</p>
                  <form class="forms-sample" action="{{route('amountupdate')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                  <form>

                    <div class="row">
                      <div class="col-md-5">
                        <div class="form-group">
                          <label>Minimum Value</label>
                          
                          <input type="text"name="min_value" @if($minmax) value="{{$minmax->min_value}}" @else placeholder="enter minimum order value" @endif class="form-control">
                        </div>
                      </div>
                      <div class="col-md-5" style=>
                        <div class="form-group">
                          <label>Maximum Value</label>
                          <input type="text" name="max_value" @if($minmax) value="{{$minmax->max_value}}" @else placeholder="enter maximum order value" @endif class="form-control">
                        </div>
                      </div>
                    </div>
                    <button type="submit" class="btn btn-primary pull-center">UPDATE</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
              
            </div>
			</div>
          </div>
          @endsection