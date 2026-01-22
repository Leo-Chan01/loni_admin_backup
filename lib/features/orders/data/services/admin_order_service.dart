import '../../../../core/services/api_client.dart';

class AdminOrderService {
  final ApiClient _apiClient;

  AdminOrderService(this._apiClient);

  Future<Map<String, dynamic>> getOrders({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final response = await _apiClient.dio.get(
        '/admin/orders',
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

  Future<Map<String, dynamic>> getOrderDetail(String orderId) async {
    try {
      final response = await _apiClient.dio.get('/admin/orders/$orderId');

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

  Future<Map<String, dynamic>> cancelOrder(String orderId) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/orders/$orderId/cancel',
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

  Future<Map<String, dynamic>> escalateOrder(String orderId) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/orders/$orderId/escalate',
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

  Future<Map<String, dynamic>> getOrderKPIs() async {
    try {
      final response = await _apiClient.dio.get('/admin/orders/kpis');

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

  Future<Map<String, dynamic>> reassignPrinter({
    required String orderId,
    required String printerId,
  }) async {
    try {
      final response = await _apiClient.dio.post(
        '/admin/orders/$orderId/reassign-printer',
        data: {'printerId': printerId},
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
