import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../l10n/l10n_extensions.dart';

class ReadingReportCard extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic>? report;
  final VoidCallback onRefresh;

  const ReadingReportCard({
    super.key,
    required this.isLoading,
    required this.error,
    required this.report,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final hasReport = report != null && report!.isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.readingReport,
                    style: textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  tooltip: context.l10n.viewJson,
                  onPressed: hasReport
                      ? () => _showJsonDialog(context, report!)
                      : null,
                  icon: const Icon(Icons.code),
                ),
                IconButton(
                  tooltip: context.l10n.copyJson,
                  onPressed: hasReport
                      ? () => _copyJson(context, report!)
                      : null,
                  icon: const Icon(Icons.copy),
                ),
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
            else if (report == null || report!.isEmpty)
              Text(context.l10n.noDataAvailable, style: textTheme.bodyMedium)
            else
              _KeyValuePreview(data: report!),
          ],
        ),
      ),
    );
  }

  void _copyJson(BuildContext context, Map<String, dynamic> report) {
    final jsonText = const JsonEncoder.withIndent('  ').convert(report);
    Clipboard.setData(ClipboardData(text: jsonText));

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.copiedToClipboard)));
  }

  void _showJsonDialog(BuildContext context, Map<String, dynamic> report) {
    final jsonText = const JsonEncoder.withIndent('  ').convert(report);

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.l10n.readingReport),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(child: SelectableText(jsonText)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.l10n.close),
            ),
          ],
        );
      },
    );
  }
}

class _KeyValuePreview extends StatelessWidget {
  const _KeyValuePreview({required this.data});

  final Map<String, dynamic> data;

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

    final shown = entries.take(8).toList(growable: false);
    if (shown.isEmpty) {
      return Text(
        const JsonEncoder.withIndent('  ').convert(data),
        style: textTheme.bodySmall,
      );
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
