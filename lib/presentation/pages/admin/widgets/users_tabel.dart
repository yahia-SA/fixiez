import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/data/models/users_model.dart';
import 'package:fixiez/presentation/pages/admin/widgets/edit_widget.dart';
import 'package:fixiez/presentation/widgets/delete.dart';
import 'package:fixiez/presentation/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/presentation/state/cubit/users/users_cubit.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsersTable extends StatefulWidget {
  const UsersTable({super.key});

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  int _pageIndex = 1;
  bool isLoading = false;
  UsersMdoel? cachedUsers;
  int? cachedTotalPages;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final state = context.read<UsersCubit>().state;
      if (state is UsersSuccess) {
        cachedUsers = state.users;
        cachedTotalPages = state.totalPages;
      } else {
        _fetchData();
      }
    });
  }

  void _fetchData() {
    if (!isLoading) {
      setState(() => isLoading = true);
      context
          .read<UsersCubit>()
          .getAdminUsers(pageIndex: _pageIndex)
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsersCubit, UsersState>(
      listener: (context, state) {
        if (state is UsersSuccess) {
          setState(() {
            cachedUsers = state.users;
            cachedTotalPages = state.totalPages;
          });
        }
        if (state is UsersSuccess || state is UsersFailure) {
          setState(() => isLoading = false);
        }
      },
      listenWhen:
          (previous, current) =>
              current is UsersSuccess || current is UsersFailure,
      builder: (context, state) {
        final totalPages =
            (state is UsersSuccess) ? state.totalPages : cachedTotalPages ?? 1;
        return Column(
          children: [
            if (state is UsersLoading && cachedUsers == null)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            if (state is UsersSuccess || cachedUsers != null)
              CustomTable(
                title: 'المستخدمين ',
                headers: [
                  'اسم المستخدم',
                  'رقم الموبايل',
                  'نوع المستخدم',
                  'تعديل',
                ],
                dataCellStyle: AppText.reg10.copyWith(
                  color: AppColors.black,
                  height: 1.3.h,
                ),
                data:
                    (state is UsersSuccess
                            ? state.users!.data!
                            : cachedUsers!.data!)
                        .map((e) {
                          return [
                            e.name,
                            e.phoneNumber,
                            e.role.toArabicRole,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap:
                                      () => showDialog(
                                        context: context,
                                        builder:
                                            (context) => EditWidget(
                                              title: 'تعديل نوع المستخدم',
                                              saveAction: (newrole) {
                                                context
                                                    .read<UsersCubit>()
                                                    .updateAdminUser(
                                                      id: e.id.toString(),
                                                      role: newrole,
                                                    );
                                                setState(() {
                                                  final index = cachedUsers!.data
                                                      ?.indexWhere(
                                                        (item) => item.id == e.id,
                                                      );
                                                  if (index != null &&
                                                      index != -1) {
                                                    cachedUsers!.data![index] = e
                                                        .copyWith(role: newrole);
                                                  }
                                                });
                                                Navigator.pop(context);
                                              },
                                              tabletitle1: 'اسم المستخدم',
                                              tabletitle2: 'نوعه',
                                              userData1: e.name.toString(),
                                              userData2:
                                                  e.role.toArabicRole.toString(),
                                            ),
                                      ),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                ),
                              InkWell(onTap: () => deleteDialog(context: context, title: 'هل انت متاكد من حذف المستخدم', deleteAction: () {
                                      context
                                          .read<UsersCubit>()
                                          .deleteAdminUser(id: e.id)
                                          .then((success) {
                                            setState(() {
                                              cachedUsers!.data!.removeWhere(
                                                (element) => element.id == e.id,
                                              );
                                            });
                                            UiHelper.showNotification(
                                              'تم حذف المستخدم بنجاح',
                                              backgroundColor: Colors.green,
                                            );
                                          })
                                          .catchError((e) {
                                            UiHelper.showNotification(
                                              'حدث خطأ:$e',
                                            );
                                          });

                                      Navigator.pop(context);
                                    }),
                                child: Icon(Icons.delete,color: AppColors.error,size: 20.sp,),),],
                            ),
                          ];
                        })
                        .toList(),
                headingRowHeight: 52,
                dataRowHeight: 38,
                columnWidths: [81.75, 81.75, 81.75, 81.75],
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
                        (_pageIndex > 1 && !isLoading) ? _onClickBack : null,
                    child: TextWidget('السابق', style: context.med14Black),
                  ),
                  TextWidget('$_pageIndex : $totalPages'),
                  TextButton(
                    onPressed:
                        (_pageIndex < totalPages! && !isLoading)
                            ? _onClickNext
                            : null,
                    child: TextWidget('التالي', style: context.med14Black),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
