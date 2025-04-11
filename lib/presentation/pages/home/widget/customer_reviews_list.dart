import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/data/models/reviews_model.dart';
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
  int _pageIndex = 1;
  bool isLoading = false;
  late ScrollController _scrollController;
  ReviewsModel? cachedReviews;
  int? cachedTotalPages;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    Future.microtask(() {
      if (!mounted) return;
      final state = context.read<ReviewCubit>().state;
      if (state is ReviewSuccess) {
        cachedReviews = state.reviews;
        cachedTotalPages = state.totalPages;
      } else {
        _fetchData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchData() {
    if (!isLoading) {
      setState(() => isLoading = true);
      context
          .read<ReviewCubit>()
          .getReviews(page: _pageIndex)
          .then((_) => setState(() => isLoading = false));
    }
  }

  void _onClickNext() {
    if (!isLoading) {
      setState(() => _pageIndex++);
      _fetchData();
    }
  }

  void _onClickBack() {
    if (!isLoading) {
      setState(() => _pageIndex--);
      _fetchData();
    }
  }

  final _avatarColors = [Colors.blue, Colors.amber, Colors.brown];

  @override
  Widget build(BuildContext context) {
    if (cachedReviews == null && !isLoading) {
      _fetchData();
    }
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSuccess) {
          setState(() {
            cachedReviews = state.reviews;
            cachedTotalPages = state.totalPages;
          });
        }
        if (state is ReviewSuccess || state is ReviewFailure) {
          setState(() => isLoading = false);
        }
      },
      listenWhen:
          (previous, current) =>
              current is ReviewSuccess || current is ReviewFailure,
      builder: (context, state) {
        // Use cached data if available, even during loading
        final reviews = cachedReviews;
        final totalPages = cachedTotalPages;

        if (reviews == null) return const SizedBox.shrink();

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Column(
                children: [
                  ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(left: 24.w),
                    itemCount: reviews.data?.length ?? 0,
                    separatorBuilder:
                        (context, index) => const Divider(thickness: 1.0),
                    itemBuilder: (context, index) {
                      final review = reviews.data![index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 50.r,
                          backgroundColor: _avatarColors[index % 3].withValues(
                            alpha: 0.7,
                          ),
                          child: Text(
                            UiHelper.getTransliteratedFirstLetter(
                              review.userId?.name ?? '',
                            ),
                            style: AppText.bold24.copyWith(color: Colors.white),
                          ),
                        ),
                        title: TextWidget(
                          review.userId?.name ?? '',
                          style: AppText.bold16,
                        ),
                        subtitle: TextWidget(
                          review.comment ?? '',
                          style: context.feedback,
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 1.h,
                      horizontal: 28.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed:
                              (_pageIndex > 1 && !isLoading)
                                  ? _onClickBack
                                  : null,
                          child: TextWidget(
                            'السابق',
                            style: context.med14Black,
                          ),
                        ),
                        TextWidget('$_pageIndex : $totalPages'),
                        TextButton(
                          onPressed:
                              (_pageIndex < totalPages! && !isLoading)
                                  ? _onClickNext
                                  : null,
                          child: TextWidget(
                            'التالي',
                            style: context.med14Black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
