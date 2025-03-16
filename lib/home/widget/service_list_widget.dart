

import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ServiceListWidger extends StatelessWidget {
  const ServiceListWidger({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < 4; i++)
          Column(
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.5.w),
                child: Container(
                  width: 63.w,
                  height: 65.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffE0E0E0),
                      width: 0.5,
                    ),
                  ),
                  child: Center(child: SvgPicture.asset(ImageAssets.onBoarding)),
                ),
              ),
              SizedBox(height: 3.h),
              TextWidget('نجارة', style: AppText.med14),
            ],
          ),
        
      ],
    );
  }
}
