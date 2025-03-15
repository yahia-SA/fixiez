import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/home/widget/location_contanier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsetsDirectional.fromSTEB(24, 30, 24, 47),
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
                        // add user name
                        TextSpan(text: ' عمرو عادل ', style: AppText.med24),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  const LocationContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
