import '../../../../core/network/admin_api.dart';

class AdminDashboardService {
  AdminDashboardService({AdminApi? adminApi})
    : _adminApi = adminApi ?? AdminApi();

  final AdminApi _adminApi;

  Future<Map<String, dynamic>> getDashboard() async {
    try {
      return {'success': true, 'data': await _adminApi.getOverview()};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSummary() async {
    try {
      return {'success': true, 'data': await _adminApi.getSummary()};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getAuditLogs({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      return {
        'success': true,
        'data': await _adminApi.getAudit(limit: limit, offset: offset),
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      return {'success': true, 'data': await _adminApi.getSystemStatus()};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getReadingReport() async {
    try {
      return {'success': true, 'data': await _adminApi.getReadingReport()};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
