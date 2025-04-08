import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  DioHelper._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: {'accept': '*/*',ApiHeaders.contentType: ApiHeaders.applicationJson},
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
             await loadTokens();
          options.headers[ApiHeaders.authorization] = 'Bearer $accessToken';
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            return await _handle401Error(e, handler);
          }
          return handler.next(e);
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
      // request: true,
      // responseBody: true,
      // error: true,
      ),
    );
  }

  factory DioHelper() => _instance;
  static final DioHelper _instance = DioHelper._internal();

  late Dio dio;
  String? accessToken;
  String? refreshToken;

  bool _isRefreshing = false;
  Completer<void>? _refreshCompleter;

  static DioHelper get instance => _instance;

  /// 🔄 **Refreshes Access Token**
  Future<void> _refreshAccessToken() async {
    if (_refreshCompleter != null) {
      await _refreshCompleter!.future;
      return;
    }

    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    _refreshCompleter = Completer();
    _isRefreshing = true;

    try {
       debugPrint('🔄 Refreshing Access Token...');
       
        debugPrint(
          '🌍 Refreshing at: ${dio.options.baseUrl}${ApiEndpoints.refresh}',
        );
      

      final response = await dio.get(
        ApiEndpoints.refresh,
        data: {'refresh_token': refreshToken},
      );

      await saveTokens(response.data['access_token'], refreshToken);
       debugPrint('✅ Access Token refreshed successfully.');

      // Complete the refresh process
      _refreshCompleter!.complete();
    } catch (e) {
       debugPrint('❌ Failed to refresh token.');
      _refreshCompleter!.completeError(e);
      throw Exception('Failed to refresh token');
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  /// 🔑 **Handles Unauthorized Requests (401)**
  Future<void> _handle401Error(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_isRefreshing) {
      await _refreshCompleter?.future;
      err.requestOptions.headers[ApiHeaders.authorization] =
          'Bearer $accessToken';
      final retryResponse = await dio.fetch(err.requestOptions);
      return handler.resolve(retryResponse);
    }
    _refreshCompleter = Completer();
    _isRefreshing = true;
    try {
      await _refreshAccessToken();
      err.requestOptions.headers[ApiHeaders.authorization] =
          'Bearer $accessToken';

      final retryResponse = await dio.fetch(err.requestOptions);
      _refreshCompleter!.complete();
      return handler.resolve(retryResponse);
    } catch (refreshError) {
      return handler.next(err); // Logout user on failed refresh
    } finally {
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  /// 📥 **GET Request**
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,

  }) async {
    return await dio.get(url, queryParameters: query);
  }

  ///  POST Request
  Future<Response> postData({
    required String url,
    required dynamic data,
    Options? options,
    Map<String, dynamic>? query,
  }) async {
    return await dio.post(url, queryParameters: query, data: data,options: options);
  }

  /// PATCH Request
  Future<Response> patchData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? query,
  }) async {
    return await dio.patch(url, queryParameters: query, data: data);
  }

  /// DELETE Request
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.delete(url, queryParameters: query);
  }
Future<void> saveTokens(String? access, String? refresh) async {
  if (access != null) await CacheHelper.saveData(key:'accessToken',value: access);
  if (refresh != null) await CacheHelper.saveData(key:'refreshToken',value: refresh);
  accessToken = access;
  refreshToken = refresh;
}

Future<void> loadTokens() async {
  accessToken = CacheHelper.getUserField(key: 'AccessToken');
  refreshToken = CacheHelper.getUserField(key: 'RefreshToken');
}

  Future<void> clearTokens() async {
    await Future.wait([
      CacheHelper.removeData(key: 'AccessToken'),
      CacheHelper.removeData(key: 'RefreshToken'),
    ]);
    accessToken = null;
    refreshToken = null;
  }

}
