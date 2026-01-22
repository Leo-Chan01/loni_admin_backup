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
import '../provider/admin_refunds_provider.dart';

class RefundsScreen extends StatefulWidget {
  const RefundsScreen({super.key});

  @override
  State<RefundsScreen> createState() => _RefundsScreenState();
}

class _RefundsScreenState extends State<RefundsScreen> {
  late final AdminRefundsProvider _provider;
  final _refundIdController = TextEditingController();
  final _patchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = AdminRefundsProvider()..load();
  }

  @override
  void dispose() {
    _refundIdController.dispose();
    _patchController.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _submitPatch() async {
    final id = _refundIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.patchRefund(
      refundId: id,
      jsonText: _patchController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.load();
    } else {
      if (_provider.invalidJson) {
        GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
      } else {
        GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.refunds),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminRefundsProvider>(
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
        body: Consumer<AdminRefundsProvider>(
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
                  title: context.l10n.refunds,
                  json: provider.refunds,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.load,
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.updateRefund,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _refundIdController,
                  label: context.l10n.refundId,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _patchController,
                  enabled: !provider.isLoading,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _submitPatch,
                    child: Text(context.l10n.update),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.lastResult,
                  json: provider.lastUpdateResult,
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
