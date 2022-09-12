import 'dart:typed_data';

import 'package:final_project/const/roles.dart';
import 'package:final_project/models/token.dart';

class Authentication {
  final String? message;
  final bool isAuthenticated;
  final String username;
  final String email;
  final UserRoles role;
  final JwtToken token;
  Uint8List? image;

  Authentication({
    required this.token,
    required this.email,
    required this.isAuthenticated,
    required this.message,
    required this.role,
    required this.username,
  });

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'isAuthenticated': isAuthenticated,
      'username': username,
      'email': email,
      'role': role.index,
      'token': token,
    };
  }

  factory Authentication.fromJson(Map<String, dynamic> map) {
    return Authentication(
      message: map['message'] ?? '',
      isAuthenticated: map['isAuthenticated'] as bool,
      username: map['username'] as String,
      email: map['email'] as String,
      role: UserRoles.values[map['role'] as int],
      token: JwtToken.fromjson(map['token'] as String),
    );
  }
}
