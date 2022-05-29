@extends('store.layout.app')
@section ('content')
<div class="row">

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
                  <h4 class="card-title">{{ __('keywords.Send Payout Request')}}</h4>
                  
                   
                </div>
                <div class="card-body">
				
		
					
                @if($current < $end)
                 <h5 class="alert-primary" style="color:red" align="center">{{ __('keywords.Your payout request sent successfully')}}.</h5><p class="alert-primary" style="color:black" align="center">{{ __('keywords.You can raise next request on')}} {{$end}}.</p>
                 @else
                @if ($sumprice - $paid >= $min_amt)    
                  <form class="forms-sample" action="{{route('payout_req_sent')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                      
                     @if($bank) 
                    <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <label>{{ __('keywords.Bank Name')}}</label>
                          <input type="text" name="bank_name" value="{{$bank->bank_name}}" class="form-control" value="{{old('bank_name')}}" >
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <label>{{ __('keywords.Account Number')}}</label>
                          <input type="number" name="ac_no" value="{{$bank->ac_no}}" class="form-control" value="{{old('ac_no')}}">
                        </div>
                      </div>
                      
                       
                     <div class="col-md-4">
                        <div class="form-group">
                          <label>{{ __('keywords.IFSC Code')}}</label>
                          <input type="text" name="ifsc" value="{{$bank->ifsc}}" class="form-control" value="{{old('ifsc')}}">
                        </div>
                      </div>
                      
                      
                    </div>
                    
                    <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <label>{{ __('keywords.Account Holder Name')}}</label>
                          <input type="text" name="holder_name" value="{{$bank->holder_name}}" class="form-control" value="{{old('holder_name')}}">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                            <label>{{ __('keywords.UPI')}}</label></label>
                          <input type="text" name="upi" value="{{$bank->upi}}" class="form-control" value="{{old('upi')}}">
                        </div>
                      </div>
                       <div class="col-md-4">
                        <div class="form-group">
                            <label>Payout Amount({{$currency->currency_sign}})</label>
                            <input type="number" name="payout_amt"  class="form-control" value="{{$total_earnings->sumprice}}" min="{{$min_amt}}" step=".01" @if($total_earnings->paid != NULL)
                                max="{{$total_earnings->sumprice - $total_earnings->paid }}"
                                @else
                                max="{{$total_earnings->sumprice}}"
                                @endif/>
                        </div>
                    </div><br>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <div class="clearfix"></div>
                  
                </div>
              </div>
            </div>
			</div>
          </div>
          @else
           <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Bank Name')}}</label>
                          <input type="text" name="bank_name" class="form-control" value="{{old('bank_name')}}">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Account Number')}}</label>
                          <input type="number" name="ac_no" class="form-control" value="{{old('ac_no')}}">
                        </div>
                      </div>
                      
                       
                     <div class="col-md-4">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.IFSC Code')}}</label>
                          <input type="text" name="ifsc" class="form-control" value="{{old('ifsc')}}">
                        </div>
                      </div>
                      
                      
                    </div>
                    
                    <div class="row">
                      <div class="col-md-4">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Account Holder Name')}}</label>
                          <input type="text" name="holder_name" class="form-control" value="{{old('holder_name')}}">
                        </div>
                      </div>
                      <div class="col-md-4">
                        <div class="form-group">
                            <label class="bmd-label-floating">{{ __('keywords.UPI')}}</label></label>
                          <input type="text" name="upi" class="form-control" value="{{old('upi')}}">
                        </div>
                      </div>
                         <div class="col-md-4">
                        <div class="form-group">
                            <label>Payout Amount({{$currency->currency_sign}})</label>
                           <input type="number" name="payout_amt" value="{{$total_earnings->sumprice - $total_earnings->paid}}" min="{{$min_amt}}" class="form-control" step=".01" @if($total_earnings->paid != NULL)
                                max="{{$total_earnings->sumprice - $total_earnings->paid }}"
                                @else
                                max="{{$total_earnings->sumprice}}"
                                @endif/>
                        </div>
                    </div>
                    </div><br>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <div class="clearfix"></div>
                  
                </div>
              </div>
            </div>
			</div>
          </div>
          @endif
          </form>
          @else
          <h5 class="alert-danger" style="color:red" align="center">{{ __('keywords.You cannot request for payout because your earning is less than')}} {{$currency->currency_sign}} {{$min_amt}}</h5>
          @endif
           @endif        
        
@endsection 

