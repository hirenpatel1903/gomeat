<!DOCTYPE html>
<html  lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
	<meta charset="utf-8" />
	<title>{{$logo->name}} Admin</title>
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="description" content="" />
	<meta name="author" content="" />
	
	<!-- ================== BEGIN core-css ================== -->
	<link href="{{url('assets/theme_assets/css/app.min.css')}}" rel="stylesheet" />
	<!-- ================== END core-css ================== -->
	
</head>
<body>
	<!-- BEGIN #app -->
	<div id="app" class="app app-full-height app-without-header">
		<!-- BEGIN login -->
		<div class="login">
		    
			<!-- BEGIN login-content -->
			<div class="login-content">
			    <div  align="center">
			    	<img align="center" img style="width:100px;height:auto;" src="{{url($logo->icon)}}" alt="IMG">
			    	</div><hr>
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
				<form action="{{route('forgot_passwordadmin',$user->id)}}" method="POST" name="login_form">
				    {{ csrf_field() }}
					<h1 class="text-center">{{ __('keywords.Change Password')}}</h1>
				
					<div class="form-group">
						<label>{{ __('keywords.Password')}}</label>
						<input type="hidden" name="token" value="{{$id}}">
                <input type="text" name="password" placeholder="input new password" class="form-control"><br><br>
               
					</div>
					<div class="form-group">
				<label>{{ __('keywords.Confirm Password')}}</label>	    
				 <input type="text" name="password2" placeholder="confirm password"  class="form-control"><br><br>
					
					</div>
					<button type="submit" class="btn btn-primary btn-lg btn-block fw-500 mb-3">{{ __('keywords.Change Password')}}</button>
				</form>
			</div>
			<!-- END login-content -->
		</div>
		<!-- END login -->
		
		<!-- BEGIN btn-scroll-top -->
		<a href="#" data-click="scroll-top" class="btn-scroll-top fade"><i class="fa fa-arrow-up"></i></a>
		<!-- END btn-scroll-top -->
	</div>
	<!-- END #app -->
	
	<!-- ================== BEGIN core-js ================== -->
	<script src="{{url('assets/theme_assets/js/app.min.js')}}"></script>
	<!-- ================== END core-js ================== -->
	
</body>
</html>



 