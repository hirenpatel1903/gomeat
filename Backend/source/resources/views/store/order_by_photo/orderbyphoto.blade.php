@extends('store.layout.app')
<link href="{{url('assets/select/styles/multiselect.css')}}" rel="stylesheet"/>
	<script src="{{url('assets/select/scripts/multiselect.min.js')}}"></script>
	<style>
		/* example of setting the width for multiselect */
		#testSelect1_multiSelect {
			width: 100%;
		}
		.multiselect-wrapper .multiselect-list {
    padding: 5px;
    min-width: 91%;
    position:inherit !important;
}
	</style>
@section ('content')
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
            <div class="col-md-5">
              <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Select')}} {{ __('keywords.Products')}}</h4></div>
                  <div class="col-md-12" align="center"><img src="{{url($u->list_photo)}}" style="width:200px !important"></div>
         <form class="forms-sample" action="{{route('listadded_product')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                
                <div class="card-body">
                       <input type="hidden" value="{{$u->ord_id}}" name="pic_id" >
                       <input type="hidden" value="{{$u->user_id}}" name="user_id" >
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Select Products for add to cart')}}</label><br>
                        <select  id='testSelect1' class='form-control' multiple="multiple" id="eightieth" data-opened="true" name="prod[]">
                          @foreach($products as $product)
                          <option value="{{$product->varient_id}}">{{$product->product_name}}({{$product->quantity}}{{$product->unit}})</option>
                          @endforeach
                        </select>
                  
                        </div>
                      </div>

                    </div>

                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
             <div class="col-md-7">
              <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">User Cart</h4>
                  <form class="forms-sample" action="{{route('process_orderby', $u->ord_id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                    <button type="submit" class="btn btn-primary">{{ __('keywords.Process')}} {{ __('keywords.Order')}}</button> 
                    </form>
                 </div><br>
                  <div class="container">
                     <table id="datatableDefault" class="table text-nowrap w-100 table-striped">
                        <thead>
                            <tr>
                                <th class="text-center">#</th>
                                <th>{{ __('keywords.Product')}} {{ __('keywords.Name')}}</th>
                                <th class="text-center">{{ __('keywords.Order Qty')}}</th>
                                <th class="text-right">{{ __('keywords.Actions')}}</th>
                            </tr>
                        </thead>
                        <tbody>
                             
                    @if(count($selected)>0)
                      @php $i=1; @endphp
                      @foreach($selected as $sel)
                    <tr>
                        <td class="text-center">{{$i}}</td>
                        <td><p>{{$sel->product_name}}({{$sel->quantity}} {{$sel->unit}})</p></td>
                        <td align="center"> 
                        <form class="forms-sample" action="{{route('add_qty_to_cart', $sel->l_cid)}}" method="post" enctype="multipart/form-data">
                          {{csrf_field()}}
                          <div class="col-md-12">
                          <div class="col-md-8" style="float:left">
                             <div class="form-group">
                              <input type="number" name="stock" class="form-control" value="{{$sel->l_qty}}" >
                            </div>
                          </div>
                          <div class="col-md-4" style="float:left;margin-left: -20px;">
                          <button type="submit" style="border:none;background-color:transparent;float:left;width: 40px !important;height: 40px;border-radius: 50%;"><i class="material-icons">add</i></button>
                            </div>
                            </form>
                        </td>
                        <td class="td-actions text-right">
                           <a href="{{route('delete_product_from_cart', $sel->l_cid)}}" rel="tooltip" class="btn btn-danger">
                                <i class="material-icons">close</i>
                            </a>
                        </td>
                    </tr>
                      @php $i++; @endphp
                             @endforeach
                              @else
                                <tr>
                                  <td colspan="4">{{ __('keywords.No data found')}}</td>
                                </tr>
                              @endif
                        </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
			</div>
          </div>   
       <script>
	document.multiselect('#testSelect1')
		.setCheckBoxClick("checkboxAll", function(target, args) {
			console.log("Checkbox 'Select All' was clicked and got value ", args.checked);
		})
		.setCheckBoxClick("1", function(target, args) {
			console.log("Checkbox for item with value '1' was clicked and got value ", args.checked);
		});

	function enable() {
		document.multiselect('#testSelect1').setIsEnabled(true);
	}

	function disable() {
		document.multiselect('#testSelect1').setIsEnabled(false);
	}
</script>      
          
@endsection




