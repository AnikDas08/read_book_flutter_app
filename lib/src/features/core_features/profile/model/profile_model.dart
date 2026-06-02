class ProfileModel {
  final String sId;
  final String profile;
  final String fullName;
  final String email;
  final String role;
  final bool isActive;
  final bool isDeleted;
  final String age;
  final bool isVerified;
  final bool isStripeConnectedAccount;
  final String createdAt;
  final String updatedAt;
  final int v;
  final int powerStones;
  final String phone;

  const ProfileModel({
    this.sId = '',
    this.profile = '',
    this.fullName = '',
    this.email = '',
    this.role = '',
    this.isActive = false,
    this.isDeleted = false,
    this.age = '',
    this.isVerified = false,
    this.isStripeConnectedAccount = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.v = 0,
    this.powerStones = 0,
    this.phone = '',
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      sId: json['_id']?.toString() ?? '',
      profile: json['profile']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      isActive: json['isActive'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      age: json['age']?.toString() ?? '',
      isVerified: json['isVerified'] ?? false,
      isStripeConnectedAccount:
      json['isStripeConnectedAccount'] ?? false,
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: json['__v'] ?? 0,
      powerStones: json['powerStones'] ?? 0,
      phone: json['phone']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'profile': profile,
      'fullName': fullName,
      'email': email,
      'role': role,
      'isActive': isActive,
      'isDeleted': isDeleted,
      'age': age,
      'isVerified': isVerified,
      'isStripeConnectedAccount': isStripeConnectedAccount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'powerStones': powerStones,
      'phone': phone,
    };
  }

  ProfileModel copyWith({
    String? sId,
    String? profile,
    String? fullName,
    String? email,
    String? role,
    bool? isActive,
    bool? isDeleted,
    String? age,
    bool? isVerified,
    bool? isStripeConnectedAccount,
    String? createdAt,
    String? updatedAt,
    int? v,
    int? powerStones,
    String? phone,
  }) {
    return ProfileModel(
      sId: sId ?? this.sId,
      profile: profile ?? this.profile,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      age: age ?? this.age,
      isVerified: isVerified ?? this.isVerified,
      isStripeConnectedAccount:
      isStripeConnectedAccount ??
          this.isStripeConnectedAccount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      powerStones: powerStones ?? this.powerStones,
      phone: phone ?? this.phone,
    );
  }
}