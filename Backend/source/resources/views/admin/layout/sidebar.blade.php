	<!-- BEGIN #sidebar -->
	@if($admin->role_id==0)
		<div id="sidebar" class="app-sidebar">
			<!-- BEGIN scrollbar -->
			<div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
				<!-- BEGIN menu -->
				<div class="menu">
					<div class="menu-header">{{ __('keywords.Navigation') }}</div>
					<div class="menu-item {{ request()->is('home') ? 'active' : ''}}">
						<a href="{{route('adminHome')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-laptop"></i></span>
							<span class="menu-text">{{ __('keywords.Dashboard') }}</span>
						</a>
					</div>
				<div class="menu-item has-sub {{ request()->is('roles') ? 'active' : ''}} {{ request()->is('subadmin/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fas fa-user-astronaut"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Sub-Admin Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item  {{ request()->is('roles') ? 'active' : ''}}">
								<a href="{{route('rolelist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Roles') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('subadmin/*') ? 'active' : ''}}">
								<a href="{{route('subadminlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Sub-Admin') }}</span>
								</a>
							</div>
						</div>
					</div>	
				<div class="menu-item  {{ request()->is('tax/*') ? 'active' : ''}}">
						<a href="{{route('taxlist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-hashtag"></i></span>
							<span class="menu-text">{{ __('keywords.Taxes') }}</span>
						</a>
					</div>
					<div class="menu-item {{ request()->is('id/*') ? 'active' : ''}}">
						<a href="{{route('idlist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-credit-card"></i></span>
							<span class="menu-text">{{ __('keywords.ID') }}</span>
						</a>
					</div>
					<div class="menu-item {{ request()->is('membership/*') ? 'active' : ''}}">
						<a href="{{route('memlist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-tag"></i></span>
							<span class="menu-text">{{ __('keywords.Membership Plans') }}</span>
						</a>
					</div>
						<div class="menu-item has-sub {{ request()->is('report/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Reports') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('report/item_sale/*') ? 'active' : ''}}">
								<a href="{{route('item_sale_rep')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Item Requirement') }} ({{ __('keywords.Day-Wise') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('report/total-item-sales/*') ? 'active' : ''}}">
								<a href="{{route('admin_reqforthirty')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Item Sales Report') }} ({{ __('keywords.Last 30 Days') }})</span>
								</a>
							</div>
						
							<div class="menu-item {{ request()->is('report/tax') ? 'active' : ''}}">
								<a href="{{route('taxreport')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Tax Reports') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('report/order') ? 'active' : ''}}">
								<a href="{{route('ad_boy_reports')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Reports') }}</span>
								</a>
							</div>
						
						</div>
					</div>
					
					<div class="menu-item has-sub {{ request()->is('notification/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-bell"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Send Notifications') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						    	<div class="menu-item {{ request()->is('notification/to-users') ? 'active' : ''}}">
								<a href="{{route('adminNotificationuser')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Users') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('notification/to-store') ? 'active' : ''}}">
								<a href="{{route('adminNotification')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Store')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('notification/to-driver') ? 'active' : ''}}">
								<a href="{{route('adminNotificationdriver')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Driver') }}</span>
								</a>
							</div>
						
						</div>
					</div>
					<div class="menu-item has-sub {{ request()->is('list/notification/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-bell"></i>
							</span>
							<span class="menu-text">{{ __('keywords.List Notifications') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						    	<div class="menu-item {{ request()->is('list/notification/list/user') ? 'active' : ''}}">
								<a href="{{route('usernotlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.User Notifications') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('list/notification/list/store') ? 'active' : ''}}">
								<a href="{{route('storenotlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Notifications')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('list/notification/list/driver') ? 'active' : ''}}">
								<a href="{{route('drivernotlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Driver Notifications') }}</span>
								</a>
							</div>
						
						</div>
					</div>
						<div class="menu-item has-sub {{ request()->is('user/*') ? 'active' : ''}} {{ request()->is('users/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-users"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Users Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('user/*') ? 'active' : ''}}">
								<a href="{{route('userlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Users Data')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('users/*') ? 'active' : ''}}">
								<a href="{{route('user_wallet')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Wallet Recharge History') }}</span>
								</a>
							</div>
						
						</div>
					</div>
	
					
						<div class="menu-item has-sub {{ request()->is('category/*') ? 'active' : ''}}{{ request()->is('sub-category/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Category Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('category/*') ? 'active' : ''}}">
								<a href="{{route('catlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Parent Categories')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('sub-category/*') ? 'active' : ''}}">
								<a href="{{route('subcatlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Sub Categories')}}</span>
								</a>
							</div>
						
						</div>
					  </div>
					  
		
						<div class="menu-item has-sub {{ request()->is('product/*') ? 'active' : ''}} {{ request()->is('varient/*') ? 'active' : ''}} {{ request()->is('bulk_upload/*') ? 'active' : ''}}{{ request()->is('store_products/*') ? 'active' : ''}}{{ request()->is('trending_search/product/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Product Catalog') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('product/*') ? 'active' : ''}} {{ request()->is('varient/*') ? 'active' : ''}}">
								<a href="{{route('productlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Admin Products')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store_products/*') ? 'active' : ''}}">
								<a href="{{route('st_plist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Products')}}({{ __('keywords.request')}})</span>
								</a>
							</div>
						<div class="menu-item {{ request()->is('trending_search/product/*') ? 'active' : ''}}">
								<a href="{{route('trendsel_product')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Trending Search') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('bulk_upload/*') ? 'active' : ''}}">
								<a href="{{route('bulkup')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Bulk Upload') }}</span>
								</a>
							</div>
						
						</div>
					</div>
				
					
						<div class="menu-item has-sub {{ request()->is('city/*') ? 'active' : ''}}{{ request()->is('society/*') ? 'active' : ''}}{{ request()->is('area_bulk_upload/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-map"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Area Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('city/*') ? 'active' : ''}}">
								<a href="{{route('citylist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Cities')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('society/*') ? 'active' : ''}}">
								<a href="{{route('societylist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Area/Society') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('area_bulk_upload/*') ? 'active' : ''}}">
								<a href="{{route('bulkupcity')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Bulk Upload') }}</span>
								</a>
							</div>
						
						</div>
					</div>
		
					
						<div class="menu-item has-sub {{ request()->is('admin/store/*') ? 'active' : ''}} {{ request()->is('stores/waiting_for_approval') ? 'active' : ''}} {{ request()->is('stores/*') ? 'active' : ''}}{{ request()->is('storess/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-building"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Store Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('admin/store/*') ? 'active' : ''}}">
								<a href="{{route('storeclist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store List') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('storess/*') ? 'active' : ''}}">
								<a href="{{route('finance')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Earning/Payments') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('stores/waiting_for_approval/*') ? 'active' : ''}}">
								<a href="{{route('storeapprove')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Approval') }}</span>
								</a>
							</div>
						
						</div>
					</div>
				
					<div class="menu-item has-sub {{ request()->is('stores/cancelled/orders') ? 'active' : ''}}
					{{ request()->is('admin/all_orders') ? 'active' : ''}}
					{{ request()->is('admin/pending_orders') ? 'active' : ''}}
					{{ request()->is('admin/cancelled_orders') ? 'active' : ''}}
					{{ request()->is('admin/ongoing_orders') ? 'active' : ''}}
					{{ request()->is('admin/out_for_delivery_orders') ? 'active' : ''}}
					{{ request()->is('admin/payment_failed_orders') ? 'active' : ''}}
					{{ request()->is('admin/completed_orders') ? 'active' : ''}}
					{{ request()->is('orders/today/all') ? 'active' : ''}}
					{{ request()->is('store/missed/orders') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-calendar"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Orders Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('stores/cancelled/orders') ? 'active' : ''}}">
								<a href="{{route('store_cancelled')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Rejected By Store') }}</span>
								</a>
							</div>
						<div class="menu-item {{ request()->is('admin/all_orders') ? 'active' : ''}}">
								<a href="{{route('admin_all_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.All orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('admin/pending_orders') ? 'active' : ''}}">
								<a href="{{route('admin_pen_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Pending orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('admin/cancelled_orders') ? 'active' : ''}}">
								<a href="{{route('admin_can_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Cancelled orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('admin/ongoing_orders') ? 'active' : ''}}">
								<a href="{{route('admin_on_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Ongoing orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('admin/out_for_delivery_orders') ? 'active' : ''}}">
								<a href="{{route('admin_out_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Out For Delivery orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('admin/payment_failed_orders') ? 'active' : ''}}">
								<a href="{{route('admin_failed_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Payment Failed orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('admin/completed_orders') ? 'active' : ''}}">
								<a href="{{route('admin_com_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Completed orders') }}</span>
								</a>
							</div>
							
							<div class="menu-item {{ request()->is('orders/today/all') ? 'active' : ''}}">
								<a href="{{route('sales_today')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Day Wise Orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/missed/orders') ? 'active' : ''}}">
								<a href="{{route('missed_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Missed Orders') }}</span>
								</a>
							</div>
						
						</div>
					</div>
					
					<div class="menu-item has-sub {{ request()->is('payout_req') ? 'active' : ''}} {{ request()->is('prv') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-check"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Payout') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('payout_req') ? 'active' : ''}}">
								<a href="{{route('pay_req')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Payout Requests') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('prv') ? 'active' : ''}}">
								<a href="{{route('prv')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Payout Validation') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
					
				   	<div class="menu-item has-sub {{ request()->is('reward/*') ? 'active' : ''}}{{ request()->is('reward') ? 'active' : ''}}{{ request()->is('reedem') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-trophy"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Rewards') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('reward') ? 'active' : ''}}">
								<a href="{{route('RewardList')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Rewards') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('reedem') ? 'active' : ''}}">
								<a href="{{route('reedem')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Redeem Value') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
				
					<div class="menu-item has-sub {{ request()->is('d_boy/*') ? 'active' : ''}} {{ request()->is('dboy_incentive') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-users"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Delivery Boy') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('d_boy/*') ? 'active' : ''}}">
								<a href="{{route('d_boylist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('dboy_incentive') ? 'active' : ''}}">
								<a href="{{route('boy_incentive')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Incentive') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>

			
					<div class="menu-item has-sub {{ request()->is('about_us') ? 'active' : ''}} {{ request()->is('terms') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-bookmark"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Pages') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('about_us') ? 'active' : ''}}">
								<a href="{{route('about_us')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.About Us') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('terms') ? 'active' : ''}}">
								<a href="{{route('terms')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Terms & Conditions') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
					
			   <div class="menu-item has-sub {{ request()->is('user_feedback/*') ? 'active' : ''}} {{ request()->is('store_feedback/*') ? 'active' : ''}} {{ request()->is('driver_feedback/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-comment"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Feedback') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('user_feedback/*') ? 'active' : ''}}">
								<a href="{{route('user_feedback')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Users') }} {{ __('keywords.Feedback') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store_feedback/*') ? 'active' : ''}}">
								<a href="{{route('store_feedback')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store') }} {{ __('keywords.Feedback') }}</span>
								</a>
							</div>
						<div class="menu-item {{ request()->is('driver_feedback/*') ? 'active' : ''}}">
								<a href="{{route('driver_feedback')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Feedback') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
				 <div class="menu-item has-sub {{ request()->is('user_callback_requests') ? 'active' : ''}} {{ request()->is('store_callback_requests') ? 'active' : ''}} {{ request()->is('driver_callback_requests') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-phone"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Callback Requests') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
								<div class="menu-item {{ request()->is('user_callback_requests') ? 'active' : ''}}">
						<a href="{{route('user_callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Users') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
					<div class="menu-item {{ request()->is('store_callback_requests') ? 'active' : ''}}">
						<a href="{{route('store_callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Stores') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
					
					<div class="menu-item {{ request()->is('driver_callback_requests') ? 'active' : ''}}">
						<a href="{{route('driver_callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
						
						
						</div>
					</div>
			
				<div class="menu-divider"></div>
					<div class="menu-header">{{ __('keywords.Settings') }}</div>
					<div class="menu-item {{ request()->is('global_settings') ? 'active' : ''}}">
						<a href="{{route('app_details')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-cog"></i></span>
							<span class="menu-text">{{ __('keywords.Settings') }}</span>
						</a>
					</div>
					<div class="menu-item {{ request()->is('cancelling_reasons/*') ? 'active' : ''}}">
						<a href="{{route('can_res_list')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-list"></i></span>
							<span class="menu-text">{{ __('keywords.Cancelling Reasons') }}</span>
						</a>
					</div>
				</div>
				<!-- END menu -->
			</div>
			<!-- END scrollbar -->
			
			<!-- BEGIN mobile-sidebar-backdrop -->
			<button class="app-sidebar-mobile-backdrop" data-dismiss="sidebar-mobile"></button>
			<!-- END mobile-sidebar-backdrop -->
		</div>
		<!-- END #sidebar -->
		
		
		
		
		
		
		
	@else
		<div id="sidebar" class="app-sidebar">
			<!-- BEGIN scrollbar -->
			<div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
				<!-- BEGIN menu -->
				@if($admin->dashboard ==1)
				<div class="menu">
					<div class="menu-header">{{ __('keywords.Navigation') }}</div>
					<div class="menu-item {{ request()->is('home') ? 'active' : ''}}">
						<a href="{{route('adminHome')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-laptop"></i></span>
							<span class="menu-text">{{ __('keywords.Dashboard') }}</span>
						</a>
					</div>
				@endif
			
				@if($admin->tax ==1)
				<div class="menu-item  {{ request()->is('tax/*') ? 'active' : ''}}">
						<a href="{{route('taxlist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-hashtag"></i></span>
							<span class="menu-text">{{ __('keywords.Taxes') }}</span>
						</a>
					</div>
				@endif
				@if($admin->id ==1)
					<div class="menu-item {{ request()->is('id/*') ? 'active' : ''}}">
						<a href="{{route('idlist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-credit-card"></i></span>
							<span class="menu-text">{{ __('keywords.ID') }}</span>
						</a>
					</div>
				@endif
				@if($admin->membership ==1)
					<div class="menu-item {{ request()->is('membership/*') ? 'active' : ''}}">
						<a href="{{route('memlist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-tag"></i></span>
							<span class="menu-text">{{ __('keywords.Membership Plans') }}</span>
						</a>
					</div>
				@endif
				@if($admin->reports ==1)
						<div class="menu-item has-sub {{ request()->is('report/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Reports') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('report/item_sale') ? 'active' : ''}}">
								<a href="{{route('item_sale_rep')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Item Requirement') }} ({{ __('keywords.Day-Wise') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('report/total-item-sales') ? 'active' : ''}}">
								<a href="{{route('admin_reqforthirty')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Item Sales Report') }} ({{ __('keywords.Last 30 Days') }})</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('report/total-item-sales') ? 'active' : ''}}">
								<a href="{{route('ad_boy_reports')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Reports') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('report/tax') ? 'active' : ''}}">
								<a href="{{route('taxreport')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Tax Reports') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('report/order') ? 'active' : ''}}">
								<a href="{{route('ad_boy_reports')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Reports') }}</span>
								</a>
							</div>
						
						</div>
					</div>
				@endif
				@if($admin->notification ==1)
					
					<div class="menu-item has-sub {{ request()->is('notification/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-bell"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Send Notifications') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						    	<div class="menu-item {{ request()->is('notification/to-users') ? 'active' : ''}}">
								<a href="{{route('adminNotificationuser')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Users') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('notification/to-store') ? 'active' : ''}}">
								<a href="{{route('adminNotification')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Store')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('notification/to-driver') ? 'active' : ''}}">
								<a href="{{route('adminNotificationdriver')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Driver') }}</span>
								</a>
							</div>
						
						</div>
					</div>
					
					<div class="menu-item has-sub {{ request()->is('list/notification/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-bell"></i>
							</span>
							<span class="menu-text">{{ __('keywords.List Notifications') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						    	<div class="menu-item {{ request()->is('list/notification/list/user') ? 'active' : ''}}">
								<a href="{{route('usernotlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.User Notifications') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('list/notification/list/store') ? 'active' : ''}}">
								<a href="{{route('storenotlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Notifications')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('list/notification/list/driver') ? 'active' : ''}}">
								<a href="{{route('drivernotlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Driver Notifications') }}</span>
								</a>
							</div>
						
						</div>
					</div>
					@endif
					@if($admin->users ==1)
						<div class="menu-item has-sub {{ request()->is('user/*') ? 'active' : ''}} {{ request()->is('users/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-users"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Users Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('user/*') ? 'active' : ''}}">
								<a href="{{route('userlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Users Data')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('users/*') ? 'active' : ''}}">
								<a href="{{route('user_wallet')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Wallet Recharge History') }}</span>
								</a>
							</div>
						
						</div>
					</div>
	             @endif
	             @if($admin->category ==1)
						<div class="menu-item has-sub {{ request()->is('category/*') ? 'active' : ''}}{{ request()->is('sub-category/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Category Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('category/*') ? 'active' : ''}}">
								<a href="{{route('catlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Parent Categories')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('sub-category/*') ? 'active' : ''}}">
								<a href="{{route('subcatlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Sub Categories')}}</span>
								</a>
							</div>
						
						</div>
					  </div>
				@endif
				@if($admin->product ==1)
							<div class="menu-item has-sub {{ request()->is('product/*') ? 'active' : ''}} {{ request()->is('varient/*') ? 'active' : ''}} {{ request()->is('bulk_upload/*') ? 'active' : ''}}{{ request()->is('store_products/*') ? 'active' : ''}}{{ request()->is('trending_search/product/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Product Catalog') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('product/*') ? 'active' : ''}} {{ request()->is('varient/*') ? 'active' : ''}}">
								<a href="{{route('productlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Admin Products')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store_products/*') ? 'active' : ''}}">
								<a href="{{route('st_plist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Products')}}({{ __('keywords.request')}})</span>
								</a>
							</div>
						<div class="menu-item {{ request()->is('trending_search/product/*') ? 'active' : ''}}">
								<a href="{{route('trendsel_product')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Trending Search') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('bulk_upload/*') ? 'active' : ''}}">
								<a href="{{route('bulkup')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Bulk Upload') }}</span>
								</a>
							</div>
						
						</div>
					</div>
				@endif
				@if($admin->area ==1)
					
						<div class="menu-item has-sub {{ request()->is('city/*') ? 'active' : ''}}{{ request()->is('society/*') ? 'active' : ''}} {{ request()->is('area_bulk_upload/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-map"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Area Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('city/*') ? 'active' : ''}}">
								<a href="{{route('citylist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Cities')}}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('society/*') ? 'active' : ''}}">
								<a href="{{route('societylist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Area/Society') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('area_bulk_upload/*') ? 'active' : ''}}">
								<a href="{{route('bulkupcity')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Bulk Upload') }}</span>
								</a>
							</div>
						
						</div>
					</div>
		   @endif
	    	@if($admin->store ==1)			
						<div class="menu-item has-sub {{ request()->is('admin/store/*') ? 'active' : ''}} {{ request()->is('stores/waiting_for_approval') ? 'active' : ''}} {{ request()->is('storess/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-building"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Store Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('admin/store/*') ? 'active' : ''}}">
								<a href="{{route('storeclist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store List') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('storess/*') ? 'active' : ''}}">
								<a href="{{route('finance')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Earning/Payments') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('stores/waiting_for_approval/*') ? 'active' : ''}}">
								<a href="{{route('storeapprove')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store Approval') }}</span>
								</a>
							</div>
						
						</div>
					</div>
				@endif
				@if($admin->orders ==1)
					<div class="menu-item has-sub {{ request()->is('stores/cancelled/orders') ? 'active' : ''}}
					{{ request()->is('admin/all_orders') ? 'active' : ''}}
					{{ request()->is('admin/pending_orders') ? 'active' : ''}}
					{{ request()->is('admin/cancelled_orders') ? 'active' : ''}}
					{{ request()->is('admin/ongoing_orders') ? 'active' : ''}}
					{{ request()->is('admin/out_for_delivery_orders') ? 'active' : ''}}
					{{ request()->is('admin/payment_failed_orders') ? 'active' : ''}}
					{{ request()->is('admin/completed_orders') ? 'active' : ''}}
					{{ request()->is('orders/today/all') ? 'active' : ''}}
					{{ request()->is('store/missed/orders') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-calendar"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Orders Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('stores/cancelled/orders') ? 'active' : ''}}">
								<a href="{{route('store_cancelled')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Rejected By Store') }}</span>
								</a>
							</div>
						<div class="menu-item {{ request()->is('admin/all_orders') ? 'active' : ''}}">
								<a href="{{route('admin_all_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.All orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('admin/pending_orders') ? 'active' : ''}}">
								<a href="{{route('admin_pen_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Pending orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('admin/cancelled_orders') ? 'active' : ''}}">
								<a href="{{route('admin_can_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Cancelled orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('admin/ongoing_orders') ? 'active' : ''}}">
								<a href="{{route('admin_on_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Ongoing orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('admin/out_for_delivery_orders') ? 'active' : ''}}">
								<a href="{{route('admin_out_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Out For Delivery orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('admin/payment_failed_orders') ? 'active' : ''}}">
								<a href="{{route('admin_failed_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Payment Failed orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('admin/completed_orders') ? 'active' : ''}}">
								<a href="{{route('admin_com_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Completed orders') }}</span>
								</a>
							</div>
							
							<div class="menu-item {{ request()->is('orders/today/all') ? 'active' : ''}}">
								<a href="{{route('sales_today')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Day Wise Orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/missed/orders') ? 'active' : ''}}">
								<a href="{{route('missed_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Missed Orders') }}</span>
								</a>
							</div>
						
						</div>
					</div>
					@endif
					@if($admin->payout ==1)
					<div class="menu-item has-sub {{ request()->is('payout_req') ? 'active' : ''}} {{ request()->is('prv') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-check"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Payout') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('payout_req') ? 'active' : ''}}">
								<a href="{{route('pay_req')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Payout Requests') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('prv') ? 'active' : ''}}">
								<a href="{{route('prv')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Payout Validation') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
				@endif
				@if($admin->rewards ==1)
				   	<div class="menu-item has-sub {{ request()->is('reward/*') ? 'active' : ''}}{{ request()->is('reward') ? 'active' : ''}}{{ request()->is('reedem') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-trophy"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Rewards') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('reward') ? 'active' : ''}}">
								<a href="{{route('RewardList')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Rewards') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('reedem') ? 'active' : ''}}">
								<a href="{{route('reedem')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Redeem Value') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
				@endif
				@if($admin->delivery_boy ==1)
					<div class="menu-item has-sub {{ request()->is('d_boy/*') ? 'active' : ''}} {{ request()->is('dboy_incentive') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-users"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Delivery Boy') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('d_boy/*') ? 'active' : ''}}">
								<a href="{{route('d_boylist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('dboy_incentive') ? 'active' : ''}}">
								<a href="{{route('boy_incentive')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Incentive') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
                  @endif
			      @if($admin->pages ==1)
					<div class="menu-item has-sub {{ request()->is('about_us') ? 'active' : ''}} {{ request()->is('terms') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-bookmark"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Pages') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('about_us') ? 'active' : ''}}">
								<a href="{{route('about_us')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.About Us') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('terms') ? 'active' : ''}}">
								<a href="{{route('terms')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Terms & Conditions') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
				@endif
				@if($admin->feedback ==1)
			   <div class="menu-item has-sub {{ request()->is('user_feedback/*') ? 'active' : ''}} {{ request()->is('store_feedback/*') ? 'active' : ''}} {{ request()->is('driver_feedback/*') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-comment"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Feedback') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('user_feedback/*') ? 'active' : ''}}">
								<a href="{{route('user_feedback')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Users') }} {{ __('keywords.Feedback') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store_feedback/*') ? 'active' : ''}}">
								<a href="{{route('store_feedback')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Store') }} {{ __('keywords.Feedback') }}</span>
								</a>
							</div>
						<div class="menu-item {{ request()->is('driver_feedback/*') ? 'active' : ''}}">
								<a href="{{route('driver_feedback')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Feedback') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
				@endif
				@if($admin->callback ==1)
				 <div class="menu-item has-sub {{ request()->is('user_callback_requests') ? 'active' : ''}} {{ request()->is('store_callback_requests') ? 'active' : ''}} {{ request()->is('driver_callback_requests') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-phone"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Callback Requests') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
								<div class="menu-item {{ request()->is('user_callback_requests') ? 'active' : ''}}">
						<a href="{{route('user_callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Users') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
					<div class="menu-item {{ request()->is('store_callback_requests') ? 'active' : ''}}">
						<a href="{{route('store_callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Stores') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
					
					<div class="menu-item {{ request()->is('driver_callback_requests') ? 'active' : ''}}">
						<a href="{{route('driver_callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
						
						
						</div>
					</div>
			@endif
			@if($admin->settings ==1)
				<div class="menu-divider"></div>
					<div class="menu-header">{{ __('keywords.Settings') }}</div>
					<div class="menu-item {{ request()->is('global_settings') ? 'active' : ''}}">
						<a href="{{route('app_details')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-cog"></i></span>
							<span class="menu-text">{{ __('keywords.Settings') }}</span>
						</a>
					</div>
			@endif
			@if($admin->reason ==1)
					<div class="menu-item {{ request()->is('cancelling_reasons/*') ? 'active' : ''}}">
						<a href="{{route('can_res_list')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-list"></i></span>
							<span class="menu-text">{{ __('keywords.Cancelling Reasons') }}</span>
						</a>
					</div>
					@endif
				</div>
				<!-- END menu -->
			</div>
			<!-- END scrollbar -->
			
			<!-- BEGIN mobile-sidebar-backdrop -->
			<button class="app-sidebar-mobile-backdrop" data-dismiss="sidebar-mobile"></button>
			<!-- END mobile-sidebar-backdrop -->
		</div>
		<!-- END #sidebar -->
	
		@endif
