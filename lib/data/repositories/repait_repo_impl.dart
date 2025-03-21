import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/data/datasources/repair_remote_source.dart';
import 'package:fixiez/domain/repositories/reapir_repository.dart';

class RepairRepositoryImpl implements RepairRepository {
  RepairRepositoryImpl({required this.remoteDataSource});
  final RepairRemoteDataSource remoteDataSource;

  @override
  Future<void> reapirRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  }) async {
    return await remoteDataSource.repairRequest(
      location: location,
      unitNumber: unitNumber,
      description: description,
      serviceName: serviceName,
      serviceType: serviceType,
      date: date,
    );
  }
}
