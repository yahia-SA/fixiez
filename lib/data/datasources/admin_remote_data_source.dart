import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/banner_model.dart';
import 'package:fixiez/data/models/felix_model.dart';
import 'package:fixiez/data/models/repair_requsest_admin.dart';
import 'package:fixiez/data/models/service_model.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/entities/felix.dart';
import 'package:flutter/material.dart';

abstract class AdminRemoteDataSource {
  // user
  Future<UsersMdoel> getUsers({required int pageIndex});
  Future<bool> updateUser({required String id, required String role});
  Future<bool> deleteUser({required String id});

  //banner
  Future<Banners> createBanner({required File image});
  Future<bool> updateBanner({required String id, required bool isActive});
  Future<bool> deleteBanner({required String id});

  // setvice
  Future<ServiceResponseModel> getServices();
  Future<bool> updateService({required String id, required int cost});
  //repairs
  Future<RepairRequestResponse> getRepairs({required int pageIndex});

  //felix
  Future<FelixResponse> getFelix({required int pageIndex});
  Future<FelixEntity> createFelix({
    required int felixNumber,
    required double cost,
  });
  Future<bool> deleteFelix({required String id});
  Future<bool> updateFelix({
    required String id,
    required int felixNumber,
    required double cost,
  });
}

class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  AdminRemoteDataSourceImpl(this.dioHelper);

  final DioHelper dioHelper;

  @override
  Future<UsersMdoel> getUsers({required int pageIndex}) async {
    try {
      final response = await dioHelper.getData(
        url: ApiEndpoints.adminUsers,
        query: {'pageIndex': pageIndex, 'pageSize': 4},
      );
      if (response.data['status'] == 'success') {
        return UsersMdoel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } on DioException catch (e) {
      throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
    }
  }

  @override
  Future<ServiceResponseModel> getServices() async {
    try {
      final response = await dioHelper.getData(url: ApiEndpoints.adminServices);
      if (response.data['status'] == 'success') {
        return ServiceResponseModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } on DioException catch (e) {
      throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
    }
  }

  @override
  Future<bool> updateService({required String id, required int cost}) async {
    try {
      final response = await dioHelper.patchData(
        url: '${ApiEndpoints.adminUpdateService}/$id',
        data: {'cost': cost},
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to update service: $e');
    }
  }

  @override
  Future<bool> updateUser({required String id, required String role}) async {
    try {
      final response = await dioHelper.patchData(
        url: '${ApiEndpoints.adminUpdateUser}/$id',
        data: {'role': role},
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to update User role: $e');
    }
  }

  @override
  Future<bool> deleteBanner({required String id}) async {
    try {
      final response = await dioHelper.deleteData(
        url: '${ApiEndpoints.adminDeleteBanner}/$id',
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to delete banner: $e');
    }
  }

  @override
  Future<Banners> createBanner({required File image}) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      ),
    });
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.adminCreateBanner,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.data['status'] == 'success') {
        return BannerModel.fromJson(response.data['data']).toEntity();
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to create banner: $e');
    }
  }

  @override
  Future<bool> updateBanner({
    required String id,
    required bool isActive,
  }) async {
    try {
      final response = await dioHelper.patchData(
        url: '${ApiEndpoints.adminUpdateBanner}/$id',
        data: {'isActive': isActive},
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to update banner: $e');
    }
  }

  @override
  Future<bool> deleteUser({required String id}) async {
    try {
      final response = await dioHelper.deleteData(
        url: '${ApiEndpoints.adminDeleteUser}/$id',
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<RepairRequestResponse> getRepairs({required int pageIndex}) async {
    try {
      final response = await dioHelper.getData(
        url: ApiEndpoints.adminRepairRequests,
        query: {'pageIndex': pageIndex, 'pageSize': 3},
      );
      debugPrint('Response Data: ${response.data}');
      debugPrint('Response Status Message: ${response.statusMessage}');
      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Headers: ${response.headers}');

      if (response.data == null) {
        throw Exception('Empty response from server');
      }

      if (response.data['status'] == 'success') {
        return RepairRequestResponse.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to load repairs');
      }
    } on DioException catch (e) {
      debugPrint('Dio Error: ${e.message}');
      debugPrint('Dio Response: ${e.response?.data}');
      throw Exception(
        e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب',
      );
    }
  }

  @override
  Future<FelixEntity> createFelix({
    required int felixNumber,
    required double cost,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.adminCreateFelix,
        data: {'felixNumber': felixNumber, 'cost': cost},
      );
      if (response.data['status'] == 'success') {
        return Felix.fromJson(response.data['data']).toEntity();
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to create felix: $e');
    }
  }

  @override
  Future<bool> deleteFelix({required String id}) async {
    try {
      final response = await dioHelper.deleteData(
        url: '${ApiEndpoints.adminDeleteFelix}/$id',
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  @override
  Future<FelixResponse> getFelix({required int pageIndex}) async {
    try {
      final response = await dioHelper.getData(
        url: ApiEndpoints.adminFelix,
        query: {'pageIndex': pageIndex, 'pageSize': 4},
      );
      if (response.data['status'] == 'success') {
        debugPrint('Response Data: ${response.data}');
        return FelixResponse.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to fetch felix data: $e');
    }
  }

  @override
  Future<bool> updateFelix({
    required String id,
    required int felixNumber,
    required double cost,
  }) async {
    try {
      final response = await dioHelper.patchData(
        url: '${ApiEndpoints.adminUpdateFelix}/$id',
        data: {'felixNumber': felixNumber, 'cost': cost},
      );
      if (response.data['status'] == 'success') {
        return true;
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } catch (e) {
      throw Exception('Failed to update banner: $e');
    }
  }
}
