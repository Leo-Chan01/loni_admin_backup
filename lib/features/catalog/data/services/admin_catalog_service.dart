import '../../../../core/services/api_client.dart';

class AdminCatalogService {
  final ApiClient _apiClient;

  AdminCatalogService(this._apiClient);

  Future<Map<String, dynamic>> getComplianceFlags() async {
    try {
      final response = await _apiClient.dio.get('/admin/catalog/flags');

      return {
        'success': true,
        'data': response.data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getItemCompliance(String itemId) async {
    try {
      final response = await _apiClient.dio
          .get('/admin/catalog/items/$itemId/compliance');

      return {
        'success': true,
        'data': response.data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateItemCompliance({
    required String itemId,
    required Map<String, dynamic> complianceData,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/items/$itemId/compliance',
        data: complianceData,
      );

      return {
        'success': true,
        'data': response.data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> updateFlagStatus({
    required String flagId,
    required String status,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/flags/$flagId/status',
        data: {'status': status},
      );

      return {
        'success': true,
        'data': response.data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> getComplianceRules() async {
    try {
      final response = await _apiClient.dio.get('/admin/catalog/compliance');

      return {
        'success': true,
        'data': response.data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
