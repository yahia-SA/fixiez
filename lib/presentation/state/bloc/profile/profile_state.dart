part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  const ProfileSuccess({
    this.repairUpdateOnly = false,
    this.user,
    this.repairData,
    this.currentPage,
    this.totalPages,
    this.totalItems,
  });
  final User? user;
  final RepairDataModel? repairData;
  final int? currentPage;
  final int? totalPages;
  final int? totalItems;
  final bool? repairUpdateOnly;

  ProfileSuccess copyWith({
    User? user,
    RepairDataModel? repairData,
    int? currentPage,
    int? totalPages,
    int? totalItems,
    bool? repairUpdateOnly,
  }) {
    return ProfileSuccess(
      user: user ?? this.user,
      repairData: repairData ?? this.repairData,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalItems: totalItems ?? this.totalItems,
      repairUpdateOnly: repairUpdateOnly ?? this.repairUpdateOnly,
    );
  }

  @override
  List<Object> get props => [
    user ?? const User(),
    repairData ?? RepairDataModel(),
    currentPage ?? 0,
    totalPages ?? 0,
    totalItems ?? 0,
    repairUpdateOnly ?? false,
  ];
}

final class ProfileFailure extends ProfileState {
  const ProfileFailure(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}
