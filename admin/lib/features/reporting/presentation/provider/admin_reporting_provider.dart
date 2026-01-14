import 'package:flutter/foundation.dart';

import '../../data/services/admin_reporting_service.dart';

class AdminReportingProvider extends ChangeNotifier {
  AdminReportingProvider({AdminReportingService? service})
    : _service = service ?? AdminReportingService();

  final AdminReportingService _service;

  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? _reporting;
  Map<String, dynamic>? _lastExportResult;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Map<String, dynamic>? get reporting => _reporting;
  Map<String, dynamic>? get lastExportResult => _lastExportResult;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getReporting();
      if (res['success'] == true) {
        _reporting = _asMap(res['data']);
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

  Future<bool> export() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.exportReporting();
      if (res['success'] == true) {
        _lastExportResult = _asMap(res['data']);
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
