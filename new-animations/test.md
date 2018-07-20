

<div>
<img src="images/AnimatedOpacity_blue.png" name="img" height="180" width="160">
 <script>
 imgOn = new Image;
 imgOff = new Image;
 imgOn.src = "images/AnimatedOpacity_blue.gif";
 imgOff.src = "images/AnimatedOpacity_blue.png";
 </script>

 <a href="#" onClick="document.img.src=imgOn.src;">▶︎</a>
 <a href="#" onClick="document.img.src=imgOff.src;">◼︎</a>

 This example shows an implicit animation using the <code>AnimatedOpacity</code> implicit widget.
</div>

 <br>
 This example shows the `AnimatedOpacity` implicit widget which automatically transitions the child's opacity over a given duration whenever the given opacity changes. Notice in the code sample below that the listeners, tickers, and other animation elements are *implied* so you don't need to add that code.

 <div>
