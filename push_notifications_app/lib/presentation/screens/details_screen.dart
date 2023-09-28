import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_notifications_app/domain/entities/push_message.dart';
import 'package:push_notifications_app/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String pushMessageID;

  const DetailsScreen({super.key, required this.pushMessageID});

  @override
  Widget build(BuildContext context) {
    final PushMessage? message =
        context.watch<NotificationsBloc>().getMessageByID(pushMessageID);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles"),
      ),
      body: (message != null)
          ? _DetailsView(message: message)
          : const Center(
              child: Text("La notificación no existe"),
            ),
    );
  }
}

class _DetailsView extends StatelessWidget {
  final PushMessage message;
  const _DetailsView({required this.message});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (message.imageURL != null) Image.network(message.imageURL!),
          const SizedBox(height: 30),
          Text(message.title, style: textStyle.titleMedium),
          Text(message.body),
          const Divider(),
          Text(message.data.toString()),
        ],
      ),
    );
  }
}
