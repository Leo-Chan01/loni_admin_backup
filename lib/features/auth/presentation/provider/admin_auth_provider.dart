import 'package:flutter/foundation.dart';

import '../../../../core/network/api_exception.dart';
import '../../data/repository/admin_auth_repository_impl.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repository/admin_auth_repository.dart';

class AdminAuthProvider extends ChangeNotifier {
  AdminAuthProvider({AdminAuthRepository? repository})
    : _repository = repository ?? AdminAuthRepositoryImpl();

  final AdminAuthRepository _repository;

  AuthSession? _session;
  bool _isLoading = false;
  String? _errorMessage;

  AuthSession? get session => _session;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _session != null;

  Future<void> loadSession() async {
    _session = await _repository.loadSession();
    notifyListeners();
  }

  Future<bool> signInWithPassword({
    required String identifier,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _session = await _repository.signInWithPassword(
        identifier: identifier,
        password: password,
      );
      return true;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _repository.clearSession();
    _session = null;
    notifyListeners();
  }
}
