import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/constants/strings.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/pages/home/widget/silder_poster_widget.dart';
import 'package:fixiez/presentation/pages/profile/widgets/customer_review_text.dart';
import 'package:fixiez/presentation/pages/profile/widgets/maintenance_widget.dart';
import 'package:fixiez/presentation/pages/profile/widgets/price_list_widget.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      24,
                      30,
                      24,
                      47,
                    ),
                    decoration: ShapeDecoration(
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.h),
                        NameHeader(onBackPressed: () {}, isThereSettings: true),
                        SizedBox(height: 48.h),
                        Row(
                          children: [
                            TextWidget(
                              'الرصيد',
                              style: AppText.medium20.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 48.w),

                            Container(
                              width: 208.w,
                              height: 48.h,

                              constraints: const BoxConstraints(
                                minHeight: 48.0,
                              ),
                              decoration: ShapeDecoration(
                                color: AppColors.white,

                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: AppColors.white,
                                    width: 1.w,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: 11.h,
                                  right: 10.w,
                                ),
                                child: TextWidget(
                                  '5000',
                                  style: AppText.medium20.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  const SilderPosterWidgetState(),
                  SizedBox(height: 4.h),
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: TextWidget(
                      'الباقات',
                      style: AppText.bold20.copyWith(
                        color: const Color(0xff0258C9),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const PriceListWidget(),
                  SizedBox(height: 16.h),
                  Center(
                    child: TextWidget(
                      'استخدم بطاقاتك الثابته بدفع رسوم الصيانه لكل زياره',
                      style: AppText.med14.copyWith(
                        color: AppColors.texthint80,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  const MaintenanceWidget(),
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: TextWidget(
                      'التقبيم',
                      style: AppText.bold20.copyWith(color: AppColors.primary),
                    ),
                  ),
                  SizedBox(height: 18.h),
                  const CustomerReviewText(),
                  SizedBox(height: 18.h),
                  Center(
                    child: CustomButton(onpressed: () {}, text: 'ارسل تقيمك'),
                  ),
                  SizedBox(height: 116.h),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: CustomButton(
                onpressed: () {
                  UiHelper.launchWhatsApp(
                  
                  );
                },
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget('تواصل معنا', style: AppText.semi16),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(ImageAssets.call),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
