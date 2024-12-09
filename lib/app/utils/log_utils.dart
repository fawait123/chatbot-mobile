import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogUtil {
  final _initLogger = Logger();

  void debug(dynamic message) {
    if (kDebugMode) _initLogger.d(message);
  }

  void errors(dynamic message) {
    if (kDebugMode) _initLogger.e(message);
  }
}
