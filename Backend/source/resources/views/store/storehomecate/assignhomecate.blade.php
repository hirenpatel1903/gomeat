@extends('store.layout.app')
<link rel="stylesheet" href="{{url('assets/fsselect/fstdropdown.css')}}">
<style>
.selecteeee {
    width: 100%;
    height: 450px;
}
.fstdropdown > .fstlist {
    display: none;
    max-height: 430px !important;
    overflow-y: auto;
    overflow-x: hidden;
}
.table .td-actions .btn {
    margin: 0px;
    height: 25px;
    padding: 25px 8px 11px 8px !important;
}
</style>
@section ('content')


        <div class="content-wrapper">
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
            <div class="col-md-6 grid-margin stretch-card">
              <div class="card">
                    <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Assign')}} {{ __('keywords.Categoryies')}} {{ __('keywords.to')}} {{ __('keywords.Home Category')}} {{ __('keywords.Group')}}</h4>
                  
                </div>
                <div class="card-body">
                  @if (count($errors) > 0)
                      @if($errors->any())
                        <div class="alert alert-primary" role="alert">
                          {{$errors->first()}}
                          <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">×</span>
                          </button>
                        </div>
                      @endif
                  @endif
                  <form class="forms-sample" action="{{route('storeInsertAssignHomeCategory')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                    <div class="form-group">
                      <label class="bmd-label-floating">{{ __('keywords.Home Category')}} {{ __('keywords.Group')}} {{ __('keywords.Title')}}</label>
                     
                      <div class="input-group col-xs-12">
                      <input type="text" name="homecate_name" value="{{ $homecat->homecat_name }}" class="form-control"  required readonly>
                      <input type="hidden" name="homecat_id" value="{{$homecat->homecat_id }}">
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="bmd-label-floating" for="exampleInputName1">{{ __('keywords.All')}} {{ __('keywords.Categories')}}</label>
                        <select class='fstdropdown-select' style="max-height: 500px;" multiple="multiple" id="eightieth" data-opened="true" name="selectedcat[]">
                          @foreach($cityadminCategory as $category)
                           <option value="<?= $category->cat_id ?>" <?php if (in_array($category->cat_id, $aci)){ echo "style='background: #eaecf4;' disabled selected"; } ?> ><?= $category->title ?> ({{$category->title}})
                                </option>
                          @endforeach
                        </select>

                        </div>
                      
                    
                    <button type="submit" class="btn btn-success mr-2">{{ __('keywords.Submit')}}</button>
                    <a href="{{route('storehomecate')}}" class="btn btn-light">{{ __('keywords.Close')}}</a>
                  </form>
                </div>
              </div>
            </div>
            
            <div class="col-md-6 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
          <thead>
            <tr>
            <th>#</th>
            <th align="center">{{ __('keywords.Category')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.Action')}}</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
            <th>#</th>
            <th align="center">{{ __('keywords.Category')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.Action')}}</th>
            </tr>
          </tfoot>
          <tbody>
          @if(count($assigned_categoroy_list)>0)
          @php $i=1; @endphp
          @foreach($assigned_categoroy_list as $HomeCategory)
        <tr>
            <td>{{$i}}</td>
            <td>{{$HomeCategory->title}}</td>
            <td>
              <a href="{{route('storeDeleteAssignHomeCategory', [$HomeCategory->assign_id])}}" class="btn btn-danger">{{ __('keywords.Delete')}}</a>
            </td>
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
    </div>
                </div>
            </div>
          </div>
        </div>
</div>
 @endsection
 <script src="{{url('assets/fsselect/fstdropdown.js')}}"></script>
    <script>
        function setDrop() {
            if (!document.getElementById('third').classList.contains("fstdropdown-select"))
                document.getElementById('third').className = 'fstdropdown-select';
            setFstDropdown();
        }
        setFstDropdown();
        function removeDrop() {
            if (document.getElementById('third').classList.contains("fstdropdown-select")) {
                document.getElementById('third').classList.remove('fstdropdown-select');
                document.getElementById("third").fstdropdown.dd.remove();
            }
        }
        function addOptions(add) {
            var select = document.getElementById("fourth");
            for (var i = 0; i < add; i++) {
                var opt = document.createElement("option");
                var o = Array.from(document.getElementById("fourth").querySelectorAll("option")).slice(-1)[0];
                var last = o == undefined ? 1 : Number(o.value) + 1;
                opt.text = opt.value = last;
                select.add(opt);
            }
        }
        function removeOptions(remove) {
            for (var i = 0; i < remove; i++) {
                var last = Array.from(document.getElementById("fourth").querySelectorAll("option")).slice(-1)[0];
                if (last == undefined)
                    break;
                Array.from(document.getElementById("fourth").querySelectorAll("option")).slice(-1)[0].remove();
            }
        }
        function updateDrop() {
            document.getElementById("fourth").fstdropdown.rebind();
        }
    </script>
