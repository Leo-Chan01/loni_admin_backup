import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/json_preview_card.dart';
import '../provider/admin_system_provider.dart';

class SystemScreen extends StatefulWidget {
  const SystemScreen({super.key});

  @override
  State<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> {
  late final AdminSystemProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = AdminSystemProvider()..loadAll();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.system),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminSystemProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : provider.loadAll,
                  icon: const Icon(Icons.refresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminSystemProvider>(
          builder: (context, provider, _) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                if (provider.error != null) ...[
                  Text(
                    provider.error!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
                JsonPreviewCard(
                  title: context.l10n.health,
                  json: provider.health,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.overview,
                  json: provider.overview,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.summary,
                  json: provider.summary,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.audit,
                  json: provider.audit,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.systemStatus,
                  json: provider.systemStatus,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.systemFeatures,
                  json: provider.systemFeatures,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.systemRoles,
                  json: provider.systemRoles,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.systemSettings,
                  json: provider.systemSettings,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
