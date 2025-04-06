import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:fixiez/domain/entities/banner.dart';
import 'package:fixiez/domain/usecases/admin/banner/create_banner.dart';
import 'package:fixiez/domain/usecases/admin/banner/delete_banner.dart';
import 'package:fixiez/domain/usecases/admin/banner/update_banner.dart';
import 'package:fixiez/domain/usecases/banners/banner_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit({required this.bannerUsecase, required this.deleteBannerAdminUseCase, required this.createBannerAdminUseCase, required this.updateBannerAdminUseCase}) : super(BannerInitial());
  final BannerUsecase bannerUsecase;
  final DeleteBannerAdminUseCase deleteBannerAdminUseCase;
  final CreateBannerAdminUseCase createBannerAdminUseCase;
  final UpdateBannerAdminUseCase updateBannerAdminUseCase;

  Future<void> getBanners() async {
    emit(BannerLoading());
    try {
      final banner = await bannerUsecase();
      emit(BannerSuccess(banner));
    } catch (e) {
      emit(BannerFailure(e.toString()));
    }
  }

  Future<void> deleteBanner({required String id}) async {
    emit(BannerDeleting());
    try {
      await deleteBannerAdminUseCase(id: id);
      emit(BannerDeleted());
    } catch (e) {
      emit(BannerFailure(e.toString()));
    }
  }
  Future<void> createBanner({required File image}) async {
    emit(BannerCreating());
    try {
     await createBannerAdminUseCase(image: image);
      emit(BannerCreated());
    } catch (e) {
      emit(BannerFailure(e.toString()));
      rethrow;
    }
  }

  Future<void> updateBanner({required String id, required bool isActive}) async {
    emit(BannerUpdating());
    try {
    final success =  await updateBannerAdminUseCase(id: id, isActive: isActive);
      if (success) {
      emit(BannerUpdated());
    }else{
      emit(const BannerFailure('Failed to update banner.'));
    }
    }catch (e) {
      emit(BannerFailure(e.toString()));
    }
  }
}

