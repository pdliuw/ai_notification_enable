import 'dart:async';

import 'package:flutter/services.dart';

///
/// AiNotificationEnable
class AiNotificationEnable {
  ///
  /// send channel
  static const MethodChannel _channel =
      const MethodChannel('ai_notification_enable');

  ///
  /// receive channel
  static const MethodChannel _channelResult =
      const MethodChannel('ai_notification_enable_result');
  static AiNotificationEnable _instance;

  static instance() {
    if (_instance == null) {
      _instance = AiNotificationEnable();
      _channelResult.setMethodCallHandler(_methodCallHandler);
    }
    return _instance;
  }

  ///
  /// methodCallHandler
  static Future<dynamic> _methodCallHandler(MethodCall call) {
    String method = call.method;
    dynamic arguments = call.arguments;

    switch (method) {
      case "":
        break;

      default:
    }

    return Future.delayed(Duration(seconds: 1));
  }

  ///
  /// notificationEnabled
  static Future<bool> notificationEnabled() async {
    final bool enabled = await _channel.invokeMethod('notificationEnabled');
    return enabled;
  }

  ///
  /// openNotificationSettings
  static openNotificationSettings() {
    _channel.invokeMethod('openNotificationSettings');
  }
}
