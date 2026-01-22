import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:loni_admin/core/services/api_client.dart';
import '../../data/services/admin_user_service.dart';

class AdminUsersProvider extends ChangeNotifier {
  AdminUsersProvider({AdminUserService? service})
    : _service = service ?? AdminUserService(ApiClient.instance);

  final AdminUserService _service;

  bool _isLoading = false;
  String? _error;
  bool _invalidJson = false;

  Map<String, dynamic>? _searchResults;
  Map<String, dynamic>? _userDetail;
  Map<String, dynamic>? _lastResult;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get invalidJson => _invalidJson;

  Map<String, dynamic>? get searchResults => _searchResults;
  Map<String, dynamic>? get userDetail => _userDetail;
  Map<String, dynamic>? get lastResult => _lastResult;

  Future<void> searchUsers({required String query, String? role}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.searchUsers(query: query, role: role);
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

  Future<void> loadUserDetail(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getUserDetail(userId);
      if (res['success'] == true) {
        _userDetail = _asMap(res['data']);
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

  Future<bool> updateUser({
    required String userId,
    required String jsonText,
  }) async {
    return _jsonAction(
      jsonText: jsonText,
      action: (payload) => _service.updateUser(userId: userId, data: payload),
    );
  }

  Future<bool> suspendUser(String userId) async {
    return _simpleAction(() => _service.suspendUser(userId));
  }

  Future<bool> activateUser(String userId) async {
    return _simpleAction(() => _service.activateUser(userId));
  }

  Future<bool> softDeleteUser(String userId) async {
    return _simpleAction(() => _service.softDeleteUser(userId));
  }

  Future<bool> _simpleAction(
    Future<Map<String, dynamic>> Function() action,
  ) async {
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
