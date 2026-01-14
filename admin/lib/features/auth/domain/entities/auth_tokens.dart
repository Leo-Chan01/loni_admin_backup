class AuthTokens {
  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshTokenExpiresIn,
  });

  final String accessToken;
  final String refreshToken;
  final int? expiresIn;
  final int? refreshTokenExpiresIn;

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: (json['accessToken'] ?? '').toString(),
      refreshToken: (json['refreshToken'] ?? '').toString(),
      expiresIn: json['expiresIn'] is int
          ? json['expiresIn'] as int
          : int.tryParse(json['expiresIn']?.toString() ?? ''),
      refreshTokenExpiresIn: json['refreshTokenExpiresIn'] is int
          ? json['refreshTokenExpiresIn'] as int
          : int.tryParse(json['refreshTokenExpiresIn']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'refreshTokenExpiresIn': refreshTokenExpiresIn,
    };
  }
}
