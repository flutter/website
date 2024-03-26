const animation1PlayButton =
    document.getElementById('animation_1_play_button_');
const animation1 =
    document.getElementById("animation_1");

if (animation1PlayButton && animation1) {
  animation1PlayButton.addEventListener('click', function (_) {
    if (animation1.paused) {
      animation1.play();
      this.style.display = 'none';
    } else {
      animation1.pause();
      this.style.display = 'block';
    }
  }, false);

  animation1.addEventListener('click', function (_) {
    if (this.paused) {
      this.play();
      animation1PlayButton.style.display = 'none';
    } else {
      this.pause();
      animation1PlayButton.style.display = 'block';
    }
  });
}
