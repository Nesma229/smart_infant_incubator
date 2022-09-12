import 'dart:typed_data';

import 'package:final_project/const/roles.dart';

class Users {
  final String id, username, email, name;
  final String? image;
  final UserRoles role;
  Uint8List? imageBytes;

  Users({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.image,
    required this.role,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      username: json['userName'],
      name: json['name'],
      email: json['email'],
      image: json['userImgId'],
      role: UserRoles.values[json['type'] as int],
    );
  }
  static List<Users> fromJsonList(List list) {
    List<Users> users = [];

    for (Map<String, dynamic> json in list) {
      users.add(Users.fromJson(json));
    }
    return users;
  }
}
// [
//   {
//     "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//     "type": 0,
//     "userName": "string",
//     "email": "string",
//     "userImgId": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
//   }
// ]