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
    on<GetProfile>(_onGetProfile);

  }
  final GetBalanceUseCase getBalanceUseCase;
  final RepairRequestsUseCase repairRequestsUseCase;

  Future<void> _onGetProfile(
    GetProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      // Get both balance and repair requests
      final user = await getBalanceUseCase();
      final repairRequests = await repairRequestsUseCase(pageIndex: 1);
      
      await CacheHelper.saveData(key: 'Balance', value: user.balance);
      await CacheHelper.saveData(key: 'CashBack', value: user.cashBack);
      
      emit(ProfileSuccess(user, repairRequests));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}
