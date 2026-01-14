class AdminUser {
  const AdminUser({
    required this.id,
    required this.email,
    required this.phone,
    required this.roles,
    required this.region,
  });

  final String id;
  final String? email;
  final String? phone;
  final List<String> roles;
  final String? region;

  factory AdminUser.fromJson(Map<String, dynamic> json) {
    final rawRoles = json['roles'];
    final roles = rawRoles is List
        ? rawRoles.map((e) => e.toString()).toList()
        : <String>[];

    return AdminUser(
      id: (json['id'] ?? '').toString(),
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      roles: roles,
      region: json['region']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'roles': roles,
      'region': region,
    };
  }

  bool get isAdmin => roles.any((r) => r.toLowerCase() == 'admin');
}
