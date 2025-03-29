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
  int _pageIndex = 1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
        Future.microtask(() {
      if(!mounted) return;
    final state = context.read<ReviewCubit>().state;
    if (state is! ReviewSuccess) {
      _fetchData();
    }
    });
  }
  void _fetchData() {
    if(!isLoading){
      setState(() => isLoading = true);
      context.read<ReviewCubit>().getReviews(page: _pageIndex).then((_) => setState(() => isLoading = false));
  }
  }
    void _onClickNext()  {
    if (!isLoading) {
      setState(() {
        _pageIndex++;
      });
      _fetchData();
    }
  }

  void _onClickBack() {
    if (!isLoading) {
      setState(() {
        _pageIndex--;
      });
      _fetchData();
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSuccess || state is ReviewFailure) {
          setState(() => isLoading = false);
        }
        
      },
      listenWhen: (previous, current) => current is ReviewSuccess || current is ReviewFailure,
      builder: (context, state) {
        if (state is ReviewSuccess) {
          final reviews = state.reviews;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                ListView.separated(
                  controller: ScrollController(
                    keepScrollOffset: true,
                    
                  ),
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
                                                Padding(
                                  padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 1.h,
                                    horizontal: 28.w,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,

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
                                      TextWidget(
                                        '$_pageIndex : ${state.totalPages}',
                                      ),
                                      TextButton(
                                        onPressed:
                                            (_pageIndex <
                                                    state.totalPages! && !isLoading)
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
          );
        }
        // While the API call is loading or in case of an error, return an empty container.
        return const SizedBox.shrink();
      },
    );
  }
}