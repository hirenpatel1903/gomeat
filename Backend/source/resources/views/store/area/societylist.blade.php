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

    .btn{
        height:27px !important;
    }
    .material-icons{
        margin-top:0px !important;
        margin-bottom:0px !important;
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

<div class="col-lg-12">
              <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Select Your Serviceable area')}}</h4>
                  
         <form class="forms-sample" action="{{route('ser_societyadddd')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">

                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Select Your Serviceable area')}}</label><br>
                        <select id='testSelect1' name="society[]"  class="form-control" multiple>
                          @foreach($area as $areas)
                          <option value="{{$areas->society_id}}">{{$areas->society_name}}</option>
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
			<hr><br>
<div class="card">  
   <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Update Delivery Charges')}}</h4></div>
    <div class="container"> <br> 

<table id="datatableDefault" class="table text-nowrap w-100 table-striped">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
            <th>{{ __('keywords.Society')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.City')}} {{ __('keywords.Name')}}</th>
             <th>{{ __('keywords.Delivery')}} {{ __('keywords.Charge')}}</th>
            <th class="text-center">{{ __('keywords.Actions')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($city)>0)
          @php $i=1; @endphp
          @foreach($city as $cities)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$cities->society_name}}</td>
            <td>{{$cities->city_name}}</td>
             <td>{{$cities->delivery_charge}}</td>
            <td class="td-actions text-center">
                <a href="{{route('ser_societyedit',$cities->ser_id)}}" rel="tooltip" class="btn btn-success">
                    <i class="fa fa-edit"></i>
                </a>
                @if($cities->enabled==1)
               <a href="{{route('ser_delete',$cities->ser_id)}}"  onClick="return confirm('Are you sure you want to remove this area from your service area.')" rel="tooltip" class="btn btn-danger">
                    <i class="fa fa-trash"></i>
                </a>
                @else
                <a href="{{route('ser_societycheck',$cities->ser_id)}}"  onClick="return confirm('This area will be added to your service area.')" rel="tooltip" class="btn btn-primary">
                    <i class="fa fa-check"></i>
                </a>
                @endif
            </td>
        </tr>
          @php $i++; @endphp
                 @endforeach
                  @else
                    <tr>
                      <td colspan="5">{{ __('keywords.No data found')}}</td>
                    </tr>
                  @endif
    </tbody>
</table>
</div>
</div>
</div>
</div>
</div>
<div>
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
</div>