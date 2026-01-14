import 'admin_user.dart';
import 'auth_tokens.dart';

class AuthSession {
  const AuthSession({required this.tokens, required this.user});

  final AuthTokens tokens;
  final AdminUser user;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      tokens: AuthTokens.fromJson(json),
      user: AdminUser.fromJson((json['user'] as Map?)?.cast<String, dynamic>() ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ...tokens.toJson(),
      'user': user.toJson(),
    };
  }
}
