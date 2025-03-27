import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/domain/entities/repair_request.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/usecases/Repair/repair_requests.dart';
import 'package:fixiez/domain/usecases/auth/get_balance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.getBalanceUseCase, this.repairRequestsUseCase)
    : super(ProfileInitial()) {
    on<GetBalance>(_onGetBalance);
    on<GetRepairRequests>(_onGetRepairRequests);
    on<InitializeProfile>(_onInitializeProfile);
  }
  final GetBalanceUseCase getBalanceUseCase;
  final RepairRequestsUseCase repairRequestsUseCase;
  Future<void> _onGetBalance(
    GetBalance event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = await getBalanceUseCase();

      await CacheHelper.saveData(key: 'Balance', value: user.balance);
      await CacheHelper.saveData(key: 'CashBack', value: user.cashBack);

      emit(ProfileSuccess(user));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }

  Future<void> _onGetRepairRequests(GetRepairRequests event, Emitter<ProfileState> emit) async {
        emit(RepairRequestsLoading());
    try {
      final repairRequests = await repairRequestsUseCase(
        pageIndex: event.pageIndex,
      );
      emit(RepairRequestsSuccess(repairRequests));
    } catch (e) {
      emit(RepairRequestsFailure(e.toString()));
    }

  }

  FutureOr<void> _onInitializeProfile(InitializeProfile event, Emitter<ProfileState> emit,) {
    add(GetBalance());
    add(const GetRepairRequests(pageIndex: 1));
  }
}
