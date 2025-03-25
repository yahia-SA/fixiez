import 'dart:developer';
import 'dart:io';
import 'package:fixiez/core/constants/strings.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher.dart';

class UiHelper {
  static void showNotification(
    String message, {
    Color backgroundColor = Colors.red,
    Color textColor = AppColors.white,
    Duration duration = const Duration(milliseconds: 2500),
  }) {
    showOverlayNotification(
      (context) => Material(
        color: Colors.transparent,
        child: SafeArea(
          child: GestureDetector(
            onTap: () => OverlaySupportEntry.of(context)!.dismiss(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: backgroundColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 7),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Center(child: TextWidget(message, color: textColor)),
              ),
            ),
          ),
        ),
      ),
      duration: duration,
    );
  }

  static Future launchWhatsApp() async {
    String contact = AppStrings.whatsAppNumber;
    String text = '';
    String androidUrl = 'whatsapp://send?phone=$contact&text=$text';
    String iosUrl = 'https://wa.me/$contact?text=${Uri.parse(text)}';

    String webUrl = 'https://api.whatsapp.com/send/?phone=$contact&text=hi';

    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      }
    } catch (e) {
      log('object');
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }
}
