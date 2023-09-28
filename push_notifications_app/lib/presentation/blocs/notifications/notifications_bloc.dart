import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications_app/domain/entities/push_message.dart';
import 'package:push_notifications_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

/// TOP LEVEL FUNCTION
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;

  final Future<void> Function()? requestLocalNotificationPermissions;
  final void Function({
    required int id,
    String? title,
    String? body,
    String? data,
  })? showLocalNotification;

  NotificationsBloc(
      {this.requestLocalNotificationPermissions, this.showLocalNotification})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);

    on<NotificationReceived>(_onPushMessageReceived);

    /// Verificar estado del usuario
    _initialStatusCheck();

    /// Escucha los mensajes de tipo foreground
    _onForegroundMessage();
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(authStatus: event.status));
    _getFirebaseToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFirebaseToken() async {
    if (state.authStatus != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    debugPrint(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessage(
      messageID:
          message.messageId?.replaceAll(":", "").replaceAll("%", "") ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageURL: Platform.isAndroid
          ? message.notification!.android?.imageUrl
          : message.notification!.apple?.imageUrl,
    );

    debugPrint(notification.toString());

    if (showLocalNotification != null) {
      showLocalNotification!(
        id: ++pushNumberId,
        title: notification.title,
        body: notification.body,
        data: notification.messageID,
      );
    }
    add(NotificationReceived(message: notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(notifications: [
      event.message,
      ...state.notifications,
    ]));
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    /// Solicita acceso a las local notifications
    if (requestLocalNotificationPermissions == null) {
      await requestLocalNotificationPermissions!();
    }

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageByID(String pushMessageID) {
    final exist = state.notifications
        .any((element) => element.messageID == pushMessageID);
    if (!exist) return null;

    return state.notifications
        .firstWhere((element) => element.messageID == pushMessageID);
  }
}
