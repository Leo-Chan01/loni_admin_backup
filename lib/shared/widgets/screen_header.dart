import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = false,
    this.onBackPressed,
    this.trailingWidget,
  });

  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBackButton || trailingWidget != null)
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (showBackButton)
                  IconButton(
                    onPressed:
                        onBackPressed ?? () => Navigator.of(context).pop(),
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft01,
                      color: colorScheme.onSurface,
                      size: 22.sp,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )
                else
                  const SizedBox.shrink(),
                if (trailingWidget != null) trailingWidget!,
              ],
            ),
          ),
        Text(
          title,
          style: textTheme.headlineLarge?.copyWith(
            fontSize: 32.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          subtitle,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
