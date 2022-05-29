@extends('admin.layout.app')


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
                <!-- BEGIN #general -->
                <div id="general" class="mb-5">
                
                         <div class="card">
                                        <div class="card-header card-header-primary">
                                          <h4 class="card-title">{{ __('keywords.App Name')}} | {{ __('keywords.Site Logo')}} | {{ __('keywords.Favicon')}} | {{ __('keywords.Country Code')}}</h4>
                                          <form class="forms-sample" action="{{route('updateappdetails')}}" method="post" enctype="multipart/form-data">
                                              {{csrf_field()}}
                                        </div>
                                        <div class="card-body">
                         
                                             <div class="row">
                                              <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.App Name')}}</label>
                                                  <input type="text"name="app_name" value="{{($logo->name)}}" class="form-control">
                                                </div>
                                              </div>
                                               <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Country Code')}}</label>
                                                  <input type="text"name="country_code" value="{{($cc->country_code)}}" class="form-control">
                                                </div>
                                              </div>
                        
                                            </div>
                                             <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Phone Number Length')}}</label>
                                                  <input type="text"name="number_length" value="{{($logo->number_limit)}}" class="form-control">
                                                </div>
                                              </div>
                                              
                                              <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Last Location in App')}}</label>
                                                  <select name="last_loc" class="form-control">
                                                      <option value="1" @if($logo->last_loc==1) selected @endif>{{ __('keywords.Save')}}</option>
                                                      <option value="0" @if($logo->last_loc==0) selected @endif>{{ __('keywords.Do Not Save')}}</option>
                                                  </select>
                                                </div>
                                              </div>
                                              </div>
                                               
                                            <div class="row">
                                              <div class="col-md-6">
                                               
                                             <img src="{{$url_aws.$logo->icon}}" alt="app logo" class="rounded-circle" style="width:100px; height:100px;">
                                               <div class="custom-file">
                                                  <input type="file" name="app_icon" class="custom-file-input" id="customFile" accept="image/*"/>
                                                  <label class="custom-file-label" for="customFile">{{ __('keywords.Site Logo')}}</label>
                                                </div>
                                              </div>
                        
                        
                                             <div class="col-md-6">
                                             <img src="{{$url_aws.$logo->favicon}}" alt="app logo" class="rounded-circle" style="width:100px; height:100px;">
                                               <div class="custom-file">
                                                  <input type="file" name="favicon" class="custom-file-input" id="customFile" accept="image/*"/>
                                                  <label class="custom-file-label" for="customFile">{{ __('keywords.Favicon')}}</label>
                                                </div>
                                              </div>
                        
                                            </div><br>
                                             <div class="row">
                                              <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Footer Text')}}</label>
                                                  <input type="text" name="footer" value="{{($logo->footer_text)}}" class="form-control">
                                                </div>
                                              </div>
                                              <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Live Chat Between User-Vendor/store')}}</label>
                                                  <select name="live_chat" class="form-control">
                                                      <option value="1" @if($logo->live_chat==1) selected @endif>{{ __('keywords.ON')}}</option>
                                                      <option value="0" @if($logo->live_chat==0) selected @endif>{{ __('keywords.OFF')}}</option>
                                                  </select>
                                                </div>
                                              </div>
                                            </div>
                                            <br>
                                             <div class="form-group row">
                                                <div class="col-sm-10">
                                                  <button type="submit" class="btn btn-primary">{{ __('keywords.Submit')}}</button>
                                                </div>
                                              </div>
                                            <div class="clearfix"></div>
                                          </form>
                                        </div>
                                      </div><hr>
                                    
                                        <div class="card">
                                        <div class="card-header card-header-primary">
                                          <h4 class="card-title">{{ __('keywords.Currency')}}</h4>
                                          <form class="forms-sample" action="{{route('updatecurrency')}}" method="post" enctype="multipart/form-data">
                                              {{csrf_field()}}
                                        </div>
                                        <div class="card-body">
                         
                                             <div class="row">
                                              <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Currency Name')}}</label>
                                                  
                                                  <select class="form-control select2 auto-select" name="currency_name" id="currency_name" required>
                        <option value="USD" @if($currency->currency_name == "USD")selected @endif>{{ __('keywords.U.S. Dollar') }}</option>
                        <option value="INR"@if($currency->currency_name == "INR")selected @endif>{{ __('keywords.Indian Rupee') }}({{ __('keywords.For Razorpay') }})</option>
                        <option value="AUD"@if($currency->currency_name == "AUD")selected @endif>{{ __('keywords.Australian Dollar') }}</option>
                        <option value="BRL"@if($currency->currency_name == "BRL")selected @endif>{{ __('keywords.Brazilian Real') }}</option>
                        <option value="CAD"@if($currency->currency_name == "CAD")selected @endif>{{ __('keywords.Canadian Dollar') }}</option>
                        <option value="CZK"@if($currency->currency_name == "CZK")selected @endif>{{ __('keywords.Czech Koruna') }}</option>
                        <option value="DKK"@if($currency->currency_name == "DKK")selected @endif>{{ __('keywords.Danish Krone') }}</option>
                        <option value="EUR"@if($currency->currency_name == "EUR")selected @endif>{{ __('keywords.Euro') }}</option>
                        <option value="HKD"@if($currency->currency_name == "HKD")selected @endif>{{ __('keywords.Hong Kong Dollar') }}</option>
                        <option value="HUF"@if($currency->currency_name == "HUF")selected @endif>{{ __('keywords.Hungarian Forint') }}</option>
                        
                        <option value="ILS"@if($currency->currency_name == "ILS")selected @endif>{{ __('keywords.Israeli New Sheqel') }}</option>
                        <option value="JPY"@if($currency->currency_name == "JPY")selected @endif>{{ __('keywords.Japanese Yen') }}</option>
                        <option value="MYR"@if($currency->currency_name == "MYR")selected @endif>{{ __('keywords.Malaysian Ringgit') }}</option>
                        <option value="MXN"@if($currency->currency_name == "MXN")selected @endif>{{ __('keywords.Mexican Peso') }}</option>
                        <option value="NOK"@if($currency->currency_name == "NOK")selected @endif>{{ __('keywords.Norwegian Krone') }}</option>
                        <option value="NZD"@if($currency->currency_name == "NZD")selected @endif>{{ __('keywords.New Zealand Dollar') }}</option>
                        <option value="PHP"@if($currency->currency_name == "PHP")selected @endif>{{ __('keywords.Philippine Peso') }}</option>
                        <option value="PLN"@if($currency->currency_name == "PLN")selected @endif>{{ __('keywords.Polish Zloty') }}</option>
                        <option value="GBP"@if($currency->currency_name == "GBP")selected @endif>{{ __('keywords.Pound Sterling') }}</option>
                        <option value="SGD"@if($currency->currency_name == "SGD")selected @endif>{{ __('keywords.Singapore Dollar') }}</option>
                        <option value="SEK"@if($currency->currency_name == "SEK")selected @endif>{{ __('keywords.Swedish Krona') }}</option>
                        <option value="CHF"@if($currency->currency_name == "CHF")selected @endif>{{ __('keywords.Swiss Franc') }}</option>
                        <option value="TWD"@if($currency->currency_name == "TWD")selected @endif>{{ __('keywords.Taiwan New Dollar') }}</option>
                        <option value="THB"@if($currency->currency_name == "THB")selected @endif>{{ __('keywords.Thai Baht') }}</option>
                        <option value="TRY"@if($currency->currency_name == "TRY")selected @endif>{{ __('keywords.Turkish Lira') }}</option>
                      
                        <option value="GHS" @if($currency->currency_name == "GHS")selected @endif>{{ __('keywords.Ghana') }}  ({{ __('keywords.For Paystack') }})</option>
                        <option value="NGN" @if($currency->currency_name == "NGN")selected @endif>{{ __('keywords.Nigeria') }}({{ __('keywords.For Paystack') }})</option>
                        <option value="ZAR" @if($currency->currency_name == "ZAR")selected @endif>{{ __('keywords.South Africa') }}({{ __('keywords.For Paystack') }})</option>
                      </select>
                                                  
                                                </div>
                                              </div>
                                               <div class="col-md-6">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Currency Sign')}}</label>
                                                  <input type="text" name="currency_sign" value="{{($currency->currency_sign)}}" class="form-control">
                                                </div>
                                              </div>
                        
                                            </div>
                                              <div class="form-group row">
                                                <div class="col-sm-10">
                                                  <button type="submit" class="btn btn-primary">{{ __('keywords.SUBMIT')}}</button>
                                                </div>
                                              </div>
                                            <div class="clearfix"></div>
                                          </form>
                                        </div>
                                      </div><hr>
                                    
                                        <div class="card">
                                        <div class="card-header card-header-primary">
                                          <h4 class="card-title">{{ __('keywords.Referral Points')}}</h4>
                                          <form class="forms-sample" action="{{route('updateref')}}" method="post" enctype="multipart/form-data">
                                              {{csrf_field()}}
                                        </div>
                                         @php
                                        $offer = json_decode($referral->points);
                                      @endphp
                                        <div class="card-body">
                                  
                                             <div class="row">
                                              <div class="form-group col-12">
                                              <label for="scratch_card_name">{{ __('keywords.Referral For')}} :</label>
                                              <input type="text" class="form-control" id="name" name="name" @if($referral) value="{{$referral->name}}" @endif readonly>
                                            </div>
                                              <div class="col-6" >
                                                <div class="form-group">
                                                  <label for="min_amount">{{ __('keywords.min amount')}} :</label>
                                                  <input type="text" class="form-control" id="min_amount" name="min_amount" placeholder="min amount" @if($referral) value="{{$offer->min}}" @endif required>
                                                </div>
                                              </div>
                                                  <div class="col-6" >

                                                <div class="form-group">
                                                  <label for="max_amount">{{ __('keywords.max amount')}} :</label>
                                                  <input type="text" class="form-control" id="max_amount" name="max_amount" placeholder="max amount" @if($referral) value="{{$offer->max}}"@endif required>
                                                </div>
                                              </div>

                        
                                            </div>
                                              <div class="form-group row">
                                                <div class="col-sm-10">
                                                  <button type="submit" class="btn btn-primary">{{ __('keywords.SUBMIT')}}</button>
                                                </div>
                                              </div>
                                            <div class="clearfix"></div>
                                          </form>
                                        </div>
                                      </div>
                
                
                       @if(count($usernull)>0 && count($usernull1)>0)

                           <div class="card">
                                    <div class="card-header card-header-primary">
                                      <h4 class="card-title">{{ __('keywords.Generate Referral Codes')}}</h4>
                                    
                                        <a href={{route('updatereferral_codes')}} class="btn btn-primary pull-center">{{ __('keywords.Generate Referral Codes')}}</a>
                                     </div>
                            </div>
                      @endif
                  
                </div>
                <!-- END #general -->
                <hr><br>
                <!-- BEGIN #notifications -->
                <div id="sms" class="mb-5">
                  <div class="card">
                      <div class="card-header card-header-primary">
                                          <h4 class="card-title">{{ __('keywords.SMS from')}}</h4>
                                        </div>
                    <div class="list-group list-group-flush">
                      <div class="list-group-item d-flex align-items-center">
                        <div class="flex-fill">
                          <div>{{ __('keywords.SMS Gateway')}}</div>
                          <div class="text-gray-700 d-flex align-items-center">
                            <i class="fa fa-circle fs-8px fa-fw text-success mr-1"></i> @if($smsby->status == 0 && $smsby->twilio == 0 && $smsby->msg91 == 0) {{ __('keywords.OTP/SMS OFF')}} &nbsp;<span style="height: 12px;width: 12px;background-color: red;border-radius: 50%;display: inline-block;" class="dot"></span> @endif
                                                          @if($smsby->status == 1 && $smsby->twilio == 1 && $smsby->msg91 == 0)  {{ __('keywords.Twilio is On')}} &nbsp;<span style="height: 12px;width: 12px;background-color: green;border-radius: 50%;display: inline-block;" class="dot"></span> @endif 
                                                          @if($smsby->status == 1 && $smsby->twilio == 0 && $smsby->msg91 == 1)  {{ __('keywords.Msg91 is On')}} &nbsp;<span style="height: 12px;width: 12px;background-color: green;border-radius: 50%;display: inline-block;" class="dot"></span> @endif
                          </div>
                        </div>
                        <div>
                          <a href="#modalEditsms" data-toggle="modal" class="btn btn-default width-100">{{ __('keywords.Edit')}}</a>
                        </div>
                      </div>
                    <hr>
                      
                                             <div class="card">
                                            <div class="card-header card-header-primary">
                                              <h4 class="card-title">{{ __('keywords.Firebase for OTP')}}</h4>
                                            </div>
                                            <div class="card-body">
                             
                                                 <div class="row">
                                                 <div class="col-md-12">
                                                <label>{{ __('keywords.Firebase for OTP')}} : &nbsp;</label> 
                                                <div class="custom-control custom-switch">
                                                  <input type="checkbox" class="custom-control-input customSwitch1" id="customSwitch1" name="status" {{ $firebase->status == 1 ? 'checked' : '' }}>
                                                  <label class="custom-control-label" for="customSwitch1">{{ __('keywords.Toggle this switch element on for Firebase for OTP')}}</label>
                                                </div>
                                               
                                                </div>
                                              </div><br><br>
                                              <form class="forms-sample" action="{{route('updatefirebase_iso')}}" method="post" enctype="multipart/form-data">
                                               {{csrf_field()}}      
                                               @if($fb_iso)
                                                <div class="row">
                                                  <div class="col-md-12">
                                                    <div class="form-group">
                                                       <label for="bmd-label-floating">{{ __('keywords.Firebase ISO(used for firebase otp)')}}</label>
                                                    <input type="text" id="iso_code" class="form-control" value="{{$fb_iso->iso_code}}" name="iso_code">
                                                    </div>
                                                  </div>
                                                </div>
                                                @else
                                                <div class="row">
                                                  <div class="col-md-12">
                                                    <div class="form-group">
                                                     <label for="bmd-label-floating">{{ __('keywords.Firebase ISO(used for firebase otp)')}}</label>
                                                    <input type="text" id="iso_code" class="form-control" placeholder="Firebase ISO code" name="iso_code" required>
                                                    </div>
                                                  </div>
                                                </div>
                                                @endif
                                                <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.UPDATE')}}</button>
                                                <div class="clearfix"></div>
                                                </form>
                                            </div>
                                          </div>
                    </div>
                  </div>
                </div>
                <!-- END #notifications -->
                  <hr><br>
              <!-- BEGIN #app_settings -->
                <div id="appsettings" class="mb-5">
                  <div class="col-md-12">
                                      <div class="card">
                                        <div class="card-header card-header-primary">
                                          <h4 class="card-title">{{ __('keywords.FCM Server Key')}}</h4>
                                          <form class="forms-sample" action="{{route('updatefcm')}}" method="post" enctype="multipart/form-data">
                                              {{csrf_field()}}
                                        </div>
                                        <div class="card-body">
                                             <div class="row">
                                               <div class="col-md-12">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.User App FCM Server Key')}}</label>
                                                  <input type="text" name="fcm" value="{{($fcm->server_key)}}" class="form-control">
                                                </div>
                                              </div>
                        
                                            </div>
                                            <div class="row">
                                               <div class="col-md-12">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Vendor/Store App FCM Server Key')}}</label>
                                                  <input type="text" name="fcm2" value="{{($fcm->store_server_key)}}" class="form-control">
                                                </div>
                                              </div>
                        
                                            </div>
                                            <div class="row">
                                               <div class="col-md-12">
                                                <div class="form-group">
                                                  <label class="bmd-label-floating">{{ __('keywords.Driver App FCM Server Key')}}</label>
                                                  <input type="text" name="fcm3" value="{{($fcm->driver_server_key)}}" class="form-control">
                                                </div>
                                              </div>
                        
                                            </div>
                                            <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.UPDATE')}}</button>
                                            <div class="clearfix"></div>
                                          </form>
                                        </div>
                                      </div>
                                     </div> 
                              </div>
                <!-- END App Settings -->
                  <hr><br>
                <!-- BEGIN #payment -->
                <div id="payment" class="mb-5">
           <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Payment Gateways')}}</h4>
                </div>
            <div class="card-body">
                
                
              <h5 class="header-title">{{ __('keywords.Choose One') }} {{ __('keywords.Payment Gateways') }}</h5>
                <div class="params-panel border border-dark p-3">
                  <div class="row">
                    <div class="col-md-12">
                     
               <form method="post" class="appsvan-submit params-panel" autocomplete="off" action="{{route('gateway_status')}}" enctype="multipart/form-data">
                {{ csrf_field() }}   
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Choose One') }}</label>           
                      <select class="form-control" name="gateway" required>
                         <option value="razorpay" {{ get_option('razorpay_active') == 'Yes' ? 'selected' : '' }}>{{ __('keywords.Razorpay') }}</option>
                         <option value="stripe" {{ get_option('stripe_active') == 'Yes' ? 'selected' : '' }}>{{ __('keywords.Stripe') }}</option>
                         <option value="paystack" {{ get_option('paystack_active') == 'Yes' ? 'selected' : '' }}>{{ __('keywords.Paystack') }}</option>
                      </select>
                      </div>
                      <br>
                        <div class="row">
                          <div class="col-md-12">
                            <div class="form-group">
                            <button type="submit" class="btn btn-primary">{{ __('keywords.Update') }}</button>
                            </div>
                          </div>              
                        </div> 
                      </form>
                    </div>

                    
                  </div>
                </div>
                
                <br>
             

               <form method="post" class="appsvan-submit params-panel" autocomplete="off" action="{{route('updategateway')}}" enctype="multipart/form-data">
                {{ csrf_field() }}
                
                <h5 class="header-title">{{ __('keywords.Stripe') }}</h5>
                <div class="params-panel border border-dark p-3">
                  <div class="row">
                    <div class="col-md-3">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Stripe Active') }}</label>           
                      <select class="form-control" disabled>
                         <option value="Yes"  {{ get_option('stripe_active') == 'Yes' ? 'selected' : '' }}>{{ __('keywords.Yes') }}</option>
                         <option value="No"  {{ get_option('stripe_active') == 'No' ? 'selected' : '' }}>{{ __('keywords.No') }}</option>
                      </select>
                      </div>
                    </div>
                    
                    <div class="col-md-3">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Secret Key') }}</label>            
                      <input type="text" class="form-control" name="stripe_secret_key" value="{{ get_option('stripe_secret_key') }}">
                      </div>
                    </div>
                    
                    <div class="col-md-3">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Publishable Key') }}</label>           
                      <input type="text" class="form-control" name="stripe_publishable_key" value="{{ get_option('stripe_publishable_key') }}">
                      </div>
                    </div>
                      <div class="col-md-3">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Merchant_id') }}</label>           
                      <input type="text" class="form-control" name="stripe_merchant_id" value="{{ get_option('stripe_merchant_id') }}">
                      </div>
                    </div>
                  </div>
                </div>

                <br>
                <h5 class="header-title">{{ __('keywords.Razorpay') }}</h5>
                <div class="params-panel border border-dark p-3">
                  <div class="row">
                    <div class="col-md-4">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Razorpay Active') }}</label>           
                      <select class="form-control" disabled>
                         <option value="No"  {{ get_option('razorpay_active') == 'Yes' ? 'selected' : '' }}>{{ __('keywords.Yes') }}</option>
                         <option value="Yes"  {{ get_option('razorpay_active') == 'No' ? 'selected' : '' }}>{{ __('keywords.No') }}</option>
                      </select>
                      </div>
                    </div>

                    <div class="col-md-4">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Razorpay Key') }}</label>            
                      <input type="text" class="form-control" name="razorpay_key_id" value="{{ get_option('razorpay_key_id') }}">
                      </div>
                    </div>
                    
                    <div class="col-md-4">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Razorpayn Secret') }}</label>            
                      <input type="text" class="form-control" name="razorpay_secret_key" value="{{ get_option('razorpay_secret_key') }}">
                      </div>
                    </div>

                  </div>
                </div>


                <br>
                <h5 class="header-title">{{ __('keywords.Paystack') }}</h5>
                <div class="params-panel border border-dark p-3">
                  <div class="row">
                    <div class="col-md-4">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Paystack Active') }}</label>           
                      <select class="form-control"  disabled>
                         <option value="No"  {{ get_option('paystack_active') == 'Yes' ? 'selected' : '' }}>{{ __('keywords.Yes') }}</option>
                         <option value="Yes"  {{ get_option('paystack_active') == 'No' ? 'selected' : '' }}>{{ __('keywords.No') }}</option>
                      </select>
                      </div>
                    </div>

                    <div class="col-md-4">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Paystack Public Key') }}</label>           
                      <input type="text" class="form-control" name="paystack_public_key" value="{{ get_option('paystack_public_key') }}">
                      </div>
                    </div>
                    
                    <div class="col-md-4">
                      <div class="form-group">
                      <label class="control-label">{{ __('keywords.Paystack Secret Key') }}</label>           
                      <input type="text" class="form-control" name="paystack_secret_key" value="{{ get_option('paystack_secret_key') }}">
                      </div>
                    </div>

                  </div>
                </div>

                <br>
                <div class="row">
                  <div class="col-md-12">
                    <div class="form-group">
                    <button type="submit" class="btn btn-primary">{{ __('keywords.Update') }}</button>
                    </div>
                  </div>              
                </div>              
              </form>
            </div>
           </div>
          </div>
                <hr><br>
                
                  <!-- BEGIN #map -->
                <div id="map" class="mb-5">
                 
                  <div class="card">
                    <div class="list-group list-group-flush">
                      <div class="list-group-item d-flex align-items-center">
                        <div class="flex-fill">
                          <div>{{ __('keywords.Map Gateway')}}</div>
                          <div class="text-gray-700 d-flex align-items-center">
                            <i class="fa fa-map fs-8px fa-fw text-success mr-1"></i>
                                                      @if($mset->mapbox == 1) {{ __('keywords.Mapbox ON')}} &nbsp;<span style="height: 12px;width: 12px;background-color: red;border-radius: 50%;display: inline-block;" class="dot"></span> @endif
                                                      @if($mset->google_map == 1) {{ __('keywords.Google map On')}} &nbsp;<span style="height: 12px;width: 12px;background-color: green;border-radius: 50%;display: inline-block;" class="dot"></span> @endif 
                          </div>
                        </div>
                        <div>
                          <a href="#modalEditmap" data-toggle="modal" class="btn btn-default width-100">{{ __('keywords.Edit')}}</a>
                        </div>
                      </div>
                                      
                    </div>
                  </div>
                </div>
                <!-- END #notifications -->
                  <hr><br>
              <!-- BEGIN #Incentive -->
                <div id="incentive" class="mb-5">
                  <div class="card">
                                    <div class="card-header card-header-primary">
                                      <h4 class="card-title">{{ __('keywords.Driver Incentive')}} ({{$currency->currency_sign}})</h4>
                                      <form class="forms-sample" action="{{route('up_admin_incentive')}}" method="post" enctype="multipart/form-data">
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
                  <hr><br>
             
                  <!-- BEGIN #app link -->
                <div id="applink" class="mb-5">
                  <div class="card">
                                    <div class="card-header card-header-primary">
                                      <h4 class="card-title">{{ __('keywords.App Link')}}</h4>
                                      <form class="forms-sample" action="{{route('app_link')}}" method="post" enctype="multipart/form-data">
                                          {{csrf_field()}}
                                    </div>
                                    <div class="card-body">
                                         <div class="row">
                                           
                                           <div class="col-md-12">
                                            <div class="form-group">
                                              <label>{{ __('keywords.Android')}} {{ __('keywords.App Link')}}</label>
                                              <textarea name="an_link" class="form-control">@if($app_link) {{$app_link->android_app_link}} @endif</textarea>
                                            </div>
                                          </div>
                                          <div class="col-md-12">
                                            <div class="form-group">
                                              <label>{{ __('keywords.IOS')}} {{ __('keywords.App Link')}}</label>
                                              <textarea name="ios_link" class="form-control">@if($app_link) {{$app_link->ios_app_link}} @endif</textarea>
                                            </div>
                                          </div>
                                        </div><br>
                                        <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Update')}}</button>
                                        <div class="clearfix"></div>
                                    </div>
                                      </form>
                                  </div>
                </div>
                <!-- END #system -->

            <hr><br>
                  <!-- BEGIN #app link -->
                <div id="otherspace" class="mb-5">
                  <div class="card">
                                    <div class="card-header card-header-primary">
                                      <h4 class="card-title">{{ __('keywords.Images Space')}}</h4>
                                      <form class="forms-sample" action="{{route('updatespace')}}" method="post" enctype="multipart/form-data">
                                          {{csrf_field()}}
                                    </div>
                                    <div class="card-body">
                                         <div class="row">
                                           
                                           <div class="col-md-12">
                                            <div class="form-group">
                                             <select name="status" class="form-control">
                                            @if($space)
                                              <option value="do" @if($space->digital_ocean==1) selected @endif>{{ __('keywords.Digital Ocean')}}</option>
                                                <option value="aws" @if($space->aws==1) selected @endif>{{ __('keywords.AWS')}}</option>
                                                
                                                <option value="ss" @if($space->same_server==1) selected @endif>{{ __('keywords.Same Server')}}</option>
                                              @else  
                                               <option value="do">{{ __('keywords.Digital Ocean')}}</option>
                                                <option value="aws">{{ __('keywords.Aws')}}</option>
                                                 <option value="ss">{{ __('keywords.Same Server')}}</option>
                                               @endif 
                                             </select>
                                            </div>
                                          </div>
                                         
                                        </div><br>
                                        <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Update')}}</button>
                                        <div class="clearfix"></div>
                                    </div>
                                      </form>
                                  </div>
                </div>
                <!-- END #system -->
                    <!-- BEGIN #notice -->
                <div id="notice" class="mb-5">
                  <div class="card">
                                    <div class="card-header card-header-primary">
                                      <h4 class="card-title">{{ __('keywords.App Notice')}}</h4>
                                      <form class="forms-sample" action="{{route('app_noticeupdate')}}" method="post" enctype="multipart/form-data">
                                          {{csrf_field()}}
                                    </div>
                                    <div class="card-body">
                                         <div class="row">
                                           
                                          <div class="col-md-12">
                                            <div class="form-group">
                                                <div class="col-md-4" style="float:left">
                                               <input type="radio" id="male" name="status" value="1" @if($notice->status == 1) checked @endif>
                                                  <label for="On">{{ __('keywords.Active')}}</label>
                                                  </div>
                                                  <div class="col-md-4" style="float:left">
                                                  <input type="radio" id="female" name="status" value="0" @if($notice->status == 0) checked @endif>
                                                  <label for="Off">{{ __('keywords.Inactive')}}</label><br>
                                                  </div> 
                                             
                                            </div>
                                          </div><br><br>
                                           <div class="col-md-12">
                                            <div class="form-group">
                                              <label>Notice</label>
                                              <textarea name="notice" minlength="20" class="form-control">@if($notice) {{$notice->notice}} @endif</textarea>
                                            </div>
                                          </div>

                                        </div><br>
                                        <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Update Notice')}}</button>
                                        <div class="clearfix"></div>
                                    </div>
                                      </form>
                                  </div>
                </div>
                <!-- END #system -->
              </div>
              <!-- END col-9-->
              <!-- BEGIN col-3 -->
              <div class="col-xl-3">
                <!-- BEGIN #sidebar-bootstrap -->
                <nav id="sidebar-bootstrap" class="navbar navbar-sticky d-none d-xl-block">
                  <nav class="nav">
                    <a class="nav-link" href="#general" data-toggle="scroll-to">{{ __('keywords.Global Settings')}}</a>
                    <a class="nav-link" href="#sms" data-toggle="scroll-to">{{ __('keywords.SMS/OTP Settings')}}</a>
                    <a class="nav-link" href="#appsettings" data-toggle="scroll-to">{{ __('keywords.FCM Keys')}}</a>
                    <a class="nav-link" href="#payment" data-toggle="scroll-to">{{ __('keywords.Payment Mode')}}</a>
                    <a class="nav-link" href="#map" data-toggle="scroll-to">{{ __('keywords.MAP Settings')}}</a>
                    <a class="nav-link" href="#incentive" data-toggle="scroll-to">{{ __('keywords.Driver Incentive')}}({{ __('keywords.Per Order')}})</a>
                    <a class="nav-link" href="#applink" data-toggle="scroll-to">{{ __('keywords.App Link')}}</a>
                    <a class="nav-link" href="#otherspace" data-toggle="scroll-to">{{ __('keywords.Images Store')}}</a>
                     <a class="nav-link" href="#notice" data-toggle="scroll-to">{{ __('keywords.App Notice')}}</a>
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
          
          
     
          
            <!-- BEGIN #modalEditsms -->
    <div class="modal fade" id="modalEditsms">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">{{ __('keywords.Edit')}} {{ __('keywords.SMS Gateway')}}</h5>
            <button type="button" class="close" data-dismiss="modal">
              <span>×</span>
            </button>
          </div>
          <div class="modal-body">
             <div class="form-group"> 
                         <div> 
                         <div class="col-md-4" style="float:left">
                                <label class="radicont"> 
                                    <input type="radio" name="colorRadio" 
                                           value="msg91" class="radio" @if($smsby->status == 1 && $smsby->twilio == 0 && $smsby->msg91 == 1) checked @endif> <span class="radio"></span>Msg91</label>
                            </div> 
                            <div class="col-md-4" style="float:left">
                                <label class="radicont"> 
                                    <input type="radio" name="colorRadio" 
                                           value="twilio" class="radio" @if($smsby->status == 1 && $smsby->twilio == 1 && $smsby->msg91 == 0) checked @endif> <span class="radio"></span> Twilio </label> 
                                  </div> 
                            <div class="col-md-4" style="float:left">      
                                <label class="radicont"> 
                                    <input type="radio" name="colorRadio" 
                                           value="msgoff" class="radio" @if($smsby->status == 0 && $smsby->twilio == 0 && $smsby->msg91 == 0) checked @endif> <span class="radio"></span> {{ __('keywords.Off')}} </label> 
                                </div>            
                            </div> 
                         <br><br> <hr>   
                           <div id="dvPassport" style="display: none" class="msg91 selectt">
                       
                                  <form class="forms-sample" action="{{route('updatemsg91')}}" method="post" enctype="multipart/form-data">
                                      {{csrf_field()}}
                                <div class="card-body">
                                     @if($msg91)
                                     <div class="row">
                                      <div class="col-md-6">
                                        <div class="form-group">
                                          <label class="bmd-label-floating">{{ __('keywords.Sender ID')}}</label>
                                          <input type="text" name="sender_id" value="{{($msg91->sender_id)}}" class="form-control">
                                        </div>
                                      </div>
                                       <div class="col-md-6">
                                        <div class="form-group">
                                          <label class="bmd-label-floating">{{ __('keywords.Msg91 API Key')}}</label>
                                          <input type="text" name="api" value="{{($msg91->api_key)}}" class="form-control">
                                        </div>
                                      </div>
                
                                    </div>
                                    @else
                                     <div class="row">
                                      <div class="col-md-6">
                                        <div class="form-group">
                                          <label class="bmd-label-floating">{{ __('keywords.Sender ID')}}</label>
                                          <input type="text" name="sender_id" placeholder="Insert Sender Id Of Six Letters Only" class="form-control" required>
                                        </div>
                                      </div>
                                       <div class="col-md-6">
                                        <div class="form-group">
                                          <label class="bmd-label-floating">{{ __('keywords.Msg91 API Key')}}</label>
                                          <input type="text" name="api" placeholder="Msg91 API Key" class="form-control" required>
                                        </div>
                                      </div>
                
                                    </div>
                                    @endif
                                     <div class="modal-footer">
                                     <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Msg91 ON')}}</button>
                                     <button type="button" class="btn btn-default" data-dismiss="modal">{{ __('keywords.Close')}}</button>
                                    <div class="clearfix"></div>
                                    </div>
                                  </form>
                              </div>              
                            </div>
                             
                        <div id="dv2Passport" style="display: none" class="twilio selectt">
                           <form class="forms-sample" action="{{route('updatetwilio')}}" method="post" enctype="multipart/form-data">
                              {{csrf_field()}}      
                                   @if($twilio)
                                    <div class="row">
                                      <div class="col-md-4">
                                        <div class="form-group">
                                           <label for="bmd-label-floating">Twilio SID</label>
                                        <input type="text" id="sid" class="form-control" value="{{$twilio->twilio_sid}}" name="sid">
                                        </div>
                                      </div>
                                       <div class="col-md-4">
                                        <div class="form-group">
                                          <label for="bmd-label-floating">Twilio Token</label>
                                        <input type="text" id="token" class="form-control" value="{{$twilio->twilio_token}}" name="token">
                                        </div>
                                      </div>
                                      <div class="col-md-4">
                                        <div class="form-group">
                                         <label for="bmd-label-floating">Twilio Phone</label>
                                        <input type="text" id="phone" class="form-control" value="{{$twilio->twilio_phone}}" name="phone">
                                        </div>
                                      </div>
                                    </div>
                                    @else
                                    <div class="row">
                                      <div class="col-md-4">
                                        <div class="form-group">
                                         <label for="bmd-label-floating">Twilio SID</label>
                                        <input type="text" id="sid" class="form-control" placeholder="Twilio SID" name="sid" required>
                                        </div>
                                      </div>
                                       <div class="col-md-4">
                                        <div class="form-group">
                                          <label for="bmd-label-floating">Twilio Token')}}</label>
                                        <input type="text" id="token" class="form-control" placeholder="Twilio Token" name="token" required>
                                        </div>
                                      </div>
                                      <div class="col-md-4">
                                        <div class="form-group">
                                         <label for="bmd-label-floating">Twilio Phone</label>
                                        <input type="text" id="phone" class="form-control" placeholder="Twilio Phone" name="phone" required>
                                        </div>
                                      </div>
                                    </div>
                                    @endif
                                    <div class="modal-footer">
                                     <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Twilio ON')}}</button>
                                     <button type="button" class="btn btn-default" data-dismiss="modal">{{ __('keywords.Close')}}</button>
                                    <div class="clearfix"></div>
                                    </div>
                                    </form>
                              </div> 
                          
                            <div id="dv3Passport" style="display: none" class="msgoff selectt">
                             <form class="forms-sample" action="{{route('msgoff')}}" method="post" enctype="multipart/form-data">
                              {{csrf_field()}} 
                              <div class="modal-footer">
                             <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Otp/SMS OFF')}}</button>
                             <button type="button" class="btn btn-default" data-dismiss="modal">{{ __('keywords.Close')}}</button>
                            <div class="clearfix"></div>
                            </div>
                            </form>
                             </div> 
                    
                    
                        </div>

          </div>
        </div>
      </div>
    </div>
    <!-- END #modalEdit -->

    <script>
    let elems = Array.prototype.slice.call(document.querySelectorAll('.customSwitch1'));

    elems.forEach(function(html) {
    let switchery = new Switchery(html,  { size: 'small' });
    });
    </script>
