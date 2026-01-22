import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../data/services/admin_ledger_service.dart';

class AdminLedgerProvider extends ChangeNotifier {
  AdminLedgerProvider({AdminLedgerService? service})
    : _service = service ?? AdminLedgerService();

  final AdminLedgerService _service;

  bool _isLoading = false;
  String? _error;
  bool _invalidJson = false;

  Map<String, dynamic>? _lastResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get invalidJson => _invalidJson;
  Map<String, dynamic>? get lastResult => _lastResult;

  Future<bool> postAdjustment({required String jsonText}) async {
    _isLoading = true;
    _error = null;
    _invalidJson = false;
    notifyListeners();

    try {
      final decoded = jsonDecode(jsonText);
      if (decoded is! Map<String, dynamic>) {
        _invalidJson = true;
        return false;
      }

      final res = await _service.postAdjustment(payload: decoded);
      if (res['success'] == true) {
        _lastResult = _asMap(res['data']);
        return true;
      }

      _error = res['message']?.toString();
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic>? _asMap(Object? data) {
    if (data is Map<String, dynamic>) return data;
    if (data == null) return null;
    return {'data': data};
  }
}
