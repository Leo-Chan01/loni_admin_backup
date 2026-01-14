import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/utilities/device_id_service.dart';
import '../../domain/entities/auth_session.dart';

class AdminAuthService {
  AdminAuthService({
    ApiClient? apiClient,
    DeviceIdService? deviceIdService,
  }) : _apiClient = apiClient ?? ApiClient.instance,
       _deviceIdService = deviceIdService ?? DeviceIdService();

  final ApiClient _apiClient;
  final DeviceIdService _deviceIdService;

  Future<AuthSession> signInWithPassword({
    required String identifier,
    required String password,
  }) async {
    try {
      final deviceId = await _deviceIdService.getOrCreate();
      final response = await _apiClient.dio.post(
        '/auth/login',
        data: {
          'identifier': identifier,
          'password': password,
          'device': {
            'deviceId': deviceId,
            'name': 'LONI Admin',
            'platform': 'web',
            'appVersion': '1.0.0',
          },
        },
      );

      if (response.data is! Map<String, dynamic>) {
        throw ApiException(message: 'Unexpected response from server.');
      }

      return AuthSession.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
