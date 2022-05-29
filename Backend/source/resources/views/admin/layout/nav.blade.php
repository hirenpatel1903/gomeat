 	<!-- BEGIN #header -->
		<div id="header" class="app-header">
			<!-- BEGIN mobile-toggler -->
			<div class="mobile-toggler">
				<button type="button" class="menu-toggler" data-toggle="sidebar-mobile">
					<span class="bar"></span>
					<span class="bar"></span>
				</button>
			</div>
			<!-- END mobile-toggler -->
			
			<!-- BEGIN brand -->
			<div class="brand">
				<div class="desktop-toggler">
					<button type="button" class="menu-toggler" data-toggle="sidebar-minify">
						<span class="bar"></span>
						<span class="bar"></span>
					</button>
				</div>
				
				<a href="#" class="brand-logo">
					<img src="{{url($logo->icon)}}" alt="" height="20" />
				</a>
			</div>
			<!-- END brand -->
			
			<!-- BEGIN menu -->
			<div class="menu">
				<form class="menu-search" method="POST" name="header_search_form">
				</form>
				<div class="menu-item dropdown">
					
						
						
				</div>
				<div class="menu-item dropdown">
					<a href="#" data-toggle="dropdown" data-display="static" class="menu-link">
						<div class="menu-img online">
							<img src="{{url($admin->admin_image)}}" alt="" class="mw-100 mh-100 rounded-circle" />
						</div>
						<div class="menu-text">{{$admin->email}}</div>
					</a>
					<div class="dropdown-menu dropdown-menu-right mr-lg-3">
						<a class="dropdown-item d-flex align-items-center" href="{{route('prof')}}">{{ __('keywords.Edit Profile')}} <i class="fa fa-user-circle fa-fw ml-auto text-gray-400 f-s-16"></i></a>
						<a class="dropdown-item d-flex align-items-center" href="{{route('passchange')}}">{{ __('keywords.Change Password')}} <i class="fa fa-key fa-fw ml-auto text-gray-400 f-s-16"></i></a>
						<a class="dropdown-item d-flex align-items-center" href="{{route('app_details')}}">{{ __('keywords.Admin Setting')}}  <i class="fa fa-wrench fa-fw ml-auto text-gray-400 f-s-16"></i></a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item d-flex align-items-center" href="{{route('logout')}}">{{ __('keywords.Log Out')}} <i class="fa fa-toggle-off fa-fw ml-auto text-gray-400 f-s-16"></i></a>
					</div>
				</div>
			</div>
			<!-- END menu -->
		</div>
		<!-- END #header -->