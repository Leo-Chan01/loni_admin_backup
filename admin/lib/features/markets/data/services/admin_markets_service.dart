import '../../../../core/network/api_client.dart';

class AdminMarketsService {
  AdminMarketsService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getRegionPresets() async {
    try {
      final response = await _apiClient.dio.get('/admin/markets/region-presets');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateRegionPresets({required Map<String, dynamic> payload}) async {
    try {
      final response = await _apiClient.dio.put(
        '/admin/markets/region-presets',
        data: payload,
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
