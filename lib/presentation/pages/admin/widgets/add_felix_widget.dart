// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/custom_formfield.dart';

class AddFelix extends StatelessWidget {
  AddFelix({super.key, required this.saveAction});
  final Function(int felix, double cost) saveAction;
  final TextEditingController _felixController = TextEditingController();

  final TextEditingController _costController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: SizedBox(
          width: 328.w,
          height: 355.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'اضافه باقه',
                style: context.bold24Blue!.copyWith(height: 1.4.h),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.5.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormfield(
                        controller: _felixController,
                        isFelix: true,
                        type: const TextInputType.numberWithOptions(
                          decimal: false,
                          signed: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          }
                          return null;
                        },
                        label: 'عدد الفيكسات',
                        hint: 'عدد الفيكسات',
                        onEditingComplete:
                            () => FocusScope.of(context).nextFocus(),
                      ),
                      SizedBox(height: 16.h),
                      CustomFormfield(
                        controller: _costController,
                        isFelix: true,

                        type: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d*\.?\d*'),
                          ),
                        ],
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          }
                          final double? number = double.tryParse(value);
                          if (number == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                        label: 'سعر الباقه',
                        hint: 'سعر الباقه',
                        onEditingComplete: () {
                          if (_formKey.currentState!.validate()) {
                            final int felix = int.parse(_felixController.text);
                            final double cost = double.parse(
                              _costController.text,
                            );

                            saveAction(felix, cost);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 47.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 79.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: TextButton(
                        onPressed: () {
                          final int felix = int.parse(_felixController.text);
                          final double cost = double.parse(
                            _costController.text,
                          );

                          saveAction(felix, cost);
                        },
                        child: Text(
                          'اضافه',
                          style: context.med16Blue!.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 79.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 0.5.w,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text(
                          'إلغاء',
                          style: context.med16Blue!.copyWith(height: 1.4.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
