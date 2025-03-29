part of 'banner_cubit.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object> get props => [];
}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerSuccess extends BannerState {
  const BannerSuccess(this.banner);
  final List<Banner> banner;
  @override
  List<Object> get props => [banner];
}

final class BannerFailure extends BannerState {
  const BannerFailure(this.message);
  final String message;
  @override
  List<Object> get props => [message];
}
