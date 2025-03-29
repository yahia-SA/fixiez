import 'package:fixiez/domain/entities/banner.dart';

class BannerResponseModel {

  BannerResponseModel({required this.status, required this.data});

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    return BannerResponseModel(
      status: json['status'],
      data: (json['data'] as List)
          .map((item) => BannerModel.fromJson(item))
          .toList(),
    );
  }
  final String status;
  final List<BannerModel> data;
}

class BannerModel {

  BannerModel({
    required this.id,
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'],
      image: json['image'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      version: json['__v'],
    );
  }
  final String id;
  final String image;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;

  Banner toEntity() {
    return Banner(
      id: id,
      image: image, 
      isActive: isActive,
    );
  }
}