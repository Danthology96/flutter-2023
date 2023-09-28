import 'package:go_router/go_router.dart';
import 'package:push_notifications_app/presentation/screens/details_screen.dart';
import 'package:push_notifications_app/presentation/screens/home_screen.dart';

final appRouter = GoRouter(routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: "/push-details/:messageID",
    builder: (context, state) =>
        DetailsScreen(pushMessageID: state.pathParameters['messageID'] ?? ''),
  ),
]);
