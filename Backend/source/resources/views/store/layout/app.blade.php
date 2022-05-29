<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
	<meta charset="utf-8" />
	<title>{{$store->store_name}} Panel</title>
	<link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="{{url($store->store_photo)}}">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<meta name="description" content="GoGrocer Multistore" />
	<meta name="author" content="Tecmanic" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.2/iconfont/material-icons.min.css" integrity="sha512-y9glprRcVESvYY3suAqBUYXx0ySbQNvbzzgvLy9F2o38Y7XCNeq/No2gnHjV3+Rjyq5ijoPZRMXotpdw6jcG4g==" crossorigin="anonymous" />

	<!-- ================== BEGIN core-css ================== -->
	<link href="{{url('assets/theme_assets/css/app.min.css')}}" rel="stylesheet" />
	<!-- ================== END core-css ================== -->
	<link href="{{url('assets/theme_assets/plugins/bootstrap-daterangepicker/daterangepicker.css')}}" rel="stylesheet" />
	<!-- required css -->
<link href="{{url('assets/theme_assets/plugins/datatables.net-bs4/css/dataTables.bootstrap4.min.css')}}" rel="stylesheet" />
<link href="{{url('assets/theme_assets/plugins/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css')}}" rel="stylesheet" />
<link href="{{url('assets/theme_assets/plugins/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css')}}" rel="stylesheet" />
<link href="{{url('assets/theme_assets/assets/plugins/bootstrap-table/dist/bootstrap-table.min.css')}}" rel="stylesheet" />

        <link href="https://unpkg.com/tailwindcss@^2/dist/tailwind.min.css" rel="stylesheet">


        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

        <!-- Styles -->
        <style>
            body {
                font-family: 'Nunito', sans-serif;
            }
        </style>
        @livewireStyles
        @powerGridStyles

</head>


  <style>
      .card-header.card-header-primary {
    padding: 10px !important;
    }
    .alert {
    padding: 6px !important;
    }
    .dataTables_info{
        display:none;
    }
    .page-item.active .page-link {
    color: #fff!important;
    background-color: gray;
    border-color: gray;
    z-index: 0 !important;
    }
    .app-sidebar .menu .menu-item.active:not(.has-sub)>.menu-link {
    color: #1f6bff;
    background-color: white !important;
    font-weight: 600;
    background: 0 0;
    }

  </style>
</head>

<body data-spy='scroll' data-target='#sidebar-bootstrap' data-offset='200'>
  	<div id="app" class="app">
     @include('store.layout.nav')
      @include('store.layout.sidebar')
     <!-- BEGIN #content -->
		<div id="content" class="app-content">
        <div class="row">
        	<div class="col-md-7">
			<h1 class="page-header mb-3">
				Hi, {{$store->store_name}}. <small>{{ __('keywords.Here is your store panel')}}.</small>

			</h1></div>
			<div class="col-md-5" align="right">
			
            <div class="col-md-4" align="right">
               <select class="form-control changeLang">
                    <option value="en" {{ session()->get('locale') == 'en'||config('app.locale')=="en" ? 'selected' : '' }}>English</option>
                    <option value="bu" {{ session()->get('locale') == 'bu'||config('app.locale')=="bu" ? 'selected' : '' }}>Bulgarian</option>
                    <option value="in" {{ session()->get('locale') == 'in'||config('app.locale')=="in" ? 'selected' : '' }}>Hindi</option>
                    <option value="ch" {{ session()->get('locale') == 'ch'||config('app.locale')=="ch" ? 'selected' : '' }}>Chinese</option>
                </select>
            </div></div></div>
                 @yield('content')
                 <div class="container-fluid">
         @include('store.layout.footer')
       </div>

             </div>
        <!--footer-->

   	        </div>
		<!-- END #content -->
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
		<script src="{{url('assets/theme_assets/plugins/chart.js/dist/Chart.min.js')}}"></script>
	<script src="{{url('assets/theme_assets/plugins/moment/min/moment.min.js')}}"></script>
	<script src="{{url('assets/theme_assets/plugins/bootstrap-daterangepicker/daterangepicker.js')}}"></script>
	<!-- <script src="{{url('assets/theme_assets/js/demo/analytics.demo.js')}}"></script> -->
	<script src="{{url('assets/theme_assets/plugins/datatables.net/js/jquery.dataTables.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-bs4/js/dataTables.bootstrap4.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-buttons/js/dataTables.buttons.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-buttons/js/buttons.colVis.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-buttons/js/buttons.flash.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-buttons/js/buttons.html5.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-buttons/js/buttons.print.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-responsive/js/dataTables.responsive.min.js')}}"></script>
    <script src="{{url('assets/theme_assets/plugins/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js')}}"></script>
     <script src="{{url('assets/theme_assets/plugins/bootstrap-table/dist/bootstrap-table.min.js')}}"></script>
	<!-- ================== END page-js ================== -->
        
  @yield('line-chart')
  @yield('jquery')
