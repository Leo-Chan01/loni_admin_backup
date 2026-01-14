import '../../../../core/network/api_client.dart';

class AdminRevenueSplitsService {
  AdminRevenueSplitsService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> listSplits({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/revenue-splits',
        queryParameters: {'limit': limit, 'offset': offset},
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getSplit(String splitId) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/revenue-splits/$splitId',
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> createSplit({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/revenue-splits',
        data: payload,
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> updateSplit({
    required String splitId,
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _apiClient.dio.put(
        '/admin/revenue-splits/$splitId',
        data: payload,
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> deleteSplit(String splitId) async {
    try {
      final response = await _apiClient.dio.delete(
        '/admin/revenue-splits/$splitId',
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> previewSplit({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/revenue-splits/preview',
        data: payload,
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
