import 'package:go_router/go_router.dart';
import 'package:mobile/features/Home/presentation/pages/homepage.dart';
import 'package:mobile/features/Problems/presentation/pages/problems_page.dart';
import 'package:mobile/features/Profile/presentation/pages/userProfile.dart';
import 'package:mobile/features/Tracks/presentation/pages/exercise_page.dart';
import 'package:mobile/features/Tracks/presentation/pages/tracks_page.dart';
import 'package:mobile/features/Users/presentation/pages/users_page.dart';
import 'package:mobile/features/group_display/presentation/pages/group_details.dart';
import 'package:mobile/features/group_display/presentation/pages/group_page.dart';
import 'package:mobile/splash_screen.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => UserprofilePage(),
    ),
    GoRoute(
      path: '/tracks',
      builder: (context, state) => TracksPage(),
    ),
    GoRoute(
      path: '/problems',
      builder: (context, state) => ProblemsPage(),
    ),
    GoRoute(
      path: '/exercise',
      builder: (context, state) => ExercisePage(),
    ),
    GoRoute(
      path: '/groups',
      builder: (context, state) => GroupsPage(),
    ),
    GoRoute(
      path: '/group_details',
      builder: (context, state) => GroupDetails(),
    ),
    GoRoute(
      path: '/users',
      builder: (context, state) => UsersPage(),
    ),
    GoRoute(
      path: '/splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Homepage(),
    ),
  ],
);
