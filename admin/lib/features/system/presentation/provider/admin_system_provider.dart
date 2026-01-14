import 'package:flutter/foundation.dart';

import '../../data/services/admin_system_service.dart';

class AdminSystemProvider extends ChangeNotifier {
  AdminSystemProvider({AdminSystemService? service})
    : _service = service ?? AdminSystemService();

  final AdminSystemService _service;

  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? _health;
  Map<String, dynamic>? _overview;
  Map<String, dynamic>? _summary;
  Map<String, dynamic>? _audit;
  Map<String, dynamic>? _systemStatus;
  Map<String, dynamic>? _systemFeatures;
  Map<String, dynamic>? _systemRoles;
  Map<String, dynamic>? _systemSettings;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Map<String, dynamic>? get health => _health;
  Map<String, dynamic>? get overview => _overview;
  Map<String, dynamic>? get summary => _summary;
  Map<String, dynamic>? get audit => _audit;
  Map<String, dynamic>? get systemStatus => _systemStatus;
  Map<String, dynamic>? get systemFeatures => _systemFeatures;
  Map<String, dynamic>? get systemRoles => _systemRoles;
  Map<String, dynamic>? get systemSettings => _systemSettings;

  Future<void> loadAll() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final healthRes = await _service.getHealth();
      final overviewRes = await _service.getOverview();
      final summaryRes = await _service.getSummary();
      final auditRes = await _service.getAudit();
      final statusRes = await _service.getSystemStatus();
      final featuresRes = await _service.getSystemFeatures();
      final rolesRes = await _service.getSystemRoles();
      final settingsRes = await _service.getSystemSettings();

      _health = _asMap(healthRes['data']);
      _overview = _asMap(overviewRes['data']);
      _summary = _asMap(summaryRes['data']);
      _audit = _asMap(auditRes['data']);
      _systemStatus = _asMap(statusRes['data']);
      _systemFeatures = _asMap(featuresRes['data']);
      _systemRoles = _asMap(rolesRes['data']);
      _systemSettings = _asMap(settingsRes['data']);

      final failed = [
        healthRes,
        overviewRes,
        summaryRes,
        auditRes,
        statusRes,
        featuresRes,
        rolesRes,
        settingsRes,
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

  Map<String, dynamic>? _asMap(Object? data) {
    if (data is Map<String, dynamic>) return data;
    if (data == null) return null;
    return {'data': data};
  }
}
