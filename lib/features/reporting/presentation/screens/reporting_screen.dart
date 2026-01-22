import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/global_snackbar.dart';
import '../../../../shared/widgets/json_preview_card.dart';
import '../provider/admin_reporting_provider.dart';

class ReportingScreen extends StatefulWidget {
  const ReportingScreen({super.key});

  @override
  State<ReportingScreen> createState() => _ReportingScreenState();
}

class _ReportingScreenState extends State<ReportingScreen> {
  late final AdminReportingProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = AdminReportingProvider()..load();
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  Future<void> _export() async {
    final ok = await _provider.export();
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.exportStarted);
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.exportFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.reporting),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminReportingProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : provider.load,
                  icon: const Icon(Icons.refresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminReportingProvider>(
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
                  title: context.l10n.reporting,
                  json: provider.reporting,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.load,
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _export,
                    child: Text(context.l10n.export),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.lastResult,
                  json: provider.lastExportResult,
                  isLoading: false,
                  error: null,
                  onRefresh: null,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
