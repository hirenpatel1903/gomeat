@extends('store.layout.app')

@section ('content')


<!-- Begin Page Content -->
<div class="container-fluid">
 
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
  <!-- DataTales Example -->
  <div class="card shadow mb-4">
        <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Store')}} {{ __('keywords.Home Category')}} {{ __('keywords.List')}}</h4>
                  
                </div>
      <div class="card-header py-3">
      <h6 class="m-0 font-weight-bold text-primary"></h6>
          @if(count($home)==0)
        <a class="btn btn-success m-auto" style="float: right;" href="{{route('AddHomeCategory')}}">{{ __('keywords.Add')}}</a>
        @endif
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-bordered" id="example9" width="100%" cellspacing="0">
          <thead>
            <tr>
            <th>{{ __('keywords.S.No')}}</th>
            <th>{{ __('keywords.Home Category')}} {{ __('keywords.Name')}}</th>
            <th align="center">{{ __('keywords.Home Category')}} {{ __('keywords.Order')}}</th>
            <th>{{ __('keywords.Action')}}</th>
            </tr>
          </thead>
          <tfoot>
            <tr>
            <th>{{ __('keywords.S.No')}}</th>
            <th>{{ __('keywords.Home Category')}} {{ __('keywords.Name')}}</th>
            <th align="center">{{ __('keywords.Home Category')}} {{ __('keywords.Order')}}</th>
            <th>{{ __('keywords.Action')}}</th>
            </tr>
          </tfoot>
          <tbody>
          @if(count($home)>0)
          @php $i=1; @endphp
          @foreach($home as $HomeCategory)
        <tr>
            <td>{{$i}}</td>
            <td>{{$HomeCategory->homecat_name}}</td>
            
            <td align="center">{{$HomeCategory->order}}</td>
            <td>
              <a href="{{route('HomecateEditCategory', [$HomeCategory->homecat_id])}}" class="btn btn-primary">Edit</a>
            
              <a href="{{route('AssignHomeCategory', [$HomeCategory->homecat_id])}}" class="btn btn-success">Assign</a>
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
<!-- /.container-fluid -->
</div>


@endsection