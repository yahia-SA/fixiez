import 'dart:io';

import 'package:fixiez/data/models/felix_model.dart';
import 'package:fixiez/data/models/repair_requsest_admin.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/domain/analtyis_model.dart';
import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/entities/felix.dart';
import 'package:fixiez/domain/entities/services.dart';

abstract class AdminRepository {
  //users
  Future<UsersMdoel> getUsers({required int pageIndex});
  Future<bool> updateUser({required String id, required String role});
  Future<bool> deleteUser({required String id});

  //Felix
  Future<FelixResponse> getFelix({required int pageIndex});
  Future<bool> deleteFelix({required String id});
  Future<bool> updateFelix({
    required String id,
    required int felixNumber,
    required double cost,
  });
  Future<FelixEntity> createFelix({
    required int felixNumber,
    required double cost,
  });

  //services
  Future<List<Services>> getServices();
  Future<bool> updateService({required String id, required int cost});
  //banner
  Future<bool> deleteBanner({required String id});
  Future<Banners> createBanner({required File image});
  Future<bool> updateBanner({required String id, required bool isActive});

  //repair
  Future<RepairRequestResponse> getRepirs({required int pageIndex});

  // statistics
  Future<AnalysisModel> getAnalysis();
}
