@extends('admin.layout.app')
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

<style>
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
      <h4 class="card-title ">{{ __('keywords.Store')}} {{ __('keywords.Feedback')}}</h4>
    </div>
<div class="container">   
<table id="datatableDefault" class="table table-striped text-nowrap w-100">
    <thead>
        <tr>
            <th class="text-center">#</th>
                      <th>{{ __('keywords.Store')}}</th>
                      <th>{{ __('keywords.Feedback')}}</th>
                    </thead>
                    <tbody>
                         @if(count($feedback)>0)
                          @php $i=1; @endphp
                          @foreach($feedback as $feed)
                            <tr>
                                <td class="text-center">{{$i}}</td>
                                
                                <td>{{$feed->store_name}} ({{$feed->phone_number}})</td>
                                    <td>{{$feed->query}}</td>
                                
                            </tr>      
                        @php $i++; @endphp
                        @endforeach
                      @else
                        <tr>
                          <td colspan="3">{{ __('keywords.No data found')}}</td>
                        </tr>
                      @endif  
                    </tbody>
</table><br>
<div class="pull-right mb-1" style="float: right;">
  {{ $feedback->render("pagination::bootstrap-4") }}
</div>
</div> 
</div>
</div>
</div>
</div>
<div>
    </div>
    <script>
        $(document).ready( function () {
    $('#myTable').DataTable();
} );
    </script>
    @endsection
</div>