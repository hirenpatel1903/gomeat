

<!DOCTYPE html>
<html lang="en">
<head>
	<title>{{$logo->name}} store</title>
	 <meta charset="utf-8" />
  <title>{{$logo->name}} Store</title>
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  
  <!-- ================== BEGIN core-css ================== -->
  <link href="{{url('assets/theme_assets/css/app.min.css')}}" rel="stylesheet" />
	@if($mapset->mapbox == 1 && $mapset->google_map == 0)
<meta name="viewport" content="initial-scale=1,maximum-scale=1,user-scalable=no"/>

    <script src="https://code.jquery.com/jquery-3.4.1.js" type="text/javascript"></script>
    <script src="https://unpkg.com/@mapbox/mapbox-sdk/umd/mapbox-sdk.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font: 16px Arial;
        }

        /*the container must be positioned relative:*/
        .autocomplete {
            position: relative;
            display: inline-block;
        }

        input {
            border: 1px solid transparent;
            background-color: #f1f1f1;
            padding: 10px;
            font-size: 16px;
        }

        input[type=text] {
            width: 100%;
        }

        input[type=submit] {
            background-color: DodgerBlue;
            color: #fff;
            cursor: pointer;
        }

        .autocomplete-items {
            position: absolute;
            border: 1px solid #d4d4d4;
            border-bottom: none;
            border-top: none;
            z-index: 99;
            /*position the autocomplete items to be the same width as the container:*/
            top: 100%;
            left: 0;
            right: 0;
        }

        .autocomplete-items div {
            padding: 10px;
            cursor: pointer;
            background-color: #fff;
            border-bottom: 1px solid #d4d4d4;
        }

        /*when hovering an item:*/
        .autocomplete-items div:hover {
            background-color: #e9e9e9;
        }

        /*when navigating through the items using the arrow keys:*/
        .autocomplete-active {
            background-color: DodgerBlue !important;
            color: #ffffff;
        }
    </style>
    @endif
  @if($mapset->mapbox == 0 && $mapset->google_map == 1)  
 <style>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
      #map {
        height: 100%;
      }
      .controls {
        margin-top: 10px;
        border: 1px solid transparent;
        border-radius: 2px 0 0 2px;
        box-sizing: border-box;
        -moz-box-sizing: border-box;
        height: 32px;
        outline: none;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
      }

      #pac-input {
        background-color: #fff;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        margin-left: 12px;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 300px;
      }

      #pac-input:focus {
        border-color: #4d90fe;
      }

      .pac-container {
        font-family: Roboto;
      }

      #type-selector {
        color: #fff;
        background-color: #4d90fe;
        padding: 5px 11px 0px 11px;
      }

      #type-selector label {
        font-family: Roboto;
        font-size: 13px;
        font-weight: 300;
      }
    </style>
    @endif
