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
import '../provider/admin_users_provider.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late final AdminUsersProvider _provider;

  final _queryController = TextEditingController();
  final _roleController = TextEditingController();
  final _userIdController = TextEditingController();
  final _updatePayloadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = AdminUsersProvider();
  }

  @override
  void dispose() {
    _queryController.dispose();
    _roleController.dispose();
    _userIdController.dispose();
    _updatePayloadController.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final query = _queryController.text.trim();
    if (query.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    await _provider.searchUsers(
      query: query,
      role: _roleController.text.trim().isEmpty
          ? null
          : _roleController.text.trim(),
    );
  }

  Future<void> _loadDetail() async {
    final userId = _userIdController.text.trim();
    if (userId.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    await _provider.loadUserDetail(userId);
  }

  Future<void> _updateUser() async {
    final userId = _userIdController.text.trim();
    if (userId.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.updateUser(
      userId: userId,
      jsonText: _updatePayloadController.text,
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadUserDetail(userId);
    } else {
      if (_provider.invalidJson) {
        GlobalSnackBar.showError(context.l10n.invalidJsonPayload);
      } else {
        GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
      }
    }
  }

  Future<void> _action(Future<bool> Function(String userId) action) async {
    final userId = _userIdController.text.trim();
    if (userId.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await action(userId);
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadUserDetail(userId);
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
          title: Text(context.l10n.usersManagement),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminUsersProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : () => _search(),
                  icon: const HugeIcon(icon: HugeIcons.strokeRoundedRefresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminUsersProvider>(
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
                Text(
                  context.l10n.searchUsers,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _queryController,
                  label: context.l10n.searchQuery,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _roleController,
                  label: context.l10n.roleOptional,
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
                  context.l10n.userDetail,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _userIdController,
                  label: context.l10n.userId,
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
                  json: provider.userDetail,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _loadDetail,
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.updateUser,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                JsonPayloadField(
                  controller: _updatePayloadController,
                  enabled: !provider.isLoading,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _updateUser,
                    child: Text(context.l10n.update),
                  ),
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
                              : () => _action(_provider.suspendUser),
                          child: Text(context.l10n.suspend),
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
                              : () => _action(_provider.activateUser),
                          child: Text(context.l10n.activate),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () => _action(_provider.softDeleteUser),
                    child: Text(context.l10n.softDelete),
                  ),
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
