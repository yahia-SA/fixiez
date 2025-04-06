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
    String? id,
    String? name,
    String? phoneNumber,
    String? role,
    bool? isActive,
    double? balance,
    double? cashBack,
    String? accessToken,
    String? refreshToken,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      balance: balance ?? this.balance,
      cashBack: cashBack ?? this.cashBack,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }}