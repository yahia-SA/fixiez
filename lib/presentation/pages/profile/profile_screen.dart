import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/pages/home/widget/silder_poster_widget.dart';
import 'package:fixiez/presentation/pages/profile/widgets/balnce_widegt.dart';
import 'package:fixiez/presentation/pages/profile/widgets/custom_repair_table.dart';
import 'package:fixiez/presentation/pages/profile/widgets/maintenance_widget.dart';
import 'package:fixiez/presentation/pages/profile/widgets/price_list_widget.dart';
import 'package:fixiez/presentation/pages/profile/widgets/review_widget.dart';
import 'package:fixiez/presentation/state/bloc/profile/profile_bloc.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:
          () async => context.read<ProfileBloc>().add(const GetProfile()),
      color: AppColors.primary,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
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
                          NameHeader(
                            onBackPressed: () => Navigator.pop(context),
                            isThereSettings: true,
                          ),
                          SizedBox(height: 48.h),
                          const GetBalnce(),
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
                    SizedBox(height: 26.h),
                    const CustomRepairTable(),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: TextWidget(
                        'التقبيم',
                        style: AppText.bold20.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    const ReviewWidget(),

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
                    UiHelper.launchWhatsApp();
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
      ),
    );
  }
}
