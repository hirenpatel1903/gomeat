@extends('store.layout.app')
<style>
   
    .material-icons{
        margin-top:0px !important;
        margin-bottom:0px !important;
    }
        .dt-buttons > button.btn.btn-secondary {
    background-color: grey;
    margin: 1px;
    border-radius: 5px;
    color: white;
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
      <h4 class="card-title ">{{$title}}</h4>
    </div>
       <div class="card-header card-header-secondary">
    <form class="forms-sample" action="{{route('datewise_itemsales')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                     <div class="row">
                       <div class="col-md-6"><br>
                        <div class="form-group">
                          <label>{{ __('keywords.Date')}}</label><br>
                          <input type="date" name="sel_date" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-6">
                        <div class="form-group">
                          <button type="submit"  style="margin-bottom: 13px;margin-top: 10px;" class="btn btn-primary">{{ __('keywords.Show Item-List')}}</button>
                        </div>
                      </div>
                    </div>  
            </form>
       </div><hr>
<div class="container"> <br> 
<table id="datatableDefault" class="table text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th>#</th>
            <th>{{ __('keywords.Product')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.Item')}} {{ __('keywords.Quantity')}} {{ __('keywords.Requirement')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($ord)>0)
          @php $i=1; @endphp
          @foreach($ord as $ords)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$ords->product_name}}</td>
            
            <td>@foreach($det as $dets)
                @if($dets->product_id == $ords->product_id)
                {{$dets->quantity}}{{$dets->unit}} * {{$dets->count* $dets->sumqty}}<b>({{$dets->quantity*$dets->count*$dets->sumqty}}{{$dets->unit}})</b> |
                @endif
                @endforeach</td>

            
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
<div>
    </div>
    @endsection
</div>