@extends('admin.layout.app')
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
    
    <br>
   </div> 
<div class="col-lg-12">
<div class="card">    
<div class="card-header card-header-primary">
    <div class="row">
    <div class="col-md-6">
      <h1 class="card-title"><b>{{ __('keywords.Membership')}} {{ __('keywords.List')}}</b></h1>
      </div>
       <div class="col-md-6">
      <a href="{{route('AddMember')}}" class="btn btn-primary p-1 ml-auto" style="width:15%;float:right;padding: 3px 0px 3px 0px;">{{ __('keywords.Add')}}</a>
      </div>
       </div>
    </div>
<div class="container"> <br>     
<table id="datatableDefault" class="table text-nowrap w-100 table-striped">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
             <th>{{ __('keywords.Image')}}</th>
            <th>{{ __('keywords.Plan Name')}}</th>
            <th>{{ __('keywords.Plan Days')}}</th>
            <th>{{ __('keywords.Plan Price')}}</th>
            <th>{{ __('keywords.Free Delivery')}}</th>
            <th>{{ __('keywords.Instant Delivery')}}</th>
            <th>{{ __('keywords.Reward')}}</th>
            <th>{{ __('keywords.Description')}}</th>
            <th class="text-right">{{ __('keywords.Actions')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($member)>0)
          @php $i=1; @endphp
          @foreach($member as $cat)
        <tr>
            <td class="text-center">{{$i}}</td>
             <td><img src="{{$url_aws.$cat->image}}" alt="no image available" style="width:70px;"></td>
            <td>{{$cat->plan_name}}</td>
             <td>{{$cat->days}}</td>
             <td>{{$cat->price}}</td>
          @if($cat->free_delivery==1)
            <td><p style="color:green"><b>YES</b></p></td>
          @else
           <td><p style="color:red"><b>NO</b></p></td>
           @endif
           @if($cat->instant_delivery==1)
            <td><p style="color:green"><b>YES</b></p></td>
          @else
           <td><p style="color:red"><b>NO</b></p></td>
           @endif
          
            <td>{{$cat->reward}}<b>X</b></td>
             <td>{{$cat->plan_description}}</td>
            <td class="td-actions text-right">
                <a href="{{route('EditMember',$cat->plan_id)}}" rel="tooltip" class="btn btn-success">
                    <i class="fa fa-edit"></i>
                </a>
               <a href="{{route('DeleteMember',$cat->plan_id)}}" onClick="return confirm('Are you sure you want to permanently remove this Plan.')" rel="tooltip" class="btn btn-danger">
                    <i class="fa fa-trash"></i>
                </a>
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
<div>
</div>
</div>
@endsection
