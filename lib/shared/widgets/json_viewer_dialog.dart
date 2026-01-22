import 'package:flutter/material.dart';

import '../../l10n/l10n_extensions.dart';
import '../../shared/utils/json_pretty.dart';

class JsonViewerDialog extends StatelessWidget {
  const JsonViewerDialog({
    super.key,
    required this.title,
    required this.json,
  });

  final String title;
  final Object json;

  @override
  Widget build(BuildContext context) {
    final text = JsonPretty.stringify(json);

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(child: SelectableText(text)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.l10n.close),
        ),
      ],
    );
  }
}
