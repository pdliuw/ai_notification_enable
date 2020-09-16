#import "AiNotificationEnablePlugin.h"
#if __has_include(<ai_notification_enable/ai_notification_enable-Swift.h>)
#import <ai_notification_enable/ai_notification_enable-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ai_notification_enable-Swift.h"
#endif

@implementation AiNotificationEnablePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAiNotificationEnablePlugin registerWithRegistrar:registrar];
}
@end
