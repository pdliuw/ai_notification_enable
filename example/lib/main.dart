import 'package:ai_notification_enable/ai_notification_enable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      primaryIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool _notificationEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkNotificationStatus();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  ///
  /// Check notification status
  _checkNotificationStatus() async {
    if (await AiNotificationEnable.notificationEnabled()) {
      setState(() {
        _notificationEnabled = true;
      });
    } else {
      setState(() {
        _notificationEnabled = false;
      });
    }
  }

  ///
  /// OpenNotification
  _openNotification() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("开启通知服务"),
          content: Text("打开通知服务，及时接收App消息?"),
          actions: [
            CupertinoDialogAction(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("去打开"),
              onPressed: () {
                Navigator.of(context).pop();
                AiNotificationEnable.openNotificationSettings();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
          child: _notificationEnabled
              ? Text('通知服务: 已开启')
              : MaterialButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryIconTheme.color,
                  onPressed: () {
                    _openNotification();
                  },
                  child: Text("去开启通知服务"),
                )),
    );
  }

  ///
  /// Lifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkNotificationStatus();
    }
  }
}
