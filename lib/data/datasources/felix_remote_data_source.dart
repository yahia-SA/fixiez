import 'package:fixiez/core/network/remote/dio_helper.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/data/models/felix_model.dart';
import 'package:flutter/material.dart';

abstract class FelixRemoteDataSource {
  Future<FelixResponse> getFelix();
}

class FelixRemoteDataSourceImpl implements FelixRemoteDataSource {
  FelixRemoteDataSourceImpl(this.dioHelper);
  final DioHelper dioHelper;
  @override
  Future<FelixResponse> getFelix() async{
    try{
      final response = await dioHelper.getData(url: ApiEndpoints.felix);
      if (response.data['status'] == 'success') {
        debugPrint('Response Data: ${response.data}');
        return FelixResponse.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? '');
      }
    }  catch (e) {
      throw ('حدث خطأ أثناء معالجة الطلب : $e');
    }
  }
}