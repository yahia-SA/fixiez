import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/presentation/pages/admin/widgets/analysis_widegt.dart';
import 'package:fixiez/presentation/pages/admin/widgets/banners_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/felix_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/repair_requests_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/service_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/users_tabel.dart';
import 'package:fixiez/presentation/state/cubit/Services/service_cubit.dart';
import 'package:fixiez/presentation/state/cubit/analysis/analysis_cubit.dart';
import 'package:fixiez/presentation/state/cubit/banner/banner_cubit.dart';
import 'package:fixiez/presentation/state/cubit/felix/felix_cubit.dart';
import 'package:fixiez/presentation/state/cubit/repair_admin/repair_admin_cubit.dart';
import 'package:fixiez/presentation/state/cubit/users/users_cubit.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      if (mounted) await context.read<AnalysisCubit>().getAnalysis();
      if (mounted) await context.read<BannerCubit>().getBanners();
      if (mounted) await context.read<FelixCubit>().getFelix(pageIndex: 1);
      if (mounted) await context.read<ServiceCubit>().getServices();
      if (mounted) await context.read<UsersCubit>().getAdminUsers(pageIndex: 1);
      if (mounted) {
        await context.read<RepairAdminCubit>().getRepirsAdmin(pageIndex: 1);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.w, 35.h, 24.w, 0),
                    child: const NameHeader(
                      isThereSettings: true,
                      isblue: true,
                    ),
                  ),
                  SizedBox(height: 48.h),
                  const AnalysisWidget(),
                  SizedBox(height: 24.h),
                  const BannersTable(),
                  SizedBox(height: 24.h),
                  const ServiceTable(),
                  SizedBox(height: 24.h),
                  const UsersTable(),
                  SizedBox(height: 24.h),
                  const RepairRequestsTable(),
                  SizedBox(height: 24.h),
                  const FelixTable(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
