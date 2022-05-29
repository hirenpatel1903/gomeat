
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
              <li class="is-active">
                <a>
                  <span><b>Verify</b></span>
                </a>
              </li>
              <li >
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
          
          <form action="verifyLicense" method="GET" >
            {{csrf_field()}}
 
             <center>
               <p><strong>License is Expired. Please connect with support and renew your license. Once license renewed click on below button.</strong></p><br>
             </center>
            <div style='text-align: center;'>
              <button type="submit" class="button is-link">Verify License Update</button>
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