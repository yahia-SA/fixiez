class Services {
  Services({required this.id, required this.name, required this.cost});

  final String id;
  final String name;
  final int cost;

  Services copyWith({
  String? id,
  String? name,
  int? cost,
}) {
  return Services(
    id: id ?? this.id,
    name: name ?? this.name,
    cost: cost ?? this.cost,
  );
}
}
