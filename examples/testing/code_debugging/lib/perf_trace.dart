import 'dart:developer';

void main() {
  Timeline.startSync('interesting function');
  // iWonderHowLongThisTakes();
  Timeline.finishSync();
}
