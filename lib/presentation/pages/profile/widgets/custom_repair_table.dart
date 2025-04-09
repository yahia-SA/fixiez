import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/data/models/repair_request.dart';
import 'package:fixiez/presentation/state/bloc/profile/profile_bloc.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:fixiez/presentation/widgets/pagination_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRepairTable extends StatefulWidget {
  const CustomRepairTable({super.key});

  @override
  State<CustomRepairTable> createState() => _CustomRepairTableState();
}

class _CustomRepairTableState extends State<CustomRepairTable> {
  final List<String> statusType = const ['مفتوح', 'تم'];

  int _pageIndex = 1;
  bool isLoading = false;
  RepairDataModel? cachedReapis;
  int? cachedTotalPages;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final state = context.read<ProfileBloc>().state;
      if (state is ProfileSuccess) {
        cachedReapis = state.repairData;
        cachedTotalPages = state.totalPages;
      } else {
        _fetchProfile();
      }
    });
  }

  void _fetchProfile() {
    if (!isLoading) {
      setState(() => isLoading = true);
      context.read<ProfileBloc>().add(
        GetProfile(pageIndex: _pageIndex, repairOnly: true),
      );
    }
  }

  void _onClickNext() {
    if (!isLoading && _pageIndex < cachedTotalPages!) {
      setState(() {
        _pageIndex++;
      });
      _fetchProfile();
    }
  }

  void _onClickBack() {
    if (!isLoading && _pageIndex > 1) {
      setState(() {
        _pageIndex--;
      });
      _fetchProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          setState(() {
            cachedReapis = state.repairData;
            cachedTotalPages = state.totalPages;
          });
        }
        if (state is ProfileSuccess || state is ProfileFailure) {
          setState(() => isLoading = false);
        }
      },
      listenWhen:
          (previous, current) =>
              current is ProfileSuccess || current is ProfileFailure,
      buildWhen: (previous, current) {
        if (current is ProfileSuccess) {
          return current.repairUpdateOnly! || previous is! ProfileSuccess;
        }
        return true;
      },

      builder: (context, state) {
        debugPrint('Current state : $state');
        final totalPages =
            (state is ProfileSuccess)
                ? state.totalPages
                : cachedTotalPages ?? 1;
        final requests =
            (state is ProfileSuccess)
                ? state.repairData!.requests
                : cachedReapis?.requests;
        if (state is ProfileLoading && cachedReapis == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (state is ProfileFailure) {
          Future.microtask(() => UiHelper.showNotification(state.message));
          return Center(
            child: Text(
              'فشل في تحميل البيانات',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        }

        if (requests == null || requests.isEmpty) {
          return Text('لا يوجد بيانات حاليا', style: AppText.med14);
        }

        return Column(
          children: [
            CustomTable(
              title: 'طلبات الصيانه ',
              headers: ['رقم الطلب', 'نوع الخدمة', 'تاكيد الطلب'],
              data: _buildTableData(requests),
              headingRowHeight: 46.h,
              dataRowHeight: 46.h,
              headersColor: AppColors.primary,
              headingTextStyle: context.med14Black!.copyWith(
                color: AppColors.white,
              ),
              dataCellStyle: context.med14Black,
              titleheight: 16.h,
            ),
            PaginationControls(
              pageIndex: _pageIndex,
              totalPages: totalPages!,
              isLoading: isLoading,
              onNext: _onClickNext,
              onBack: _onClickBack,
            ),
          ],
        );
      },
    );
  }

  _buildTableData(List<RepairRequestModel> requests) {
    return requests.map((e) {
      return [
        e.id.substring(e.id.length - 6),
        serviceNameFromString(e.serviceModel.name!)?.arabicName ??
            e.serviceModel.name ??
            '',
        _buildStatusDropdown(e),
      ];
    }).toList();
  }

  Widget _buildStatusDropdown(RepairRequestModel e) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: e.status.toArabicStatus,
        icon: Padding(
          padding: EdgeInsets.only(right: 4.0.w),
          child: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: const Color(0xFF929292),
            size: 20.sp,
          ),
        ),

        onChanged: (String? newValue) {
          context.read<ProfileBloc>().add(
            RepairRequestsUpdate(id: e.id, status: newValue!.toEnglishStatus),
          );
          setState(() {
            final index = cachedReapis!.requests!.indexWhere(
              (element) => element.id == e.id,
            );
            if (index != -1) {
              cachedReapis!.requests![index] = e.copyWith(
                status: newValue.toEnglishStatus,
              );
            }
          });
        },
        items:
            statusType.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: context.med16Blue!.copyWith(
                    color: AppColors.black,
                    height: 1.4.h,
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
