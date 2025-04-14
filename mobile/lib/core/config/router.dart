import 'package:go_router/go_router.dart';
import 'package:mobile/features/Home/presentation/pages/homepage.dart';
import 'package:mobile/features/Profile/presentation/pages/userProfile.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Homepage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => UserprofilePage(),
    )
  ],
);
