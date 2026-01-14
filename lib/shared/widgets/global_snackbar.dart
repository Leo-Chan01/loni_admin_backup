import 'package:flutter/material.dart';

enum SnackBarType { success, error, warning, info }

class GlobalSnackBar {
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey =>
      _scaffoldMessengerKey;

  static void hide() {
    final scaffoldMessenger = _scaffoldMessengerKey.currentState;
    if (scaffoldMessenger == null || !scaffoldMessenger.mounted) return;
    scaffoldMessenger.hideCurrentSnackBar();
  }

  static void showSuccess(String message, {Duration? duration}) {
    _show(message: message, type: SnackBarType.success, duration: duration);
  }

  static void showError(String message, {Duration? duration}) {
    _show(message: message, type: SnackBarType.error, duration: duration);
  }

  static void showWarning(String message, {Duration? duration}) {
    _show(message: message, type: SnackBarType.warning, duration: duration);
  }

  static void showInfo(String message, {Duration? duration}) {
    _show(message: message, type: SnackBarType.info, duration: duration);
  }

  static void _show({
    required String message,
    required SnackBarType type,
    Duration? duration,
  }) {
    final context = _scaffoldMessengerKey.currentContext;
    if (context == null) return;

    final scaffoldMessenger = _scaffoldMessengerKey.currentState;
    if (scaffoldMessenger == null || !scaffoldMessenger.mounted) return;

    final theme = Theme.of(context);
    final config = _configFor(type, theme.colorScheme);

    scaffoldMessenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: duration ?? const Duration(seconds: 3),
          backgroundColor: config.background,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Row(
            children: [
              Icon(config.icon, color: config.foreground, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: config.foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }

  static _SnackBarConfig _configFor(SnackBarType type, ColorScheme scheme) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarConfig(
          background: scheme.secondaryContainer,
          foreground: scheme.onSecondaryContainer,
          icon: Icons.check_circle,
        );
      case SnackBarType.error:
        return _SnackBarConfig(
          background: scheme.errorContainer,
          foreground: scheme.onErrorContainer,
          icon: Icons.error,
        );
      case SnackBarType.warning:
        return _SnackBarConfig(
          background: scheme.tertiaryContainer,
          foreground: scheme.onTertiaryContainer,
          icon: Icons.warning,
        );
      case SnackBarType.info:
        return _SnackBarConfig(
          background: scheme.primaryContainer,
          foreground: scheme.onPrimaryContainer,
          icon: Icons.info,
        );
    }
  }
}

class _SnackBarConfig {
  const _SnackBarConfig({
    required this.background,
    required this.foreground,
    required this.icon,
  });

  final Color background;
  final Color foreground;
  final IconData icon;
}
