import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/state/cubit/analysis/analysis_cubit.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, state) {
        if (state is AnalysisLoading) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary,),);
        }
        else if(state is AnalysisFailure){
          WidgetsBinding.instance.addPostFrameCallback((_) {
                                UiHelper.showNotification(state.message);
                              });
        }
        if (state is AnalysisSuccess){
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(ImageAssets.statistics),
                      SizedBox(width: 16.w),
                      Text(
                        'الخدمات',
                        style: AppText.bold24.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'عدد الطلبات لكل خدمه',
                    style: AppText.reg16.copyWith(
                      color: const Color(0xff383838),
                    ),
                  ),
                  SizedBox(height: 19.h),
                  SizedBox(
                    height: 200.h,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: false,
                          horizontalInterval: 10,
                          getDrawingHorizontalLine:
                              (value) => FlLine(
                                color: Colors.grey.withValues(alpha: 0.2),
                                strokeWidth: 1,
                              ),
                        ),

                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                );
                                String text;
                                switch (value.toInt()) {
                                  case 1:
                                    text = ServiceName.plumbing.arabicName;
                                    break;
                                  case 2:
                                    text = ServiceName.carpentry.arabicName;
                                    break;
                                  case 3:
                                    text = ServiceName.electricity.arabicName;
                                    break;
                                  case 4:
                                    text = ServiceName.painting.arabicName;
                                    break;
                                  default:
                                    text = '';
                                    break;
                                }
                                return SideTitleWidget(
                                  meta: meta,
                                  space: 4,
                                  child: Text(text, style: style),
                                );
                              },
                            ),
                          ),
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(toY: state.repairRequestResult?.analysis?.plumbing?.count?.toDouble() ??0, color: Colors.blue),
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(toY: state.repairRequestResult?.analysis?.carpentry?.count?.toDouble() ??0, color: Colors.blue),
                            ],
                          ),
                          BarChartGroupData(
                            x: 3,
                            barRods: [
                              BarChartRodData(toY: state.repairRequestResult?.analysis?.electricity?.count?.toDouble() ??0, color: Colors.blue),
                            ],
                          ),
                          BarChartGroupData(
                            x: 4,
                            barRods: [
                              BarChartRodData(toY: state.repairRequestResult?.analysis?.painting?.count?.toDouble() ??0, color: Colors.blue),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
        return const SizedBox();
      },
    );
  }
}
