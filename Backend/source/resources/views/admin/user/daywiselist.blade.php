@extends('admin.layout.app')
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

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
      <h1 class="card-title"><b>{{$title}}</b></h1>
      </div>
       <div class="col-md-6">
      <a href="{{route('userlist')}}" class="btn btn-primary p-1 ml-auto" style="width:15%;float:right;padding: 3px 0px 3px 0px;">{{ __('keywords.All Users')}}</a>
      </div>
       </div>
    </div>
     <div class="card-header card-header-secondary">
    <form class="forms-sample" action="{{route('daywise_reg')}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                     <div class="row">
                    
                       <div class="col-md-4">
                        <div class="form-group">
                          <label>{{ __('keywords.From Date')}}</label><br>
                          <input type="date" name="sel_date" class="form-control">
                        </div>
                      </div>
                       <div class="col-md-4">
                        <div class="form-group">
                          <label>{{ __('keywords.To Date')}}</label><br>
                          <input type="date" name="to_date" class="form-control">
                        </div>
                      </div>
                      <div class="col-md-4"><br>
                        <div class="form-group">
                            <label></label><br>
                          <button type="submit" value="SUBMIT" class="btn btn-primary">{{ __('keywords.Show Users')}}</button>
                        </div>
                      </div>
                    </div>   
            </form>
       </div><hr>
<div class="container"> <br> 
<table id="datatableDefault" class="table text-nowrap w-100 table-striped">
    <thead>
        <tr>
            <th>#</th>
            <th>{{ __('keywords.User')}} {{ __('keywords.Name')}}</th>
            <th>{{ __('keywords.User Phone')}}</th>
            <th>{{ __('keywords.User Email')}}</th>
            <th>{{ __('keywords.Registration Date')}}</th>
            <th>{{ __('keywords.Is Verified')}}</th>
            <th>{{ __('keywords.Active/Block')}}</th>
            <th>{{ __('keywords.Actions')}}</th>
             <th>{{ __('keywords.Details')}}</th>
        </tr>
    </thead>
     <tbody>
           @if(count($users)>0)
          @php $i=1; @endphp
          @foreach($users as $user)
        <tr>
            <td class="text-center">{{$i}}</td>
            <td>{{$user->name}}</td>
            <td>{{$user->user_phone}}</td>
            <td>{{$user->email}}</td>
            <td>{{$user->reg_date}}</td>
            @if($user->is_verified==0)
            <td class="td-actions text-center" style="color:red"><i class="fa fa-times-circle" style="color:red"></i></td>
            @else
            <td class="td-actions text-center" style="color:green"><i class="fa fa-check-circle" style="color:green"></i></td>
            @endif
            
               
            <td class="td-actions text-center">
                 @if($user->block==1)
               <a href="{{route('userunblock',$user->id)}}" rel="tooltip">
                    <i class="fa fa-ban" style="color:red;font-size:20px;"></i>
                </a>
                @else
                <a href="{{route('userblock',$user->id)}}" rel="tooltip">
                  <i class="fa fa-check-circle" style="color:green;font-size:20px;"></i>
                </a>
                @endif
                
               
            </td>
            <td> <button type="button" data-toggle="modal" data-target="#exampleModal1{{$user->id}}"><i class="fa fa-credit-card" style="color:green;"></i></button>&nbsp;
            <a href="{{route('ed_user',$user->id)}}" rel="tooltip" >
                  <i class="fa fa-edit" style="color:orange;"></i>
                </a>&nbsp;
                 <a href="{{route('del_userfromlist',$user->id)}}" rel="tooltip" onclick="return confirm('Are You sure! It will remove all the addresses & orders related to this User.')">
                    <i class="fa fa-trash" style="color:red;"></i>
                </a></td>
            <td>  <a href="{{route('mem_list',$user->id)}}" rel="tooltip" class="btn btn-primary">
                    {{ __('keywords.Details')}}
                </a></td>
        </tr>
          @php $i++; @endphp
                 @endforeach
                  @else
                    <tr>
                      <td>{{ __('keywords.No data found')}}</td>
                    </tr>
                  @endif
    </tbody>
</table><br>
<div class="pull-right mb-1" style="float: right;">
  {{ $users->render("pagination::bootstrap-4") }}
</div>
</div>  
</div>
</div>
</div>
</div>
<div>
          @foreach($users as $user)
        <div class="modal fade" id="exampleModal1{{$user->id}}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel"><b>{{$user->name}}</b></h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <br>
              <!--//form-->
              <form class="forms-sample" action="{{route('usr_recharge', $user->id)}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
              <div class="row">
                  
                <div class="col-md-3" align="center"></div>  
                      <div class="col-md-6" align="center">
                        <div class="form-group">
                        <label>{{ __('keywords.Enter Amount')}}</label>        
                  <input class="form-control" type="number" min="10" step="0.01" value="0" step ="0.01" name="amt"/>
              </div>
              <button type="submit" class="btn btn-primary pull-center">{{ __('keywords.Submit')}}</button>
              </div>
              </div>
                
                    <div class="clearfix"></div>
              </form>
              <!--//form-->
            </div>
          </div>
        </div>
 @endforeach
    </div>
<style>.buttons-html5 {
    color: white !important;
    background-color: #35d26d !important;
    border-radius: 5px;
    margin: 2px !important;
}
.buttons-print {
    color: white !important;
    background-color: #35d26d !important;
    border-radius: 5px;
    margin: 2px !important;
}</style>
<script>
        $(document).ready( function () {
    $('#myTable').DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'csv', 'excel', 'pdf', 'print'
        ]});
} );
    </script>
    @endsection
</div>