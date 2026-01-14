import '../../../../core/network/api_client.dart';

class AdminSystemService {
  AdminSystemService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getHealth() async {
    try {
      final response = await _apiClient.dio.get('/admin/health');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getOverview() async {
    try {
      final response = await _apiClient.dio.get('/admin/overview');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSummary() async {
    try {
      final response = await _apiClient.dio.get('/admin/summary');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getAudit({int limit = 50, int offset = 0}) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/audit',
        queryParameters: {'limit': limit, 'offset': offset},
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSystemStatus() async {
    try {
      final response = await _apiClient.dio.get('/admin/system/status');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSystemFeatures() async {
    try {
      final response = await _apiClient.dio.get('/admin/system/features');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSystemRoles() async {
    try {
      final response = await _apiClient.dio.get('/admin/system/roles');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSystemSettings() async {
    try {
      final response = await _apiClient.dio.get('/admin/system/settings');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
