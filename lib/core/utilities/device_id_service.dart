import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

class DeviceIdService {
  static const _key = 'admin_device_id';

  Future<String> getOrCreate() async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_key);
    if (existing != null && existing.length >= 6) return existing;

    final random = Random.secure();
    final suffix = List.generate(12, (_) => random.nextInt(16).toRadixString(16))
        .join();
    final created = 'admin-$suffix';

    await prefs.setString(_key, created);
    return created;
  }
}
