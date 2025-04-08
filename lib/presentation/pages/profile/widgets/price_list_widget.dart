import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/state/bloc/profile/profile_bloc.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriceListWidget extends StatelessWidget {
  const PriceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is ProfileFailure) {
          Future.microtask(() => UiHelper.showNotification(state.message));
          return Container();
        } else if (state is ProfileSuccess) {
          debugPrint('State Felix: ${state.felix}');
          final felixes = state.felix ?? [];
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                felixes
                    .map(
                      (service) => InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Container(
                            width: 69.w,
                            height: 92.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.yellow,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 61.w,
                                    height: 46.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColors.white,
                                    ),
                                    child: Center(
                                      child: TextWidget(
                                        '${service.felixNumber} Fx',
                                        style: AppText.bold14.copyWith(
                                          color: AppColors.primary,
                                        ),
                                        textDirection: TextDirection.ltr,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  TextWidget(
                                    '${service.cost} LE',
                                    style: AppText.bold14.copyWith(
                                      color: AppColors.primary,
                                    ),
                                    textDirection: TextDirection.ltr,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          );
        }

        return Center(child: TextWidget('Loading', style: context.bold16Blue));
      },
    );
  }
}
