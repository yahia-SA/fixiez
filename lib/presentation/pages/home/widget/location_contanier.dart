import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/cubit/repair_user/repair_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LocationContainer extends StatefulWidget {
  const LocationContainer({super.key});

  @override
  State<LocationContainer> createState() => _LocationContainerState();
}

class _LocationContainerState extends State<LocationContainer> {
  final TextEditingController _textController = TextEditingController();
  final List<String> addresses = ['بادية ', '800 فدان'];

  @override
  void initState() {
    super.initState();
    final cubit = context.read<RepairCubit>();
    _textController.text = cubit.state.formData.unitNumber ?? '';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepairCubit, RepairState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: 328.w,
              height: 48.h,
              constraints: const BoxConstraints(minHeight: 48.0),
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.white, width: 1.w),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    SizedBox(width: 13.w),
                    SvgPicture.asset(ImageAssets.location),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 270.w,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: state.formData.location,
                        underline: Container(),
                        icon: Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: ShapeDecoration(
                            color: const Color(0xffE0E0E0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          child: const Icon(Icons.keyboard_arrow_down_sharp),
                        ),
                        hint: const Text('الموقع'),
                        items:
                            addresses.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          if (newValue != null) {
                            context.read<RepairCubit>().updateLocation(
                              newValue,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            // Text input field
            Container(
              width: 328.w,
              height: 48.h,
              decoration: ShapeDecoration(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              child: TextField(
                controller: _textController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                onChanged: (value) {
                  context.read<RepairCubit>().updateUnitNumber(value);
                },
                style: AppText.reg16,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0.r),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0.w),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Colors.grey, width: 0.1.w),
                  ),
                  hintText: 'من فضلك اكتب رقم وحدتك ',
                  hintStyle: AppText.reg16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
