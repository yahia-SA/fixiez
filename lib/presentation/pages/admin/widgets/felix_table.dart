import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:fixiez/data/models/felix_model.dart';
import 'package:fixiez/presentation/pages/admin/widgets/add_felix_widget.dart';
import 'package:fixiez/presentation/pages/admin/widgets/edit_widget.dart';
import 'package:fixiez/presentation/state/cubit/felix/felix_cubit.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:fixiez/presentation/widgets/delete.dart';
import 'package:fixiez/presentation/widgets/pagination_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FelixTable extends StatefulWidget {
  const FelixTable({super.key});

  @override
  State<FelixTable> createState() => _FelixTableState();
}

class _FelixTableState extends State<FelixTable> {
  bool isLoading = false;
  FelixResponse? cachedFelixs;
  int _pageIndex = 1;
  int? cachedTotalPages;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final state = context.read<FelixCubit>().state;
      if (state is FelixSuccess) {
        cachedFelixs = state.felix;
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
          .read<FelixCubit>()
          .getFelix(pageIndex: _pageIndex)
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
    return BlocConsumer<FelixCubit, FelixState>(
      listener: (context, state) {
        if (state is FelixSuccess) {
          setState(() {
            cachedFelixs = state.felix;
            cachedTotalPages = state.totalPages;
          });
        }
        if (state is FelixSuccess || state is FelixFailure) {
          setState(() => isLoading = false);
        }
      },
      listenWhen:
          (previous, current) =>
              current is FelixSuccess || current is FelixFailure,
      builder: (context, state) {
        final totalPages =
            (state is FelixSuccess) ? state.totalPages : cachedTotalPages ?? 1;

        return Column(
          children: [
            if (state is FelixLoading && cachedFelixs == null && !isLoading)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            if (state is FelixSuccess || cachedFelixs != null)
              CustomTable(
                title: 'ادراه الباقات ',
                titleButton: 'اضافه باقه',
                titleButtonAction:
                    () => showDialog(
                      context: context,
                      builder:
                          (context) => AddFelix(
                            saveAction: (felix, cost) {
                              context
                                  .read<FelixCubit>()
                                  .createFelix(felixNumber: felix, cost: cost)
                                  .then((e) {
                                    setState(() {
                                      _fetchData();
                                    });
                                    if (context.mounted) Navigator.pop(context);
                                    UiHelper.showNotification(
                                      'تم اضافه الباقه بنجاح',
                                      backgroundColor: Colors.green,
                                    );
                                  })
                                  .catchError((e) {
                                    UiHelper.showNotification('حدث خطأ:$e');
                                  });
                            },
                          ),
                    ),
                headers: ['عدد الفيكسات', 'سعر الباقه', 'تعديل الباقه'],
                data:
                    (state is FelixSuccess
                            ? state.felix!.data
                            : cachedFelixs!.data!)!
                        .map((e) {
                          return [
                            e.felixNumber.toString(),
                            e.cost.toString(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap:
                                      () => showDialog(
                                        context: context,
                                        builder:
                                            (context) => EditWidget(
                                              isEditUser: false,
                                              title: 'تعديل باقات الصيانه',
                                              saveAction: (newcost) {
                                                final cost = double.tryParse(
                                                  newcost,
                                                );
                                                if (cost != null) {
                                                  context
                                                      .read<FelixCubit>()
                                                      .updateFelix(
                                                        id: e.id.toString(),
                                                        cost: cost,
                                                        felixNumber:
                                                            e.felixNumber,
                                                      );
                                                  setState(() {
                                                    final index = cachedFelixs
                                                        ?.data
                                                        ?.indexWhere(
                                                          (item) =>
                                                              item.id == e.id,
                                                        );
                                                    if (index != null &&
                                                        index != -1) {
                                                      cachedFelixs!
                                                          .data![index] = e
                                                          .copyWith(cost: cost);
                                                    }
                                                  });
                                                }

                                                Navigator.pop(context);
                                              },
                                              isDouble: true,
                                              tabletitle1: 'عدد الفيكسات',
                                              tabletitle2: 'سعر الباقه',
                                              userData1:
                                                  e.felixNumber.toString(),
                                              userData2: e.cost.toString(),
                                            ),
                                      ),
                                  child: Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                    size: 20.sp,
                                  ),
                                ),
                                InkWell(
                                  onTap:
                                      () => deleteDialog(
                                        context: context,
                                        title: 'هل انت متاكد من حذف الباقه',
                                        deleteAction: () {
                                          context
                                              .read<FelixCubit>()
                                              .deleteFelix(id: e.id)
                                              .then((success) {
                                                setState(() {
                                                  cachedFelixs!.data!
                                                      .removeWhere(
                                                        (element) =>
                                                            element.id == e.id,
                                                      );
                                                });
                                                UiHelper.showNotification(
                                                  'تم حذف الباقه بنجاح',
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
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColors.error,
                                    size: 20.sp,
                                  ),
                                ),
                              ],
                            ),
                          ];
                        })
                        .toList(),
                headingRowHeight: 36,
                dataRowHeight: 38,
                // columnWidths: 109,
              ),
            PaginationControls(
              pageIndex: _pageIndex,
              totalPages: totalPages!,
              isLoading: isLoading,
              onNext: _onClickNext,
              onBack: _onClickBack,
            ),
          ],
        );
      },
    );
  }
}
