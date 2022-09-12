import 'package:final_project/const/roles.dart';
import 'package:flutter/foundation.dart';

class MotherModel {
  final String id, adminId, name, email, userNme;
  final String? motherImgId, phoneNumber;
  final UserRoles type;
  final List babyCodes, babiesId, doctorId, nurseId;

  MotherModel({
    required this.id,
    required this.adminId,
    required this.name,
    required this.email,
    required this.userNme,
    required this.phoneNumber,
    required this.motherImgId,
    required this.type,
    required this.babyCodes,
    required this.babiesId,
    required this.doctorId,
    required this.nurseId,
  });

  factory MotherModel.fromJson(Map<String, dynamic> map) {
    return MotherModel(
      id: map['id'],
      adminId: map['adminId'],
      name: map['name'],
      email: map['email'],
      userNme: map['userName'],
      phoneNumber: map['phoneNumber'],
      motherImgId: map['motherImgId'],
      type: UserRoles.values[map['type']],
      babyCodes: map['babyCodes'],
      babiesId: map['babiesId'],
      doctorId: map['doctorsId'],
      nurseId: map['nursesId'],
    );
  }
}
