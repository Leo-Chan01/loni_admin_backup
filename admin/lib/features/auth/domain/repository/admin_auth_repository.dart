import '../entities/auth_session.dart';

abstract class AdminAuthRepository {
  Future<AuthSession> signInWithPassword({
    required String identifier,
    required String password,
  });

  Future<AuthSession?> loadSession();

  Future<void> clearSession();
}
