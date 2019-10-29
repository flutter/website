var animation_1_play_button_=document.getElementById("animation_1_play_button_");
var animation_1=document.getElementById("animation_1");

animation_1_play_button_.addEventListener('click', function (event) {
  if (animation_1.paused) {
    animation_1.play();
    this.style.display = 'none';
  } else {
    animation_1.pause();
    this.style.display = 'block';
  }
}, false);

animation_1.addEventListener('click', function(event) {
  if (this.paused) {
    this.play();
    animation_1_play_button_.style.display = 'none';
  } else {
    this.pause();
    animation_1_play_button_.style.display = 'block';
  }
});
