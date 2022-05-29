<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<title>{{ __('keywords.Change Password')}}</title>
	<link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="{{url($logo->favicon)}}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="description" content="GoGrocer Multistore" />
	<meta name="author" content="Tecmanic" />
	
	<!-- ================== BEGIN core-css ================== -->
	<link href="{{url('assets/theme_assets/css/app.min.css')}}" rel="stylesheet" />
	<!-- ================== END core-css ================== -->
	
</head>


  <style>
      .card-header.card-header-primary {
    padding: 10px !important;
    }
    .alert {
    padding: 6px !important;
    }
    
  </style>
</head>

<body data-spy='scroll' data-target='#sidebar-bootstrap' data-offset='200'>
  	<div id="app" class="app">
     <!-- BEGIN #content -->
		<div id="content" class="app-content">
		    <div class="container">      
            <form method="post" action="{{route('forgot_password1',$user->user_id)}}">
                {{csrf_field()}}
                <br><br>
                <input type="text" name="password" placeholder="input new password" class="form-control"><br><br>
                <input type="text" name="password2" placeholder="confirm password"  class="form-control"><br><br>
                <input type="submit" class="btn btn-primary" name="button" value= "submit"><br>
            </form>
            </div>

   	        </div>
		<!-- END #content -->
		
		<!-- BEGIN btn-scroll-top -->
		<a href="#" data-click="scroll-top" class="btn-scroll-top fade"><i class="fa fa-arrow-up"></i></a>
		<!-- END btn-scroll-top -->
	</div>
	<!-- END #app -->
	
	<!-- ================== BEGIN core-js ================== -->
	<script src="{{url('assets/theme_assets/js/app.min.js')}}"></script>
	<!-- ================== END core-js ================== -->
	
	<!-- ================== BEGIN page-js ================== -->
	<script src="{{url('assets/theme_assets/plugins/apexcharts/dist/apexcharts.min.js')}}"></script>
	<script src="{{url('assets/theme_assets/js/demo/dashboard.demo.js')}}"></script>
	<!-- ================== END page-js ================== -->

</body>
</html>
 