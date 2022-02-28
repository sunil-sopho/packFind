import 'package:flutter/foundation.dart';

class PackFindUser {
  final String userId;
  final String displayName;
  final String email;
  final String profileUrl;
  final bool verified;

  PackFindUser(
      {required this.email,
      this.displayName = '',
      this.profileUrl = '',
      required this.userId,
      required this.verified});

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'profile_url': profileUrl,
      'display_name': displayName,
      'email': email,
      'verified': verified
    };
  }

  static PackFindUser? fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      return PackFindUser(
          userId: json['user_id'],
          profileUrl: json['profile_url'],
          displayName: json['display_name'],
          email: json['email'],
          verified: json['verified']);
    } else {
      return null;
    }
  }
}
