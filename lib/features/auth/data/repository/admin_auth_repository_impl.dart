import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_exception.dart';
import '../data_sources/admin_auth_local_data_source.dart';
import '../services/admin_auth_service.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repository/admin_auth_repository.dart';

class AdminAuthRepositoryImpl implements AdminAuthRepository {
  AdminAuthRepositoryImpl({
    AdminAuthService? remoteService,
    AdminAuthLocalDataSource? localDataSource,
  }) : _remoteService = remoteService ?? AdminAuthService(),
       _localDataSource = localDataSource ?? AdminAuthLocalDataSource();

  final AdminAuthService _remoteService;
  final AdminAuthLocalDataSource _localDataSource;

  @override
  Future<AuthSession> signInWithPassword({
    required String identifier,
    required String password,
  }) async {
    try {
      final session = await _remoteService.signInWithPassword(
        identifier: identifier,
        password: password,
      );
      await _localDataSource.saveSession(session);
      ApiClient.instance.setAccessToken(session.tokens.accessToken);
      return session;
    } on ApiException {
      rethrow;
    }
  }

  @override
  Future<AuthSession?> loadSession() async {
    final session = await _localDataSource.getSession();
    if (session != null) {
      ApiClient.instance.setAccessToken(session.tokens.accessToken);
    }
    return session;
  }

  @override
  Future<void> clearSession() async {
    await _localDataSource.clearSession();
    ApiClient.instance.setAccessToken(null);
  }
}
