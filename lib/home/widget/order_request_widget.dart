import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderRequestWidget extends StatelessWidget {
  const OrderRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        // First Column
        Expanded(
          child: Column(
            children: [
              // Dropdown Button for first column
              Container(
                width: 154.w,
                height: 30.h,
                color: Colors.white,
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,

                    child: DropdownButton(
                      underline: Container(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff0258C9),
                      ),

                      value: 'السبت القادم',
                      style: AppText.reg16.copyWith(
                        color: const Color(0xff0258C9),
                      ),
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
              // Normal (Elevated) Button for first column
              ElevatedButton(
                onPressed: () {},
                child: TextWidget('طلب', style: AppText.semi16),
              ),
            ],
          ),
        ),
        // Second Column
        Expanded(
          child: Column(
            children: [
              // Dropdown Button for second column
              Container(
                width: 154.w,
                height: 30.h,
                color: Colors.white,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: DropdownButton(
                      value: '24 ينارير',
                      underline: Container(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xff0258C9),
                      ),
                      style: AppText.reg16.copyWith(
                        color: const Color(0xff0258C9),
                      ),
                      onChanged: (String? newValue) {
                        // Handle selection changes for second column
                      },
                      items:
                          [
                            '24 ينارير',
                            'Option B',
                            'Option C',
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

              ElevatedButton(
                onPressed: () {
                  // Handle button press for second column
                },
                child: TextWidget('طلب سريع ', style: AppText.semi16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
