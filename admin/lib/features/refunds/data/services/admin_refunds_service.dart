import '../../../../core/network/api_client.dart';

class AdminRefundsService {
  AdminRefundsService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getRefunds({int limit = 50, int offset = 0}) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/refunds',
        queryParameters: {'limit': limit, 'offset': offset},
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateRefund({
    required String refundId,
    required Map<String, dynamic> patch,
  }) async {
    try {
      final response = await _apiClient.dio.patch(
        '/admin/refunds/$refundId',
        data: patch,
      );

      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
