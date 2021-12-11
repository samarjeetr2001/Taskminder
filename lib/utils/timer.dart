import 'dart:async';

import 'package:flutter_beep/flutter_beep.dart';

class TaskTimer {
  static Map<String, Timer> timer = {};
  int duration;
  String id;

  TaskTimer({required this.id, required this.duration});

  void startTimer({
    required Function onComplete,
    required Function periodicFunction,
  }) {
    timer[id] = new Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (duration == 0) {
          timer.cancel();
          FlutterBeep.playSysSound(AndroidSoundIDs.TONE_CDMA_ABBR_ALERT);
          onComplete();
        } else {
          duration--;
          periodicFunction();
        }
      },
    );
  }
}
