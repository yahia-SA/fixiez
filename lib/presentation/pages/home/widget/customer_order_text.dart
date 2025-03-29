import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/cubit/repair_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerOrderText extends StatefulWidget {
  const CustomerOrderText({super.key});

  @override
  State<CustomerOrderText> createState() => _CustomerOrderTextState();
}

class _CustomerOrderTextState extends State<CustomerOrderText> {
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 326.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey, width: 0.5.w),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: BlocBuilder<RepairCubit, RepairState>(
            builder: (context, state) {
              return TextField(
                controller: _textController,
                expands: true,
                maxLines: null,
                minLines: null,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                style: context.reg16Hint80,
                decoration: const InputDecoration(
                  hintText: 'اوصف العمل المطلوب',
                  border: InputBorder.none,
                  fillColor: AppColors.white,
                  contentPadding: EdgeInsets.all(0),
                ),
                onChanged: (value) {},
                onSubmitted: (value) {
                  context.read<RepairCubit>().updateDescription(
                    _textController.text,
                  );
                },
                onTapOutside: (event) {
                  context.read<RepairCubit>().updateDescription(
                    _textController.text,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
