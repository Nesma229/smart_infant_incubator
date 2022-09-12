import 'dart:typed_data';

import 'baby_model.dart';

class IncubatorModel {
  final String id, incubatorCode;
  final String? incubatorImgId;
  final bool isEmpty;
  final BabyModel? babies;
  Uint8List? image;
  IncubatorModel({
    required this.babies,
    required this.id,
    required this.incubatorCode,
    this.incubatorImgId,
    required this.isEmpty,
  });

  factory IncubatorModel.fromJson(Map<String, dynamic> map) {
    print(map['incubatorImgId']);
    return IncubatorModel(
        babies: map['baby'] != null ? BabyModel.fromJson(map['baby']) : null,
        id: map['id'],
        incubatorImgId: map['incubatorImgId'],
        incubatorCode: map['incubatorCode'],
        isEmpty: map['isEmpty']);
  }

  static List<IncubatorModel> fromJsonList(List? jsonList) {
    List<IncubatorModel> list = [];
    jsonList?.forEach((element) {
      print(element);
      list.add(IncubatorModel.fromJson(element as Map<String, dynamic>));
    });

    return list;
  }
}
