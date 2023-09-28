import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:push_notifications_app/presentation/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select(
            (NotificationsBloc bloc) => Text('${bloc.state.authStatus}')),
        actions: [
          IconButton(
              onPressed: () {
                context.read<NotificationsBloc>().requestPermission();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<NotificationsBloc>().state.notifications;
    if (notifications.isEmpty) return const SizedBox();

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          title: Text(
            notification.title,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            notification.body,
            overflow: TextOverflow.ellipsis,
          ),
          leading: notification.imageURL != null
              ? Image.network(notification.imageURL!)
              : null,
          onTap: () => context.push("/push-details/${notification.messageID}"),
        );
      },
    );
  }
}
