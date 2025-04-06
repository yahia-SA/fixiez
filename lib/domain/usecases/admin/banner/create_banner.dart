import 'dart:io';

import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/repositories/admin_repository.dart';

class CreateBannerAdminUseCase {

  CreateBannerAdminUseCase( this.adminRepository);
  final AdminRepository adminRepository;

  Future<Banners> call({required File image}) async => await adminRepository.createBanner(image: image);
  
}