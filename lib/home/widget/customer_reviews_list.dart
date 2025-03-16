import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/shared/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerReviewsList extends StatelessWidget {
  const CustomerReviewsList({super.key});

  final List<Map<String, String>> reviews = const [
    {
      'name': 'مروه اسامه',
      'review': 'لقد قاموا باصلاح اضواء حديقتي وعم محترفون والعمل رائع',
      'photo': 'https://picsum.photos/329/123',
    },
    {
      'name': 'ساره علي',
      'review': 'انهم محترفون بالعمل سعدت بالتعامل معهم',
      'photo': 'https://picsum.photos/329/123',
    },
    {
      'name': 'ساره علي',
      'review': 'انهم محترفون بالعمل سعدت بالتعامل معهم',
      'photo': 'https://picsum.photos/329/123',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
           padding:  EdgeInsets.only(left: 24.w),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => const Divider(thickness: 1.0),
        itemBuilder: (context, index) {
          final review = reviews[index];
          return ListTile(
            contentPadding: EdgeInsets.zero, 
            leading: CircleAvatar(
              radius: 50.r,
              backgroundImage: NetworkImage(review['photo']!),
            ),
            title: TextWidget(
              review['name']!,
              style: AppText.bold16,
            ),
            subtitle: TextWidget(review['review']!,
            style: AppText.reg16.copyWith(color: const Color(0xff455A64))
            ),
          );
        },
      ),
    );
  }
}
