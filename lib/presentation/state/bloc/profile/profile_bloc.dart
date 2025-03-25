import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/domain/entities/user.dart';
import 'package:fixiez/domain/usecases/auth/get_balance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.getBalanceUseCase) : super(ProfileInitial()) {
    on<GetBalance>(_onGetBalance);
  }
final GetBalanceUseCase getBalanceUseCase;
Future<void> _onGetBalance(GetBalance event, Emitter<ProfileState> emit) async {
  // Add this
  emit(ProfileLoading());
  try {
    // Add this
    final user = await getBalanceUseCase();
    // Add this

    await CacheHelper.saveData(key:'Balance',value: user.balance );
    await CacheHelper.saveData(key:'CashBack',value: user.cashBack );
    // Add this

    emit(ProfileSuccess(user));
    // Add this
  } catch (e) {
    // Add this
    emit(ProfileFailure(e.toString()));
    // Add this
  }
}}
