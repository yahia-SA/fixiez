import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceListWidget extends StatelessWidget {
  const PriceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          services
              .map(
                (service) => InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      width: 69.w,
                      height: 92.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.yellow,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 61.w,
                              height: 46.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: TextWidget(
                                  '${service['fx']} Fx',
                                  style: AppText.bold14.copyWith(
                                    color: AppColors.primary,
                                  ),
                                  textDirection: TextDirection.ltr,
                                ),
                              ),
                            ),
                            SizedBox(height: 3.h),
                            TextWidget(
                              '${service['price']} LE',
                              style: AppText.bold14.copyWith(
                                color: AppColors.primary,
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
    );
  }
}

final List<Map<String, String>> services = [
  {'fx': '1000', 'price': '500'},
  {'fx': '3000', 'price': '1400'},
  {'fx': '5000', 'price': '2200'},
  {'fx': '10000', 'price': '4400'},
];
