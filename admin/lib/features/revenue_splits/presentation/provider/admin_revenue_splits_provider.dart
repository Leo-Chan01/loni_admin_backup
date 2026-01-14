import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../data/services/admin_revenue_splits_service.dart';

class AdminRevenueSplitsProvider extends ChangeNotifier {
  AdminRevenueSplitsProvider({AdminRevenueSplitsService? service})
    : _service = service ?? AdminRevenueSplitsService();

  final AdminRevenueSplitsService _service;

  bool _isLoading = false;
  String? _error;
  bool _invalidJson = false;

  Map<String, dynamic>? _splits;
  Map<String, dynamic>? _detail;
  Map<String, dynamic>? _lastResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get invalidJson => _invalidJson;

  Map<String, dynamic>? get splits => _splits;
  Map<String, dynamic>? get detail => _detail;
  Map<String, dynamic>? get lastResult => _lastResult;

  Future<void> loadList() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.listSplits();
      if (res['success'] == true) {
        _splits = _asMap(res['data']);
      } else {
        _error = res['message']?.toString();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDetail(String splitId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getSplit(splitId);
      if (res['success'] == true) {
        _detail = _asMap(res['data']);
      } else {
        _error = res['message']?.toString();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> create({required String jsonText}) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) => _service.createSplit(payload: payload),
    );
  }

  Future<bool> update({
    required String splitId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) =>
          _service.updateSplit(splitId: splitId, payload: payload),
    );
  }

  Future<bool> preview({required String jsonText}) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) => _service.previewSplit(payload: payload),
    );
  }

  Future<bool> delete(String splitId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.deleteSplit(splitId);
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

  Future<bool> _jsonAction({
    required String jsonText,
    required Future<Map<String, dynamic>> Function(Map<String, dynamic> payload)
    action,
  }) async {
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

      final res = await action(decoded);
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
