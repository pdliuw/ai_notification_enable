package com.air.ai_notification_enable

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.annotation.NonNull;
import androidx.core.app.NotificationManagerCompat

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** AiNotificationEnablePlugin */
public class AiNotificationEnablePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "ai_notification_enable")
        channel.setMethodCallHandler(this);

        //update context
        mContext = flutterPluginBinding.applicationContext
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "ai_notification_enable")
            channel.setMethodCallHandler(AiNotificationEnablePlugin())

            //update context
            mContext = registrar.context().applicationContext;

        }

        /**
         * Context
         */
        private lateinit var mContext: Context;
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "notificationEnabled") {
            result.success(isNotificationEnabled(mContext))
        } else if (call.method == "openNotificationSettings") {
            openNotificationSettings(mContext)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    /**
     * isNotificationEnabled
     */
    private fun isNotificationEnabled(context: Context): Boolean {
        var isOpened = false
        isOpened = try {
            NotificationManagerCompat.from(context).areNotificationsEnabled()
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
        return isOpened
    }

    /**
     * openNotificationSettings
     */
    private fun openNotificationSettings(context: Context) {
        val intent = Intent()
        when {
            Build.VERSION.SDK_INT >= 26 -> {
                // android 8.0引导
                intent.action = "android.settings.APP_NOTIFICATION_SETTINGS"
                intent.putExtra("android.provider.extra.APP_PACKAGE", context.packageName)
            }
            Build.VERSION.SDK_INT >= 21 -> {
                // android 5.0-7.0
                intent.action = "android.settings.APP_NOTIFICATION_SETTINGS"
                intent.putExtra("app_package", context.packageName)
                intent.putExtra("app_uid", context.applicationInfo.uid)
            }
            else -> {
                // 其他
                intent.action = "android.settings.APPLICATION_DETAILS_SETTINGS"
                intent.data = Uri.fromParts("package", context.packageName, null)
            }
        }
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        context.startActivity(intent)
    }
}
