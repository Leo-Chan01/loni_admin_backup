import 'dart:convert';

class JsonPretty {
  static String stringify(Object? value) {
    if (value == null) return 'null';

    try {
      return const JsonEncoder.withIndent('  ').convert(value);
    } catch (_) {
      return value.toString();
    }
  }
}
