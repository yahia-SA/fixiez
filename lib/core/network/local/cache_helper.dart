import 'package:fixiez/domain/entities/user.dart';
import 'package:flutter/foundation.dart';
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

  /// Save user data to cache
  static Future<bool> saveUser(
    User user) async {
   try{   await Future.wait([
       saveData(key: 'Id', value: user.id),
       saveData(key: 'Name', value: user.name),
       saveData(key: 'PhoneNumber', value: user.phoneNumber),
       saveData(key: 'Role', value: user.role),
       saveData(key: 'IsActive', value: user.isActive),
       saveData(key: 'Balance', value: user.balance),
       saveData(key: 'CashBack', value: user.cashBack),
       saveData(key: 'AccessToken', value: user.accessToken),
       saveData(key: 'RefreshToken', value: user.refreshToken),

   ]);
    } catch (e) {
      return false;
    }
    return true;
  }

/// Get user data from cache
  static User? getUser() {
    try {
      final id = getData(key: 'Id');
      final name = getData(key: 'Name');
      final phoneNumber = getData(key: 'PhoneNumber');
      final role = getData(key: 'Role');
      final isActive = getData(key: 'IsActive');
      final balance = getData(key: 'Balance');
      final cashBack = getData(key: 'CashBack');
      final accessToken = getData(key: 'AccessToken');
      final refreshToken = getData(key: 'RefreshToken');

      if (id != null &&
          name != null &&
          phoneNumber != null &&
          role != null &&
          isActive != null &&
          balance != null &&
          cashBack != null &&
          accessToken != null &&
          refreshToken != null) {
        return User(
          id: id,
          name: name,
          phoneNumber: phoneNumber,
          role: role,
          isActive: isActive,
          balance: balance,
          cashBack: cashBack,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving user data: $e');
      }
    }
    return null;
  }
}
