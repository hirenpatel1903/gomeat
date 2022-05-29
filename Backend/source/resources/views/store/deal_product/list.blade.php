@extends('store.layout.app')
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
    <div class="row">
    <div class="col-md-6">
      <h1 class="card-title"><b>{{ __('keywords.Deal Products')}}</b></h1>
      </div>
       <div class="col-md-6">
      <a href="{{route('AddDeal')}}" class="btn btn-primary p-1 ml-auto" style="width:15%;float:right;padding: 3px 0px 3px 0px;">{{ __('keywords.Add')}}</a>
      </div>
       </div>
    </div>
<div class="container"><br>    
<table id="datatableDefault" class="table table-striped text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
            <th>{{ __('keywords.Product')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.Deal Price')}}</th>
            <th>{{ __('keywords.From Date')}}</th>
            <th>{{ __('keywords.To Date')}}</th>
            <th>{{ __('keywords.Status')}}</th>
            <th class="text-right">{{ __('keywords.Actions')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($deal_p)>0)
          @php $i=1; @endphp
          @foreach($deal_p as $deal)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$deal->product_name}} ({{$deal->quantity}}{{$deal->unit}})</td>
            <td>{{$deal->deal_price}}</td>
            <td>{{$deal->valid_from}}</td>
            <td>{{$deal->valid_to}}</td>
            @if($deal->valid_to > $currentdate && $currentdate >= $deal->valid_from)
            <td style="color:green">Ongoing</td>
            @endif
            @if($deal->valid_to < $currentdate)
            <td style="color:red">Expired</td>
            @endif
            @if($deal->valid_from > $currentdate)
            <td style="color:blue">Coming soon</td>
            @endif
          
            
            <td class="td-actions text-right">
                <a href="{{route('EditDeal',$deal->deal_id)}}" rel="tooltip" class="btn btn-success">
                    <i class="material-icons">edit</i>
                </a>
               <a href="{{route('DeleteDeal',$deal->deal_id)}}" onClick="return confirm('Are you sure you want to remove this Deal Product.')" rel="tooltip" class="btn btn-danger">
                    <i class="material-icons">close</i>
                </a>
            </td>
        </tr>
          @php $i++; @endphp
                 @endforeach
                  @else
                    <tr>
                      <td>No data found</td>
                    </tr>
                  @endif
    </tbody>
</table>
<div class="pull-right mb-1" style="float: right;">
  {{ $deal_p->render("pagination::bootstrap-4") }}
</div>
</div>
</div>
</div>
</div>
</div>
<div>
    </div>
    @endsection
</div>