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
             <div class="col-md-12">
              <div class="card">
                <div class="card-header card-header-primary">
                  <h4 class="card-title">{{ __('keywords.Update Stock')}}</h4>
                 </div>
                     <div class="container"> <br> 
                        <table id="datatableDefault" class="table text-nowrap w-100 table-striped">
                        <thead class="thead-light">
                            <tr>
                                <th class="text-center">#</th>
                                <th>{{ __('keywords.Product')}} {{ __('keywords.Name')}}</th>
                                <th>Id</th>
                                <th class="text-center">{{ __('keywords.Current Stock')}}</th>
                                <th class="text-center">{{ __('keywords.Add Stock')}}</th>
                                <th class="text-right">{{ __('keywords.Actions')}}</th>
                            </tr>
                        </thead>
                        <tbody>
                             
                              @if(count($selected)>0)
                      @php $i=1; @endphp
                      @foreach($selected as $sel)
                    <tr>
                        <td class="text-center">{{$i}}</td>
                        <td><p>{{$sel->product_name}}({{$sel->quantity}} {{$sel->unit}})</p></td>
                        <td><b>{{$sel->p_id}}</b></td>
                        <td>{{$sel->stock}}</td>
                        <td>
                            
                         <form class="forms-sample" action="{{route('stock_update', $sel->p_id)}}" method="post" enctype="multipart/form-data">
                          {{csrf_field()}}
                          <div class="col-md-12">
                          <div class="col-md-12" style="float:left">
                             <div class="form-group">
                              <label class="bmd-label-floating">{{ __('keywords.stock')}}</label>
                              <input type="number" name="stock" class="form-control" value="0">
                            </div>
                          </div><br>
                          <div class="form-group">
                             <button type="submit" class="btn btn-primary"> <i class="fa fa-plus"></i></button>
                             </div>
                          </form>
                          </div>
                        </td>
                        <td class="td-actions text-right">
                           <a href="{{route('delete_product', $sel->p_id)}}" rel="tooltip" class="btn btn-danger">
                                <i class="material-icons">close</i>
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
                      {{ $selected->render("pagination::bootstrap-4") }}
                    </div>
                    </div>
                </div>
              </div>
            </div>
			</div>
          </div>

@endsection




