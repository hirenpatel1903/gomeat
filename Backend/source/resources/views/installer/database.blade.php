
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
              <li >
                <a>
                  <span>Requirements</span>
                </a>
              </li>
              <li>
                <a>
                  <span>Verify</span>
                </a>
              </li>
              <li class="is-active">
                <a>
                  <span><b>Database</b></span>
                </a>
              </li>
              <li>
                <a>
                  <span>Finish</span>
                </a>
              </li>
            </ul>
          </div>

          @if ($message = Session::get('error'))
              <center>
                <p><strong style="color:red;" >{{ $message }}</strong></p><br>
              </center>  
          @endif

          <form action="databasePost" method="POST">
            @csrf
            <input type="hidden" name="lcscs" id="lcscs" value="">
            <div class="field">
              <label class="label">Database Host</label>
              <div class="control">
                <input class="input" type="text" id="host" placeholder="enter your database host" name="db_host" required>
              </div>
            </div>
            <div class="field">
              <label class="label">Database Username</label>
              <div class="control">
                <input class="input" type="text" id="user" placeholder="enter your database username" name="db_user" required>
              </div>
            </div>
            <div class="field">
              <label class="label">Database Password</label>
              <div class="control">
                <input class="input" type="text" id="pass" placeholder="enter your database password" name="db_pass">
              </div>
            </div>
            <div class="field">
              <label class="label">Database Name</label>
              <div class="control">
                <input class="input" type="text" id="name" placeholder="enter your database name" name="db_name" required>
              </div>
            </div>
            <div style='text-align: right;'>
              <button type="submit" class="button is-link">Next</button>
            </div>
          </form>
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