import 'package:final_project/const/roles.dart';

// {
//   "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//   "type": 0,
//   "name": "string",
//   "userName": "string",
//   "email": "string",
//   "phoneNumber": "string",
//   "ssn": "string",
//   "birthDate": "2022-04-21T20:12:17.227Z",
//   "userImgId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//   "hospitalName": "string",
//   "hospitalPhone": "string",
//   "university": "string",
//   "degreeOfPromotion": "string",
//   "specialization": "string",
//   "babyCodes": [
//     "string"
//   ]
// }

class UserInfo {
  final String id,
      name,
      userName,
      email,
      phoneNumber,
      ssn,
      birthday,
      hospitalName,
      hospitalPhone,
      university,
      degreeOfPromotion,
      specialization;
  final UserRoles roles;

  final String? userImgId;

  UserInfo(
      {required this.id,
      required this.roles,
      required this.name,
      required this.userName,
      required this.email,
      required this.phoneNumber,
      required this.ssn,
      required this.birthday,
      this.userImgId,
      required this.hospitalName,
      required this.hospitalPhone,
      required this.university,
      required this.degreeOfPromotion,
      required this.specialization});

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'type': roles,
      'ssn': ssn,
      'userName': userName,
      'name': name,
      'phoneNumper': phoneNumber,
      'email': email,
      'birthDate': birthday,
      'userPictureId': userImgId,
      'hospitalName': hospitalName,
      'hospitalPhone': hospitalPhone,
      'university': university,
      'degreeOfPromotion': degreeOfPromotion,
      'specialization': specialization,
    };
  }

  factory UserInfo.fromjson(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'],
      roles: UserRoles.values[map['type'] as int],
      name: map['name'],
      userName: map['userName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      ssn: map['ssn'],
      birthday: map['birthDate'],
      userImgId: map['userImgId'],
      hospitalName: map['hospitalName'],
      hospitalPhone: map['hospitalPhone'],
      university: map['university'],
      degreeOfPromotion: map['degreeOfPromotion'],
      specialization: map['specialization'],
    );
  }
}
