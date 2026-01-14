import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  String? _authToken;
  String? _adminId;
  String? _adminEmail;

  String? get authToken => _authToken;
  String? get adminId => _adminId;
  String? get adminEmail => _adminEmail;

  void setAuth(String token, String adminId, String email) {
    _authToken = token;
    _adminId = adminId;
    _adminEmail = email;
    notifyListeners();
  }

  void clearAuth() {
    _authToken = null;
    _adminId = null;
    _adminEmail = null;
    notifyListeners();
  }

  bool get isAuthenticated => _authToken != null;
}
