import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/presentation/state/cubit/review/review_cubit.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerReviewsList extends StatefulWidget {
  const CustomerReviewsList({super.key});

  @override
  State<CustomerReviewsList> createState() => _CustomerReviewsListState();
}

class _CustomerReviewsListState extends State<CustomerReviewsList> {
  @override
  void initState() {
    super.initState();
    // Trigger the API call once when the widget is inserted in the widget tree.
    context.read<ReviewCubit>().getReviews(page: 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewCubit, ReviewState>(
      builder: (context, state) {
        if (state is ReviewSuccess) {
          final reviews = state.reviews;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 24.w),
              itemCount: reviews?.data?.length ?? 0,
              separatorBuilder:
                  (context, index) => const Divider(thickness: 1.0),
              itemBuilder: (context, index) {
                final review = reviews?.data![index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(radius: 50.r, child: const Text('A')),
                  title: TextWidget(
                    review?.userId?.name ?? '',
                    style: AppText.bold16,
                  ),
                  subtitle: TextWidget(
                    review?.comment ?? '',
                    style: context.feedback,
                  ),
                );
              },
            ),
          );
        }
        // While the API call is loading or in case of an error, return an empty container.
        return const SizedBox.shrink();
      },
    );
  }
}
