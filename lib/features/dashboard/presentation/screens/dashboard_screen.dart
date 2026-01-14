import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../dashboard/data/services/admin_dashboard_service.dart';
import '../../../../features/auth/presentation/provider/admin_auth_provider.dart';
import '../../../../l10n/l10n_extensions.dart';
import '../provider/admin_reading_report_provider.dart';
import '../widgets/menu_card.dart';
import '../widgets/reading_report_card.dart';
import '../widgets/stat_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late AdminDashboardService _dashboardService;
  late AdminReadingReportProvider _readingReportProvider;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _dashboardService = AdminDashboardService();
    _readingReportProvider = AdminReadingReportProvider();
    _loadDashboard();
    _readingReportProvider.load();
  }

  @override
  void dispose() {
    _readingReportProvider.dispose();
    super.dispose();
  }

  Future<void> _loadDashboard() async {
    setState(() => _isLoading = true);
    await _dashboardService.getDashboard();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _readingReportProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.dashboard),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await context.read<AdminAuthProvider>().signOut();
                if (!context.mounted) return;
                context.go('/login');
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: context.l10n.users,
                            value: 0.toString(),
                            icon: Icons.people,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: context.l10n.orders,
                            value: 0.toString(),
                            icon: Icons.shopping_cart,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: context.l10n.moderation,
                            value: 0.toString(),
                            icon: Icons.assignment,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: StatCard(
                            title: context.l10n.catalog,
                            value: 0.toString(),
                            icon: Icons.library_books,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Consumer<AdminReadingReportProvider>(
                      builder: (context, provider, _) {
                        return ReadingReportCard(
                          isLoading: provider.isLoading,
                          error: provider.error,
                          report: provider.report,
                          onRefresh: provider.load,
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MenuCard(
                          title: context.l10n.users,
                          icon: Icons.people,
                          onTap: () => context.go('/users'),
                        ),
                        MenuCard(
                          title: context.l10n.orders,
                          icon: Icons.shopping_cart,
                          onTap: () => context.go('/orders'),
                        ),
                        MenuCard(
                          title: context.l10n.moderation,
                          icon: Icons.assignment,
                          onTap: () => context.go('/moderation'),
                        ),
                        MenuCard(
                          title: context.l10n.catalog,
                          icon: Icons.library_books,
                          onTap: () => context.go('/catalog'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
