class FelixEntity {
  FelixEntity({ required this.id,required this.felixNumber,required this.cost,required this.v});

  final String id;
  final int felixNumber;
  final double cost;
  final int v;

  FelixEntity copyWith({
    String? id,
    int? felixNumber,
    double? cost,
    int? v,
  }) {
    return FelixEntity(
      id: id ?? this.id,
      felixNumber: felixNumber ?? this.felixNumber,
      cost: cost ?? this.cost,
      v: v ?? this.v,
    );
  }
}
