import 'dart:async';
import 'package:dio/dio.dart';
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
        headers: {ApiHeaders.contentType: ApiHeaders.applicationJson},
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
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
      if (kDebugMode) print('🔄 Refreshing Access Token...');
      if (kDebugMode)
        print(
          '🌍 Refreshing at: ${dio.options.baseUrl}${ApiEndpoints.refresh}',
        );

      final response = await dio.post(
        ApiEndpoints.refresh,
        data: {'refresh_token': refreshToken},
      );

      accessToken = response.data['access_token'];
      if (kDebugMode) print('✅ Access Token refreshed successfully.');

      // Complete the refresh process
      _refreshCompleter!.complete();
    } catch (e) {
      if (kDebugMode) print('❌ Failed to refresh token.');
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

    _isRefreshing = true;
    try {
      await _refreshAccessToken();
      err.requestOptions.headers[ApiHeaders.authorization] =
          'Bearer $accessToken';

      final retryResponse = await dio.fetch(err.requestOptions);
      return handler.resolve(retryResponse);
    } catch (refreshError) {
      return handler.next(err); // Logout user on failed refresh
    } finally {
      _isRefreshing = false;
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
    Map<String, dynamic>? query,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
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
}
