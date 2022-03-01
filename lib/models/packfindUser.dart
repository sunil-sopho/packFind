class PackFindUser {
  final String userId;
  final String displayName;
  final String email;
  final String? photoUrl;
  final bool verified;

  PackFindUser(
      {required this.email,
      this.displayName = '',
      this.photoUrl = '',
      required this.userId,
      required this.verified});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'photo_url': photoUrl,
      'display_name': displayName,
      'email': email,
      'verified': verified
    };
  }

  static PackFindUser? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return PackFindUser(
          userId: json['user_id'],
          photoUrl: json['photo_url'],
          displayName: json['display_name'],
          email: json['email'],
          verified: json['verified']);
    } else {
      return null;
    }
  }
}
