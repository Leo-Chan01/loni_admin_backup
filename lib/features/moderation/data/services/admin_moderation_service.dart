import 'package:dio/dio.dart';

import '../../../../core/services/api_client.dart';

class AdminModerationService {
  final ApiClient _apiClient;

  AdminModerationService(this._apiClient);

  Future<Map<String, dynamic>> getModerationTasks({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/moderation/tasks',
        queryParameters: {
          'limit': limit,
          'offset': offset,
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

  Future<Map<String, dynamic>> getTaskDetail(String taskId) async {
    try {
      final response =
          await _apiClient.dio.get('/admin/moderation/tasks/$taskId');

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

  Future<Map<String, dynamic>> getTaskEvents(String taskId) async {
    try {
      final response = await _apiClient.dio
          .get('/admin/moderation/tasks/$taskId/events');

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

  Future<Map<String, dynamic>> updateTaskStatus({
    required String taskId,
    required String status,
    String? reviewerNotes,
    String? note,
  }) async {
    try {
      final response = await _apiClient.dio.patch(
        '/admin/moderation/tasks/$taskId',
        data: {
          'status': status,
          if (reviewerNotes != null) 'reviewerNotes': reviewerNotes,
          if (note != null) 'note': note,
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

  Future<Map<String, dynamic>> downloadTaskEpub(String taskId) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/moderation/tasks/$taskId/epub',
        options: Options(responseType: ResponseType.bytes),
      );

      return {
        'success': true,
        'data': {
          'bytesLength': (response.data as List<int>?)?.length ?? 0,
        },
        'bytes': response.data,
      };
    } catch (e) {
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
