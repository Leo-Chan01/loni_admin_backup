import 'package:flutter/material.dart';

import '../../l10n/l10n_extensions.dart';

class JsonPayloadField extends StatelessWidget {
  const JsonPayloadField({
    super.key,
    required this.controller,
    this.minLines = 6,
    this.maxLines = 12,
    this.enabled = true,
  });

  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: context.l10n.jsonPayload,
        hintText: context.l10n.jsonPayloadHint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
