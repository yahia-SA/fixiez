import 'package:fixiez/presentation/widgets/custom_table.dart';
import 'package:fixiez/presentation/widgets/name_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  // Data for المستخدمين
  static final List<List<String>> usersData = [
    ['عمرو احمد', '0110100423', 'مستخدم', '✅️'],
    ['عادل طه', '0100122223', 'احدن', '✅️'],
    ['عمر محمد', '0122345639', 'مستخدم', '✅️'],
  ];

  // Headers for المستخدمين
  static final List<String> usersHeaders = ['اسم المستخدم', 'رقم الموبايل', 'نوع المستخدم', 'تعديل'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F7FF),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                textDirection: TextDirection.ltr,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [Padding(
                  padding:  EdgeInsets.fromLTRB(
                      28.w,
                      43.h,
                      59.w,
                      0,
                    ),
                  child: NameHeader(onSettingsPressed: () {},isblue: true,),
                ),
                SizedBox(height: 48.h,),
                CustomTable(title: 'المستخدمين ', headers: usersHeaders, data: usersData, headingRowHeight: 40, dataRowHeight: 36,),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
