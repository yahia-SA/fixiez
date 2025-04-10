import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/presentation/pages/admin/widgets/analysis_widegt.dart';
import 'package:fixiez/presentation/pages/admin/widgets/banners_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/felix_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/repair_requests_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/service_table.dart';
import 'package:fixiez/presentation/pages/admin/widgets/users_tabel.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
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

