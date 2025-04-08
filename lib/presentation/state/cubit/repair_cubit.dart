import 'dart:developer';

import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/domain/usecases/repair/repair_request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'repair_state.dart';

class RepairCubit extends Cubit<RepairState> {
  RepairCubit(this._repairRequestUseCase)
    : super(const RepairInitial(RepairFormData()));
  final RepairRequestUseCase _repairRequestUseCase;

  // Form update methods should NOT emit loading state
  void updateLocation(String location) =>
      _updateForm(state.formData.copyWith(location: location));
  void updateUnitNumber(String unitNumber) =>
      _updateForm(state.formData.copyWith(unitNumber: unitNumber));
  void updateDescription(String description) =>
      _updateForm(state.formData.copyWith(description: description));
  void updateServiceName(ServiceName serviceName) =>
      _updateForm(state.formData.copyWith(serviceName: serviceName));
  void updateServiceType(ServiceType serviceType) =>
      _updateForm(state.formData.copyWith(serviceType: serviceType));
  void updateDate(String date) =>
      _updateForm(state.formData.copyWith(date: date));

  void _updateForm(RepairFormData newFormData) {
    // Preserve current state type while updating form data
    if (state is RepairLoading) return;
    emit(switch (state) {
      RepairInitial() => RepairInitial(newFormData),
      RepairLoading() => RepairLoading(newFormData),
      RepairSuccess() => RepairSuccess(newFormData),
      RepairFailure() => RepairFailure(
        newFormData,
        (state as RepairFailure).message,
      ),
    });
    log('state: $state');
  }

  Future<void> submitRepairRequest() async {
    final formData = state.formData;

    // Validate required fields
    if (formData.location == null || formData.location!.isEmpty) {
      emit(RepairFailure(formData, 'Location is required'));
      UiHelper.showNotification('ادخل الموقع');
      return;
    }
    if (formData.serviceName == null) {
      emit(RepairFailure(formData, 'Service name is required'));
      UiHelper.showNotification('ادخل اسم الخدمة');
      return;
    }

    if (formData.unitNumber == null || formData.unitNumber!.isEmpty) {
      emit(RepairFailure(formData, 'Unit number is required'));
      UiHelper.showNotification('ادخل رقم الوحدة');
      return;
    }

    if (formData.description == null || formData.description!.isEmpty) {
      emit(RepairFailure(formData, 'Description is required'));
      UiHelper.showNotification('ادخل الوصف');
      return;
    }

    emit(RepairLoading(formData));

    try {
      await _repairRequestUseCase(
        location: formData.location!,
        unitNumber: formData.unitNumber ?? '',
        description: formData.description ?? '',
        serviceName: formData.serviceName!,
        serviceType: formData.serviceType ?? ServiceType.normal_request,
        date: formData.date ?? DateTime.now().toIso8601String(),
      );
      emit(RepairSuccess(formData));
    } catch (e) {
      UiHelper.showNotification(e.toString());
      emit(RepairFailure(formData, e.toString()));
    }
  }
}
