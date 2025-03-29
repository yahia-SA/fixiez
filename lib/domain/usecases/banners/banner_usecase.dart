import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/repositories/banner_repository.dart';

class BannerUsecase {
  BannerUsecase( this.bannerRepository);

  final BannerRepository bannerRepository;

  Future<List<Banner>> call() => bannerRepository.getBanners();
}