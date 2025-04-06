// ignore_for_file: constant_identifier_names

enum ServiceName { plumbing, carpentry, electricity, painting }

enum ServiceType { urgent_request, normal_request }

enum OtpPages {signup,forgetPassword}

extension ServiceNameE on ServiceName {
  String get arabicName {
    switch (this) {
      case ServiceName.plumbing:
        return 'سباكة';
      case ServiceName.carpentry:
        return 'نجارة';
      case ServiceName.electricity:
        return 'كهرباء';
      case ServiceName.painting:
        return 'دهانات';
    }
  }
}
ServiceName? serviceNameFromString(String name) {
  return ServiceName.values.firstWhere(
    (e) => e.name == name,
    orElse: () => ServiceName.plumbing,
  );
}
extension UserTypeArabicExtension on String {
  String get toArabicRole {
    switch (this) {
      case 'user':
        return 'مستخدم';
      case 'admin':
        return 'ادمن';
      default:
        return this;
    }
  }
}
