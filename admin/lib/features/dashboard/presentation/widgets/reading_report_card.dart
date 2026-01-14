import 'package:flutter/material.dart';

import '../../../../l10n/l10n_extensions.dart';
import '../../../../shared/widgets/json_preview_card.dart';

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
    return JsonPreviewCard(
      title: context.l10n.readingReport,
      json: report,
      isLoading: isLoading,
      error: error,
      onRefresh: onRefresh,
    );
  }
}
