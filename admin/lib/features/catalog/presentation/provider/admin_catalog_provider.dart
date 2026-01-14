import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:loni_admin/core/services/api_client.dart';
import '../../data/services/admin_catalog_service.dart';

class AdminCatalogProvider extends ChangeNotifier {
  AdminCatalogProvider({AdminCatalogService? service})
    : _service = service ?? AdminCatalogService(ApiClient.instance);

  final AdminCatalogService _service;

  bool _isLoading = false;
  String? _error;
  bool _invalidJson = false;

  Map<String, dynamic>? _flags;
  Map<String, dynamic>? _complianceRules;
  Map<String, dynamic>? _featured;
  Map<String, dynamic>? _searchResults;
  Map<String, dynamic>? _item;
  Map<String, dynamic>? _itemCompliance;
  Map<String, dynamic>? _lastResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get invalidJson => _invalidJson;

  Map<String, dynamic>? get flags => _flags;
  Map<String, dynamic>? get complianceRules => _complianceRules;
  Map<String, dynamic>? get featured => _featured;
  Map<String, dynamic>? get searchResults => _searchResults;
  Map<String, dynamic>? get item => _item;
  Map<String, dynamic>? get itemCompliance => _itemCompliance;
  Map<String, dynamic>? get lastResult => _lastResult;

  Future<void> loadOverview() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final flagsRes = await _service.getComplianceFlags();
      final rulesRes = await _service.getComplianceRules();
      final featuredRes = await _service.getFeatured();

      if (flagsRes['success'] == true) {
        _flags = _asMap(flagsRes['data']);
      }
      if (rulesRes['success'] == true) {
        _complianceRules = _asMap(rulesRes['data']);
      }
      if (featuredRes['success'] == true) {
        _featured = _asMap(featuredRes['data']);
      }

      final failed = [flagsRes, rulesRes, featuredRes]
          .where((r) => r['success'] != true)
          .map((r) => r['message']?.toString() ?? '')
          .where((m) => m.trim().isNotEmpty)
          .toList();
      if (failed.isNotEmpty) {
        _error = failed.join('\n');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchContent(String query) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.searchContent(query: query);
      if (res['success'] == true) {
        _searchResults = _asMap(res['data']);
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

  Future<void> loadItem(String itemId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final itemRes = await _service.getCatalogItem(itemId);
      final complianceRes = await _service.getItemCompliance(itemId);

      if (itemRes['success'] == true) {
        _item = _asMap(itemRes['data']);
      }
      if (complianceRes['success'] == true) {
        _itemCompliance = _asMap(complianceRes['data']);
      }

      final failed = [itemRes, complianceRes]
          .where((r) => r['success'] != true)
          .map((r) => r['message']?.toString() ?? '')
          .where((m) => m.trim().isNotEmpty)
          .toList();
      if (failed.isNotEmpty) {
        _error = failed.join('\n');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateItemCompliance({
    required String itemId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) => _service.updateItemCompliance(
        itemId: itemId,
        complianceData: payload,
      ),
    );
  }

  Future<bool> simulateCompliance({required String jsonText}) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) => _service.simulateCompliance(payload: payload),
    );
  }

  Future<bool> updateFlagStatus({
    required String flagId,
    required String status,
  }) async {
    return _action(
      () => _service.updateFlagStatus(flagId: flagId, status: status),
    );
  }

  Future<bool> setFeatured({
    required String itemId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) =>
          _service.setFeatured(itemId: itemId, payload: payload),
    );
  }

  Future<bool> scheduleLifecycle({
    required String itemId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) =>
          _service.scheduleLifecycle(itemId: itemId, payload: payload),
    );
  }

  Future<bool> publishLifecycle({
    required String itemId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) =>
          _service.publishLifecycle(itemId: itemId, payload: payload),
    );
  }

  Future<bool> unpublishLifecycle({
    required String itemId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) =>
          _service.unpublishLifecycle(itemId: itemId, payload: payload),
    );
  }

  Future<bool> cancelLifecycle({
    required String itemId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) =>
          _service.cancelLifecycle(itemId: itemId, payload: payload),
    );
  }

  Future<bool> _action(Future<Map<String, dynamic>> Function() action) async {
    _isLoading = true;
    _error = null;
    _invalidJson = false;
    notifyListeners();

    try {
      final res = await action();
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
      final trimmed = jsonText.trim();
      final decoded = trimmed.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(trimmed);
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
