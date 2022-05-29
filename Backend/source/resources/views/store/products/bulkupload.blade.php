@extends('store.layout.app')
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/switchery/0.8.2/switchery.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/switchery/0.8.2/switchery.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

<style>
.card-header.bg-primary.text-white {
    border-radius: 10px;
}
    .material-icons{
        margin-top:0px !important;
        margin-bottom:0px !important;
    }
    a:hover {
 cursor:pointer;
}

</style>
@section ('content')

<div class="page-header">
    <div class="row align-items-center">
        <!-- Page title actions -->
        <div class="col-auto ml-auto d-print-none">

        </div>
    </div>
</div>
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
<div class="col-12">
<form method="post" class="validate" autocomplete="off" action="{{route('bulk_uploadprice')}}" enctype="multipart/form-data">
    <div class="row">
        <div class="col-md-6">
         <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                   <h5>{{ __('keywords.Instructions')}}</h5>
                </div>
                <div class="card-body">
                    <ol class="pl-3">
                      <li>{{ __('keywords.Only CSV file are allowed')}}.</li>
                      <li>{{ __('keywords.First row need to keep blank or use for column name only')}}.</li>
                      <li>{{ __('keywords.All fields are must needed in csv file')}}.</li>
                      <li>{{ __('keywords.fill the id(Which is available in Update Stock section or Update Price/Mrp Section) in product_id column of csv file')}}.</li>
                      <li><a href="{{ asset('public/csv_sample/priceupdate.csv') }}" download="priceupdate.csv">{{ __('keywords.Download Sample File')}}</a></li>
                   </ol>
                </div>
            </div>
        </div>  
            <div class="card">
                <div class="card-header bg-primary text-white">
                   <h5 class="panel-title">{{ __('keywords.Bulk Price Update')}}</h5>
                </div>
                <div class="card-body">
                    {{ csrf_field() }}

                    <div class="row">
                        <div class="col">
                           <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="select_file" data-allowed-file-extensions="csv" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                            
                                                        
                        </div><br>

                  
                        <div class="col-md-12">
                            <hr>
                          <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-xs">{{ __('keywords.Bulk Price Update')}}</button>
                          </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div class="col-md-6">
         <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                   <h5>{{ __('keywords.Instructions')}}</h5>
                </div>
                <div class="card-body">
                   <ol class="pl-3">
                      <li>{{ __('keywords.Only CSV file are allowed')}}.</li>
                      <li>{{ __('keywords.First row need to keep blank or use for column name only')}}.</li>
                      <li>{{ __('keywords.All fields are must needed in csv file')}}.</li>
                      <li>{{ __('keywords.fill the id(Which is available in Update Stock section or Update Price/Mrp Section) in product_id column of csv file')}}.</li>
                      <li><a href="{{ asset('public/csv_sample/stockupdate.csv') }}" download="stockupdate.csv">{{ __('keywords.Download Sample File')}}</a></li>
                   </ol>
                </div>
            </div>
        </div>  
    <form method="post" class="validate" autocomplete="off" action="{{ route('bulk_uploadstock') }}"  action="#" enctype="multipart/form-data">
        
            <div class="card">
                {{ csrf_field() }}
                <div class="card-header bg-primary text-white">
                   <h5>{{ __('keywords.Bulk Stock Update')}}</h5>
                </div>
                <div class="card-body">

                    <div class="col">
                            
                              <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="select_file" data-allowed-file-extensions="csv" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                                                        
                        </div>
                 
                        <div class="col-md-12">
                            <br>
                          <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-xs">{{ __('keywords.Bulk Stock Update')}}</button>
                          </div>
                        </div>
                </div>
            </div>
            
        </form>
    </div></div>
   
     <div class="col-md-12">
         <div class="col-md-12">
            <div class="card">
                <div class="card-header bg-primary text-white">
                   <h5>{{ __('keywords.Instructions')}}</h5>
                </div>
                <div class="card-body">
                   <ol class="pl-3">
                      <li>{{ __('keywords.Only CSV file are allowed')}}.</li>
                      <li>{{ __('keywords.First row need to keep blank or use for column name only')}}.</li>
                      <li>{{ __('keywords.All fields are must needed in csv file')}}.</li>
                      <li>{{ __('keywords.fill the id(Which is available in Update Stock section or Update Price/Mrp Section or Update order Quantity section) in product_id column of csv file')}}.</li>
                      <li><a href="{{ asset('public/csv_sample/quantityupdate.csv') }}" download="quantityupdate.csv">{{ __('keywords.Download Sample File')}}</a></li>
                   </ol>
                </div>
            </div>
        </div>  
    <form method="post" class="validate" autocomplete="off" action="{{ route('importquantity') }}"  action="#" enctype="multipart/form-data">
        
            <div class="card">
                {{ csrf_field() }}
                <div class="card-header bg-primary text-white">
                   <h5>{{ __('keywords.Bulk Order Quantity Update')}}</h5>
                </div>
                <div class="card-body">

                    <div class="col">
                            
                            <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="select_file" data-allowed-file-extensions="csv" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                                                        
                        </div>
                 
                        <div class="col-md-12">
                            <br>
                          <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-xs">{{ __('keywords.Bulk Quantity Update')}}</button>
                          </div>
                        </div>
                </div>
            </div>
            
        </form>
    </div>
</div>
</div>









     
    @endsection