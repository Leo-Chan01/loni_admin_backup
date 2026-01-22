import 'package:flutter/foundation.dart';

import 'package:loni_admin/core/services/api_client.dart';
import '../../data/services/admin_moderation_service.dart';

class AdminModerationProvider extends ChangeNotifier {
  AdminModerationProvider({AdminModerationService? service})
    : _service = service ?? AdminModerationService(ApiClient.instance);

  final AdminModerationService _service;

  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? _tasks;
  Map<String, dynamic>? _taskDetail;
  Map<String, dynamic>? _taskEvents;
  Map<String, dynamic>? _lastResult;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Map<String, dynamic>? get tasks => _tasks;
  Map<String, dynamic>? get taskDetail => _taskDetail;
  Map<String, dynamic>? get taskEvents => _taskEvents;
  Map<String, dynamic>? get lastResult => _lastResult;

  Future<void> loadTasks() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getModerationTasks();
      if (res['success'] == true) {
        _tasks = _asMap(res['data']);
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

  Future<void> loadTaskDetail(String taskId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getTaskDetail(taskId);
      if (res['success'] == true) {
        _taskDetail = _asMap(res['data']);
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

  Future<void> loadTaskEvents(String taskId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getTaskEvents(taskId);
      if (res['success'] == true) {
        _taskEvents = _asMap(res['data']);
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

  Future<bool> updateStatus({
    required String taskId,
    required String status,
    String? reviewerNotes,
    String? note,
  }) async {
    return _action(
      () => _service.updateTaskStatus(
        taskId: taskId,
        status: status,
        reviewerNotes: reviewerNotes,
        note: note,
      ),
    );
  }

  Future<bool> downloadEpub(String taskId) async {
    return _action(() => _service.downloadTaskEpub(taskId));
  }

  Future<bool> _action(Future<Map<String, dynamic>> Function() action) async {
    _isLoading = true;
    _error = null;
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

  Map<String, dynamic>? _asMap(Object? data) {
    if (data is Map<String, dynamic>) return data;
    if (data == null) return null;
    return {'data': data};
  }
}
