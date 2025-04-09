import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditWidget extends StatefulWidget {
  const EditWidget({
    super.key,
    required this.title,
    this.buttontext,
    required this.saveAction,
    required this.tabletitle1,
    required this.tabletitle2,
    required this.userData1,
    required this.userData2,
    this.userTypes = const ['مستخدم', 'ادمن'],
    this.isEditUser = true,
    this.isDouble = false,
    this.onChanged,
  });

  final String title;
  final String? buttontext;
  final void Function(String newdata) saveAction;
  final String tabletitle1;
  final String tabletitle2;
  final String userData1;
  final String userData2;
  final List<String> userTypes;
  final bool isEditUser;
  final Function(dynamic)? onChanged;
  final bool isDouble;

  @override
  State<EditWidget> createState() => _EditWidgetState();
}

class _EditWidgetState extends State<EditWidget> {
  late String userData2;
  late dynamic value;
  @override
  void initState() {
    super.initState();
    userData2 = widget.userData2;
    widget.isDouble
        ? value = double.tryParse(userData2) ?? 0
        : value = int.tryParse(userData2) ?? 0;
  }

  void increaseValue() {
    setState(() {
      widget.isDouble ? value += 0.5 : value += 10;
      widget.onChanged?.call(value);
    });
  }

  void decreaseValue() {
    setState(() {
      widget.isDouble ? value -= 0.5 : value -= 10;
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: SizedBox(
        width: 328.w,
        height: 282.h,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            children: [
              Text(
                widget.title,
                style: context.bold24Blue!.copyWith(height: 1.4.h),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              SizedBox(
                width: 260.w,
                child: Table(
                  border: TableBorder.all(color: const Color(0xFFE0E0E0)),
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: Color(0xFFE6F1FF)),
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          height: 32.h,
                          alignment: Alignment.center,
                          child: Text(
                            widget.tabletitle1,
                            style: context.med16Blue,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          height: 32.h,
                          alignment: Alignment.center,
                          child: Text(
                            widget.tabletitle2,
                            style: context.med16Blue,
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 42.h,
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Text(
                            widget.userData1,
                            style: context.med16Blue,
                          ),
                        ),

                        Container(
                          height: 42.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 5.h,
                          ),
                          child:
                              widget.isEditUser
                                  ? DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: userData2,
                                      icon: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE0E0E0),
                                        ),
                                        child: Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          color: const Color(0xFF929292),
                                          size: 18.sp,
                                        ),
                                      ),

                                      onChanged: (String? newValue) {
                                        setState(() {
                                          userData2 = newValue!;
                                        });
                                      },
                                      items:
                                          widget.userTypes.map<
                                            DropdownMenuItem<String>
                                          >((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: context.med16Blue!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                      height: 1.4.h,
                                                    ),
                                              ),
                                            );
                                          }).toList(),
                                    ),
                                  )
                                  : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        value.toString(),
                                        style: context.med16Blue!.copyWith(
                                          height: 1.4.h,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: increaseValue,
                                            child: Icon(
                                              Icons.arrow_drop_up_outlined,
                                              size: 20.sp,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: decreaseValue,
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              size: 20.sp,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        if (userData2.toString() == 'ادمن') {
                          widget.saveAction('admin');
                        } else if (userData2.toString() == 'مستخدم') {
                          widget.saveAction('user');
                        } else {
                          widget.saveAction(value.toString());
                        }
                      },
                      child: Text(
                        widget.buttontext ?? 'حفظ',
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
            ],
          ),
        ),
      ),
    );
  }
}
