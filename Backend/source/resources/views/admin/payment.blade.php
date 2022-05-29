
<!DOCTYPE html>
<html>
<head>
<style>
  .wrapper {
  width: 100px; /* Set the size of the progress bar */
  height: 100px;
  position: absolute; /* Enable clipping */
  clip: rect(0px, 100px, 100px, 50px); /* Hide half of the progress bar */
   top:50%;
  left:50%;
}
/* Set the sizes of the elements that make up the progress bar */
.circle {
  width: 80px;
  height: 80px;
  border: 10px solid green;
  border-radius: 50px;
  position: absolute;
 
 
  clip: rect(0px, 50px, 100px, 0px);
}
/* Using the data attributes for the animation selectors. */
/* Base settings for all animated elements */
div[data-anim~=base] {
  -webkit-animation-iteration-count: 1;  /* Only run once */
  -webkit-animation-fill-mode: forwards; /* Hold the last keyframe */
  -webkit-animation-timing-function:linear; /* Linear animation */
}

.wrapper[data-anim~=wrapper] {
  -webkit-animation-duration: 3s; /* Complete keyframes asap */
  -webkit-animation-delay: 3s; /* Wait half of the animation */
  -webkit-animation-name: close-wrapper; /* Keyframes name */
}

.circle[data-anim~=left] {
  -webkit-animation-duration: 8s; /* Full animation time */
  -webkit-animation-name: left-spin;
}

.circle[data-anim~=right] {
  -webkit-animation-duration: 3s; /* Half animation time */
  -webkit-animation-name: right-spin;
}
/* Rotate the right side of the progress bar from 0 to 180 degrees */
@-webkit-keyframes right-spin {
  from {
    -webkit-transform: rotate(0deg);
  }
  to {
    -webkit-transform: rotate(180deg);
  }
}
/* Rotate the left side of the progress bar from 0 to 360 degrees */
@-webkit-keyframes left-spin {
  from {
    -webkit-transform: rotate(0deg);
  }
  to {
    -webkit-transform: rotate(360deg);
  }
}
/* Set the wrapper clip to auto, effectively removing the clip */
@-webkit-keyframes close-wrapper {
  to {
    clip: rect(auto, auto, auto, auto);
  }


}
p {text-align: center;
    position: absolute;
    top: 30%;
    left:40%;
    
}
</style>
</head>
<body>
<p>Please don't Press Back Button your payment under process</p>
<div class="wrapper" data-anim="base wrapper">
  <div class="circle" data-anim="base left"></div>
  <div class="circle" data-anim="base right"></div>
</div>

</body>
</html> 