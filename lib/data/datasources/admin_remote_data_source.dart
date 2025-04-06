import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/banner_model.dart';
import 'package:fixiez/data/models/service_model.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/entities/banner.dart';

abstract class AdminRemoteDataSource {
  Future<UsersMdoel> getUsers({required int pageIndex});
  Future<ServiceResponseModel> getServices();
  Future<bool> updateService({required String id, required int cost});
  Future<bool> updateUser({required String id, required String role});
  Future<bool> deleteBanner({required String id});
  Future<bool> deleteUser({required String id});
  Future<Banners> createBanner({required File image});
  Future<bool> updateBanner({required String id, required bool isActive});
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
  Future<bool> deleteUser({required String id}) async{
      try {
        final response = await dioHelper.deleteData(url: '${ApiEndpoints.adminDeleteUser}/$id');
        if (response.data['status'] == 'success') {
          return true;
        } else {
          throw Exception(response.data['message'] ?? '');
        }
      } catch (e) {
        throw Exception('Failed to delete user: $e');
      }
    }
}
