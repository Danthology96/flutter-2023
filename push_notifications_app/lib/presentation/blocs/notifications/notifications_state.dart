part of 'notifications_bloc.dart';

class NotificationsState extends Equatable {
  final AuthorizationStatus authStatus;
  final List<PushMessage> notifications;

  const NotificationsState({
    this.authStatus = AuthorizationStatus.notDetermined,
    this.notifications = const [],
  });

  NotificationsState copyWith({
    AuthorizationStatus? authStatus,
    List<PushMessage>? notifications,
  }) =>
      NotificationsState(
        authStatus: authStatus ?? this.authStatus,
        notifications: notifications ?? this.notifications,
      );

  @override
  List<Object> get props => [authStatus, notifications];
}
