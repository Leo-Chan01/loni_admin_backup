import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/global_snackbar.dart';
import '../../../../shared/widgets/json_payload_field.dart';
import '../../../../shared/widgets/json_preview_card.dart';
import '../provider/admin_economics_provider.dart';

class EconomicsScreen extends StatefulWidget {
  const EconomicsScreen({super.key});

  @override
  State<EconomicsScreen> createState() => _EconomicsScreenState();
}

class _EconomicsScreenState extends State<EconomicsScreen> {
  late final AdminEconomicsProvider _provider;
  final _payloadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = AdminEconomicsProvider()..load();
  }

  @override
  void dispose() {
    _payloadController.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _submitUpdate() async {
    final ok = await _provider.update(jsonText: _payloadController.text);
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
          title: Text(context.l10n.economics),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminEconomicsProvider>(
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
        body: Consumer<AdminEconomicsProvider>(
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
                  title: context.l10n.currentEconomics,
                  json: provider.economics,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.load,
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.updateEconomics,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _payloadController,
                  enabled: !provider.isLoading,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _submitUpdate,
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
