import '../../../../core/network/api_client.dart';

class AdminEconomicsService {
  AdminEconomicsService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getEconomics() async {
    try {
      final response = await _apiClient.dio.get('/admin/economics');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateEconomics({required Map<String, dynamic> payload}) async {
    try {
      final response = await _apiClient.dio.put('/admin/economics', data: payload);
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
