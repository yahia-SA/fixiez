import 'package:dio/dio.dart';
import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';

abstract class RepairRemoteDataSource {
  Future<void> repairRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  });
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
    try{
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
  } on DioException catch (e){
    throw (e.response?.data['message'] ?? 'حدث خطأ أثناء معالجة الطلب');
  }
  }
}
