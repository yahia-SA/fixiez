import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/usecases/banners/banner_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit(this.bannerUsecase) : super(BannerInitial());
  final BannerUsecase bannerUsecase;

  Future<void> getBanners() async {
    emit(BannerLoading());
    try {
      final banner = await bannerUsecase();
      emit(BannerSuccess(banner));
    } catch (e) {
      emit(BannerFailure(e.toString()));
    }
  }
}

