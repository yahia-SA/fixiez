import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:fixiez/core/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadWidget extends StatefulWidget {
  const UploadWidget({super.key, required this.onPressed
  });
  final void Function(File file) onPressed;

  @override
  State<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends State<UploadWidget> {
  File? _image;
  bool _isImage = true; 
  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        
        type: FileType.image,
        // allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );
      if (result == null) return;

      if (result.files.single.size >= 10 * 1024 * 1024) {
        UiHelper.showNotification('حجم الملف يجب ان يكون اقل من 10 ميجابايت');
      }
      _isImage = !(result.files.single.extension!.toLowerCase() == 'pdf');
      final encdoePath = Uri.file(result.files.single.path!).toFilePath();
      setState(() {
        _image = File(encdoePath);
      });
    } catch (e) {
      UiHelper.showNotification('حدث خطأ في تحميل الملف');
      debugPrint('Failed to pick file $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      child: SizedBox(
        width: 327.w,
        height: 316.h,
        child: Padding(
          padding: EdgeInsets.only(top: 32.h, bottom: 29.h),
          child: Column(
            children: [
              Container(
                width: 263.w,
                height: 193.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primary, width: 1.w),
                ),
                child:
                    _image != null
                            ? _isImage ? Image.file(
                              _image!,
                              fit: BoxFit.fill,
                              errorBuilder:
                                  (context, error, stackTrace) => Center(
                                    child: Text(
                                      'الصورة غير صالحة',
                                      style: context.error,
                                    ),
                                  ),
                            )
                            
                        : PdfPreview(image: _image)
                         :Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: AppColors.primary,
                              size: 40.sp,
                            ),
                            Text(
                              'Select a file or drag and drop here',
                              style: AppText.reg13.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              'JPG, PNG or PDF, file size no more than 10MB',
                              style: AppText.reg12.copyWith(
                                color: const Color(0x66000000),
                              ),
                            ),
                            Container(
                              height: 35.h,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFBFDFE),
                                borderRadius: BorderRadius.circular(5.r),
                                border: Border.all(
                                  color: const Color(0xFF0F91D2),
                                  width: 1.w,
                                ),
                              ),
                              child: TextButton(
                                onPressed: () => pickFile(),
                                child: Text(
                                  'Select File'.toUpperCase(),
                                  style: context.reg14Hint92!.copyWith(
                                    color: const Color(0xFF0F91D2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 36.5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 79.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: TextButton(
                        onPressed:() =>widget.onPressed(_image!),
                        child: Text(
                          'حفظ',
                          textAlign: TextAlign.center,
                          style: context.bold16Blue!.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 79.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 0.5.w,
                        ),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: Text(
                          'إلغاء',
                          style: context.med16Blue!.copyWith(height: 1.4.h),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PdfPreview extends StatelessWidget {
  const PdfPreview({
    super.key,
    required File? image,
  }) : _image = image;

  final File? _image;

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
                size: 50.sp,
              ),
              SizedBox(height: 8.h),
              Text('PDF Document', style: AppText.med14),
              Text(
                _image!.path.split('/').last,
                style: AppText.reg12.copyWith(
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
  }
}

