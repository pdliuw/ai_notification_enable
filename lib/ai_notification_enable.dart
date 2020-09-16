
import 'dart:async';

import 'package:flutter/services.dart';

class AiNotificationEnable {
  static const MethodChannel _channel =
      const MethodChannel('ai_notification_enable');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
