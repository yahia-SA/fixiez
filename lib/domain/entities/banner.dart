class Banners {
  Banners({required this.id, required this.image, required this.isActive});

  final String id;
  final String image;
  final bool isActive;
  Banners copyWith({
    String? id,
    String? image,
    bool? isActive,
  }) {
    return Banners(
      id: id ?? this.id,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
    );
  }
}