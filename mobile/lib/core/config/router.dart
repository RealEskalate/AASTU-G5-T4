import 'package:go_router/go_router.dart';
import 'package:mobile/features/Home/presentation/pages/homepage.dart';
import 'package:mobile/features/Problems/presentation/pages/problems_page.dart';
import 'package:mobile/features/Profile/presentation/pages/userProfile.dart';
import 'package:mobile/features/Tracks/presentation/pages/exercise_page.dart';
import 'package:mobile/features/Tracks/presentation/pages/tracks_page.dart';
import 'package:mobile/features/group_display/pages/group_page.dart';

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
  ],
);
