@extends('store.layout.app')

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
      <h4 class="card-title ">{{ __('keywords.Order By Photo')}} {{ __('keywords.List')}}</h4>
    </div>
<div class="container"> <br> 
<table id="datatableDefault" class="table text-nowrap w-100 table-striped">
    <thead class="thead-light">
        <tr>
            <th>#</th>
            <th>{{ __('keywords.User')}}</th>
            <th>{{ __('keywords.Address')}}</th>
            <th>{{ __('keywords.Accept/Reject')}}</th>
        </tr>
    </thead>
    <tbody>
           @if(count($list)>0)
          @php $i=1; @endphp
          @foreach($list as $user)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$user->name}}<br>
           ({{$user->user_phone}})</td>
           <td>{{$user->receiver_name}},{{$user->house_no}},{{$user->landmark}},{{$user->state}},{{$user->pincode}}</td>
            <td>
               @if($user->processed == 0)
                 <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal1{{$user->ord_id}}">{{ __('keywords.View & Accept')}}</button>
           <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal2{{$user->ord_id}}">{{ __('keywords.Reject')}}</button>
           @else
           <span style="color:green"><b>{{ __('keywords.Accepted')}}</b></span>
           @endif
            </td>
        </tr>
 <!--/////////Accept orders///////////-->        
<div class="modal fade" id="exampleModal1{{$user->ord_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        	<div class="modal-dialog" role="document">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title" id="exampleModalLabel"><b>{{ __('keywords.View & Accept')}}</b></h5>
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
        						<span aria-hidden="true">&times;</span>
        					</button>
        			</div>
        			<div class="container"> <br> 
                       <div class="col-lg-12 text-center" align="center">
                          <img src="{{url($user->list_photo)}}" style="width:200 !important;"> 
                       </div><br>
                      <div class="col-lg-12 text-center" align="center">
                       <a href="{{route('store_accept_order', $user->ord_id)}}"  class="btn btn-primary pull-center">{{ __('keywords.Accept Order')}}</a>
                        </div><br>
                     </div>  
        		
        		</div>
        	</div>
        </div>
        
<!-----reject order with cause ------->
 <div class="modal fade" id="exampleModal2{{$user->ord_id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        	<div class="modal-dialog" role="document">
        		<div class="modal-content">
        			<div class="modal-header">
        				<h5 class="modal-title" id="exampleModalLabel">{{ __('keywords.Reject')}} {{ __('keywords.Order')}}</h5>
        					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
        						<span aria-hidden="true">&times;</span>
        					</button>
        			</div>
        			<!--//form-->
        		<form class="forms-sample" action="{{route('store_reject_orderbyphoto', $user->ord_id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
        			<div class="row">
        			  <div class="col-md-3" align="center"></div>  
                      <div class="col-md-6" align="center">
                          <br>
                        <div class="form-group">
                           <label>{{ __('keywords.Send Rejection Reason to User')}}</label>    
        		     	   <textarea class="form-control" name="cause" row="5" required></textarea>
        			    </div>
        			<button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button><br>
        			</div>
        			</div>
        			 <br> 
                    <div class="clearfix"></div>
        			</form>
        		
        		</div>
        	</div>
        </div>
        
        
          @php $i++; @endphp
                 @endforeach
                  @else
                    <tr>
                      <td colspan="4">{{ __('keywords.No data found')}}</td>
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
    <!--/////////reject orders///////////-->
 

    @endsection
</div>