
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
              <li class="is-active">
                <a>
                  <span><b>Requirements</b></span>
                </a>
              </li>
              {{-- <li>
                <a>
                  <span>Verify</span>
                </a>
              </li> --}}
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

          @if(phpversion() < "7.3.0")
              <div class='notification is-danger' style='padding:12px;'><i class='fa fa-times'></i> Current PHP version is {{phpversion()}}! minimum PHP 7.3.0 or higher required.</div>";
          @else
              <div class='notification is-success' style='padding:12px;'><i class='fa fa-check'></i> You are running PHP version {{phpversion()}}</div>
          @endif
          @if (!extension_loaded('mysqli'))
              <div class='notification is-danger' style='padding:12px;'><i class='fa fa-times'></i> MySQLi PHP extension missing!</div>
          @else
              <div class='notification is-success' style='padding:12px;'><i class='fa fa-check'></i> MySQLi PHP extension available</div>
          @endif

          @if(phpversion() >= "7.3.0" || extension_loaded('mysqli'))
             <a href="databaseinst" class="button is-link gen-env">Next</a>
          @else
             <a href="#" class="button is-link" disabled>Next</a>
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
