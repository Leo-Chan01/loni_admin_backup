import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
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
              tooltip: context.l10n.logout,
              icon: const HugeIcon(icon: HugeIcons.strokeRoundedLogout01),
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
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: context.l10n.users,
                            value: 0.toString(),
                            icon: HugeIcons.strokeRoundedUser,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: StatCard(
                            title: context.l10n.orders,
                            value: 0.toString(),
                            icon: HugeIcons.strokeRoundedShoppingBag01,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: StatCard(
                            title: context.l10n.moderation,
                            value: 0.toString(),
                            icon: HugeIcons.strokeRoundedShieldUser,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: StatCard(
                            title: context.l10n.catalog,
                            value: 0.toString(),
                            icon: HugeIcons.strokeRoundedBook02,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
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
                    SizedBox(height: 32.h),
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MenuCard(
                          title: context.l10n.users,
                          icon: HugeIcons.strokeRoundedUser,
                          onTap: () => context.go('/users'),
                        ),
                        MenuCard(
                          title: context.l10n.orders,
                          icon: HugeIcons.strokeRoundedShoppingBag01,
                          onTap: () => context.go('/orders'),
                        ),
                        MenuCard(
                          title: context.l10n.moderation,
                          icon: HugeIcons.strokeRoundedShieldUser,
                          onTap: () => context.go('/moderation'),
                        ),
                        MenuCard(
                          title: context.l10n.catalog,
                          icon: HugeIcons.strokeRoundedBook02,
                          onTap: () => context.go('/catalog'),
                        ),
                        MenuCard(
                          title: context.l10n.system,
                          icon: HugeIcons.strokeRoundedSettings01,
                          onTap: () => context.go('/system'),
                        ),
                        MenuCard(
                          title: context.l10n.refunds,
                          icon: HugeIcons.strokeRoundedInvoice01,
                          onTap: () => context.go('/refunds'),
                        ),
                        MenuCard(
                          title: context.l10n.economics,
                          icon: HugeIcons.strokeRoundedCoins01,
                          onTap: () => context.go('/economics'),
                        ),
                        MenuCard(
                          title: context.l10n.markets,
                          icon: HugeIcons.strokeRoundedGlobal,
                          onTap: () => context.go('/markets'),
                        ),
                        MenuCard(
                          title: context.l10n.reporting,
                          icon: HugeIcons.strokeRoundedChartLineData01,
                          onTap: () => context.go('/reporting'),
                        ),
                        MenuCard(
                          title: context.l10n.backorders,
                          icon: HugeIcons.strokeRoundedPackageProcess,
                          onTap: () => context.go('/backorders'),
                        ),
                        MenuCard(
                          title: context.l10n.payouts,
                          icon: HugeIcons.strokeRoundedMoney01,
                          onTap: () => context.go('/payouts'),
                        ),
                        MenuCard(
                          title: context.l10n.revenueSplits,
                          icon: HugeIcons.strokeRoundedChartDecrease,
                          onTap: () => context.go('/revenue-splits'),
                        ),
                        MenuCard(
                          title: context.l10n.ledger,
                          icon: HugeIcons.strokeRoundedDatabase,
                          onTap: () => context.go('/ledger'),
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
