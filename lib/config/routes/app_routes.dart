import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/provider/admin_auth_provider.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/users/presentation/screens/users_list_screen.dart';
import '../../features/orders/presentation/screens/orders_list_screen.dart';
import '../../features/moderation/presentation/screens/moderation_tasks_screen.dart';
import '../../features/catalog/presentation/screens/catalog_management_screen.dart';

class AppRoutes {
  static GoRouter createRouter(AdminAuthProvider auth) {
    return GoRouter(
      initialLocation: '/login',
      refreshListenable: auth,
      redirect: (context, state) {
        final isLoggingIn = state.matchedLocation == '/login';
        final isAuthed = auth.isAuthenticated;

        if (!isAuthed && !isLoggingIn) return '/login';
        if (isAuthed && isLoggingIn) return '/dashboard';
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          name: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/dashboard',
          name: 'dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/users',
          name: 'users',
          builder: (context, state) => const UsersListScreen(),
        ),
        GoRoute(
          path: '/orders',
          name: 'orders',
          builder: (context, state) => const OrdersListScreen(),
        ),
        GoRoute(
          path: '/moderation',
          name: 'moderation',
          builder: (context, state) => const ModerationTasksScreen(),
        ),
        GoRoute(
          path: '/catalog',
          name: 'catalog',
          builder: (context, state) => const CatalogManagementScreen(),
        ),
      ],
    );
  }
}
