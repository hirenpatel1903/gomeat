	<!-- BEGIN #sidebar -->
		<div id="sidebar" class="app-sidebar">
			<!-- BEGIN scrollbar -->
			<div class="app-sidebar-content" data-scrollbar="true" data-height="100%">
				<!-- BEGIN menu -->
				<div class="menu">
					<div class="menu-header">{{ __('keywords.Navigation') }}</div>
					<div class="menu-item {{ request()->is('store/home') ? 'active' : ''}}">
						<a href="{{route('storeHome')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-laptop"></i></span>
							<span class="menu-text">{{ __('keywords.Dashboard') }}</span>
						</a>
					</div>
					
					  	<div class="menu-divider"></div>
					  		<div class="menu-item {{ request()->is('store/service_societylist') ? 'active' : ''}}">
						<a href="{{route('ser_societylist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-marker"></i></span>
							<span class="menu-text">{{ __('keywords.Delivery Charges') }}</span>
						</a>
					</div>
						<div class="menu-item has-sub {{ request()->is('store/itemlist/requirement/today') ? 'active' : ''}} {{ request()->is('store/item-sales-report/last-30-days') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Reports') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						<div class="menu-item {{ request()->is('store/itemlist/requirement/today') ? 'active' : ''}}">
						<a href="{{route('reqfortoday')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-map"></i></span>
							<span class="menu-text">{{ __('keywords.Item Requirement') }}</span>
						</a>
					</div>
					<div class="menu-item {{ request()->is('store/item-sales-report/last-30-days') ? 'active' : ''}}">
						<a href="{{route('reqforthirty')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-map"></i></span>
							<span class="menu-text">{{ __('keywords.Item Sale Report') }} ({{ __('keywords.Last 30 Days')}})</span>
						</a>
				    	</div>
						
						</div>
					</div>
					 
					<div class="menu-item has-sub {{ request()->is('store/driver/Notification') ? 'active' : ''}}
					 {{ request()->is('store/notification/to-users') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-bell"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Send Notifications') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						    	<div class="menu-item {{ request()->is('store/notification/to-users') ? 'active' : ''}}">
								<a href="{{route('storeNotification')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Users') }}</span>
								</a>
							</div>
		
							<div class="menu-item {{ request()->is('store/driver/Notification') ? 'active' : ''}}">
								<a href="{{route('storeNotificationdriver')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Send Notification to Driver') }}</span>
								</a>
							</div>
						
						</div>
					</div>
					<div class="menu-item  {{ request()->is('store/coupon/*') ? 'active' : ''}}">
						<a href="{{route('couponlist')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-smile"></i></span>
							<span class="menu-text">{{ __('keywords.Coupon') }}</span>
						</a>
					</div>
				
					<div class="menu-item {{ request()->is('store/payout/request') ? 'active' : ''}}">
						<a href="{{route('payout_req')}}" class="menu-link">
							<span class="menu-icon"><i class="material-icons">layers</i></span>
							<span class="menu-text">{{ __('keywords.Send Payout Request') }}</span>
						</a>
					</div>
				
                   	<div class="menu-item has-sub {{ request()->is('store/storebannerlist') ? 'active' : ''}}
                   	{{ request()->is('store/secondary_bannerlist') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-image"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Banners') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						    	<div class="menu-item {{ request()->is('store/storebannerlist') ? 'active' : ''}}">
								<a href="{{route('storebannerlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Category Banner') }}</span>
								</a>
							</div>
		
							<div class="menu-item {{ request()->is('store/secondary_bannerlist') ? 'active' : ''}}">
								<a href="{{route('sec_bannerlist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Product Banner') }}</span>
								</a>
							</div>
						
						</div>
					</div>

				
					
					<div class="menu-item {{ request()->is('store/st/product/*') ? 'active' : ''}}">
						<a href="{{route('storeproductlist')}}" class="menu-link">
             
							<span class="menu-icon"><i class="fa fa-cubes"></i></span>
							<span class="menu-text">{{ __('keywords.Products') }}</span>
						</a>
					</div>

                 
					<div class="menu-item has-sub {{ request()->is('store/product/*') ? 'active' : ''}} {{ request()->is('store/stproducts/*') ? 'active' : ''}} 
					{{ request()->is('store/update/stock') ? 'active' : ''}}
					{{ request()->is('store/products/order_quantity') ? 'active' : ''}}
					{{ request()->is('store/deal/list') ? 'active' : ''}}
					{{ request()->is('store/spotlight/add') ? 'active' : ''}}
					{{ request()->is('store/bulk/upload') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-cubes"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Admin') }} {{ __('keywords.Category') }}/{{ __('keywords.Product') }} </span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item  {{ request()->is('store/product/*') ? 'active' : ''}}">
								<a href="{{route('sel_product')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Add Products') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/stproducts/*') ? 'active' : ''}}">
								<a href="{{route('stt_product')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Update Price/Mrp') }}</span>
								</a>
							</div>
							<div class="menu-item  {{ request()->is('store/update/stock') ? 'active' : ''}}">
								<a href="{{route('st_product')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Update Stock') }}</span>
								</a>
							</div>
								<div class="menu-item  {{ request()->is('store/products/order_quantity') ? 'active' : ''}}">
								<a href="{{route('stt_product2')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Update Order Quantity') }}</span>
								</a>
							</div>
							<div class="menu-item  {{ request()->is('store/deal/list') ? 'active' : ''}}">
								<a href="{{route('deallist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Deal Products') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/spotlight/add') ? 'active' : ''}}">
								<a href="{{route('spotlight_product')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Add Spotlight') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/bulk/upload') ? 'active' : ''}}">
								<a href="{{route('bulkuprice')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Bulk Update Price/Stock/Order Quantity') }}</span>
								</a>
							</div>
						

						</div>
					</div>

                 
                      	<div class="menu-item has-sub {{ request()->is('store/store/all_orders') ? 'active' : ''}}
					{{ request()->is('store/store/pending_orders') ? 'active' : ''}}
					{{ request()->is('store/store/cancelled_orders') ? 'active' : ''}}
					{{ request()->is('store/store/ongoing_orders') ? 'active' : ''}}
					{{ request()->is('store/store/out_for_delivery_orders') ? 'active' : ''}}
					{{ request()->is('store/store/payment_failed_orders') ? 'active' : ''}}
					{{ request()->is('store/store/completed_orders') ? 'active' : ''}}
					{{ request()->is('store/store_orders/today/all') ? 'active' : ''}}
					{{ request()->is('store/st/missed/orders') ? 'active' : ''}}
					{{ request()->is('store/orders/today') ? 'active' : ''}}
					{{ request()->is('store/orders/next_day') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-calendar"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Orders Management') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
						    <div class="menu-item {{ request()->is('store/store/all_orders') ? 'active' : ''}}">
								<a href="{{route('store_all_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.All orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('store/store/pending_orders') ? 'active' : ''}}">
								<a href="{{route('store_pen_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Pending orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('store/store/cancelled_orders') ? 'active' : ''}}">
								<a href="{{route('store_can_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Cancelled orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/store/ongoing_orders') ? 'active' : ''}}">
								<a href="{{route('store_on_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Ongoing orders') }}</span>
								</a>
							</div>
								<div class="menu-item {{ request()->is('store/store/out_for_delivery_orders') ? 'active' : ''}}">
								<a href="{{route('store_out_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Out For Delivery orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/store/payment_failed_orders') ? 'active' : ''}}">
								<a href="{{route('store_failed_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Payment Failed orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/store/completed_orders') ? 'active' : ''}}">
								<a href="{{route('store_com_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Completed orders') }}</span>
								</a>
							</div>
							
							<div class="menu-item {{ request()->is('store/st/missed/orders') ? 'active' : ''}}">
								<a href="{{route('st_missed_orders')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Missed Orders') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/store_orders/today/all') ? 'active' : ''}}">
								<a href="{{route('store_sales_today')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Day wise orders') }}</span>
								</a>
							</div>
							
						<div class="menu-item {{ request()->is('store/orders/today') ? 'active' : ''}}">
						<a href="{{route('storeassignedorders')}}" class="menu-link">
							<span class="menu-text">{{ __('keywords.Today Orders') }}</span>
						</a>
					</div>
					<div class="menu-item {{ request()->is('store/orders/next_day') ? 'active' : ''}}">
						<a href="{{route('storeOrders')}}" class="menu-link">
							<span class="menu-text">{{ __('keywords.Next-Day Orders') }}</span>
						</a>
					</div>
						
						</div>
					</div>
	             
	             	<div class="menu-item {{ request()->is('store/store/orderbyphoto') ? 'active' : ''}}">
						<a href="{{route('storeorder_byphoto')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-image"></i></span>
							<span class="menu-text">{{ __('keywords.Order By Photo') }}</span>
						</a>
					</div>
	            
					
                   <div class="menu-item has-sub {{ request()->is('store/d_boy/*') ? 'active' : ''}}
                   {{ request()->is('store/dboy_incentive') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-users"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Delivery Boy') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
							<div class="menu-item {{ request()->is('store/d_boy/*') ? 'active' : ''}}">
								<a href="{{route('store_d_boylist')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }}</span>
								</a>
							</div>
							<div class="menu-item {{ request()->is('store/dboy_incentive') ? 'active' : ''}}">
								<a href="{{route('store_boy_incentive')}}" class="menu-link">
									<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Incentive') }}</span>
								</a>
							</div>
						
						
						</div>
					</div>
				    <div class="menu-item has-sub {{ request()->is('store/callback_requests') ? 'active' : ''}}
				    {{ request()->is('store/st_driver_callback_requests') ? 'active' : ''}}">
						<a href="#" class="menu-link">
							<span class="menu-icon">
								<i class="fa fa-phone"></i>
							</span>
							<span class="menu-text">{{ __('keywords.Callback Requests') }}</span>
							<span class="menu-caret"><b class="caret"></b></span>
						</a>
						<div class="menu-submenu">
								<div class="menu-item {{ request()->is('store/callback_requests') ? 'active' : ''}}">
						<a href="{{route('callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Users') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
				
					<div class="menu-item {{ request()->is('store/st_driver_callback_requests') ? 'active' : ''}}">
						<a href="{{route('st_driver_callback_requests')}}" class="menu-link">
						
							<span class="menu-text">{{ __('keywords.Delivery Boy') }} {{ __('keywords.Callback Requests') }}</span>
						</a>
					</div>
						
						
						</div>
					</div>
                   <div class="menu-divider"></div>
					<div class="menu-header">{{ __('keywords.Settings') }}</div>
					<div class="menu-item {{ request()->is('store/store/timeslot') ? 'active' : ''}}">
						<a href="{{route('storetimeslot')}}" class="menu-link">
							<span class="menu-icon"><i class="fa fa-cog"></i></span>
							<span class="menu-text">{{ __('keywords.Store Settings') }}</span>
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
		

