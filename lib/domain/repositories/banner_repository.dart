import 'package:fixiez/domain/entities/banner.dart';

abstract class BannerRepository {

  Future<List<Banner>> getBanners();
  
}