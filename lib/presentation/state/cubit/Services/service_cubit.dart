
import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/entities/services.dart';
import 'package:fixiez/domain/usecases/admin/services_admin/admin_get_services_use_case.dart';
import 'package:fixiez/domain/usecases/admin/services_admin/admin_update_service_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'service_state.dart';
class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit({required this.serviceUsecase, required this.updateServiceUsecase}) : super(ServiceInitial());
  final GetAdminServicesUseCase serviceUsecase;
  final UpdateAdminServiceUseCase updateServiceUsecase;

  Future<void> getServices() async {
    emit(ServiceLoading());
    try {
      final service = await serviceUsecase();
      emit(ServiceSuccess(service));
    } catch (e) {
      emit(ServiceFailure(e.toString()));
    }
  }

    Future<void> updateServiceCost({required String id, required int cost}) async {
    emit(ServiceUpdating()); 
    try {
      final success = await updateServiceUsecase(id: id, cost: cost);
      if (success) {
        emit(ServiceUpdated());
      } else {
        emit(const ServiceFailure('Failed to update service.'));
      }
    } catch (e) {
      emit(ServiceFailure(e.toString()));
    }
  }

}



