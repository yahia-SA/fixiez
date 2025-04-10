class AnalysisModel {
  const AnalysisModel({this.status, this.message, this.data});

  factory AnalysisModel.fromJson(Map<String, dynamic> json) => AnalysisModel(
    status: json['status'] as String?,
    message: json['message'] as String?,
    data: json['data'] != null ? Data.fromJson(json['data']) : null,
  );
  final String? status;
  final String? message;
  final Data? data;

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data?.toJson(),
  };
}

class Data {
  const Data({this.repairRequestResult, this.userResult});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    repairRequestResult:
        json['repairRequestResult'] != null
            ? RepairRequestResult.fromJson(json['repairRequestResult'])
            : null,
    userResult:
        json['userResult'] != null
            ? UserResult.fromJson(json['userResult'])
            : null,
  );
  final RepairRequestResult? repairRequestResult;
  final UserResult? userResult;

  Map<String, dynamic> toJson() => {
    'repairRequestResult': repairRequestResult?.toJson(),
    'userResult': userResult?.toJson(),
  };
}

class RepairRequestResult {
  const RepairRequestResult({
    this.analysis,
    this.repairRequestNumberList,
    this.total,
  });

  factory RepairRequestResult.fromJson(Map<String, dynamic> json) =>
      RepairRequestResult(
        analysis:
            json['analysis'] != null
                ? Analysis.fromJson(json['analysis'])
                : null,
        repairRequestNumberList:
            json['RepairRequestNumberList'] != null
                ? (json['RepairRequestNumberList'] as List)
                    .map((v) => RequestNumberList.fromJson(v))
                    .toList()
                : null,
        total: json['total'] as int?,
      );
  final Analysis? analysis;
  final List<RequestNumberList>? repairRequestNumberList;
  final int? total;

  Map<String, dynamic> toJson() => {
    'analysis': analysis?.toJson(),
    'RepairRequestNumberList':
        repairRequestNumberList?.map((v) => v.toJson()).toList(),
    'total': total,
  };
}

class Analysis {
  const Analysis({
    this.painting,
    this.electricity,
    this.plumbing,
    this.carpentry,
  });

  factory Analysis.fromJson(Map<String, dynamic> json) => Analysis(
    painting:
        json['painting'] != null ? Painting.fromJson(json['painting']) : null,
    electricity:
        json['electricity'] != null
            ? Painting.fromJson(json['electricity'])
            : null,
    plumbing:
        json['plumbing'] != null ? Painting.fromJson(json['plumbing']) : null,
    carpentry:
        json['carpentry'] != null ? Painting.fromJson(json['carpentry']) : null,
  );
  final Painting? painting;
  final Painting? electricity;
  final Painting? plumbing;
  final Painting? carpentry;

  Map<String, dynamic> toJson() => {
    'painting': painting?.toJson(),
    'electricity': electricity?.toJson(),
    'plumbing': plumbing?.toJson(),
    'carpentry': carpentry?.toJson(),
  };
}

class Painting {
  const Painting({this.count});

  factory Painting.fromJson(Map<String, dynamic> json) =>
      Painting(count: json['count'] as int?);
  final int? count;

  Map<String, dynamic> toJson() => {'count': count};
}

class RequestNumberList {
  const RequestNumberList({this.sId, this.count});

  factory RequestNumberList.fromJson(Map<String, dynamic> json) =>
      RequestNumberList(
        sId: json['_id'] as String?,
        count: json['count'] as int?,
      );
  final String? sId;
  final int? count;

  Map<String, dynamic> toJson() => {'_id': sId, 'count': count};
}

class UserResult {
  const UserResult({this.analysis, this.userNumberList, this.total});

  factory UserResult.fromJson(Map<String, dynamic> json) => UserResult(
    analysis:
        json['analysis'] != null
            ? NumberOfUsers.fromJson(json['analysis'])
            : null,
    userNumberList:
        json['userNumberList'] != null
            ? (json['userNumberList'] as List)
                .map((v) => RequestNumberList.fromJson(v))
                .toList()
            : null,
    total: json['total'] as int?,
  );
  final NumberOfUsers? analysis;
  final List<RequestNumberList>? userNumberList;
  final int? total;

  Map<String, dynamic> toJson() => {
    'analysis': analysis?.toJson(),
    'userNumberList': userNumberList?.map((v) => v.toJson()).toList(),
    'total': total,
  };
}

class NumberOfUsers {
  const NumberOfUsers({this.user, this.admin});

  factory NumberOfUsers.fromJson(Map<String, dynamic> json) =>
      NumberOfUsers(user: json['user'] as int?, admin: json['admin'] as int?);
  final int? user;
  final int? admin;

  Map<String, dynamic> toJson() => {'user': user, 'admin': admin};
}
