import Flutter
import UIKit

public class SwiftAiNotificationEnablePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ai_notification_enable", binaryMessenger: registrar.messenger())
        let instance = SwiftAiNotificationEnablePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        
        let method:String = call.method;
        
        switch method {
        case "notificationEnabled":
            checkPushNotification(checkNotificationStatus: { (enable:Bool) in
                result(enable)
            })
            
        case "openNotificationSettings":
            openNotificatinSettings();
        default:
            doNothing();
        }
    }
    
    
    func checkPushNotification(checkNotificationStatus isEnable : ((Bool)->())? = nil){
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings(){ (setttings) in
                
                switch setttings.authorizationStatus{
                case .authorized:
                    
                    print("enabled notification setting")
                    isEnable?(true)
                case .denied:
                    
                    print("setting has been disabled")
                    isEnable?(false)
                case .notDetermined:
                    
                    print("something vital went wrong here")
                    isEnable?(false)
                case .provisional:
                    isEnable?(false)
                @unknown default:
                    isEnable?(false)
                }
            }
        } else {
            
            let isNotificationEnabled = UIApplication.shared.currentUserNotificationSettings?.types.contains(UIUserNotificationType.alert)
            if isNotificationEnabled == true{
                
                print("enabled notification setting")
                isEnable?(true)
                
            }else{
                
                print("setting has been disabled")
                isEnable?(false)
            }
        }
    }
    
    func openNotificatinSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            
            if #available(iOS 10.0, *) {
                
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            } else {
                
                // Fallback on earlier versions
                
            }
            
        }
        
    }
    
    func doNothing(){}
}
