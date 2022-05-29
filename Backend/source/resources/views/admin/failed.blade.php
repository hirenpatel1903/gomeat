<html>
  <head>
     <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
    <style type="text/css">

        body
        {
            background:#f2f2f2;
        }

        .payment
	    {
		    border:1px solid #f01b1b;
		    height:280px;
            border-radius:20px;
            background:#fff;
	    }
       .payment_header
       {
	       background:#f01b1b;
	       padding:20px;
           border-radius:20px 20px 0px 0px;
	   
       }
   
       .check
       {
	       margin:0px auto;
	       width:50px;
	       height:50px;
	       border-radius:100%;
	       background:#fff;
	       text-align:center;
       }
   
       .check i
       {
	       vertical-align:middle;
	       line-height:50px;
	       font-size:30px;
       }

        .content 
        {
            text-align:center;
        }

        .content  h1
        {
            font-size:25px;
            padding-top:25px;
        }

        .content a
        {
            width:200px;
            height:35px;
            color:#fff !important;
            border-radius:30px;
            padding:5px 10px;
            background:#f01b1b;
            transition:all ease-in-out 0.3s;
        }

    
   
    </style>
  </head>
  
    <body>
     <div class="container">
   <div class="row">
      <div class="col-md-12 mx-auto mt-5">
         <div class="payment">
            <div class="payment_header">
               <div class="check"><i class="fa fa-exclamation-triangle" aria-hidden="true"></i></div>
            </div>
            <div class="content">
               <h1>Payment Failed</h1>
               <p>We are facing some issues with money transfer from your account please try again later. </p>
               <a>Try Again Later</a>
            </div>
            
         </div>
      </div>
   </div>
</div>
    </body>
</html>