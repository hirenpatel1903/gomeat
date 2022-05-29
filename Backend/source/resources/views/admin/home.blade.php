@extends('admin.layout.app')

@section ('content')

<!-- BEGIN row -->
      <div class="row">
        <!-- BEGIN col-6 -->
        <div class="col-xl-6">
          <!-- BEGIN card -->
          <div class="card text-white-transparent-7 mb-3 overflow-hidden">
            <!-- BEGIN card-img-overlay -->
            <div class="card-img-overlay d-block d-lg-none bg-blue rounded"></div>
            <!-- END card-img-overlay -->
            
            <!-- BEGIN card-img-overlay -->
            <div class="card-img-overlay d-none d-md-block bg-blue rounded" style="background-image: url({{url('assets/theme_assets/img/bg/wave-bg.png')}}); background-position: right bottom; background-repeat: no-repeat; background-size: 100%;"></div>
            <!-- END card-img-overlay -->
            
            <!-- BEGIN card-img-overlay -->
            <div class="card-img-overlay d-none d-md-block bottom-0 top-auto">
              <div class="row">
                <div class="col-md-8 col-xl-6"></div>
                <div class="col-md-4 col-xl-6 mb-n2">
                  <img src="{{url('assets/theme_assets/img/page/dashboard.svg')}}" alt="" class="d-block ml-n3 mb-5" style="max-height: 310px" />
                </div>
              </div>
            </div>
            <!-- END card-img-overlay -->
            
            <!-- BEGIN card-body -->
            <div class="card-body position-relative">
              <!-- BEGIN row -->
              <div class="row">
                <!-- BEGIN col-8 -->
                <div class="col-md-8">
                  <!-- stat-top -->
                  <div class="d-flex">
                    <div class="mr-auto">
                      <h5 class="text-white-transparent-8 mb-3">{{ __('keywords.This Week Earning')}}</h5>
                      <h3 class="text-white mt-n1 mb-1">{{round($this_week,2)}}</h3>
                      <p class="mb-1 text-white-transparent-6 text-truncate">
                       @if($difference >= 0) <i class="fa fa-caret-up"></i>@else<i class="fa fa-caret-down"></i>@endif <b>{{round($difference,2)}} %</b>  @if($difference >= 0) {{ __('keywords.increase')}}@else {{ __('keywords.decrease')}} @endif {{ __('keywords.compare to last week')}}
                      </p>
                    </div>
                  </div>
                  
                  <hr class="hr-transparent bg-white-transparent-2 mt-3 mb-3" />
                  
                  <!-- stat-bottom -->
                  <div class="row">
                    <div class="col-6 col-lg-5">
                      <div class="mt-1">
                        <i class="fa fa-fw fa-shopping-bag fs-28px text-black-transparent-5"></i>
                      </div>
                      <div class="mt-1">
                        <div>{{ __('keywords.Store Earnings')}}</div>
                        <div class="font-weight-600 text-white">{{round($store_earnings,2)}}</div>
                      </div>
                    </div>
                    <div class="col-6 col-lg-5">
                      <div class="mt-1">
                        <i class="fa fa-fw fa-retweet fs-28px text-black-transparent-5"></i>
                      </div>
                      <div class="mt-1">
                        <div>{{ __('keywords.Admin Earnings')}}</div>
                        <div class="font-weight-600 text-white">{{round($admin_earnings,2)}}</div>
                      </div>
                    </div>
                  </div>
                  
                  <hr class="hr-transparent bg-white-transparent-2 mt-3 mb-3" />
                  
                  <div class="mt-3 mb-2">
                    <a href="{{route('finance')}}" class="btn btn-yellow btn-rounded btn-sm pl-5 pr-5 pt-2 pb-2 fs-14px font-weight-600"><i class="fa fa-wallet mr-2 ml-n2"></i>{{ __('keywords.Go To Store Earnings')}}</a>
                  </div>
                  <p class="fs-12px">
                    {{ __('keywords.It Takes You To The Store Earnings Section')}}.
                  </p>
                </div>
                <!-- END col-8 -->
                
                <!-- BEGIN col-4 -->
                <div class="col-md-4 d-none d-md-block" style="min-height: 380px;"></div>
                <!-- END col-4 -->
              </div>
              <!-- END row -->
            </div>
            <!-- END card-body -->
          </div>
          <!-- END card -->
        </div>
        <!-- END col-6 -->
        
        <!-- BEGIN col-6 -->
        <div class="col-xl-6">
          <!-- BEGIN row -->
          <div class="row">
            <!-- BEGIN col-6 -->
            <div class="col-sm-6">
              <!-- BEGIN card -->
              <div class="card mb-3 overflow-hidden fs-13px border-0 bg-gradient-custom-orange" style="min-height: 202px;">
                <!-- BEGIN card-img-overlay -->
                <div class="card-img-overlay mb-n4 mr-n4 d-flex" style="bottom: 0; top: auto;">
                  <img src="assets/img/icon/order.svg" alt="" class="ml-auto d-block mb-n3" style="max-height: 105px" />
                </div>
                <!-- END card-img-overlay -->
                
                <!-- BEGIN card-body -->
                <div class="card-body position-relative">
                  <h5 class="text-white-transparent-8 mb-3 fs-16px">{{ __('keywords.New Orders')}}</h5>
                  <h3 class="text-white mt-n1">{{$this_week_ord}}</h3>
                  <div class="progress bg-black-transparent-5 mb-2" style="height: 6px">
                       @if($diff_ord >= 0)
                   <div class="progrss-bar progress-bar-striped bg-white" style="width:<?php echo round($diff_ord,2)?>%" ></div>
                    @else
                     <div class="progrss-bar progress-bar-striped bg-red" style="width:<?php echo round($diff_ord,2)?>%"></div>
                     @endif
                  </div>
                  <div><div class="text-white-transparent-8 mb-4">  @if($diff_ord >= 0) <i class="fa fa-caret-up"></i>@else<i class="fa fa-caret-down"></i>@endif{{round($diff_ord,2)}} %  @if($diff_ord >= 0) {{ __('keywords.increase')}}@else {{ __('keywords.decrease')}} @endif<br />{{ __('keywords.compare to last week')}}</div>
                      </div>
                </div>
                <!-- BEGIN card-body -->
              </div>
              <!-- END card -->
              
              <!-- BEGIN card -->
              <div class="card mb-3 overflow-hidden fs-13px border-0 bg-gradient-custom-teal" style="min-height: 202px;">
                <!-- BEGIN card-img-overlay -->
                <div class="card-img-overlay mb-n4 mr-n4 d-flex" style="bottom: 0; top: auto;">
                  <img src="assets/img/icon/visitor.svg" alt="" class="ml-auto d-block mb-n3" style="max-height: 105px" />
                </div>
                <!-- END card-img-overlay -->
                
                <!-- BEGIN card-body -->
                <div class="card-body position-relative">
                  <h5 class="text-white-transparent-8 mb-3 fs-16px">{{ __('keywords.Cancelled Orders')}}</h5>
                  <h3 class="text-white mt-n1">{{$this_week_can}}</h3>
                  <div class="progress bg-black-transparent-5 mb-2" style="height: 6px">
                    @if($diff_can >= 0)
                   <div class="progrss-bar progress-bar-striped bg-white" style="width:<?php echo round($diff_can,2)?>%" ></div>
                    @else
                     <div class="progrss-bar progress-bar-striped bg-red" style="width:<?php echo round($diff_can,2)?>%"></div>
                     @endif
                  </div>
                  <div><div class="text-white-transparent-8 mb-4">  @if($diff_can >= 0) <i class="fa fa-caret-up"></i>@else<i class="fa fa-caret-down"></i>@endif{{round($diff_can,2)}} %  @if($diff_can >= 0) {{ __('keywords.increase')}}@else {{ __('keywords.decrease')}} @endif<br />{{ __('keywords.compare to last week')}}</div></div>
                </div>
                <!-- END card-body -->
              </div>
              <!-- END card -->
            </div>
            <!-- END col-6 -->
            
            <!-- BEGIN col-6 -->
            <div class="col-sm-6">
              <!-- BEGIN card -->
              <div class="card mb-3 overflow-hidden fs-13px border-0 bg-gradient-custom-pink" style="min-height: 202px;">
                <!-- BEGIN card-img-overlay -->
                <div class="card-img-overlay mb-n4 mr-n4 d-flex" style="bottom: 0; top: auto;">
                  <img src="assets/img/icon/email.svg" alt="" class="ml-auto d-block mb-n3" style="max-height: 105px" />
                </div>
                <!-- END card-img-overlay -->
                
                <!-- BEGIN card-body -->
                <div class="card-body position-relative">
                  <h5 class="text-white-transparent-8 mb-3 fs-16px">{{ __('keywords.Pending Orders')}}</h5>
                  <h3 class="text-white mt-n1">{{$this_week_pen}}</h3>
                  <div class="progress bg-black-transparent-5 mb-2" style="height: 6px">
                    @if($diff_pen >= 0)
                   <div class="progrss-bar progress-bar-striped bg-white" style="width:<?php echo round($diff_pen,2)?>%" ></div>
                    @else
                     <div class="progrss-bar progress-bar-striped bg-red" style="width:<?php echo round($diff_pen,2)?>%"></div>
                     @endif
                  </div>
                
                  <div><div class="text-white-transparent-8 mb-4">  @if($diff_pen >= 0) <i class="fa fa-caret-up"></i>@else<i class="fa fa-caret-down"></i>@endif{{round($diff_pen, 2)}} %  @if($diff_pen >= 0) {{ __('keywords.increase')}}@else {{ __('keywords.decrease')}} @endif<br />{{ __('keywords.compare to last week')}}</div></div>
                </div>
                <!-- END card-body -->
              </div>
              <!-- END card -->
              
              <!-- BEGIN card -->
              <div class="card mb-3 overflow-hidden fs-13px border-0 bg-gradient-custom-indigo" style="min-height: 202px;">
                <!-- BEGIN card-img-overlay -->
                <div class="card-img-overlay mb-n4 mr-n4 d-flex" style="bottom: 0; top: auto;">
                  <img src="assets/img/icon/browser.svg" alt="" class="ml-auto d-block mb-n3" style="max-height: 105px" />
                </div>
                <!-- end card-img-overlay -->
                
                <!-- BEGIN card-body -->
                <div class="card-body position-relative">
                  <h5 class="text-white-transparent-8 mb-3 fs-16px">{{ __('keywords.This Week')}} {{ __('keywords.App Users')}}</h5>
                  <h3 class="text-white mt-n1">{{$this_week_usr}}</h3>
                  <div class="progress bg-black-transparent-5 mb-2" style="height: 6px">
                    @if($diff_usr >= 0)
                   <div class="progrss-bar progress-bar-striped bg-white" style="width:<?php echo round($diff_usr,2)?>%" ></div>
                    @else
                     <div class="progrss-bar progress-bar-striped bg-red" style="width:<?php echo round($diff_usr,2)?>%"></div>
                     @endif
                  </div>
                  <div><div class="text-white-transparent-8 mb-4">  @if($diff_usr >= 0) <i class="fa fa-caret-up"></i>@else<i class="fa fa-caret-down"></i>@endif{{round($diff_usr,2)}} %  @if($diff_usr >= 0) {{ __('keywords.increase')}}@else {{ __('keywords.decrease')}} @endif<br />{{ __('keywords.compare to last week')}}</div></div>
                </div>
                <!-- END card-body -->
              </div>
              <!-- END card -->
            </div>
            <!-- BEGIN col-6 -->
          </div>
          <!-- END row -->
        </div>
        <!-- END col-6 -->


         
      </div>
      <!-- END row -->
      	<!-- BEGIN row -->
			<div class="row">
				<!-- BEGIN col-6 -->
				<div class="col-xl-6">
					<!-- BEGIN card -->
					<div class="card mb-3">
						<!-- BEGIN card-body -->
						<div class="card-body">
							<div class="d-flex align-items-center mb-4">
								<div class="flex-grow-1">
									<h5 class="mb-1">{{ __('keywords.Bestseller')}}</h5>
									<div class="fs-13px">{{ __('keywords.Top product sales this week')}}</div>
								</div>
							
							</div>
							@if(count($topselling)>0)
                               @php $i=1; @endphp
							@foreach($topselling as $topsellings)
							<?php
							$topselling1 = DB::table('store_orders')
							->join ('orders', 'store_orders.order_cart_id', '=', 'orders.cart_id')
                          ->select(DB::raw('count(store_orders.varient_id) as count'),DB::raw('SUM(store_orders.qty) as totalqty'),DB::raw('SUM(store_orders.price) as revenue'))
                          ->where('store_orders.varient_id',$topsellings->varient_id)
                           ->whereBetween('orders.delivery_date', [$to, $next_date])
                          ->first(); ?>
							<!-- product-1 -->
							<div class="d-flex align-items-center mb-3">
								<div class="d-flex align-items-center justify-content-center mr-3 width-50 height-50">
									<img src="{{$url_aws.$topsellings->varient_image}}" alt="" class="mw-100 mh-100" />
								</div>
								<div class="flex-grow-1">
									<div>
										<div class="text-dark font-weight-600">{{$topsellings->product_name}}</div>
										<div class="fs-13px">{{$topselling1->revenue}}</div>
									</div>
								</div>
								<div class="pl-3 text-center">
									<div class="text-dark font-weight-600">{{$topsellings->count}}</div>
									<div class="fs-13px">{{ __('keywords.sales')}}</div>
								</div>
							</div>
						@php $i++; @endphp
                                                         @endforeach
                                          @else
                                            <tr>
                                              <td>{{ __('keywords.No data found')}}</td>
                                            </tr>
                                          @endif
						
					
						</div>
						<!-- END card-body -->
					</div>
					<!-- END card -->
				</div>
				<!-- END col-6 -->
				
				<!-- BEGIN col-6 -->
				<div class="col-xl-6">
					<!-- BEGIN card -->
					<div class="card">
						<!-- BEGIN card-body -->
						<div class="card-body">
							<div class="d-flex align-items-center mb-2">
								<div class="flex-grow-1">
									<h5 class="mb-1">{{ __('keywords.Orders')}}</h5>
									<div class="fs-13px">{{ __('keywords.Latest order history')}}</div>
								</div>
							
							</div>
							
							<!-- BEGIN table-responsive -->
							<div class="table-responsive mb-n2">
								<table class="table table-borderless mb-0">
									<thead>
										<tr class="text-dark">
											<th class="pl-0">No</th>
											<th>Cart ID</th>
											<th>User Details</th>
											<th class="text-center">Status</th>
											<th class="text-right pr-0">Amount</th>
										</tr>
									</thead>
									<tbody>
									     @if(count($ongoin)>0)
                                           @php $i=1; @endphp
									    @foreach($ongoin as $ongoing)
										<tr>
											<td class="pl-0">{{$i}}</td>
											<td>
												<div class="d-flex align-items-center">
												
													<div class="ml-3 flex-grow-1">
														<div class="font-weight-600 text-dark">{{$ongoing->cart_id}}</div>
														<div class="fs-13px">{{$ongoing->delivery_date}}</div>
													</div>
													
												</div>
											</td>
											<td>
											    <div class="ml-3 flex-grow-1">
														<div class="font-weight-600 text-dark">{{$ongoing->name}}</div>
														<div class="fs-13px">{{$ongoing->user_phone}}</div>
													</div>
											</td>
											<td class="text-center">@if($ongoing->order_status=="Pending")<span class="label bg-warning-transparent-2 text-warning" style="min-width: 60px;padding: 5px;border-radius: 11px;">@endif 
											@if($ongoing->order_status=="Confirmed")<span class="label bg-success-transparent-2 text-success" style="min-width: 60px;padding: 5px;border-radius: 11px;">@endif
											@if($ongoing->order_status=="Completed")<span class="label bg-success-transparent-2 text-success" style="min-width: 60px;padding: 5px;border-radius: 11px;">@endif
											@if($ongoing->order_status=="Cancelled")<span class="label text-dark-transparent-5" style="min-width: 60px;padding: 5px;border-radius: 11px;">@endif
											@if($ongoing->order_status=="Out For Delivery")<span class="label bg-success-transparent-2 text-success" style="min-width: 60px;    padding: 5px;border-radius: 11px;">@endif
											{{$ongoing->order_status}}</span></td>
											<td class="text-right pr-0">	{{$ongoing->total_price}}</td>
										</tr>
									     @php $i++; @endphp
                                                         @endforeach
                                          @else
                                            <tr>
                                              <td>{{ __('keywords.No data found')}}</td>
                                            </tr>
                                          @endif
									</tbody>
								</table>
							</div>
							<!-- END table-responsive -->
						</div>
						<!-- END card-body -->
					</div>
					<!-- END card -->
				</div>
				<!-- END col-6 -->
			</div>
			<!-- END row -->
   
@endsection
