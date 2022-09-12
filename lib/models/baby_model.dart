import 'dart:typed_data';

import 'package:final_project/models/incubator_model.dart';
import 'package:final_project/models/mother_model.dart';

class BabyModel {
  final String babyCode, gender, id, doctorName, nurseName;
  final DateTime birthDate;
  final String? babyImgId;
  final String incubatorId;
  final MotherModel mother;
  Uint8List? image;

  BabyModel({
    required this.babyCode,
    required this.birthDate,
    required this.gender,
    required this.id,
    required this.incubatorId,
    this.babyImgId,
    required this.doctorName,
    required this.nurseName,
    required this.mother,
  });

  Map<String, dynamic> toJson() {
    return {
      'babyCode': babyCode,
      'birthDate': birthDate,
      'gender': gender,
      'id': id,
      'incubatorId': incubatorId,
    };
  }

  factory BabyModel.fromJson(Map<String, dynamic> map) {
    return BabyModel(
      babyCode: map['babyCode'],
      birthDate: DateTime.parse(map['birthDate']),
      gender: map['gender'],
      id: map['id'],
      doctorName: map['doctorName'],
      nurseName: map['nurseName'],
      babyImgId: map['babyImgId'],
      incubatorId: map['incubatorId'],
      mother: MotherModel.fromJson(map['mother']),
    );
  }

  static List<BabyModel> fromJsonList(List jsonList) {
    final List<BabyModel> list = [];
    for (Map<String, dynamic> json in jsonList) {
      list.add(BabyModel.fromJson(json));
    }
    return list;
  }
}
