import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/global_snackbar.dart';
import '../../../../shared/widgets/json_payload_field.dart';
import '../../../../shared/widgets/json_preview_card.dart';
import '../provider/admin_payouts_provider.dart';

class PayoutsScreen extends StatefulWidget {
  const PayoutsScreen({super.key});

  @override
  State<PayoutsScreen> createState() => _PayoutsScreenState();
}

class _PayoutsScreenState extends State<PayoutsScreen> {
  late final AdminPayoutsProvider _provider;

  final _batchIdController = TextEditingController();
  final _createBatchController = TextEditingController(
    text: '{\n  "example": true\n}',
  );
  final _schedulerPayloadController = TextEditingController(
    text: '{\n  "example": true\n}',
  );

  @override
  void initState() {
    super.initState();
    _provider = AdminPayoutsProvider()..loadAll();
  }

  @override
  void dispose() {
    _batchIdController.dispose();
    _createBatchController.dispose();
    _schedulerPayloadController.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _createBatch() async {
    final ok = await _provider.createBatch(
      jsonText: _createBatchController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadAll();
    } else {
      if (_provider.invalidJson) {
        GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
      } else {
        GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
      }
    }
  }

  Future<void> _runScheduler() async {
    final ok = await _provider.runScheduler(
      jsonText: _schedulerPayloadController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadAll();
    } else {
      if (_provider.invalidJson) {
        GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
      } else {
        GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
      }
    }
  }

  Future<void> _exportBatch() async {
    final id = _batchIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.exportBatch(batchId: id);
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
          title: Text(context.l10n.payouts),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminPayoutsProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : provider.loadAll,
                  icon: const HugeIcon(icon: HugeIcons.strokeRoundedRefresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminPayoutsProvider>(
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
                  title: context.l10n.payoutBalances,
                  json: provider.balances,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.payoutPending,
                  json: provider.pending,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.payoutStatements,
                  json: provider.statements,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.payoutBatches,
                  json: provider.batches,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadAll,
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.createBatch,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _createBatchController,
                  enabled: !provider.isLoading,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _createBatch,
                    child: Text(context.l10n.create),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.runScheduler,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _schedulerPayloadController,
                  enabled: !provider.isLoading,
                  minLines: 3,
                  maxLines: 6,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _runScheduler,
                    child: Text(context.l10n.run),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.exportBatch,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _batchIdController,
                  label: context.l10n.batchId,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _exportBatch,
                    child: Text(context.l10n.export),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.lastResult,
                  json: provider.lastActionResult,
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
