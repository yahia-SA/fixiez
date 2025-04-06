class BalanceResponse {

  BalanceResponse({required this.balance, required this.cashBack});

  factory BalanceResponse.fromJson(Map<String, dynamic> json) {
    return BalanceResponse(
      balance: (json['balance'] as num).toDouble(),
      cashBack: (json['cashBack'] as num).toDouble(),
    );
  }
  final double balance;
  final double cashBack;
  BalanceResponse copyWith({
    double? balance,
    double? cashBack,
  }) {
    return BalanceResponse(
      balance: balance ?? this.balance,
      cashBack: cashBack ?? this.cashBack,
    );
  }
}