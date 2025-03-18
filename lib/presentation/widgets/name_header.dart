import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';

class NameHeader extends StatelessWidget {
  const NameHeader({super.key, this.onSettingsPressed});
  final VoidCallback? onSettingsPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(text: 'اهلا', style: AppText.bold24),
              TextSpan(text: ' عمرو عادل ', style: AppText.med24),
            ],
          ),
        ),
        const Spacer(),
        onSettingsPressed != null
            ? IconButton(
              onPressed: onSettingsPressed,
              icon: const Icon(Icons.settings, color: AppColors.white),
            )
            : const SizedBox(),
      ],
    );
  }
}
