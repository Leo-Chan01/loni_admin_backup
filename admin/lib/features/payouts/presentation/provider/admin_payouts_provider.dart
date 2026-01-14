import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../data/services/admin_payouts_service.dart';

class AdminPayoutsProvider extends ChangeNotifier {
  AdminPayoutsProvider({AdminPayoutsService? service})
    : _service = service ?? AdminPayoutsService();

  final AdminPayoutsService _service;

  bool _isLoading = false;
  String? _error;
  bool _invalidJson = false;

  Map<String, dynamic>? _balances;
  Map<String, dynamic>? _pending;
  Map<String, dynamic>? _statements;
  Map<String, dynamic>? _batches;

  Map<String, dynamic>? _lastActionResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get invalidJson => _invalidJson;

  Map<String, dynamic>? get balances => _balances;
  Map<String, dynamic>? get pending => _pending;
  Map<String, dynamic>? get statements => _statements;
  Map<String, dynamic>? get batches => _batches;
  Map<String, dynamic>? get lastActionResult => _lastActionResult;

  Future<void> loadAll() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final balancesRes = await _service.getBalances();
      final pendingRes = await _service.getPending();
      final statementsRes = await _service.getStatements();
      final batchesRes = await _service.getBatches();

      if (balancesRes['success'] == true) {
        _balances = _asMap(balancesRes['data']);
      }
      if (pendingRes['success'] == true) {
        _pending = _asMap(pendingRes['data']);
      }
      if (statementsRes['success'] == true) {
        _statements = _asMap(statementsRes['data']);
      }
      if (batchesRes['success'] == true) {
        _batches = _asMap(batchesRes['data']);
      }

      final failed = [
        balancesRes,
        pendingRes,
        statementsRes,
        batchesRes,
      ].where((r) => r['success'] != true);
      if (failed.isNotEmpty) {
        _error = failed.map((r) => r['message']?.toString() ?? '').join('\n');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createBatch({required String jsonText}) async {
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

      final res = await _service.createBatch(payload: decoded);
      if (res['success'] == true) {
        _lastActionResult = _asMap(res['data']);
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

  Future<bool> runScheduler({String? jsonText}) async {
    _isLoading = true;
    _error = null;
    _invalidJson = false;
    notifyListeners();

    try {
      Map<String, dynamic>? payload;
      if (jsonText != null && jsonText.trim().isNotEmpty) {
        final decoded = jsonDecode(jsonText);
        if (decoded is! Map<String, dynamic>) {
          _invalidJson = true;
          return false;
        }
        payload = decoded;
      }

      final res = await _service.runScheduler(payload: payload);
      if (res['success'] == true) {
        _lastActionResult = _asMap(res['data']);
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

  Future<bool> exportBatch({required String batchId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.exportBatch(batchId: batchId);
      if (res['success'] == true) {
        _lastActionResult = _asMap(res['data']);
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
