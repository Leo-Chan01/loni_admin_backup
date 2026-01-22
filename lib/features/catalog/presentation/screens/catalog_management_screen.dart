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
import '../provider/admin_catalog_provider.dart';

class CatalogManagementScreen extends StatefulWidget {
  const CatalogManagementScreen({super.key});

  @override
  State<CatalogManagementScreen> createState() =>
      _CatalogManagementScreenState();
}

class _CatalogManagementScreenState extends State<CatalogManagementScreen> {
  late final AdminCatalogProvider _provider;

  final _searchQueryController = TextEditingController();
  final _itemIdController = TextEditingController();
  final _flagIdController = TextEditingController();
  final _flagStatusController = TextEditingController();

  final _compliancePayloadController = TextEditingController();
  final _simulatePayloadController = TextEditingController();
  final _featuredPayloadController = TextEditingController();
  final _lifecyclePayloadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = AdminCatalogProvider()..loadOverview();
  }

  @override
  void dispose() {
    _searchQueryController.dispose();
    _itemIdController.dispose();
    _flagIdController.dispose();
    _flagStatusController.dispose();
    _compliancePayloadController.dispose();
    _simulatePayloadController.dispose();
    _featuredPayloadController.dispose();
    _lifecyclePayloadController.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final q = _searchQueryController.text.trim();
    if (q.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    await _provider.searchContent(q);
  }

  Future<void> _loadItem() async {
    final id = _itemIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    await _provider.loadItem(id);
  }

  Future<void> _updateCompliance() async {
    final id = _itemIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.updateItemCompliance(
      itemId: id,
      jsonText: _compliancePayloadController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadItem(id);
    } else {
      if (_provider.invalidJson) {
        GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
      } else {
        GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
      }
    }
  }

  Future<void> _simulate() async {
    final ok = await _provider.simulateCompliance(
      jsonText: _simulatePayloadController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
    } else {
      if (_provider.invalidJson) {
        GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
      } else {
        GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
      }
    }
  }

  Future<void> _updateFlagStatus() async {
    final flagId = _flagIdController.text.trim();
    final status = _flagStatusController.text.trim();
    if (flagId.isEmpty || status.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.updateFlagStatus(flagId: flagId, status: status);
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadOverview();
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
    }
  }

  Future<void> _setFeatured() async {
    final id = _itemIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.setFeatured(
      itemId: id,
      jsonText: _featuredPayloadController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadOverview();
    } else {
      if (_provider.invalidJson) {
        GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
      } else {
        GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
      }
    }
  }

  Future<void> _lifecycleAction(
    Future<bool> Function({required String itemId, required String jsonText})
    action,
  ) async {
    final id = _itemIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await action(
      itemId: id,
      jsonText: _lifecyclePayloadController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadItem(id);
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
          title: Text(context.l10n.catalogManagement),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminCatalogProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : provider.loadOverview,
                  icon: const HugeIcon(icon: HugeIcons.strokeRoundedRefresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminCatalogProvider>(
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
                  title: context.l10n.catalogFlags,
                  json: provider.flags,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadOverview,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.catalogComplianceRules,
                  json: provider.complianceRules,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadOverview,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.catalogFeatured,
                  json: provider.featured,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadOverview,
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.contentSearch,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _searchQueryController,
                  label: context.l10n.searchQuery,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _search,
                    child: Text(context.l10n.search),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.searchResults,
                  json: provider.searchResults,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _search,
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.catalogItem,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _itemIdController,
                  label: context.l10n.itemId,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _loadItem,
                    child: Text(context.l10n.loadDetail),
                  ),
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.detail,
                  json: provider.item,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _loadItem,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.itemCompliance,
                  json: provider.itemCompliance,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _loadItem,
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.updateItemCompliance,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _compliancePayloadController,
                  enabled: !provider.isLoading,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _updateCompliance,
                    child: Text(context.l10n.update),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.simulateCompliance,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _simulatePayloadController,
                  enabled: !provider.isLoading,
                  minLines: 3,
                  maxLines: 8,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _simulate,
                    child: Text(context.l10n.preview),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.updateFlagStatus,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _flagIdController,
                  label: context.l10n.flagId,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _flagStatusController,
                  label: context.l10n.status,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _updateFlagStatus,
                    child: Text(context.l10n.update),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.setFeatured,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _featuredPayloadController,
                  enabled: !provider.isLoading,
                  minLines: 2,
                  maxLines: 6,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _setFeatured,
                    child: Text(context.l10n.update),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.lifecycle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _lifecyclePayloadController,
                  enabled: !provider.isLoading,
                  minLines: 3,
                  maxLines: 8,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () => _lifecycleAction(
                                  _provider.scheduleLifecycle,
                                ),
                          child: Text(context.l10n.schedule),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () => _lifecycleAction(
                                  _provider.publishLifecycle,
                                ),
                          child: Text(context.l10n.publish),
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
                          onPressed: provider.isLoading
                              ? null
                              : () => _lifecycleAction(
                                  _provider.unpublishLifecycle,
                                ),
                          child: Text(context.l10n.unpublish),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading
                              ? null
                              : () =>
                                    _lifecycleAction(_provider.cancelLifecycle),
                          child: Text(context.l10n.cancel),
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
