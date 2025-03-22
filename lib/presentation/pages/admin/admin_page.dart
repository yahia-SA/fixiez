import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/presentation/pages/admin/widgets/bar_chart_widget.dart';
import 'package:fixiez/presentation/pages/admin/widgets/custom_banner.dart';
import 'package:fixiez/presentation/pages/admin/widgets/custom_chart.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  // Data for المستخدمين
  static final List<List<String>> usersData = [
    ['عمرو احمد', '0110100423', 'مستخدم', '✅️'],
    ['عادل طه', '0100122223', 'احدن', '✅️'],
    ['عمر محمد', '0122345639', 'مستخدم', '✅️'],
  ];

  // Headers for المستخدمين
  static final List<String> usersHeaders = [
    'اسم المستخدم',
    'رقم الموبايل',
    'نوع المستخدم',
    'تعديل',
  ];

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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBanner(
                          title: 'عدد المستخدمين',
                          iconPath: ImageAssets.person,
                          number: '340',
                        ),
                        CustomBanner(
                          title: 'عدد الطلبات',
                          iconPath: ImageAssets.service,
                          number: '633',
                          numberColor: AppColors.primary,
                          chart: CustomChart(
                            spots: [
                              FlSpot(0, 1),
                              FlSpot(1, 10),
                              FlSpot(2, 3),
                              FlSpot(3, 15),
                              FlSpot(4, 4),
                              FlSpot(5, 2),
                              FlSpot(6, 9),
                            ],
                            lineColor: AppColors.primary,
                            barColor: Color(0xFF11BB8D),
                            barOpacity: 0.05,
                            barWidth: 1,
                            isCurved: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28.h),
                  const BarChartWidget(),
                  SizedBox(height: 28.h),
                  CustomTable(
                    title: 'المستخدمين ',
                    headers: usersHeaders,
                    data: usersData,
                    headingRowHeight: 40,
                    dataRowHeight: 36,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
