# ai_notification_enable

![totem](https://raw.githubusercontent.com/pdliuw/pdliuw.github.io/master/images/totem_four_logo.jpg)

-----

|[English Document](https://github.com/pdliuw/ai_notification_enable/blob/master/README_EN.md)|[中文文档](https://github.com/pdliuw/ai_notification_enable)|
|:-|:-|


## Effect

|iOS-notification|Android-notification|
|:-|:-|
|![ios](https://github.com/pdliuw/ai_notification_enable/blob/master/example/gif/ai_notification_enable_ios.gif)|![android](https://github.com/pdliuw/ai_notification_enable/blob/master/example/gif/ai_notification_enable_android.gif)|
|:-|:-|


## 1.安装

使用当前包作为依赖库

### 1. 依赖此库

在文件 'pubspec.yaml' 中添加

[![pub package](https://img.shields.io/pub/v/ai_notification_enable.svg)](https://pub.dev/packages/ai_notification_enable)

```

dependencies:

  ai_notification_enable: ^version

```

或者以下方式依赖

```
dependencies:

  # ai_notification_enable package.
  ai_notification_enable:
    git:
      url: https://github.com/pdliuw/ai_notification_enable.git

```

### 2. 安装此库

你可以通过下面的命令行来安装此库

```

$ flutter pub get


```

你也可以通过项目开发工具通过可视化操作来执行上述步骤

### 3. 导入此库

现在，在你的Dart编辑代码中，你可以使用：

```

import 'package:ai_notification_enable/ai_notification_enable.dart';

```


## 2.使用

* 1. 检查是否开启通知权限

```

        AiNotificationEnable.notificationEnabled()


```

example 

```
        
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

```

* 2. 打开权限设置页面

```

        AiNotificationEnable.openNotificationSettings();


```

example 

```
        
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

```



## LICENSE

    BSD 3-Clause License
    
    Copyright (c) 2020, pdliuw
    All rights reserved.