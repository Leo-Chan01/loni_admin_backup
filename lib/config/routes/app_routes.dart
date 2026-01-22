import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/provider/admin_auth_provider.dart';

import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/users/presentation/screens/users_list_screen.dart';
import '../../features/orders/presentation/screens/orders_list_screen.dart';
import '../../features/moderation/presentation/screens/moderation_tasks_screen.dart';
import '../../features/catalog/presentation/screens/catalog_management_screen.dart';
import '../../features/system/presentation/screens/system_screen.dart';
import '../../features/refunds/presentation/screens/refunds_screen.dart';
import '../../features/economics/presentation/screens/economics_screen.dart';
import '../../features/markets/presentation/screens/markets_screen.dart';
import '../../features/reporting/presentation/screens/reporting_screen.dart';
import '../../features/backorders/presentation/screens/backorders_screen.dart';
import '../../features/payouts/presentation/screens/payouts_screen.dart';
import '../../features/revenue_splits/presentation/screens/revenue_splits_screen.dart';
import '../../features/ledger/presentation/screens/ledger_screen.dart';

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
        GoRoute(
          path: '/system',
          name: 'system',
          builder: (context, state) => const SystemScreen(),
        ),
        GoRoute(
          path: '/refunds',
          name: 'refunds',
          builder: (context, state) => const RefundsScreen(),
        ),
        GoRoute(
          path: '/economics',
          name: 'economics',
          builder: (context, state) => const EconomicsScreen(),
        ),
        GoRoute(
          path: '/markets',
          name: 'markets',
          builder: (context, state) => const MarketsScreen(),
        ),
        GoRoute(
          path: '/reporting',
          name: 'reporting',
          builder: (context, state) => const ReportingScreen(),
        ),
        GoRoute(
          path: '/backorders',
          name: 'backorders',
          builder: (context, state) => const BackordersScreen(),
        ),
        GoRoute(
          path: '/payouts',
          name: 'payouts',
          builder: (context, state) => const PayoutsScreen(),
        ),
        GoRoute(
          path: '/revenue-splits',
          name: 'revenueSplits',
          builder: (context, state) => const RevenueSplitsScreen(),
        ),
        GoRoute(
          path: '/ledger',
          name: 'ledger',
          builder: (context, state) => const LedgerScreen(),
        ),
      ],
    );
  }
}
