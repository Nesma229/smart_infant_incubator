class PictureModel {
  final String picId, picBody;

  PictureModel({required this.picId, required this.picBody});

  factory PictureModel.fromjson(Map<String, dynamic> map) {
    return PictureModel(picId: map['id'], picBody: map['stringValue']);
  }

  Map<String, dynamic> tojson() {
    return {
      'id': picId,
      'stringValue': picBody,
    };
  }
}
