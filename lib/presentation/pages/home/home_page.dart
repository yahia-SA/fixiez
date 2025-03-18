import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/pages/home/widget/customer_order_text.dart';
import 'package:fixiez/presentation/pages/home/widget/customer_reviews_list.dart';
import 'package:fixiez/presentation/pages/home/widget/location_contanier.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:fixiez/presentation/pages/home/widget/order_request_widget.dart';
import 'package:fixiez/presentation/pages/home/widget/service_list_widget.dart';
import 'package:fixiez/presentation/pages/home/widget/silder_poster_widget.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FF),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.end,
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
                      color:  AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.h),
                         NameHeader(onBackPressed: (){}),
                        SizedBox(height: 16.h),
                        const LocationContainer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const SilderPosterWidgetState(),
                  SizedBox(height: 20.h),
                  const ServiceListWidget(),
                  SizedBox(height: 16.h),
                  const CustomerOrderText(),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: TextWidget(
                      'اراء العملاء ',
                      style: context.bold20Blue,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  const CustomerReviewsList(),
                  SizedBox(height: 180.h),
                ],
              ),
            ),
            const Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: OrderRequestWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