</head>
<body>
	
	  <div id="app" class="app app-full-height app-without-header">
    <!-- BEGIN login -->
    <div class="login">
        
      <!-- BEGIN login-content -->
      <div class="login-content">
          <div  align="center">
            <img align="center" img style="width:100px;height:auto;" src="{{url($logo->icon)}}" alt="IMG">
            </div><hr>
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
        
				<form action="{{ route('store_registered') }}" method="POST" name="login_form">
            {{ csrf_field() }}
          <h1 class="text-center">{{ __('keywords.Sign Up')}}</h1>
          <div class="text-muted text-center mb-4">
            {{ __('keywords.Please Enter your right details so that we can contact with you for approval process.')}}
          </div>
          <div class="form-group">
            <label>{{ __('keywords.Store Name')}}</label>
            <input type="text" class="form-control form-control-lg fs-15px" name="store_name" placeholder="XYZ Store" />
          </div>
          <div class="form-group">
            <label>{{ __('keywords.Email Address')}}</label>
            <input data-validate = "Valid email is required: ex@abc.xyz" type="email" class="form-control form-control-lg fs-15px" name="email" placeholder="username@address.com" />
          </div>
          <div class="form-group">
            <label>{{ __('keywords.Store Phone')}}</label>
            <input type="number" class="form-control form-control-lg fs-15px" name="store_phone" placeholder="9999999999" />
          </div>
          <div class="form-group">
            <label>{{ __('keywords.Store Owner')}}</label>
            <input type="text" class="form-control form-control-lg fs-15px" name="emp_name" placeholder="ABC" />
          </div>
          <div class="form-group">
            <label>{{ __('keywords.Admin Share')}}</label>
            <input type="number" class="form-control form-control-lg fs-15px" name="share" placeholder="{{ __('keywords.Admin Share')}}(%)" />
          </div>


             <div class="form-group">
                  <select name="city" class="form-control form-control-lg fs-15px">
                      <option disabled selected>Select City</option>
                      @foreach($city as $cities)
                      <option value="{{$cities->city_name}}">{{$cities->city_name}}</option>
                      @endforeach
                 </select>
                </div>

          <div class="form-group">
            <div class="d-flex">
              <label>{{ __('keywords.Password')}}</label>
            </div>
            <input type="password" class="form-control form-control-lg fs-15px" name="password" placeholder="{{ __('keywords.Enter your password')}}" />
             @include('admin.partials._googletagmanager')
          </div>


                         <div class="form-group">
                            <label>Document Proof</label>
                          <input type="file" name="store_doc" class="form-control form-control-lg fs-15px" class="form-control">
                        </div>
                      <br>
                    @if($mapset->mapbox == 0 && $mapset->google_map == 1)
                       
                           <div class="form-group">
                            <input type="text" name="address" class="form-control form-control-lg fs-15px" id="autocomplete" class="form-control" placeholder="{{ __('keywords.Store Address')}}">
                        </div>
                        
                      @endif
                     @if($mapset->mapbox == 1 && $mapset->google_map == 0) 
                     
                       <div class="autocomplete" style="width:100%;">
                           <input id="lng" type="hidden" name="lng">
                              <input id="lat" type="hidden" name="lat">
                            <input id="myInput" type="text" class="form-control form-control-lg fs-15px" name="address" placeholder="{{ __('keywords.Store Address')}}">
                             
                        </div>
                         
                      @endif
          
  
          <button type="submit" class="btn btn-primary btn-lg btn-block fw-500 mb-3">{{ __('keywords.Sign Up')}}</button>
        </form>
        <p><span style="font-size:15px">{{ __('keywords.If Store is already registered')}}! </span><a href="{{route('storeLogin')}}"><b style="color:red">Login</b></a></p>
			</div>
		</div>
	</div>
	
  <!-- END login -->
    
    <!-- BEGIN btn-scroll-top -->
    <a href="#" data-click="scroll-top" class="btn-scroll-top fade"><i class="fa fa-arrow-up"></i></a>
    <!-- END btn-scroll-top -->
  </div>
  <!-- END #app -->
  
  <!-- ================== BEGIN core-js ================== -->
  <script src="{{url('assets/theme_assets/js/app.min.js')}}"></script>
  <!-- ================== END core-js ================== -->
    
