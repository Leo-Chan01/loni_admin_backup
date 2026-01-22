import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../data/services/admin_markets_service.dart';

class AdminMarketsProvider extends ChangeNotifier {
  AdminMarketsProvider({AdminMarketsService? service})
    : _service = service ?? AdminMarketsService();

  final AdminMarketsService _service;

  bool _isLoading = false;
  String? _error;
  bool _invalidJson = false;

  Map<String, dynamic>? _regionPresets;
  Map<String, dynamic>? _lastUpdateResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get invalidJson => _invalidJson;

  Map<String, dynamic>? get regionPresets => _regionPresets;
  Map<String, dynamic>? get lastUpdateResult => _lastUpdateResult;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getRegionPresets();
      if (res['success'] == true) {
        _regionPresets = _asMap(res['data']);
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

  Future<bool> update({required String jsonText}) async {
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

      final res = await _service.updateRegionPresets(payload: decoded);
      if (res['success'] == true) {
        _lastUpdateResult = _asMap(res['data']);
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
