import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';

class CustomerOrderText extends StatelessWidget {
  const CustomerOrderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 326,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 0.5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            expands: true,
            maxLines: null,
            minLines: null,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            style: AppText.reg16.copyWith(color: const Color(0xff808080)),
            decoration: const InputDecoration(
              hintText: 'اوصف العمل المطلوب',
              border: InputBorder.none,
              fillColor: AppColors.white,
              // Remove any internal padding if necessary
              contentPadding: EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}
