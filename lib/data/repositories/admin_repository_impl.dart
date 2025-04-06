import 'dart:io';

import 'package:fixiez/data/datasources/admin_remote_data_source.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/entities/services.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  AdminRepositoryImpl({required this.remoteDataSource});
  final AdminRemoteDataSource remoteDataSource;
  @override
  Future<UsersMdoel> getUsers({required int pageIndex}) async {
    final response = await remoteDataSource.getUsers(pageIndex: pageIndex);
    return response;
  }

  @override
  Future<List<Services>> getServices() async {
    final response = await remoteDataSource.getServices();
    return response.data.map((e) => e.toEntity()).toList();
  }

  @override
  Future<bool> updateService({required String id, required int cost}) async {
    return await remoteDataSource.updateService(id: id, cost: cost);
  }

  @override
  Future<bool> updateUser({required String id, required String role}) async {
    return await remoteDataSource.updateUser(id: id, role: role);
  }

  @override
  Future<bool> deleteBanner({required String id}) async {
    return await remoteDataSource.deleteBanner(id: id);
  }

  @override
  Future<Banners> createBanner({required File image}) async {
    return await remoteDataSource.createBanner(image: image);
  }
  
  @override
  Future<bool> updateBanner({required String id, required bool isActive}) async {
    return await remoteDataSource.updateBanner(id: id, isActive: isActive);}
    
      @override
      Future<bool> deleteUser({required String id}) async {
        return await remoteDataSource.deleteUser(id: id);}
}
