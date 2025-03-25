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
}