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
                  <h4 class="card-title">{{ __('keywords.Notification to Users')}}</h4>
                  <form class="forms-sample" action="{{route('storeNotificationSend')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">
                     <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
                          <label class="bmd-label-floating">{{ __('keywords.Select Users')}}</label><br>
                            <select id='testSelect1'name="user[]"  class="form-control" multiple>
                              
                              @foreach($users as $user)
                          <option value="{{$user->id}}"><b style="color:white !important">{{$user->name}}  (</b>{{$user->society_name}}<b>)</b></option>
                          @endforeach
                            </select>
                        </div>
                      </div>
            
                       <div class="col-md-12">
                        <div class="form-group">
                          <label>{{ __('keywords.Title')}}</label>
                          <input type="text" name="title" class="form-control">
                        </div>
                      </div>
                       <div class="col-md-12">
                        <div class="form-group">
                          <label>{{ __('keywords.Message')}}</label>
                          <textarea name="text" class="form-control"></textarea>
                        </div>
                      </div>
                      <div class="col-md-12">
                        <div>
                          <label>{{ __('keywords.Image')}}</label>
                             <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="image" accept="image/*"/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                        </div>
                      </div>
                    </div><br>
                    <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Send Notification to App Users')}}</button>
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