<script>
    $(document).ready(function(){
    $('.customSwitch1').change(function () {
        let status = $(this).prop('checked') === true ? 1 : 0;
        $.ajax({
            type: "GET",
            dataType: "json",
            url: '{{ route("updatefirebase") }}',
            data: {'status': status},
            success: function (data) {
                console.log(data.message);
            }
        });
    });
});
</script> 
          
          
 <script type="text/javascript"> 
    $(document).ready(function() { 
        $('input[type="radio"]').click(function() { 
            var inputValue = $(this).attr("value"); 
            var targetBox = $("." + inputValue); 
            $(".selectt").not(targetBox).hide(); 
            $(targetBox).show(); 
        }); 
    }); 
 </script> 
 
<script type="text/javascript">
  var value = {{$smsby->twilio}};
  var status = {{$smsby->status}};
  if(value=='1' && status == '1')
  {
    $('#dv2Passport').show();
  }
  else
  {
    $('#dv2Passport').hide();
  }
  
</script>
<script type="text/javascript">
  var value = {{$smsby->msg91}};
  var status = {{$smsby->status}};
  if(value=='1' && status == '1')
  {
    $('#dvPassport').show();
  }
  else
  {
    $('#dvPassport').hide();
  }
  
</script>

<script type="text/javascript">
  var value = {{$smsby->msg91}};
  var twilio = {{$smsby->twilio}};
  var status = {{$smsby->status}};
  if(value=='0' && status == '0' && twilio == '0')
  {
    $('#dv3Passport').show();
  }
  else
  {
    $('#dv3Passport').hide();
  }
  
