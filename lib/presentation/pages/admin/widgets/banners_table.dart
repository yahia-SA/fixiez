import 'package:fixiez/core/network/remote/endpoints.dart';
import 'package:fixiez/core/routes/app_routes.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/pages/admin/widgets/upload_widget.dart';
import 'package:fixiez/presentation/state/cubit/banner/banner_cubit.dart';
import 'package:fixiez/presentation/widgets/delete.dart';
import 'package:fixiez/domain/entities/banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannersTable extends StatefulWidget {
  const BannersTable({super.key});

  @override
  State<BannersTable> createState() => _BannersTableState();
}

class _BannersTableState extends State<BannersTable> {
  bool isLoading = false;
  List<Banners>? cachedBanners;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final state = context.read<BannerCubit>().state;
      if (state is BannerSuccess) {
        cachedBanners = state.banner;
      }
    });
  }

  void _fetchData() {
    if (!isLoading) {
      setState(() => isLoading = true);
      context.read<BannerCubit>().getBanners().then(
        (_) => setState(() => isLoading = false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BannerCubit, BannerState>(
      listener: (context, state) {
        if (state is BannerSuccess) {
          setState(() {
            cachedBanners = state.banner;
          });
        }
        if (state is BannerSuccess || state is BannerFailure) {
          setState(() => isLoading = false);
        }
      },
      listenWhen:
          (previous, current) =>
              current is BannerSuccess || current is BannerFailure,
      builder: (context, state) {
        return Column(
          children: [
            if (state is BannerLoading && cachedBanners == null && !isLoading)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            if (state is BannerSuccess || cachedBanners != null)
              CustomTable(
                title: 'اداره البانرات ',
                titleButton: 'اضافه بانر',
                titleButtonAction:
                    () => showDialog(
                      context: context,
                      builder:
                          (context) => UploadWidget(
                            onPressed: (newImage) async {
                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                await context.read<BannerCubit>().createBanner(
                                  image: newImage,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                _fetchData();
                                if (context.mounted) {
                                  Navigator.pop(context);
                                }
                                UiHelper.showNotification(
                                  'تم إضافة البانر بنجاح',
                                  backgroundColor: Colors.green,
                                );
                              } catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                UiHelper.showNotification(
                                  'حدث خطأ ما',
                                  backgroundColor: Colors.red,
                                );
                              }
                            },
                          ),
                    ),

                headers: ['صوره', 'عرض', 'الحاله', 'تعديل'],
                dataCellStyle: AppText.reg10.copyWith(
                  color: AppColors.black,
                  height: 1.3.h,
                ),
                data:
                    (state is BannerSuccess ? state.banner : cachedBanners!)
                        .map((e) {
                          return [
                            Image.network(
                              '${ApiEndpoints.baseUrl}/${e.image}',
                              fit: BoxFit.cover,
                            ),
                            InkWell(
                              onTap:
                                  () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.webview,
                                    arguments: {
                                      'url':
                                          '${ApiEndpoints.baseUrl}/${e.image}',
                                    },
                                  ),
                              child: Container(
                                width: 59.w,
                                height: 23.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color: AppColors.primary,
                                    width: 0.5.w,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'مشاهده',
                                    style: AppText.semi12.copyWith(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap:
                                  () => deleteDialog(
                                    context: context,
                                    title:
                                        !e.isActive
                                            ? 'هل انت متاكد من تفعيل البانر؟'
                                            : 'هل انت متاكد من تعطيل البانر؟',
                                    buttontext: !e.isActive ? 'تفعيل' : 'تعطيل',
                                    deleteAction: () async {
                                      try {
                                        await context
                                            .read<BannerCubit>()
                                            .updateBanner(
                                              id: e.id,
                                              isActive: !e.isActive,
                                            );

                                        setState(() {
                                          final index = cachedBanners
                                              ?.indexWhere(
                                                (item) => item.id == e.id,
                                              );
                                          if (index != null && index != -1) {
                                            cachedBanners![index] = e.copyWith(
                                              isActive: !e.isActive,
                                            );
                                          }
                                        });
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                        UiHelper.showNotification(
                                          !e.isActive
                                              ? 'تم تفعيل البانر بنجاح'
                                              : 'تم تعطيل البانر بنجاح',
                                          backgroundColor: Colors.green,
                                        );
                                      } catch (e) {
                                        UiHelper.showNotification(
                                          'حدث خطأ ما',
                                        );
                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      }
                                    },
                                  ),
                              child: Container(
                                width: 59.w,
                                height: 23.h,

                                decoration: BoxDecoration(
                                  color:
                                      e.isActive
                                          ? const Color.fromARGB(
                                            245,
                                            239,
                                            238,
                                            238,
                                          )
                                          : const Color.fromARGB(
                                            255,
                                            244,
                                            236,
                                            236,
                                          ),
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color:
                                        e.isActive
                                            ? const Color(0xFF40B956)
                                            : AppColors.error,
                                    width: 0.5.w,
                                  ),
                                ),
                                child: Center(
                                  child:
                                      e.isActive
                                          ? Text(
                                            'تفعيل',
                                            style: AppText.bold12.copyWith(
                                              color: const Color(0xFF34A449),
                                              height: 1.3.h,
                                            ),
                                          )
                                          : Text(
                                            'ايقاف',
                                            style: AppText.bold12.copyWith(
                                              color: const Color(0xFFC90202),
                                              height: 1.3.h,
                                            ),
                                          ),
                                ),
                              ),
                            ),
                            InkWell(
                              child: Icon(
                                Icons.delete,
                                color: AppColors.error,
                                size: 20.sp,
                              ),
                              onTap:
                                  () => deleteDialog(
                                    context: context,
                                    title: 'هل انت متاكد من حذف البانر',
                                    deleteAction: () {
                                      context
                                          .read<BannerCubit>()
                                          .deleteBanner(id: e.id)
                                          .then((success) {
                                            setState(() {
                                              cachedBanners!.removeWhere(
                                                (element) => element.id == e.id,
                                              );
                                            });
                                            UiHelper.showNotification(
                                              'تم حذف البانر بنجاح',
                                              backgroundColor: Colors.green,
                                            );
                                          })
                                          .catchError((e) {
                                            UiHelper.showNotification(
                                              'حدث خطأ:$e',
                                            );
                                          });

                                      Navigator.pop(context);
                                    },
                                  ),
                            ),
                          ];
                        })
                        .toList(),
                headingRowHeight: 52,
                dataRowHeight: 36,
                // columnWidths: 81.75,
              ),
            // Padding(
            //   padding: EdgeInsetsDirectional.symmetric(
            //     vertical: 1.h,
            //     horizontal: 28.w,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       TextButton(
            //         onPressed:
            //             (_pageIndex > 1 && !isLoading) ? _onClickBack : null,
            //         child: TextWidget('السابق', style: context.med14Black),
            //       ),
            //       TextWidget('$_pageIndex : $totalPages'),
            //       TextButton(
            //         onPressed:
            //             (_pageIndex < totalPages! && !isLoading)
            //                 ? _onClickNext
            //                 : null,
            //         child: TextWidget('التالي', style: context.med14Black),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        );
      },
    );
  }
}

// Future<void> _launchURL(String image) async {
//   final Uri url = Uri.parse('${ApiEndpoints.baseUrl}/$image');

//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
