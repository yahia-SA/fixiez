class User {
  const User({
    this.id,
    this.name,
    this.phoneNumber,
    this.role,
    this.isActive,
    this.balance,
    this.cashBack,
    this.accessToken,
    this.refreshToken,
  });
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? role;
  final bool? isActive;
  final double? balance;
  final double? cashBack;
  final String? accessToken;
  final String? refreshToken;

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
  }
}
