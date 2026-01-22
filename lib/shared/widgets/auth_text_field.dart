import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.prefix,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final String hintText;
  final Widget? prefix;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: textTheme.labelSmall?.copyWith(
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          obscureText: widget.isPassword,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          style: textTheme.bodyMedium?.copyWith(fontSize: 15.sp),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withValues(alpha: 0.4),
              fontSize: 15.sp,
            ),
            prefixIcon:
                widget.prefix ??
                (widget.prefixIcon != null
                    ? Icon(
                        widget.prefixIcon,
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        size: 20.sp,
                      )
                    : null),
            suffixIcon: widget.suffixIcon,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
            errorStyle: textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
