@extends('admin.layout.app')

@section ('content')
        <div class="content-wrapper">
          <div class="row">
            
            <div class="col-md-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">{{ __('keywords.Add Role')}}</h4><br>
                             @if (count($errors) > 0)
                              @if($errors->any())
                                <div class="alert alert-primary" role="alert">
                                  {{$errors->first()}}
                                  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                  </button>
                                </div>
                              @endif
                          @endif
                       
                  <form class="forms-sample" action="{{route('addnewrole')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                      <div class="form-group">
                      <label for="exampleInputName1">{{ __('keywords.Role Name')}}</label>
                      <input type="text" class="form-control" id="exampleInputName1" name="name" value="{{old('name')}}" placeholder="{{ __('keywords.Role Name')}}">
                      </div>
                      <br>
                      
                    
                      <div class="form-group">
                   
                      
                      <h5 align="center"><b>{{ __('keywords.Enable Sections')}}</b> </h5><hr><br>
                    <div class="row">
                     <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                        
                          <input type="checkbox" form-control name="dashboard" value="1" >
                            &nbsp;&nbsp;<label>{{ __('keywords.Dashboard')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          
                          <input type="checkbox" form-control name="category" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Category')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                         
                          <input type="checkbox" form-control name="tax" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Tax')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          <input type="checkbox" form-control name="id" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Id')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          <input type="checkbox" form-control name="membership" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Membership')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                       
                          <input type="checkbox" form-control name="reports" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Reports')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                        
                          <input type="checkbox" form-control name="notification" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Notification')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          
                          <input type="checkbox" form-control name="users" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Users')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                         
                          <input type="checkbox" form-control name="product" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Product')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                     
                          <input type="checkbox" form-control name="area" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Area')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                         
                          <input type="checkbox" form-control name="store" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Store')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                         
                          <input type="checkbox" form-control name="orders" value="1" > &nbsp;&nbsp;<label>{{ __('keywords.Orders')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          <input type="checkbox" form-control name="payout" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Payout')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          
                          <input type="checkbox" form-control name="rewards" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Rewards')}}</label><br>
                      </div>
                    </div>

                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          <input type="checkbox" form-control name="delivery_boy" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Delivery Boy')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                       
                          <input type="checkbox" form-control name="pages" value="1" > &nbsp;&nbsp;<label>{{ __('keywords.Pages')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                  
                          <input type="checkbox" form-control name="feedback" value="1" > &nbsp;&nbsp;<label>{{ __('keywords.Feedback')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                        
                          <input type="checkbox" form-control name="callback" value="1" > &nbsp;&nbsp;<label>{{ __('keywords.Callback')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                         
                          <input type="checkbox" form-control name="settings" value="1" > &nbsp;&nbsp;<label>{{ __('keywords.Settings')}}</label><br>
                      </div>
                    </div>
                    <div class="input-group col-xs-6 col-sm-6 col-md-4 col-lg-3">
                       <div class="form-group">
                          
                          <input type="checkbox" form-control name="reason" value="1" >&nbsp;&nbsp;<label>{{ __('keywords.Cancelling Reasons')}}</label><br>
                      </div>
                    </div>
        
                  </div>
                    
                    <button type="submit" class="btn btn-primary mr-2">{{ __('keywords.Submit')}}</button>
                    <!--
                   
                    -->
                     <a href="{{route('rolelist')}}" class="btn btn-danger">{{ __('keywords.Close')}}</a>
                  </form>
                </div>
              </div>
            </div>
             <div class="col-md-2">
      </div>
     
          </div>
        </div>
        
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">
          $(document).ready(function(){
          
                $(".des_price").hide();
                
            $(".img").on('change', function(){
                  $(".des_price").show();
              
          });
          });
</script>

 


 @endsection