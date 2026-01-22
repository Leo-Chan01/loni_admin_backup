import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../../../shared/widgets/global_snackbar.dart';
import '../../../../shared/widgets/json_preview_card.dart';
import '../provider/admin_moderation_provider.dart';

class ModerationTasksScreen extends StatefulWidget {
  const ModerationTasksScreen({super.key});

  @override
  State<ModerationTasksScreen> createState() => _ModerationTasksScreenState();
}

class _ModerationTasksScreenState extends State<ModerationTasksScreen> {
  late final AdminModerationProvider _provider;

  final _taskIdController = TextEditingController();
  final _statusController = TextEditingController();
  final _reviewerNotesController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _provider = AdminModerationProvider()..loadTasks();
  }

  @override
  void dispose() {
    _taskIdController.dispose();
    _statusController.dispose();
    _reviewerNotesController.dispose();
    _noteController.dispose();
    _provider.dispose();
    super.dispose();
  }

  Future<void> _loadDetail() async {
    final id = _taskIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    await _provider.loadTaskDetail(id);
  }

  Future<void> _loadEvents() async {
    final id = _taskIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }
    await _provider.loadTaskEvents(id);
  }

  Future<void> _updateStatus() async {
    final id = _taskIdController.text.trim();
    final status = _statusController.text.trim();
    if (id.isEmpty || status.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.updateStatus(
      taskId: id,
      status: status,
      reviewerNotes: _reviewerNotesController.text.trim().isEmpty
          ? null
          : _reviewerNotesController.text.trim(),
      note: _noteController.text.trim().isEmpty
          ? null
          : _noteController.text.trim(),
    );
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
      await _provider.loadTaskDetail(id);
      await _provider.loadTaskEvents(id);
      await _provider.loadTasks();
    } else {
      GlobalSnackBar.showError(_provider.error ?? context.l10n.updateFailed);
    }
  }

  Future<void> _downloadEpub() async {
    final id = _taskIdController.text.trim();
    if (id.isEmpty) {
      GlobalSnackBar.showWarning(context.l10n.pleaseFillAllFields);
      return;
    }

    final ok = await _provider.downloadEpub(id);
    if (!mounted) return;

    if (ok) {
      GlobalSnackBar.showSuccess(context.l10n.updatedSuccessfully);
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
          title: Text(context.l10n.moderationTasks),
          leading: IconButton(
            icon: const HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01),
            onPressed: () => context.go('/dashboard'),
          ),
          actions: [
            Consumer<AdminModerationProvider>(
              builder: (context, provider, _) {
                return IconButton(
                  tooltip: context.l10n.refresh,
                  onPressed: provider.isLoading ? null : provider.loadTasks,
                  icon: const HugeIcon(icon: HugeIcons.strokeRoundedRefresh),
                );
              },
            ),
          ],
        ),
        body: Consumer<AdminModerationProvider>(
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
                  title: context.l10n.moderationTasksList,
                  json: provider.tasks,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: provider.loadTasks,
                ),
                SizedBox(height: 24.h),
                Text(
                  context.l10n.taskActions,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _taskIdController,
                  label: context.l10n.taskId,
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _loadDetail,
                          child: Text(context.l10n.loadDetail),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton(
                          onPressed: provider.isLoading ? null : _loadEvents,
                          child: Text(context.l10n.loadEvents),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.taskDetail,
                  json: provider.taskDetail,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _loadDetail,
                ),
                SizedBox(height: 12.h),
                JsonPreviewCard(
                  title: context.l10n.taskEvents,
                  json: provider.taskEvents,
                  isLoading: provider.isLoading,
                  error: null,
                  onRefresh: _loadEvents,
                ),
                SizedBox(height: 16.h),
                Text(
                  context.l10n.updateTaskStatus,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _statusController,
                  label: context.l10n.status,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _reviewerNotesController,
                  label: context.l10n.reviewerNotesOptional,
                ),
                SizedBox(height: 12.h),
                AppTextField(
                  controller: _noteController,
                  label: context.l10n.noteOptional,
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _updateStatus,
                    child: Text(context.l10n.update),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : _downloadEpub,
                    child: Text(context.l10n.downloadEpub),
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