</script>




   
            <!-- BEGIN #modalEditmap -->
    <div class="modal fade" id="modalEditmap">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">Edit Map Settings</h5>
            <button type="button" class="close" data-dismiss="modal">
              <span>×</span>
            </button>
          </div>
          <div class="modal-body">
                 <div class="form-group">    
                  <div class="col-md-6" style="float:left">
                        <label class="radicont"> 
                            <input type="radio" name="colorRadio" 
                                   value="mapbox" class="radio" @if($mset->mapbox == 1) checked @endif><span class="radio"></span>Mapbox</label>
                    </div> 
                    <div class="col-md-6" align="center" style="float:left">
                        <label class="radicont"> 
                            <input type="radio" name="colorRadio" 
                                   value="google_map" class="radio" @if($mset->google_map == 1) checked @endif><span class="radio"></span> Google Map </label> 
                          </div> 
                    </div><br><br><hr>      
            
                 <div class="col-md-12" style="float:left">
                       <div id="dv5Passport" style="display: none" class="mapbox selectt">
                   
                              <form class="forms-sample" action="{{route('updatemapbox')}}" method="post" enctype="multipart/form-data">
                                  {{csrf_field()}}
                            <div class="card-body">
                                 @if($m)
                                 <div class="row">
                                  
                                   <div class="col-md-12">
                                    <div class="form-group">
                                      <label class="bmd-label-floating">Mapbox API Key</label>
                                      <input type="text" name="mapbox" value="{{($m->mapbox_api)}}" class="form-control">
                                    </div>
                                  </div>
            
                                </div>
                                @else
                                 <div class="row">
                                    <div class="col-md-12">
                                    <div class="form-group">
                                      <label class="bmd-label-floating">Mapbox API Key</label>
                                      <input type="text" name="mapbox" placeholder="mapbox api key" class="form-control">
                                    </div>
                                  </div>
            
            
                                </div>
                                @endif
                               <div class="modal-footer">
                             <button type="submit" class="btn btn-primary pull-center">Mapbox On</button>
                             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <div class="clearfix"></div>
                            </div>
                              </form>
                          </div>              
                        </div>
                         
                    <div id="dv6Passport" style="display: none" class="google_map selectt">
                       <form class="forms-sample" action="{{route('updatemap')}}" method="post" enctype="multipart/form-data">
                          {{csrf_field()}}      
                               @if($g)
                                <div class="row">
                                  <div class="col-md-12">
                                    <div class="form-group">
                                       <label for="bmd-label-floating">Google map</label>
                                    <input type="text" id="api" class="form-control" value="{{($g->map_api_key)}}" name="api">
                                    </div>
                                  </div>
                                </div>
                                @else
                                <div class="row">
                                 <div class="form-group">
                                       <label for="bmd-label-floating">Google map</label>
                                    <input type="text" id="api" class="form-control" placeholder="map api key" name="api">
                                    </div>
                                </div>
                                @endif
                                <div class="modal-footer">
                             <button type="submit" class="btn btn-primary pull-center">Google Map ON</button>
                             <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                            <div class="clearfix"></div>
                            </div>
                                </form>
                          </div> 
                      
                          </div>

          </div>
        </div>
      </div>
    </div>
    <!-- END #modalEdit -->


<script type="text/javascript">
  var value = {{$mset->mapbox}};
  if(value=='1')
  {
    $('#dv5Passport').show();
  }
  else
  {
    $('#dv5Passport').hide();
  }
  
</script>
<script type="text/javascript">
  var value = {{$mset->google_map}};
  if(value=='1')
  {
    $('#dv6Passport').show();
  }
  else
  {
    $('#dv6Passport').hide();
  }
  
</script>
        
@endsection




