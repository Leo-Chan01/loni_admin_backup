import '../../../../core/network/api_client.dart';

class AdminBackordersService {
  AdminBackordersService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getBackordersSummary() async {
    try {
      final response = await _apiClient.dio.get('/admin/backorders/summary');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getBackorders({int limit = 50, int offset = 0}) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/backorders',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
