import 'package:dio/dio.dart';
import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/repair_request.dart';
import 'package:fixiez/domain/entities/repair_request.dart';

abstract class RepairRemoteDataSource {
  Future<void> repairRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  });

  Future<RepairData> fetchRepairRequests({required int pageIndex});
}

class RepairRemoteDataSourceImpl implements RepairRemoteDataSource {
  RepairRemoteDataSourceImpl(this.dioHelper);
  final DioHelper dioHelper;

  @override
  Future<void> repairRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: ApiEndpoints.repairRequest,
        data: {
          'location': location,
          'unitNumber': unitNumber,
          'description': description,
          'serviceName': serviceName.name,
          'serviceType': serviceType.name,
          'date': date,
        },
      );

      if (response.data['status'] == 'success') {
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } on DioException catch (e) {
      throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
    }
  }

  @override
  Future<RepairData> fetchRepairRequests({
    required int pageIndex,
  }) async {
    try {
      final response = await dioHelper.getData(
        url: ApiEndpoints.repairRequestsUser,
        query: {'pageIndex': pageIndex, 'pageSize':3},
      );

      if (response.data['status'] == 'success') {
        return RepairDataModel.fromJson(response.data).toEntity();
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw 'يرجى تسجيل الدخول';
      } else {
        throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
      }
}
  }
}