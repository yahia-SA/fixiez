import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/state/bloc/profile/profile_bloc.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetBalnce extends StatelessWidget {
  const GetBalnce({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWidget(
          'الرصيد',
          style: AppText.medium20.copyWith(color: Colors.white),
        ),
        SizedBox(width: 48.w),

        Container(
          width: 208.w,
          height: 48.h,

          constraints: const BoxConstraints(minHeight: 48.0),
          decoration: ShapeDecoration(
            color: AppColors.white,

            shape: RoundedRectangleBorder(
              side: BorderSide(color: AppColors.white, width: 1.w),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 11.h, right: 10.w),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileSuccess) {
                  return TextWidget(
                    state.user!.balance.toString(),
                    style: AppText.medium20.copyWith(color: Colors.black),
                  );
                } else if (state is ProfileFailure) {
                  Future.microtask(
                    () => UiHelper.showNotification(state.message),
                  );
                  return TextWidget(
                    state.message,
                    style: AppText.medium20.copyWith(color: Colors.black),
                  );
                } else {
                  return TextWidget(
                    'Loading',
                    style: AppText.medium20.copyWith(color: Colors.black),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
