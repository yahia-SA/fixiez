import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class OrderRequestWidget extends StatelessWidget {
  const OrderRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: ui.TextDirection.rtl,
      children: [
        // First Column
        Expanded(
          child: Column(
            children: [
              // Dropdown Button for first column
              Container(
                width: 154.w,
                height: 30.h,
                color: AppColors.white,
                child: Center(
                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,

                    child: DropdownButton(
                      underline: Container(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.primary,
                      ),

                      value: 'السبت القادم',
                      style: AppText.reg16.copyWith(color: AppColors.primary),
                      onChanged: (String? newValue) {
                        // Handle selection changes for first column
                      },
                      items:
                          [
                            'السبت القادم',
                            'Option 2',
                            'Option 3',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              SizedBox(
                width: 154.w,
                height: 48.h,
                child: CustomButton(onpressed: () {}, text: 'طلب'),
              ),
            ],
          ),
        ),
        // Second Column
        Expanded(
          child: Column(
            children: [
              // Dropdown Button for second column
              const CalendarContainer(),
              SizedBox(height: 8.h),

              SizedBox(
                width: 154.w,
                height: 48.h,
                child: CustomButton(
                  onpressed: () {
                    // Handle button press for second column
                  },
                  text: 'طلب سريع ',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CalendarContainer extends StatefulWidget {
  const CalendarContainer({super.key});

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  DateTime? selectedDate;
  String displayText = '24 ينارير';

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Change the text display to your desired format (or keep the same text if needed)
        displayText = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _pickDate,
      child: Container(
        width: 154.w,
        height: 30.h,
        color: AppColors.white,
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget(
                  displayText,
                  style: AppText.reg16.copyWith(color: AppColors.primary),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
