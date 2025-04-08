import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/pages/profile/widgets/customer_review_text.dart';
import 'package:fixiez/presentation/state/cubit/review/review_cubit.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key});

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  late TextEditingController _textController;
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
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomerReviewText(textController: _textController),
        SizedBox(height: 18.h),
        Center(
          child: CustomButton(
            onpressed: () {
              if (_textController.text.isEmpty) {
                UiHelper.showNotification('يرجى كتابة تقيمك');
              } else {
                context.read<ReviewCubit>().submitReview(
                  comment: _textController.text,
                );
                debugPrint('comment : ${_textController.text}');
                UiHelper.showNotification(
                  ('شكرا للك علي التعليق\n comment : ${_textController.text}'),
                  backgroundColor: Colors.green,
                );
                _textController.clear();
              }
            },
            text: 'ارسل تقيمك',
          ),
        ),
      ],
    );
  }
}
