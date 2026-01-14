import 'package:flutter/foundation.dart';

import '../../data/services/admin_dashboard_service.dart';

class AdminReadingReportProvider extends ChangeNotifier {
  AdminReadingReportProvider({AdminDashboardService? dashboardService})
    : _dashboardService = dashboardService ?? AdminDashboardService();

  final AdminDashboardService _dashboardService;

  bool _isLoading = false;
  String? _error;
  Map<String, dynamic>? _report;

  bool get isLoading => _isLoading;
  String? get error => _error;
  Map<String, dynamic>? get report => _report;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _dashboardService.getReadingReport();
      final success = response['success'] == true;
      if (!success) {
        _error = response['message'] as String?;
        _report = null;
        _isLoading = false;
        notifyListeners();
        return;
      }

      final data = response['data'];
      _report = data is Map<String, dynamic> ? data : <String, dynamic>{};
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _report = null;
      _isLoading = false;
      notifyListeners();
    }
  }
}
