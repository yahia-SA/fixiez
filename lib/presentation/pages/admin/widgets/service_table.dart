import 'package:fixiez/core/constants/enums.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/domain/entities/services.dart';
import 'package:fixiez/presentation/pages/admin/widgets/edit_widget.dart';
import 'package:fixiez/presentation/state/cubit/Services/service_cubit.dart';
import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceTable extends StatefulWidget {
  const ServiceTable({super.key});

  @override
  State<ServiceTable> createState() => _ServiceTableState();
}

class _ServiceTableState extends State<ServiceTable> {
  bool isLoading = false;
  List<Services>? cachedServices;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      final state = context.read<ServiceCubit>().state;
      if (state is ServiceSuccess) {
        cachedServices = state.service;
      } else {
        _fetchData();
      }
    });
  }

  void _fetchData() {
    if (!isLoading) {
      setState(() => isLoading = true);
      context.read<ServiceCubit>().getServices().then(
        (_) => setState(() => isLoading = false),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceCubit, ServiceState>(
      listener: (context, state) {
        if (state is ServiceSuccess) {
          setState(() {
            cachedServices = state.service;
          });
        }
        if (state is ServiceSuccess || state is ServiceFailure) {
          setState(() => isLoading = false);
        }
      },
      listenWhen:
          (previous, current) =>
              current is ServiceSuccess || current is ServiceFailure,
      builder: (context, state) {
        return Column(
          children: [
            if (state is ServiceLoading && cachedServices == null)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            if (state is ServiceSuccess || cachedServices != null)
              CustomTable(
                title: 'الخدمات ',
                headers: ['اسم الخدمه', 'سعر الخدمه', 'تعديل الخدمه'],
                data:
                    (state is ServiceSuccess ? state.service : cachedServices!)
                        .map((e) {
                          return [
                            serviceNameFromString(e.name)?.arabicName ?? e.name,
                            e.cost.toString(),
                            InkWell(
                              onTap:
                                  () => showDialog(
                                    context: context,
                                    builder:
                                        (context) => EditWidget(
                                          isEditUser: false,
                                          title: 'تعديل سعر الخدمه',
                                          saveAction: (newcost) {
                                            final cost = int.tryParse(newcost);
                                            if (cost != null) {
                                              context
                                                  .read<ServiceCubit>()
                                                  .updateServiceCost(
                                                    id: e.id.toString(),
                                                    cost: cost,
                                                  );
                                              setState(() {
                                                final index = cachedServices
                                                    ?.indexWhere(
                                                      (item) => item.id == e.id,
                                                    );
                                                if (index != null &&
                                                    index != -1) {
                                                  cachedServices![index] = e
                                                      .copyWith(cost: cost);
                                                }
                                              });
                                            }

                                            Navigator.pop(context);
                                          },
                                          tabletitle1: 'اسم الخدمه',
                                          tabletitle2: 'سعر الخدمه',
                                          userData1: serviceNameFromString(e.name)?.arabicName ?? e.name,
                                          userData2: e.cost.toString(),

                                        ),
                                  ),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.primary,
                                size: 20.sp,
                              ),
                            ),
                          ];
                        })
                        .toList(),
                headingRowHeight: 36,
                dataRowHeight: 38,
                // columnWidths: 109,
              ),
          ],
        );
      },
    );
  }
}
