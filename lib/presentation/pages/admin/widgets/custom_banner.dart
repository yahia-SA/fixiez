import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/pages/admin/widgets/custom_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.iconPath,
    required this.number,
    required this.title,
    this.chart = const CustomChart(),
    this.backgroundColor = Colors.white,
    this.numberColor = AppColors.yellow,
    this.titleColor = Colors.black,
    this.width = 153,
  });

  final String iconPath;
  final String number;
  final String title;
  final Widget chart;
  final Color backgroundColor;
  final Color numberColor;
  final Color titleColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(iconPath),
                Text(number, style: AppText.reg16.copyWith(color: numberColor)),
              ],
            ),
            SizedBox(height: 10.h),
            Text(title, style: AppText.bold14.copyWith(color: titleColor)),
            SizedBox(height: 10.h),
            chart,
          ],
        ),
      ),
    );
  }
}
