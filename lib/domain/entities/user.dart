class User {

  const User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.isActive,
    required this.balance,
    required this.cashBack,
    required this.accessToken,
    required this.refreshToken,
  });
  final String id;
  final String name;
  final String phoneNumber;
  final String role;
  final bool isActive;
  final double balance;
  final double cashBack;
  final String accessToken;
  final String refreshToken;

  User copyWith({
    double? balance,
    double? cashBack,
  }) {
    return User(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      role: role,
      isActive: isActive,
      balance: balance ?? this.balance,
      cashBack: cashBack ?? this.cashBack,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}