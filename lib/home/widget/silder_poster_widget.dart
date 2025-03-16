
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SilderPosterWidgetState extends StatefulWidget {
  const SilderPosterWidgetState({super.key});

  @override
  State<SilderPosterWidgetState> createState() =>
      _SilderPosterWidgetStateState();
}

class _SilderPosterWidgetStateState extends State<SilderPosterWidgetState> {
  final List<String> _imageUrls = [
    'https://picsum.photos/329/123',
    'https://picsum.photos/330/123',
    'https://picsum.photos/331/123',
    'https://picsum.photos/332/123',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items:
              _imageUrls.map((url) {
                return Container(
                  width: 329.w,
                  height: 123.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.error, color: Colors.red),
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
              setState(() {
                _currentIndex = index;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              _imageUrls.asMap().entries.map((entry) {
                return Container(
                  width: 11.w,
                  height: 11.h,

                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: ShapeDecoration(
                    color:
                        _currentIndex == entry.key
                            ? const Color(0xff0258C9)
                            : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
