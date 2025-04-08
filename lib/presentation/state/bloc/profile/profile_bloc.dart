import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/data/models/repair_request.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/usecases/repair/repair_request_upated.dart';
import 'package:fixiez/domain/usecases/repair/repair_requests.dart';
import 'package:fixiez/domain/usecases/auth/get_balance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    this.getBalanceUseCase,
    this.repairRequestsUseCase,
    this.repairRequestUpatedUseCase,
  ) : super(ProfileInitial()) {
    on<GetProfile>(_onGetProfile);
    on<RepairRequestsUpdate>(_onRepairRequestsUpdate);
  }

  final GetBalanceUseCase getBalanceUseCase;
  final RepairRequestsUseCase repairRequestsUseCase;
  final RepairRequestUpatedUseCase repairRequestUpatedUseCase;

  int _currentPage = 1;
  int _totalPages = 1;
  int _totalItems = 1;
  bool _isLoading = false;
  RepairDataModel _repairRequests = RepairDataModel(
    requests: [],
    metadata: null,
  );

  Future<void> _onGetProfile(
    GetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    if (_isLoading || event.pageIndex < 1 || event.pageIndex > _totalPages) {
      return;
    }
    _isLoading = true;
    if (!event.repairOnly) {
      emit(ProfileLoading());
    }
    try {
      final user = await _getUserBalance();
      await _cacheUserData(user);
      final repairRequestsModel = await repairRequestsUseCase(
        pageIndex: event.pageIndex,
      );
      final repairRequests = repairRequestsModel.toEntity();

      _currentPage = event.pageIndex;
      _totalPages = repairRequests.metadata.totalPages!;
      _totalItems = repairRequests.metadata.totalItems!;
      _repairRequests = repairRequestsModel; // تحميل الصفحة الجديدة فقط
      emit(
        state is ProfileSuccess
            ? (state as ProfileSuccess).copyWith(
              user: user,
              repairData: _repairRequests,
              currentPage: _currentPage,
              totalPages: _totalPages,
              totalItems: _totalItems,
              repairUpdateOnly: event.repairOnly,
            )
            : ProfileSuccess(
              user: user,
              repairData: _repairRequests,
              currentPage: _currentPage,
              totalPages: _totalPages,
              totalItems: _totalItems,
            ),
      );
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }

    _isLoading = false;
  }

  Future<User> _getUserBalance() async {
    return await getBalanceUseCase();
  }

  Future<void> _cacheUserData(User user) async {
    await CacheHelper.saveData(key: 'Balance', value: user.balance);
    await CacheHelper.saveData(key: 'CashBack', value: user.cashBack);
  }

  Future<void> _onRepairRequestsUpdate(
    RepairRequestsUpdate event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is! ProfileSuccess) {
      return;
    }

    final currentState = state as ProfileSuccess;
    final currentRepairData = currentState.repairData!.toEntity();
    final updatedRequests =
        currentRepairData.requests.map((request) {
          return request.id == event.id
              ? request.copyWith(status: event.status)
              : request;
        }).toList();

    final updatedRepairData = currentRepairData.copyWith(
      requests: updatedRequests,
    );

    emit(
      currentState.copyWith(
        repairData: updatedRepairData.toModel(),
        repairUpdateOnly: true,
      ),
    );
    try {
      await repairRequestUpatedUseCase(id: event.id, status: event.status);
    } catch (e) {
      emit(currentState.copyWith(repairUpdateOnly: false));
      emit(ProfileFailure(e.toString()));
      rethrow;
    }
  }
}
