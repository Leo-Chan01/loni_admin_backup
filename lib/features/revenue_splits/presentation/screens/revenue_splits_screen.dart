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
import '../provider/admin_revenue_splits_provider.dart';

class RevenueSplitsScreen extends StatefulWidget {
  const RevenueSplitsScreen({super.key});

  @override
  State<RevenueSplitsScreen> createState() => _RevenueSplitsScreenState();
}

class _RevenueSplitsScreenState extends State<RevenueSplitsScreen> {
  late final AdminRevenueSplitsProvider _provider;

  final _splitIdController = TextEditingController();
  final _payloadController = TextEditingController(
    text: '{\n  "example": true\n}',
  );

  @override
  void initState() {
    super.initState();
    _provider = AdminRevenueSplitsProvider()..loadList();
  }

  @override
  void dispose() {
    _splitIdController.dispose();
    _payloadController.dispose();
    _provider.dispose();
    super.dispose();
  }

  void _showError() {
    if (_provider.invalidJson) {
      GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
    }
  }

  Future<void> _loadDetail() async {
    final id = _splitIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    await _provider.loadDetail(id);
  }

  Future<void> _create() async {
    final ok = await _provider.create(jsonText: _payloadController.text);
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadList();
    } else {
      _showError();
    }
  }

  Future<void> _update() async {
    final id = _splitIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.update(
      splitId: id,
      jsonText: _payloadController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadDetail(id);
      await _provider.loadList();
    } else {
      _showError();
    }
  }

  Future<void> _preview() async {
    final ok = await _provider.preview(jsonText: _payloadController.text);
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
    } else {
      _showError();
    }
  }

  Future<void> _delete() async {
    final id = _splitIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.delete(id);
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadList();
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.revenueSplits),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminRevenueSplitsProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : provider.loadList,
                  icon: const HugeIcon(icon: HugeIcons.strokeRoundedRefresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminRevenueSplitsProvider>(
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
                  title: context.l10n.revenueSplits,
                  json: provider.splits,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadList,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _splitIdController,
                  label: context.l10n.revenueSplitId,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _loadDetail,
                    child: Text(context.l10n.loadDetail),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.detail,
                  json: provider.detail,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: null,
                ),
                SizedBox(height: 16.h),
                JsonPayloadField(
                  controller: _payloadController,
                  enabled: !provider.isLoading,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _create,
                          child: Text(context.l10n.create),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _update,
                          child: Text(context.l10n.update),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _preview,
                          child: Text(context.l10n.preview),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _delete,
                          child: Text(context.l10n.delete),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.lastResult,
                  json: provider.lastResult,
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
