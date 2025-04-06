import 'package:fixiez/data/datasources/banner_remote_data_source.dart';
import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl implements BannerRepository {
  BannerRepositoryImpl({required this.remoteDataSource});
  final BannerRemoteDataSource remoteDataSource;
  @override
  Future<List<Banners>> getBanners() async {
    final response =  await remoteDataSource.getBanners();
    return response.data.map((e) => e.toEntity()).toList();
  }
}
