import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationControls extends StatelessWidget {
  const PaginationControls({
    super.key,
    required this.pageIndex,
    required this.totalPages,
    required this.isLoading,
    required this.onNext,
    required this.onBack,
  });
  final int pageIndex;
  final int totalPages;
  final bool isLoading;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: 1.h, horizontal: 28.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: (pageIndex > 1 && !isLoading) ? onBack : null,
            child: TextWidget('السابق', style: context.med14Black),
          ),
          TextWidget('$pageIndex : $totalPages'),
          TextButton(
            onPressed: (pageIndex < totalPages && !isLoading) ? onNext : null,
            child: TextWidget('التالي', style: context.med14Black),
          ),
        ],
      ),
    );
  }
}
