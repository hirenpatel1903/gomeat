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
      <h1 class="card-title"><b>{{ __('keywords.Category')}} {{ __('keywords.List')}}</b></h1>
      </div>
       <div class="col-md-6">
      <a href="{{route('AddCategory')}}" class="btn btn-primary p-1 ml-auto" style="width:15%;float:right;padding: 3px 0px 3px 0px;">{{ __('keywords.Add')}}</a>
      </div>
       </div>
</div>
<div class="container"> <br>     
<table id="datatableDefault" class="table table-striped text-nowrap w-100">
    <thead class="thead-light">
        <tr>
            <th class="text-center">#</th>
            <th>{{ __('keywords.Title')}}</th>
            <th>{{ __('keywords.Category image')}}</th>
            <th>{{ __('keywords.Cat Id')}}</th>
            <th class="text-right">{{ __('keywords.Actions')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($category)>0)
          @php $i=1; @endphp
          @foreach($category as $cat)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$cat->title}}</td>
          
            <td><img src="{{$url_aws.$cat->image}}" alt="category image" style="width:50px; height:50px; border-radius:50%;"/></td>
            <td>{{$cat->cat_id}}</td>
            <td class="td-actions text-right">
                <a href="{{route('EditCategory',$cat->cat_id)}}" rel="tooltip" class="btn btn-success">
                    <i class="fa fa-edit"></i>
                </a>
               <a href="{{route('DeleteCategory',$cat->cat_id)}}" onClick="return confirm('Are you sure you want to permanently remove this Category.')" rel="tooltip" class="btn btn-danger">
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
   <div class="pull-right mb-1" style="float: right;">
  {{ $category->render("pagination::bootstrap-4") }}
</div>
</div>
</div>
</div>
</div>
</div>
<div>
</div>
</div>
@endsection
