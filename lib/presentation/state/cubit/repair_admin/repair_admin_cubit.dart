import 'package:equatable/equatable.dart';
import 'package:fixiez/data/models/repair_requsest_admin.dart';
import 'package:fixiez/domain/usecases/admin/repair/repair_admin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'repair_admin_state.dart';

class RepairAdminCubit extends Cubit<RepairAdminState> {
  RepairAdminCubit({required this.repairAdminUseCase})
    : super(RepairAdminInitial());
  final GetRepairAdminUseCase repairAdminUseCase;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 1;
  bool _isLoading = false;
  RepairRequestResponse _repairmodel = RepairRequestResponse();

  Future<void> getRepirsAdmin({required int pageIndex}) async {
    if (_isLoading || pageIndex < 1 || pageIndex > _totalPages) return;
    _isLoading = true;
    emit(RepairAdminLoading());
    try {
      final RepairRequestResponse repairmodel = await repairAdminUseCase.call(
        pageIndex: pageIndex,
      );
      _currentPage = pageIndex;
      _totalPages = repairmodel.data!.metadata.totalPages!;
      _totalItems = repairmodel.data!.metadata.totalItems!;
      _repairmodel = repairmodel;
      emit(
        RepairAdminSuccess(
          repairRequestResponse: _repairmodel,
          totalPages: _totalPages,
          currentPage: _currentPage,
          totalItems: _totalItems,
        ),
      );
    } catch (e) {
      emit(RepairAdminFailure(e.toString()));
    }
    _isLoading = false;
  }
}