</body>
@if($mapset->mapbox == 1 && $mapset->google_map == 0)          
<script>

    var geocodingClient = mapboxSdk({accessToken: '{{$mapbox->mapbox_api}}'});

    function autocompleteSuggestionMapBoxAPI(inputParams, callback) {
        geocodingClient.geocoding.forwardGeocode({
            query: inputParams,
            countries: ['In'],
            autocomplete: true,
            limit: 5,
        })
            .send()
            .then(response => {
                const match = response.body;
                callback(match);
            });
    }

    function autocompleteInputBox(inp) {
        var currentFocus;
        inp.addEventListener("input", function (e) {
            var a, b, i, val = this.value;
            closeAllLists();
            if (!val) {
                return false;
            }
            currentFocus = -1;
            a = document.createElement("DIV");
            a.setAttribute("id", this.id + "autocomplete-list");
            a.setAttribute("class", "autocomplete-items");
            this.parentNode.appendChild(a);

            // suggestion list MapBox api called with callback
            autocompleteSuggestionMapBoxAPI($('#myInput').val(), function (results) {
                results.features.forEach(function (key) {
                    b = document.createElement("DIV");
                    b.innerHTML = "<strong>" + key.place_name.substr(0, val.length) + "</strong>";
                    b.innerHTML += key.place_name.substr(val.length);
                    b.innerHTML += "<input type='hidden' data-lat='" + key.geometry.coordinates[1] + "' data-lng='" + key.geometry.coordinates[0] + "'  value='" + key.place_name + "'>";
                    b.addEventListener("click", function (e) {
                        let lat = $(this).find('input').attr('data-lat');
                        let long = $(this).find('input').attr('data-lng');
                        inp.value = $(this).find('input').val();
                        $(inp).attr('data-lat', lat);
                        $(inp).attr('data-lng', long);
                        document.getElementById("lat").value = lat;
                        document.getElementById("lng").value = long;
                        closeAllLists();
                        
                    });
                    a.appendChild(b);
                });
            })
        });


        /*execute a function presses a key on the keyboard:*/
        inp.addEventListener("keydown", function (e) {
            var x = document.getElementById(this.id + "autocomplete-list");
            if (x) x = x.getElementsByTagName("div");
            if (e.keyCode == 40) {
                /*If the arrow DOWN key is pressed,
                increase the currentFocus variable:*/
                currentFocus++;
                /*and and make the current item more visible:*/
                addActive(x);
            } else if (e.keyCode == 38) { //up
                /*If the arrow UP key is pressed,
                decrease the currentFocus variable:*/
                currentFocus--;
                /*and and make the current item more visible:*/
                addActive(x);
            } else if (e.keyCode == 13) {
                /*If the ENTER key is pressed, prevent the form from being submitted,*/
                e.preventDefault();
                if (currentFocus > -1) {
                    /*and simulate a click on the "active" item:*/
                    if (x) x[currentFocus].click();
                }
            }
        });

        function addActive(x) {
            /*a function to classify an item as "active":*/
            if (!x) return false;
            /*start by removing the "active" class on all items:*/
            removeActive(x);
            if (currentFocus >= x.length) currentFocus = 0;
            if (currentFocus < 0) currentFocus = (x.length - 1);
            /*add class "autocomplete-active":*/
            x[currentFocus].classList.add("autocomplete-active");
        }

        function removeActive(x) {
            /*a function to remove the "active" class from all autocomplete items:*/
            for (var i = 0; i < x.length; i++) {
                x[i].classList.remove("autocomplete-active");
            }
        }

        function closeAllLists(elmnt) {
            /*close all autocomplete lists in the document,
            except the one passed as an argument:*/
            var x = document.getElementsByClassName("autocomplete-items");
            for (var i = 0; i < x.length; i++) {
                if (elmnt != x[i] && elmnt != inp) {
                    x[i].parentNode.removeChild(x[i]);
                }
            }
        }

        /*execute a function when someone clicks in the document:*/
        document.addEventListener("click", function (e) {
            closeAllLists(e.target);
        });
    }

    autocompleteInputBox(document.getElementById("myInput"));
</script>





@endif

@if($mapset->mapbox == 0 && $mapset->google_map == 1)          
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
{{-- javascript code --}}
<script src="https://maps.google.com/maps/api/js?key={{$map}}=places&callback=initAutocomplete" type="text/javascript"></script>
<script>
   $(document).ready(function() {
        $("#lat_area").addClass("d-none");
        $("#long_area").addClass("d-none");
   });
</script>
<script>
   google.maps.event.addDomListener(window, 'load', initialize);

   function initialize() {
       var input = document.getElementById('autocomplete');
       var autocomplete = new google.maps.places.Autocomplete(input);
       autocomplete.addListener('place_changed', function() {
           var place = autocomplete.getPlace();
           $('#latitude').val(place.geometry['location'].lat());
           $('#longitude').val(place.geometry['location'].lng());
           $("#lat_area").removeClass("d-none");
           $("#long_area").removeClass("d-none");
       });
   }
</script>

    <script src="https://maps.googleapis.com/maps/api/js?key={{$map}}&libraries=places&callback=initMap"
        async defer></script> 
        
@endif        
</html>