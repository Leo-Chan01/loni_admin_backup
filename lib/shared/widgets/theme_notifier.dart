import 'package:flutter/material.dart';

class ThemeNotifier extends InheritedWidget {
  const ThemeNotifier({
    required this.themeMode,
    required this.onToggle,
    required super.child,
    super.key,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggle;

  static ThemeNotifier? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeNotifier>();
  }

  static ThemeNotifier of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No ThemeNotifier found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ThemeNotifier oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
