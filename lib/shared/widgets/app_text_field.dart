import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    this.hintText,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.minLines,
    this.maxLines = 1,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final Widget? prefix;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final int? minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: textTheme.labelSmall?.copyWith(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          style: textTheme.bodyMedium?.copyWith(fontSize: 15.sp),
          decoration: InputDecoration(
            hintText: hintText ?? label,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.4),
              fontSize: 15.sp,
            ),
            prefixIcon:
                prefix ??
                (prefixIcon != null
                    ? Icon(
                        prefixIcon,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        size: 20.sp,
                      )
                    : null),
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            filled: true,
            fillColor: colorScheme.surface.withValues(alpha: 0.03),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: colorScheme.onSurface.withValues(alpha: 0.08),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
