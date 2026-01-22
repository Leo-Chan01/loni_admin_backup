import 'package:flutter/foundation.dart';

import '../../data/services/admin_backorders_service.dart';

class AdminBackordersProvider extends ChangeNotifier {
  AdminBackordersProvider({AdminBackordersService? service})
    : _service = service ?? AdminBackordersService();

  final AdminBackordersService _service;

  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? _summary;
  Map<String, dynamic>? _backorders;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Map<String, dynamic>? get summary => _summary;
  Map<String, dynamic>? get backorders => _backorders;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final summaryRes = await _service.getBackordersSummary();
      final listRes = await _service.getBackorders();

      if (summaryRes['success'] == true) {
        _summary = _asMap(summaryRes['data']);
      }
      if (listRes['success'] == true) {
        _backorders = _asMap(listRes['data']);
      }

      final failed = [summaryRes, listRes].where((r) => r['success'] != true);
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
