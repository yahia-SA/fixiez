import 'package:fixiez/core/constants/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        ImageAssets.logo,
        width: 255.w,
        height: 75.h,
      ),
    );
  }
}
