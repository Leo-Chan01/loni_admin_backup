import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/l10n_extensions.dart';
import '../../shared/utils/json_pretty.dart';
import '../../shared/widgets/global_snackbar.dart';
import 'json_viewer_dialog.dart';

class JsonPreviewCard extends StatelessWidget {
  const JsonPreviewCard({
    super.key,
    required this.title,
    required this.json,
    this.isLoading = false,
    this.error,
    this.onRefresh,
  });

  final String title;
  final Map<String, dynamic>? json;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final hasJson = json != null && json!.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(title, style: textTheme.titleLarge)),
                IconButton(
                  tooltip: context.l10n.viewJson,
                  onPressed: hasJson ? () => _showJson(context, json!) : null,
                  icon: const Icon(Icons.code),
                ),
                IconButton(
                  tooltip: context.l10n.copyJson,
                  onPressed: hasJson ? () => _copyJson(context, json!) : null,
                  icon: const Icon(Icons.copy),
                ),
                if (onRefresh != null)
                  IconButton(
                    tooltip: context.l10n.refresh,
                    onPressed: onRefresh,
                    icon: const Icon(Icons.refresh),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (error != null)
              Text(
                error!,
                style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
              )
            else if (!hasJson)
              Text(context.l10n.noDataAvailable, style: textTheme.bodyMedium)
            else
              KeyValuePreview(data: json!),
          ],
        ),
      ),
    );
  }

  void _copyJson(BuildContext context, Map<String, dynamic> json) {
    Clipboard.setData(ClipboardData(text: JsonPretty.stringify(json)));
    GlobalSnackBar.showInfo(context.l10n.copiedToClipboard);
  }

  void _showJson(BuildContext context, Map<String, dynamic> json) {
    showDialog<void>(
      context: context,
      builder: (context) => JsonViewerDialog(title: title, json: json),
    );
  }
}

class KeyValuePreview extends StatelessWidget {
  const KeyValuePreview({super.key, required this.data, this.maxRows = 10});

  final Map<String, dynamic> data;
  final int maxRows;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final entries =
        data.entries
            .where(
              (e) =>
                  e.value == null ||
                  e.value is num ||
                  e.value is bool ||
                  e.value is String,
            )
            .toList(growable: false)
          ..sort((a, b) => a.key.compareTo(b.key));

    final shown = entries.take(maxRows).toList(growable: false);
    if (shown.isEmpty) {
      return Text(JsonPretty.stringify(data), style: textTheme.bodySmall);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in shown)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    entry.key,
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 4,
                  child: Text(
                    _formatValue(context, entry.value),
                    style: textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  String _formatValue(BuildContext context, Object? value) {
    if (value == null) return context.l10n.notAvailable;
    if (value is String) return value;
    if (value is num || value is bool) return value.toString();
    return value.toString();
  }
}
