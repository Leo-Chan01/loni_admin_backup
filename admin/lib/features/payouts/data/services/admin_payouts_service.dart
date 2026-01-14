import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';

class AdminPayoutsService {
  AdminPayoutsService({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient.instance;

  final ApiClient _apiClient;

  Future<Map<String, dynamic>> getBalances() async {
    try {
      final response = await _apiClient.dio.get('/admin/payouts/balances');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getPending() async {
    try {
      final response = await _apiClient.dio.get('/admin/payouts/pending');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getStatements() async {
    try {
      final response = await _apiClient.dio.get('/admin/payouts/statements');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> getBatches() async {
    try {
      final response = await _apiClient.dio.get('/admin/payouts/batches');
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> createBatch({
    required Map<String, dynamic> payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/payouts/batch',
        data: payload,
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> runScheduler({
    Map<String, dynamic>? payload,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/payouts/scheduler/run',
        data: payload ?? {},
      );
      return {'success': true, 'data': response.data};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> exportBatch({required String batchId}) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/payouts/batches/$batchId/export',
        options: Options(responseType: ResponseType.bytes),
      );

      final bytes = response.data as List<int>?;
      return {
        'success': true,
        'data': {'bytesLength': bytes?.length ?? 0},
        'bytes': bytes,
      };
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }
}
