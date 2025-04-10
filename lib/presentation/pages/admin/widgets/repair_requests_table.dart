import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/data/models/repair_request.dart';
import 'package:fixiez/data/models/repair_requsest_admin.dart';
import 'package:fixiez/presentation/state/cubit/repair_admin/repair_admin_cubit.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:fixiez/presentation/widgets/pagination_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepairRequestsTable extends StatefulWidget {
  const RepairRequestsTable({super.key});

  @override
  State<RepairRequestsTable> createState() => _RepairRequestsTableState();
}

class _RepairRequestsTableState extends State<RepairRequestsTable> {
  int _pageIndex = 1;
  bool isLoading = false;
  RepairRequestData? cachedData;
  int? cachedTotalPages;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final state = context.read<RepairAdminCubit>().state;
      if (state is RepairAdminSuccess) {
        cachedData = state.repairRequestResponse!.data;
        cachedTotalPages = state.totalPages;
      } else {
        _fetchData();
      }
    });
  }

  void _fetchData() {
    if (!isLoading) {
      setState(() => isLoading = true);
      context
          .read<RepairAdminCubit>()
          .getRepirsAdmin(pageIndex: _pageIndex)
          .then((_) => setState(() => isLoading = false));
    }
  }

  void _onClickNext() {
    if (!isLoading) {
      setState(() => _pageIndex++);
      _fetchData();
    }
  }

  void _onClickBack() {
    if (!isLoading) {
      setState(() => _pageIndex--);
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RepairAdminCubit, RepairAdminState>(
      listener: (context, state) {
        if (state is RepairAdminSuccess) {
          setState(() {
            cachedData = state.repairRequestResponse!.data;
            cachedTotalPages = state.totalPages;
          });
        }
        if (state is RepairAdminSuccess || state is RepairAdminFailure) {
          setState(() => isLoading = false);
        }
      },
      listenWhen:
          (previous, current) =>
              current is RepairAdminSuccess || current is RepairAdminFailure,
      builder: (context, state) {
        final totalPages =
            (state is RepairAdminSuccess)
                ? state.totalPages
                : cachedTotalPages ?? 1;
        final requests =
            (state is RepairAdminSuccess)
                ? state.repairRequestResponse!.data?.requests ?? []
                : cachedData?.requests ?? [];
        return Column(
          children: [
            if (state is RepairAdminLoading && cachedData == null)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            if (state is RepairAdminSuccess || cachedData != null)
              CustomTable(
                title: 'طلبات التصليح',
                headers: ['اسم المستخدم', 'طلبات التصليح'],
                data: _buildTableData(requests),
                headingRowHeight: 36,
                dataRowHeight: 36,
                //  columnWidths: 163.5,
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
}

_buildTableData(List<RepairRequestModel> requests) {
  return requests
      .map((e) => <Object>[e.user?.name ?? '', e.serviceModel.name ?? ''])
      .toList();
}
