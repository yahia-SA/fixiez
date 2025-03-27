
import 'package:fixiez/core/constants/image_assets.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/presentation/pages/home/widget/silder_poster_widget.dart';
import 'package:fixiez/presentation/pages/profile/widgets/customer_review_text.dart';
import 'package:fixiez/presentation/pages/profile/widgets/maintenance_widget.dart';
import 'package:fixiez/presentation/pages/profile/widgets/price_list_widget.dart';
import 'package:fixiez/presentation/state/bloc/profile/profile_bloc.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:fixiez/presentation/widgets/cutom_button.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(InitializeProfile());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
               context.read<ProfileBloc>().add(InitializeProfile());
              },
              child: SingleChildScrollView(
                child: Column(
                  textDirection: TextDirection.rtl,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        24,
                        30,
                        24,
                        47,
                      ),
                      decoration: ShapeDecoration(
                        color: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 25.h),
                          NameHeader(
                            onBackPressed: () => Navigator.pop(context),
                            isThereSettings: true,
                          ),
                          SizedBox(height: 48.h),
                          Row(
                            children: [
                              TextWidget(
                                'الرصيد',
                                style: AppText.medium20.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 48.w),
              
                              Container(
                                width: 208.w,
                                height: 48.h,
              
                                constraints: const BoxConstraints(
                                  minHeight: 48.0,
                                ),
                                decoration: ShapeDecoration(
                                  color: AppColors.white,
              
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      color: AppColors.white,
                                      width: 1.w,
                                    ),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 11.h,
                                    right: 10.w,
                                  ),
                                  child: BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                      if (state is ProfileSuccess) {
                                        return TextWidget(
                                          state.user.balance.toString(),
                                          style: AppText.medium20.copyWith(
                                            color: Colors.black,
                                          ),
                                        );
                                      } else if (state is ProfileFailure) {
                                        Future.microtask(() => UiHelper.showNotification(state.message));
                                        return TextWidget(
                                          state.message,
                                          style: AppText.medium20.copyWith(
                                            color: Colors.black,
                                          ),
                                        );
                                      } else {
                                        return TextWidget(
                                          'Loading',
                                          style: AppText.medium20.copyWith(
                                            color: Colors.black,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    const SilderPosterWidgetState(),
                    SizedBox(height: 4.h),
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: TextWidget(
                        'الباقات',
                        style: AppText.bold20.copyWith(
                          color: const Color(0xff0258C9),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    const PriceListWidget(),
                    SizedBox(height: 16.h),
                    Center(
                      child: TextWidget(
                        'استخدم بطاقاتك الثابته بدفع رسوم الصيانه لكل زياره',
                        style: AppText.med14.copyWith(
                          color: AppColors.texthint80,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const MaintenanceWidget(),
                    SizedBox(height: 26.h),
                    BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                          print(state);
                        if(state is RepairRequestsFailure){
                          Future.microtask(() => UiHelper.showNotification(state.message));
                            return Center(child: Text('فشل في تحميل البيانات',style: context.error,));
                        }
                        else if (state is RepairRequestsLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        else if (state is RepairRequestsSuccess) {
                        return CustomTable(
                          title: 'طلبات الصيانه ',
                          headers: ['رقم الطلب', 'نوع الخدمة', 'تاكيد الطلب'],
                          data: state.repairData.requests.map((e){
                            return [
                            e.id,
                            e.serviceName,
                            e.status
                          ];
                          }
                          ).toList(),
                          headingRowHeight: 46.h,
                          dataRowHeight: 46.h,
                          headersColor: AppColors.primary,
                          headingTextStyle: context.med14Black!.copyWith(
                            color: AppColors.white,
                          ),
                          dataCellStyle: context.med14Black,
                          titleheight: 16.h,
                        );
                      }
                      else { return const SizedBox.shrink(); }
                      },
                    ),
                    SizedBox(height: 24.h),
                    Padding(
                      padding: EdgeInsets.only(right: 24.w),
                      child: TextWidget(
                        'التقبيم',
                        style: AppText.bold20.copyWith(color: AppColors.primary),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    const CustomerReviewText(),
                    SizedBox(height: 18.h),
                    Center(
                      child: CustomButton(onpressed: () {}, text: 'ارسل تقيمك'),
                    ),
                    SizedBox(height: 116.h),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: CustomButton(
                onpressed: () {
                  UiHelper.launchWhatsApp();
                },
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget('تواصل معنا', style: AppText.semi16),
                    SizedBox(width: 5.w),
                    SvgPicture.asset(ImageAssets.call),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
