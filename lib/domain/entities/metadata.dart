import 'package:fixiez/data/models/meta_data_model.dart';

class MetadataEntity {
  MetadataEntity({
    required this.totalItems,
    required this.totalPages,
    required this.skip,
    required this.pageIndex,
    required this.pageSize,
  });

  final int? totalItems;
  final int? totalPages;
  final int? skip;
  final int? pageIndex;
  final int? pageSize;
  MetadataEntity copyWith({
    int? totalItems,
    int? totalPages,
    int? skip,
    int? pageIndex,
    int? pageSize,
  }) {
    return MetadataEntity(
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      skip: skip ?? this.skip,
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  Metadata toModel() {
    return Metadata(
      totalItems: totalItems,
      totalPages: totalPages,
      skip: skip,
      pageIndex: pageIndex,
      pageSize: pageSize,
    );
  }
}
