import '../../../../core/services/api_client.dart';

class AdminUserService {
  final ApiClient _apiClient;

  AdminUserService(this._apiClient);

  Future<Map<String, dynamic>> searchUsers({
    required String query,
    String? role,
    int limit = 50,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/users',
        queryParameters: {
          'q': query,
          if (role != null) 'role': role,
          'limit': limit,
        },
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

  Future<Map<String, dynamic>> getUserDetail(String userId) async {
    try {
      final response = await _apiClient.dio.get('/admin/users/$userId');

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

  Future<Map<String, dynamic>> updateUser({
    required String userId,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _apiClient.dio.patch(
        '/admin/users/$userId',
        data: data ?? {},
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

  Future<Map<String, dynamic>> suspendUser(String userId) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/users/$userId/suspend',
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

  Future<Map<String, dynamic>> activateUser(String userId) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/users/$userId/activate',
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
}
