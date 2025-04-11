import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/state/cubit/banner/banner_cubit.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SilderPosterWidgetState extends StatelessWidget {
  SilderPosterWidgetState({super.key});

  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCubit, BannerState>(
      buildWhen: (previous, current) {
        return previous.runtimeType != current.runtimeType ||
            (current is BannerSuccess &&
                previous is BannerSuccess &&
                current.banner != previous.banner);
      },
      builder: (context, state) {
        if (state is BannerLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (state is BannerFailure) {
          Future.microtask(() => UiHelper.showNotification(state.message));
          return Container();
        } else if (state is BannerSuccess) {
          return Column(
            children: [
              CarouselSlider(
                items:
                    state.banner.map((url) {
                      return Container(
                        width: 329.w,
                        height: 123.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.white, width: 2),
                        ),

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            '${ApiEndpoints.baseUrl}/${url.image}',
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              );
                            },
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.error,
                                  color: AppColors.error,
                                ),
                          ),
                        ),
                      );
                    }).toList(),

                options: CarouselOptions(
                  height: 123,
                  aspectRatio: 329 / 123,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    _currentIndex.value = index;
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: _currentIndex,
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        state.banner.asMap().entries.map((entry) {
                          return Container(
                            width: 11.w,
                            height: 11.h,

                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: ShapeDecoration(
                              color:
                                  _currentIndex.value == entry.key
                                      ? AppColors.primary
                                      : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }).toList(),
                  );
                },
              ),
            ],
          );
        }
        return const Center(
          child: TextWidget('Error occured', color: AppColors.error),
        );
      },
    );
  }
}
