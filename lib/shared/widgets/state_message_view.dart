import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'primary_button.dart';

class StateMessageView extends StatelessWidget {
  const StateMessageView({
    super.key,
    required this.title,
    required this.message,
    this.actionText,
    this.onAction,
  });

  final String title;
  final String message;
  final String? actionText;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          if (actionText != null && onAction != null) ...[
            SizedBox(height: 16.h),
            PrimaryButton(label: actionText!, onPressed: onAction),
          ],
        ],
      ),
    );
  }
}
