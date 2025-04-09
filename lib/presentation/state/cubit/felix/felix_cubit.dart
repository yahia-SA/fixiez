import 'package:equatable/equatable.dart';
import 'package:fixiez/data/models/felix_model.dart';
import 'package:fixiez/domain/usecases/admin/felix/create_felix.dart';
import 'package:fixiez/domain/usecases/admin/felix/delete_felix.dart';
import 'package:fixiez/domain/usecases/admin/felix/get_felix.dart';
import 'package:fixiez/domain/usecases/admin/felix/update_felix.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'felix_state.dart';

class FelixCubit extends Cubit<FelixState> {
  FelixCubit({
    required this.createFelixUseCase,
    required this.deleteFelixUseCase,
    required this.updateFelixUseCase,
    required this.getFelixUsecase,
  }) : super(FelixInitial());
  final CreateFelixUseCase createFelixUseCase;
  final DeleteFelixUseCase deleteFelixUseCase;
  final UpdateFelixUseCase updateFelixUseCase;
  final GetFelixUsecase getFelixUsecase;
  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 1;
  bool _isLoading = false;
  FelixResponse _felixResponse = FelixResponse();

  Future<void> getFelix({required int pageIndex}) async {
    if (_isLoading || pageIndex < 1 || pageIndex > _totalPages) return;
    _isLoading = true;

    emit(FelixLoading());
    try {
      final felix = await getFelixUsecase(pageIndex: pageIndex);
      _currentPage = pageIndex;
      _totalPages = felix.metadata!.totalPages!;
      _felixResponse = felix;
      _totalItems = felix.metadata!.totalItems!;
      emit(
        FelixSuccess(
          felix: _felixResponse,
          totalPages: _totalPages,
          currentPage: _currentPage,
          totalItems: _totalItems,
        ),
      );
    } catch (e) {
      emit(FelixFailure(e.toString()));
    }
    _isLoading =false;
  }

  Future<void> deleteFelix({required String id}) async {
    emit(FelixDeleting());
    try {
      await deleteFelixUseCase(id: id);
      emit(FelixDeleted());
    } catch (e) {
      emit(FelixFailure(e.toString()));
    }
  }

  Future<void> updateFelix({
    required String id,
    required int felixNumber,
    required double cost,
  }) async {
    emit(FelixUpdating());
    try {
      await updateFelixUseCase(id: id, felixNumber: felixNumber, cost: cost);
      emit(FelixUpdated());
    } catch (e) {
      emit(FelixFailure(e.toString()));
    }
  }

  Future<void> createFelix({
    required int felixNumber,
    required double cost,
  }) async {
    emit(FelixCreating());
    try {
      await createFelixUseCase(felixNumber: felixNumber, cost: cost);
      emit(FelixCreated());
    } catch (e) {
      emit(FelixFailure(e.toString()));
    }
  }
}
