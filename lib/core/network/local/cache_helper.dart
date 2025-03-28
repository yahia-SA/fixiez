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
   try{
          final Map<String, dynamic> userData = {
        'Id': user.id,
        'Name': user.name,
        'PhoneNumber': user.phoneNumber,
        'Role': user.role,
        'IsActive': user.isActive,
        'Balance': user.balance,
        'CashBack': user.cashBack,
      };

    
       await Future.wait(userData.entries.map((entry) => saveData(key: entry.key, value: entry.value)));
      final String? oldAccessToken = getData(key: 'AccessToken');
    final String? oldRefreshToken = getData(key: 'RefreshToken');

    if (user.accessToken != oldAccessToken) {
      await saveData(key: 'AccessToken', value: user.accessToken);
    }
    if (user.refreshToken != oldRefreshToken) {
      await saveData(key: 'RefreshToken', value: user.refreshToken);
    }

    } catch (e) {
      return false;
    }
    return true;
  }

/// Get user data from cache
  static User? getUser() {
    try {
      final userData = {
        'id': getData(key: 'Id'),
        'name': getData(key: 'Name'),
        'phoneNumber': getData(key: 'PhoneNumber'),
        'role': getData(key: 'Role'),
        'isActive': getData(key: 'IsActive'),
        'balance': getData(key: 'Balance'),
        'cashBack': getData(key: 'CashBack'),
        'accessToken': getData(key: 'AccessToken'),
        'refreshToken': getData(key: 'RefreshToken'),
      };

      if (userData.values.every((value) => value != null)) {
        return User(
          id: userData['id'],
          name: userData['name'],
          phoneNumber: userData['phoneNumber'],
          role: userData['role'],
          isActive: userData['isActive'],
          balance: userData['balance'],
          cashBack: userData['cashBack'],
          accessToken: userData['accessToken'],
          refreshToken: userData['refreshToken'],
        );
      }
    } catch (e) {
      debugPrint('❌ خطاء في استرجاع بيانات المستخدم: $e');}
    return null;
  }

    // استرجاع قيمة معينة من بيانات المستخدم باستخدام المفتاح
  static dynamic getUserField({ required String key}) {
    try {
      return getData(key: key);
    } catch (e, stackTrace) {
      debugPrint('❌ خطأ في استرجاع قيمة [$key]: $e\n$stackTrace');
      return null;
    }
  }

}
