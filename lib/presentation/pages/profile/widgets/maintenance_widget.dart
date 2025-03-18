import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MaintenanceWidget extends StatelessWidget {
  const MaintenanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 24.w, left: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            'باقات الصيانه ',
            style: AppText.bold20.copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 20.h),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 2,
            physics: const NeverScrollableScrollPhysics(),

            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Container(
                  width: 328.w,
                  padding: EdgeInsetsDirectional.symmetric(
                    horizontal: 10.w,
                    vertical: 19.h,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xffC4C4C4),
                      width: 0.5.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(
                          alpha: 0.16,
                        ), 
                        offset: const Offset(1, 1),
                        blurRadius: 1, 
                        spreadRadius: 0, 
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            'صيانة ربع سنويه ',
                            style: AppText.bold16.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.5.w,
                              vertical: 7.h,
                            ),

                            decoration: BoxDecoration(
                              color: const Color(0xffFFDE59),
                              borderRadius: BorderRadius.circular(8.r),
                            ),

                            child: Center(
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '3600',
                                      style: AppText.bold16.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' جنيه مصري',
                                      style: AppText.reg14.copyWith(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),

                      SizedBox(
                        width: 300.w,
                        child: TextWidget(
                          'تغطي هذه الحزمة الصيانه الاسبوعية للكهرباء و السباكة لمدة اربعه اشهر . ',
                          style: AppText.med14.copyWith(
                            color: AppColors.texthint92,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        children: [
                          TextWidget(
                            'لا يتم تضمين تكلفة الاجزاء ',
                            style: AppText.med14.copyWith(
                              color: AppColors.texthint92,
                            ),
                          ),
                          SvgPicture.asset(ImageAssets.alert),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
