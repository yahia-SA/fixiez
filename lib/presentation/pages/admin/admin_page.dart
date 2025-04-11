import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/presentation/pages/admin/widgets/analysis_widegt.dart';
import 'package:fixiez/presentation/pages/admin/widgets/banners_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/felix_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/repair_requests_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/service_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/users_tabel.dart';
import 'package:fixiez/presentation/service/bloc_providers.dart';
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

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProvidersList(child: AdminPageData());
  }
}

class AdminPageData extends StatefulWidget {
  const AdminPageData({super.key});

  @override
  State<AdminPageData> createState() => _AdminPageDataState();
}

class _AdminPageDataState extends State<AdminPageData> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

  fetchData() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
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
      },
    );
  }
}
