import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/home/widget/customer_order_text.dart';
import 'package:fixiez/home/widget/customer_reviews_list.dart';
import 'package:fixiez/home/widget/location_contanier.dart';
import 'package:fixiez/home/widget/order_request_widget.dart';
import 'package:fixiez/home/widget/service_list_widget.dart';
import 'package:fixiez/home/widget/silder_poster_widget.dart';
import 'package:fixiez/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
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
                      color: const Color(0xFF0258C9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.h),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(text: 'اهلا', style: AppText.bold24),
                              TextSpan(
                                text: ' عمرو عادل ',
                                style: AppText.med24,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        const LocationContainer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const SilderPosterWidgetState(),
                  SizedBox(height: 20.h),
                  const ServiceListWidger(),
                  SizedBox(height: 16.h),
                  const CustomerOrderText(),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.only(right: 24.w),
                    child: TextWidget(
                      'اراء العملاء ',
                      style: AppText.bold20.copyWith(
                        color: const Color(0xff0258C9),
                      ),
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
