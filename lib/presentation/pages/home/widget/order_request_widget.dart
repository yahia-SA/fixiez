import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/cubit/repair_cubit.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class OrderRequestWidget extends StatelessWidget {
  const OrderRequestWidget({super.key});

  DateTime getNextSaturday() {
    final DateTime from = DateTime.now();
    int daysUntilSaturday = (6 - from.weekday + 7) % 7;
    if (daysUntilSaturday == 0) {
      daysUntilSaturday = 7;
    }
    return from.add(Duration(days: daysUntilSaturday));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: ui.TextDirection.rtl,
      children: [
        Expanded(
          child: Column(
            children: [
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
                      onChanged: (String? newValue) {},
                      items:
                          ['السبت القادم'].map<DropdownMenuItem<String>>((
                            String value,
                          ) {
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
                child: CustomButton(
                  onpressed: () {
                    context.read<RepairCubit>().updateDate(
                      getNextSaturday().toString(),
                    );
                    context.read<RepairCubit>().submitRepairRequest();
                  },
                  text: 'طلب سريع',
                ),
              ),
            ],
          ),
        ),
        const CalendarContainer(),
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
  String displayText = DateFormat('dd MMM').format(DateTime.now());
  DateTime dateIOS = DateTime.now().add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairCubit, RepairState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                      displayText = DateFormat('dd MMM').format(picked);
                      dateIOS = picked;
                    });
                  }
                },
                child: Container(
                  width: 154.w,
                  height: 30.h,
                  color: AppColors.white,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextWidget(
                          displayText,
                          style: AppText.reg16.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),

              SizedBox(
                width: 154.w,
                height: 48.h,
                child: CustomButton(
                  onpressed: () {
                    context.read<RepairCubit>().updateDate(
                      dateIOS.toUtc().toString(),
                    );
                    context.read<RepairCubit>().submitRepairRequest();
                  },
                  text: 'طلب',
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
