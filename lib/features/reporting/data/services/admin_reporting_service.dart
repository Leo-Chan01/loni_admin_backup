import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';

class AdminReportingService {
  AdminReportingService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getReporting() async {
    try {
      final response = await _apiClient.dio.get('/admin/reporting');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> exportReporting() async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/reporting/export',
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = response.data as List<int>?;
      return {
        'success': true,
        'data': {
          'bytesLength': bytes?.length ?? 0,
        },
        'bytes': bytes,
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
