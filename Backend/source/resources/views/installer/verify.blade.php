
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>GoMeat - Installer</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" />
    <style type="text/css">
    body, html {
    background: #F7F7F7;
    }
    .notification.is-success {
    background-color: #d17b23;
    color: #fff;
}
    </style>
  </head>
  <body>
        <div class="container main_body"> <div class="section" >
      <div class="column is-6 is-offset-3">
        <center><h1 class="title" style="padding-top: 20px">
        GoMeat Installer
        </h1><br></center>
        <div class="box">
                    <div class="tabs is-fullwidth">
            <ul>
              <li>
                <a>
                  <span>Requirements</span>
                </a>
              </li>
              <li  class="is-active">
                <a>
                  <span><b>Verify</b></span>
                </a>
              </li>
              <li>
                <a>
                  <span>Database</span>
                </a>
              </li>
              <li>
                <a>
                  <span>Finish</span>
                </a>
              </li>
            </ul>
          </div>
         
          @if(isset($data))
              <form action="databaseinst" method="GET">
                  <div class="notification is-success">{{$data['message']}}</div>
                  <input type="hidden" name="lcscs" id="lcscs" value="{{ucfirst($data['lic_response'])}}">
                  <div style='text-align: right;'>
                      <button type="submit" class="button is-link">Next</button>
                  </div>
              </form>
          @else
            <form action="verifyPost" method="POST">
              {{csrf_field()}}

              @if(Session::has('fail'))
                <div class="notification is-danger">
                    {{ Session::get('fail') }}
                    @php
                        Session::forget('fail');
                    @endphp
                </div>
              @endif

              <div class="field">
                <label class="label">License code</label>
                <div class="control">
                  <input class="input" type="text" placeholder="enter your purchase/license code" name="license" required>
                </div>
              </div>
              <div class="field">
                <label class="label">Your name</label>
                <div class="control">
                  <input class="input" type="text" placeholder="enter your name/envato username" name="client" required>
                </div>
              </div>
              <div style='text-align: right;'>
                <button type="submit" class="button is-link">Verify</button>
              </div>
            </form>
          @endif  
      </div>
    </div>
  </div>
  <div class="content has-text-centered">
    <p>
      Made with ❤️ in India . All Rights Reserved. Powered by <a target="_blank" rel="noopener noreferrer" href="https://tecmanic.com/" >Tecmanic</a>.
    </p>
    <br>
  </div>
</body>
</html>