import 'package:flutter/foundation.dart';

import 'package:loni_admin/core/services/api_client.dart';
import '../../data/services/admin_order_service.dart';

class AdminOrdersProvider extends ChangeNotifier {
  AdminOrdersProvider({AdminOrderService? service})
    : _service = service ?? AdminOrderService(ApiClient.instance);

  final AdminOrderService _service;

  bool _isLoading = false;
  String? _error;

  Map<String, dynamic>? _orders;
  Map<String, dynamic>? _kpis;
  Map<String, dynamic>? _orderDetail;
  Map<String, dynamic>? _lastResult;

  bool get isLoading => _isLoading;
  String? get error => _error;

  Map<String, dynamic>? get orders => _orders;
  Map<String, dynamic>? get kpis => _kpis;
  Map<String, dynamic>? get orderDetail => _orderDetail;
  Map<String, dynamic>? get lastResult => _lastResult;

  Future<void> loadOrders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getOrders();
      if (res['success'] == true) {
        _orders = _asMap(res['data']);
      } else {
        _error = res['message']?.toString();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadKPIs() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getOrderKPIs();
      if (res['success'] == true) {
        _kpis = _asMap(res['data']);
      } else {
        _error = res['message']?.toString();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadOrderDetail(String orderId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await _service.getOrderDetail(orderId);
      if (res['success'] == true) {
        _orderDetail = _asMap(res['data']);
      } else {
        _error = res['message']?.toString();
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> cancelOrder(String orderId) async {
    return _action(() => _service.cancelOrder(orderId));
  }

  Future<bool> escalateOrder(String orderId) async {
    return _action(() => _service.escalateOrder(orderId));
  }

  Future<bool> reassignPrinter({
    required String orderId,
    required String printerId,
  }) async {
    return _action(
      () => _service.reassignPrinter(orderId: orderId, printerId: printerId),
    );
  }

  Future<bool> _action(Future<Map<String, dynamic>> Function() action) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final res = await action();
      if (res['success'] == true) {
        _lastResult = _asMap(res['data']);
        return true;
      }

      _error = res['message']?.toString();
      return false;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<String, dynamic>? _asMap(Object? data) {
    if (data is Map<String, dynamic>) return data;
    if (data == null) return null;
    return {'data': data};
  }
}
