@extends('admin.layout.app')
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
            <div class="col-md-12">
          
               <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Notification to Store')}}</h4>
                  <form class="forms-sample" action="{{route('adminNotificationSendtostore')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                     <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Select Stores')}}</label><br>
                          <select id='testSelect1' name="st[]"  class="form-control" multiple>
                              
                             @foreach($store as $stores)
                          <option value="{{$stores->id}}">{{$stores->store_name}}({{$stores->city}})</option>
                          @endforeach
                            </select>
                        </div>
                      </div>
                       <div class="col-md-12">
                        <div class="form-group">
                          <label>{{ __('keywords.Title')}}</label>
                          <input type="text" name="notification_title" class="form-control">
                        </div>
                      </div>
                      
                       <div class="col-md-12">
                        <div class="form-group">
                          <label>{{ __('keywords.Message')}}</label>
                          <textarea name="notification_text" class="form-control"></textarea>
                        </div>
                      </div>
                      <div class="col-md-12">
                        <label class="bmd-label-floating">{{ __('keywords.Image')}} ({{ __('keywords.1000 KB')}})</label>
                        <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="notify_image" accept="image/*"/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                      </div>
                    </div><br>
                    
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Send Notification to Store')}}</button>
                    <div class="clearfix"></div>
                  </form>
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


