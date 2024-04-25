import "package:flutter_local_notifications/flutter_local_notifications.dart";

class NotificationProvider {
  static initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}

  static showNotification(ActiveNotification activeNotification,
      FlutterLocalNotificationsPlugin flnp) {
    flnp.show(
      activeNotification.id!,
      activeNotification.title,
      activeNotification.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'binario_m_id',
          'binario_m_channel',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: activeNotification.payload,
    );
  }
}
/*
class ActiveNotification {
  /// Constructs an instance of [ActiveNotification].
  const ActiveNotification({
    this.id,
    this.groupKey,
    this.channelId,
    this.title,
    this.body,
    this.payload,
    this.tag,
  });

  /// The notification's id.
  ///
  /// This will be null if the notification was outsided of the plugin's
  /// control e.g. on iOS and via Firebase Cloud Messaging.
  final int? id;

  /// The notification's channel id.
  ///
  /// Returned only on Android 8.0 or newer.
  final String? channelId;

  /// The notification's group.
  ///
  /// Returned only on Android.
  final String? groupKey;

  /// The notification's title.
  final String? title;

  /// The notification's body.
  final String? body;

  /// The notification's payload.
  ///
  /// Returned only on iOS and macOS.
  final String? payload;

  /// The notification's tag.
  ///
  /// Returned only on Android.
  final String? tag;
}*/
