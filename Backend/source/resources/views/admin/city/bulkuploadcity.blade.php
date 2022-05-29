
@extends('admin.layout.app')
<style>
    .card-header.bg-primary.text-white {
    border-radius: 10px;
}
</style>
@section('content')
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
<form method="post" class="validate" autocomplete="off" action="{{ route('importcity') }}" enctype="multipart/form-data">
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
                      <li><a style="color:blue" href="{{ asset('public/csv_sample/cities.csv') }}" download="products.csv">{{ __('keywords.Download Sample File')}}</a></li>
                   </ol>
                </div>
            </div>
        </div>  
            <div class="card">
                <div class="card-header bg-primary text-white">
                   <h5 class="panel-title">{{ __('keywords.Bulk Cities Upload')}}</h5>
                </div>
                <div class="card-body">
                    {{ csrf_field() }}

                    <div class="row">
                        <div class="col">
                            
                           <div class="custom-file">
                            <input type="file" class="custom-file-input" id="customFile" name="select_file" data-allowed-file-extensions="csv" required/>
                            <label class="custom-file-label" for="customFile">Choose file</label>
                          </div>
                                                        
                        </div>

                  
                        <div class="col-md-12">
                            <br>
                          <div class="form-group">
                            <button type="submit" class="btn btn-primary btn-xs">{{ __('keywords.Import Cities')}}</button>
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
                      <li>{{ __('keywords.fill the city id(Which is available in city list section) in city_id column of csv file')}}.</li>
                      <li><a style="color:blue" href="{{ asset('public/csv_sample/society.csv') }}"  download="products_varient.csv">{{ __('keywords.Download Sample File')}}</a></li>
                   </ol>
                </div>
            </div>
        </div>  
    <form method="post" class="validate" autocomplete="off" action="{{ route('importsociety') }}"  action="#" enctype="multipart/form-data">
        
            <div class="card">
                {{ csrf_field() }}
                <div class="card-header bg-primary text-white">
                   <h5 class="panel-title">{{ __('keywords.Bulk Society Upload')}}</h5>
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
                            <button type="submit" class="btn btn-primary btn-xs">{{ __('keywords.Import Society')}}</button>
                          </div>
                        </div>
                </div>
            </div>
            
        </form>
    </div></div>

</div>
</div>
@endsection

