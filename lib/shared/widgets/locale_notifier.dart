import 'package:flutter/material.dart';

class LocaleNotifier extends InheritedWidget {
  const LocaleNotifier({
    required this.locale,
    required this.onLocaleChange,
    required super.child,
    super.key,
  });

  final Locale? locale;
  final ValueChanged<Locale> onLocaleChange;

  static LocaleNotifier? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleNotifier>();
  }

  static LocaleNotifier of(BuildContext context) {
    final result = maybeOf(context);
    assert(result != null, 'No LocaleNotifier found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LocaleNotifier oldWidget) {
    return locale != oldWidget.locale;
  }
}
