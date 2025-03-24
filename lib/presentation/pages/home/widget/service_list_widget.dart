import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/cubit/repair_cubit.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ServiceListWidget extends StatelessWidget {
  const ServiceListWidget({super.key});

  ServiceName? getServiceName(String arabicName) {
    switch (arabicName) {
      case 'نجارة':
        return ServiceName.carpentry;
      case 'دهان':
        return ServiceName.painting;
      case 'سباكة':
        return ServiceName.plumbing;
      case 'كهرباء':
        return ServiceName.electricity;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          services.map((service) {
            // Get the enum value corresponding to the Arabic name
            final serviceEnum = getServiceName(service['name']!);

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.5.w),
                  child: BlocBuilder<RepairCubit, RepairState>(
                    builder: (context, state) {
                      // Check if the current service is selected
                      final isSelected =
                          state.formData.serviceName == serviceEnum;

                      return InkWell(
                        onTap: () {
                          context.read<RepairCubit>().updateServiceName(
                            serviceEnum!,
                          );
                        },
                        child: Container(
                          width: 63.w,
                          height: 65.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? AppColors.primary
                                      : const Color(0xffE0E0E0),
                              width: isSelected ? 2 : 0.5,
                            ),

                            color:
                                isSelected
                                    ? const Color(
                                      0xff0258C9,
                                    ).withValues(alpha: 0.15)
                                    : Colors.transparent,
                          ),
                          child: Center(
                            child: SvgPicture.asset(service['image']!),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 3.h),
                TextWidget(service['name']!, style: AppText.med14),
              ],
            );
          }).toList(),
    );
  }
}

final List<Map<String, String>> services = [
  {'name': 'نجارة', 'image': ImageAssets.carpenter},
  {'name': 'دهان', 'image': ImageAssets.paint},
  {'name': 'سباكة', 'image': ImageAssets.plumbing},
  {'name': 'كهرباء', 'image': ImageAssets.electric},
];
