import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _sharedPreferences;

  /// Initialize SharedPreferences
  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Get data from cache
  static dynamic getData({required String key}) {
    return _sharedPreferences?.get(key);
  }

  /// Save data to cache
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (_sharedPreferences == null) return false;

    if (value is String) return await _sharedPreferences!.setString(key, value);
    if (value is int) return await _sharedPreferences!.setInt(key, value);
    if (value is bool) return await _sharedPreferences!.setBool(key, value);
    if (value is double) return await _sharedPreferences!.setDouble(key, value);

    if (value is List<String>) return await _sharedPreferences!.setStringList(key, value);

    return false; // Unsupported type
  }

  /// Remove a specific key
  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences?.remove(key) ?? false;
  }

  /// Clear all cached data
  static Future<bool> clearAll() async {
    return await _sharedPreferences?.clear() ?? false;
  }
}