<script type="text/javascript">
  
    var url = "{{ route('changeLang') }}";
  
    $(".changeLang").change(function(){
        window.location.href = url + "?lang="+ $(this).val();
    });
  
</script>
<script>
  $('#datatableDefault').DataTable({
    dom: "<'row mb-3'<'col-sm-4'l><'col-sm-8 text-right'<'d-flex justify-content-end'fB>>>t<'d-flex align-items-center'<'mr-auto'i><'mb-0'p>>",
     responsive: true,
    lengthMenu: false,
    autoWidth:true,
    select: true,
    scrollX: true,
    processing:true,
    ordering:true,
   paging:false,
    buttons: [ 
      { extend: 'print', className: 'btn btn-default' },
      { extend: 'csv', className: 'btn btn-default' }
    ]
  });
</script>
<script>
  $('#datatableDefaults').DataTable({
    dom: "<'row mb-3'<'col-sm-4'l><'col-sm-8 text-right'<'d-flex justify-content-end'fB>>>t<'d-flex align-items-center'<'mr-auto'i><'mb-0'p>>",
    lengthMenu: [ 10, 20, 30, 40, 50 ],
    responsive: true,
    buttons: [ 
      { extend: 'print', className: 'btn btn-default' },
      { extend: 'csv', className: 'btn btn-default' }
    ]
  });
</script>

<script>
  $('#datatableDefault1').DataTable({
    dom: "<'row mb-3'<'col-sm-4'l><'col-sm-8 text-right'<'d-flex justify-content-end'fB>>>t<'d-flex align-items-center'<'mr-auto'i><'mb-0'p>>",
    lengthMenu: [ 10, 20, 30, 40, 50 ],
    responsive: true,
    buttons: [ 
      { extend: 'print', className: 'btn btn-default' },
      { extend: 'csv', className: 'btn btn-default' }
    ]
  });
</script>
<script>
  $('#datatableDefault2').DataTable({
    dom: "<'row mb-3'<'col-sm-4'l><'col-sm-8 text-right'<'d-flex justify-content-end'fB>>>t<'d-flex align-items-center'<'mr-auto'i><'mb-0'p>>",
    lengthMenu: [ 10, 20, 30, 40, 50 ],
    responsive: true,
    buttons: [ 
      { extend: 'print', className: 'btn btn-default' },
      { extend: 'csv', className: 'btn btn-default' }
    ]
  });
</script>
<script>
  $('#datatableDefaults2').DataTable({
    dom: "<'row mb-3'<'col-sm-4'l><'col-sm-8 text-right'<'d-flex justify-content-end'fB>>>t<'d-flex align-items-center'<'mr-auto'i><'mb-0'p>>",
    lengthMenu: [ 10, 20, 30, 40, 50 ],
    responsive: true,
    buttons: [ 
      { extend: 'print', className: 'btn btn-default' },
      { extend: 'csv', className: 'btn btn-default' }
    ]
  });
</script>
<script>
  $('#datatableDefaults3').DataTable({
    dom: "<'row mb-3'<'col-sm-4'l><'col-sm-8 text-right'<'d-flex justify-content-end'fB>>>t<'d-flex align-items-center'<'mr-auto'i><'mb-0'p>>",
    lengthMenu: [ 10, 20, 30, 40, 50 ],
    responsive: true,
    buttons: [ 
      { extend: 'print', className: 'btn btn-default' },
      { extend: 'csv', className: 'btn btn-default' }
    ]
  });
</script>
  @livewireScripts
        @powerGridScripts

        <script>
            window.addEventListener('showAlert', event => {
                alert('You clicked in user id#' + event.detail.id);
            })
        </script>
</body>
</html>
 




