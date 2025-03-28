class Metadata {
  Metadata({
    this.totalItems,
    this.totalPages,
    this.skip,
    this.pageIndex,
    this.pageSize,
  });

  Metadata.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    skip = json['skip'];
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
  }
  int? totalItems;
  int? totalPages;
  int? skip;
  int? pageIndex;
  int? pageSize;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    data['skip'] = skip;
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    return data;
  }
}