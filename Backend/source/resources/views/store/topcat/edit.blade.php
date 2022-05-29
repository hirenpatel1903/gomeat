@extends('admin.layout.app')

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
                  <h4 class="card-title">Edit Category</h4>
                  <form class="forms-sample" action="{{route('adminUpdateTopCat', [$id])}}" method="post" enctype="multipart/form-data">
                      {{csrf_field()}}
                </div>
                <div class="card-body">

                    <div class="row">
                    <div class="col-lg-12">    
                      <div class="form-group">
                          <label for="app_id">select Category :</label>
                          <select class="js-example-basic-single w-100 form-control" name="cat_id">
                            @foreach($app as $apps)
                              <option value="{{$apps->cat_id}}" @if($getCatId == $apps->cat_id) selected @endif>{{$apps->title}}</option>
                            @endforeach
                          </select>
                        </div>
                         </div>
                        <div class="col-lg-12">
                        <div class="form-group">
                          <label for="app_rank">select position :</label>
                          <select class="js-example-basic-single w-100 form-control" name="cat_rank">
                          	<option disabled>choose position</option>
                            @for($i=1; $i<4; $i++)
                              @if(!in_array($i, $allPosition) || $getCatRank == $i)
                                <option value="{{$i}}" @if($i == $getCatRank) selected @endif>{{$i}}</option>
                              @endif
                            @endfor
                          </select>
                        </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary pull-center">Submit</button>
                    <a href="{{route('adminTopCat')}}" class="btn">Close</a>
                    <div class="clearfix"></div>
                  </form>
                </div>
              </div>
            </div>
			</div>
          </div>
@endsection




