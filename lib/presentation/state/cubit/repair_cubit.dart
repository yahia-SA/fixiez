import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/domain/repositories/reapir_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'repair_state.dart';

class RepairCubit extends Cubit<RepairState> {
  RepairCubit(this._repairRepository) : super(RepairInitial());
  final RepairRepository _repairRepository;

  Future<void> reapirRequest({
    required String location,
    required String unitNumber,
    required String description,
    required ServiceName serviceName,
    required ServiceType serviceType,
    required String date,
  }) async {
    emit(RepairLoading());
    try {
      await _repairRepository.reapirRequest(
        location: location,
        unitNumber: unitNumber,
        description: description,
        serviceName: serviceName,
        serviceType: serviceType,
        date: date,
      );
      emit(Repairsuccess());
} catch (e) {
      emit(RepairFailure(e.toString()));
    }
  }
}
