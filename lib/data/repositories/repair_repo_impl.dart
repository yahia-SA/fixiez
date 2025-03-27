import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/data/datasources/repair_remote_source.dart';
import 'package:fixiez/domain/entities/repair_request.dart';
import 'package:fixiez/domain/repositories/repair_repository.dart';

class RepairRepositoryImpl implements RepairRepository {
  RepairRepositoryImpl({required this.remoteDataSource});
  final RepairRemoteDataSource remoteDataSource;

  @override
  Future<void> repairRequest({
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

  @override
  Future<RepairData> getRepairRequests({
    required int pageIndex,
  }) async {
    final model = await remoteDataSource.fetchRepairRequests(
      pageIndex: pageIndex,
    );
    return model;
  }
}
