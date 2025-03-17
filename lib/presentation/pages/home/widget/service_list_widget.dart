

import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ServiceListWidget extends StatelessWidget {
  const ServiceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: services.map((service) => Column(children: [
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
                  child: Center(child: SvgPicture.asset(service['image']!)),
                ),
              ),
              SizedBox(height: 3.h),
              TextWidget(service['name']!, style: AppText.med14),
            ],
          ),
      ).toList(),
    );
  }
}
  final List<Map<String, String>> services = [
    {'name': 'نجارة', 'image': ImageAssets.carpenter},
    {'name': 'دهان', 'image': ImageAssets.paint},
    {'name': 'سباكة', 'image': ImageAssets.plumbing},
    {'name': 'كهرباء', 'image': ImageAssets.electric},
  ];
