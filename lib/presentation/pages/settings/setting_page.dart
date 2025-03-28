import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/network/local/cache_helper.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/delete.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF4F7FF),
        body: Column(
          children: [
            SizedBox(height: 46.h),
            NameHeader(
              isblue: true,
              onBackPressed: () => Navigator.pop(context),
            ),
            SizedBox(height: 12.h),
            Container(width: 327.w, color: AppColors.primary, height: 0.5.h),
            SizedBox(height: 41.h),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 25.w),
              child: Column(
                children: [
                  InkWell(
                    onTap:
                        () => deleteDialog(
                          context: context,
                          title: 'هل انت متاكد من حذف حسابك؟',
                          deleteAction: () {},
                        ),
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.delete),
                        SizedBox(width: 16.w),
                        TextWidget('حذف حساب ', style: AppText.medium20),
                      ],
                    ),
                  ),
                  SizedBox(height: 41.h),
                  InkWell(
                    onTap: () {
                      deleteDialog(
                        context: context,
                        title: 'هل انت متاكد من تسجيل الخروج',
                        deleteAction: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            AppRoutes.initial,
                            (route) => false,
                          );
                          CacheHelper.clearAll();
                        },
                        buttontext: 'خروج',
                      );
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(ImageAssets.logout),
                        SizedBox(width: 16.w),
                        TextWidget('تسجيل خروج', style: AppText.medium20),
                      ],
                    ),
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
