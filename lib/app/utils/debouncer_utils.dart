import 'dart:async';

import 'package:flutter/material.dart';

class DebouncerUtils {
  final Duration duration;
  DebouncerUtils({required this.duration});

  Timer? timer;

  void run(VoidCallback action) {
    bool isActive = timer?.isActive ?? false;

    if (isActive) {
      timer?.cancel();
    }
    timer = Timer(duration, action);
  }
}
