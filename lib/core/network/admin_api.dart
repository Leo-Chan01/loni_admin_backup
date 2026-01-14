import 'package:dio/dio.dart';

import 'api_client.dart';
import 'api_exception.dart';

class AdminApi {
  AdminApi({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  /// GET /v1/admin/health
  Future<Map<String, dynamic>> getHealth() async {
    return _getJson('/admin/health');
  }

  /// GET /v1/admin/overview
  Future<Map<String, dynamic>> getOverview({List<String>? include}) async {
    return _getJson(
      '/admin/overview',
      queryParameters: {
        if (include != null && include.isNotEmpty) 'include': include,
      },
    );
  }

  /// GET /v1/admin/summary
  Future<Map<String, dynamic>> getSummary() async {
    return _getJson('/admin/summary');
  }

  /// GET /v1/admin/audit
  Future<Map<String, dynamic>> getAudit({
    int limit = 50,
    int offset = 0,
  }) async {
    return _getJson(
      '/admin/audit',
      queryParameters: {'limit': limit, 'offset': offset},
    );
  }

  /// GET /v1/admin/system/status
  Future<Map<String, dynamic>> getSystemStatus() async {
    return _getJson('/admin/system/status');
  }

  /// GET /v1/admin/analytics/reading-report
  Future<Map<String, dynamic>> getReadingReport() async {
    return _getJson('/admin/analytics/reading-report');
  }

  Future<Map<String, dynamic>> _getJson(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        path,
        queryParameters: queryParameters,
      );

      final data = response.data;
      if (data is Map<String, dynamic>) return data;

      throw ApiException(message: 'Unexpected response from server.');
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
