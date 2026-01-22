import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shadowColor: colorScheme.primary.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.5),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150),
          child: isLoading
              ? SizedBox(
                  key: const ValueKey('loading'),
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(
                  label,
                  key: const ValueKey('label'),
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onPrimary,
                  ),
                ),
        ),
      ),
    );
  }
}
