import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/pages/admin/widgets/bar_chart_widget.dart';
import 'package:fixiez/presentation/pages/admin/widgets/custom_banner.dart';
import 'package:fixiez/presentation/pages/admin/widgets/custom_chart.dart';
import 'package:fixiez/presentation/state/cubit/analysis/analysis_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalysisWidget extends StatefulWidget {
  const AnalysisWidget({super.key});

  @override
  State<AnalysisWidget> createState() => _AnalysisWidgetState();
}

class _AnalysisWidgetState extends State<AnalysisWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<AnalysisCubit, AnalysisState>(
                builder: (context, state) {
                  if (state is AnalysisSuccess) {
                    return CustomBanner(
                      title: 'عدد المستخدمين',
                      iconPath: ImageAssets.person,
                      number: state.userResult?.total.toString() ?? '1',
                      chart: CustomChart(
                        spots: [
                          for (
                            int i = 0;
                            i < state.userResult!.userNumberList!.length;
                            i++
                          )
                            FlSpot(
                              i.toDouble(),
                              state.userResult!.userNumberList?[i].count
                                      ?.toDouble() ??
                                  1,
                            ),
                        ],
                      ),
                    );
                  } else if (state is AnalysisFailure) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      UiHelper.showNotification(state.message);
                    });
                  }
                  return const CustomBanner(
                    title: 'عدد المستخدمين',
                    iconPath: ImageAssets.person,
                    number: '0',
                  );
                },
              ),
              BlocBuilder<AnalysisCubit, AnalysisState>(
                builder: (context, state) {
                  if (state is AnalysisSuccess) {
                    return CustomBanner(
                      title: 'عدد الطلبات',
                      iconPath: ImageAssets.service,
                      number:
                          state.repairRequestResult?.total.toString() ?? '1',
                      numberColor: AppColors.primary,
                      chart: CustomChart(
                        spots: [
                          for (
                            int i = 0;
                            i <
                                state
                                    .repairRequestResult!
                                    .repairRequestNumberList!
                                    .length;
                            i++
                          )
                            FlSpot(
                              i.toDouble(),
                              state
                                      .repairRequestResult!
                                      .repairRequestNumberList?[i]
                                      .count
                                      ?.toDouble() ??
                                  1,
                            ),
                        ],
                        lineColor: AppColors.primary,
                        barColor: const Color(0xFF11BB8D),
                        barOpacity: 0.05,
                        barWidth: 1,
                        isCurved: true,
                      ),
                    );
                  }
                  return const CustomBanner(
                    title: 'عدد الطلبات',
                    iconPath: ImageAssets.service,
                    number: '0',
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
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        const BarChartWidget(),
      ],
    );
  }
}
