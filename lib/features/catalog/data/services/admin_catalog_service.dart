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

  Future<Map<String, dynamic>> createComplianceRule({
    required Map<String, dynamic> rule,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/compliance',
        data: rule,
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateComplianceRule({
    required String ruleId,
    required Map<String, dynamic> patch,
  }) async {
    try {
      final response = await _apiClient.dio.patch(
        '/admin/catalog/compliance/$ruleId',
        data: patch,
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteComplianceRule({
    required String ruleId,
  }) async {
    try {
      final response = await _apiClient.dio.delete(
        '/admin/catalog/compliance/$ruleId',
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> simulateCompliance({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/compliance/simulate',
        data: payload,
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getFeatured() async {
    try {
      final response = await _apiClient.dio.get('/admin/catalog/featured');

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> setFeatured({
    required String itemId,
    Map<String, dynamic>? payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/featured/$itemId',
        data: payload ?? {},
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> searchContent({
    required String query,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/content/search',
        queryParameters: {
          'q': query,
          'limit': limit,
          'offset': offset,
        },
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getCatalogItem(String itemId) async {
    try {
      final response = await _apiClient.dio.get('/admin/catalog/items/$itemId');

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> scheduleLifecycle({
    required String itemId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _apiClient.dio.put(
        '/admin/catalog/items/$itemId/lifecycle/schedule',
        data: payload,
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> publishLifecycle({
    required String itemId,
    Map<String, dynamic>? payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/items/$itemId/lifecycle/publish',
        data: payload ?? {},
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> unpublishLifecycle({
    required String itemId,
    Map<String, dynamic>? payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/items/$itemId/lifecycle/unpublish',
        data: payload ?? {},
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> cancelLifecycle({
    required String itemId,
    Map<String, dynamic>? payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/catalog/items/$itemId/lifecycle/cancel',
        data: payload ?? {},
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
