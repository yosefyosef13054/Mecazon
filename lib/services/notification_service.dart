import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController {
  final _channelId = 'mecazon_notification';
  final _channelName = 'mecazon notification channel';
  final _channelDescription = 'mecazon notification';

  late AndroidInitializationSettings _initializationSettingsAndroid;
  late FlutterLocalNotificationsPlugin _plugin;
  late InitializationSettings _initializationSettings;
  NotificationController() {
    _initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    _initializationSettings = InitializationSettings(
      android: _initializationSettingsAndroid,
    );
    _plugin = FlutterLocalNotificationsPlugin();
  }

  showNotification(int id, String? title, String? body) async {
    var init = await _plugin.initialize(_initializationSettings);
    if (init == true) {
      await _plugin.show(
          id,
          title ?? 'No title',
          body ?? 'No body',
          NotificationDetails(
            android: AndroidNotificationDetails(_channelId, _channelName,
                channelDescription: _channelDescription,
                importance: Importance.high,
                visibility: NotificationVisibility.public),
          ));
    }
  }

  /*Future<void> showNotificationFromFirebase(RemoteMessage message) async {
    var init = await _plugin.initialize(_initializationSettings);

    if (init == true) {
      _plugin.cancelAll();
      if (message.notification != null) {
        var notif = message.notification!;
        await _plugin.show(
            notif.hashCode,
            notif.title ?? 'No title',
            notif.body ?? 'No body',
            NotificationDetails(
              android: AndroidNotificationDetails(_channelId, _channelName,
                  channelDescription: _channelDescription,
                  importance: Importance.high,
                  visibility: NotificationVisibility.public),
            ));
      }
    }
  }*/
}
