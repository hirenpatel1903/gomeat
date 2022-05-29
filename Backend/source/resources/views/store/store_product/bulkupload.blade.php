
@extends('admin.layout.app')
@section('content')
<div class="page-header">
    <div class="row align-items-center">
        <div class="col-auto">
            <!-- Page pre-title -->
            <h2 class="page-title">
                {{ __('keywords.Bulk Upload')}}
            </h2>
        </div>
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
<form method="post" class="validate" autocomplete="off" action="{{ route('bulk_upload') }}" enctype="multipart/form-data">
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
                      <li>{{ __('keywords.fill the cat id(Which is available in Category list) od subcategory(which has a parent category) in category_id column of csv file')}}.</li>
                      <li>{{ __('keywords.Insert tags in tags column separated by comma')}}.</li>
                      <li>{{ __('keywords.Please upload the images on images/products path inside your main project directory')}}.</li>
                      <li><a href="{{ asset('public/csv_sample/products.csv') }}">{{ __('keywords.Download Sample File')}}</a></li>
                   </ol>
                </div>
            </div>
        </div>  
            <div class="card">
                <div class="card-header bg-primary text-white">
                   <h5 class="panel-title">{{ __('keywords.Bulk Products Upload')}}</h5>
                </div>
                <div class="card-body">
                    {{ csrf_field() }}

                    <div class="row">
                        <div class="col">
                            
                            <input type="file" class="form-control " name="select_file" data-allowed-file-extensions="csv" required>
                            
                                                        
                        </div>

                  
                        <div class="col-md-12">
                            <hr>
                          <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-xs">{{ __('keywords.Import Products')}}</button>
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
                      <li>{{ __('keywords.fill the product id(Which is available in product list) in product_id column of csv file')}}.</li>
                       <li>{{ __('keywords.Insert tags in tags column separated by comma')}}.</li>
                      <li>{{ __('keywords.Please upload the images on images/products path inside your main project directory')}}.</li>
                      <li><a href="{{ asset('public/csv_sample/productsvarient.csv') }}">{{ __('keywords.Download Sample File')}}</a></li>
                   </ol>
                </div>
            </div>
        </div>  
    <form method="post" class="validate" autocomplete="off" action="{{ route('bulk_v_upload') }}"  action="#" enctype="multipart/form-data">
        
            <div class="card">
                {{ csrf_field() }}
                <div class="card-header bg-primary text-white">
                   <h5 class="panel-title">{{ __('keywords.Bulk Varient Upload')}}</h5>
                </div>
                <div class="card-body">

                    <div class="col">
                            
                             <input type="file" name="select_file"  data-allowed-file-extensions="csv" class="form-control" required/><br>
                                                        
                        </div>
                 
                        <div class="col-md-12">
                            <hr>
                          <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-xs">{{ __('keywords.Import Varients')}}</button>
                          </div>
                        </div>
                </div>
            </div>
            
        </form>
    </div></div>

</div>
</div>
@endsection

