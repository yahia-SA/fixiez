import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NameHeader extends StatelessWidget {
  const NameHeader({
    super.key,
    this.isThereSettings = false,
    this.onBackPressed,
    this.isblue = false,
  });
  final bool isThereSettings;
  final VoidCallback? onBackPressed;
  final bool isblue;

  @override
  Widget build(BuildContext context) {
    final iconColor = isblue ? AppColors.primary : AppColors.white;
    final textColor = isblue ? AppColors.primary : AppColors.white;
    return Row(
      children: [
        IconButton(
          onPressed: onBackPressed,
          icon: Icon(Icons.arrow_back_ios, color: iconColor),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'اهلا',
                style: AppText.bold24.copyWith(color: textColor),
              ),
              TextSpan(
                text: ' عمرو عادل ',
                style: AppText.med24.copyWith(color: textColor),
              ),
            ],
          ),
        ),
        const Spacer(),
        isThereSettings
            ? InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.settings);
              },
              child: SvgPicture.asset(
                ImageAssets.settings,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
            )
            : const SizedBox(),
      ],
    );
  }
}
