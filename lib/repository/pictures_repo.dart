import 'package:final_project/endpoints.dart';
import 'package:final_project/helper/dio_helper.dart';
import 'package:final_project/models/pictures_model.dart';

class PicturesRepo {
  final _dioHelper = DioHelper();

  Future<PictureModel?> postPicture(String body) async {
    final Map<String, dynamic>? response =
        await _dioHelper.post(Endpoints.pictures, data: {'stringValue': body});
    if (response != null) {
      print('done');
      return PictureModel.fromjson(response);
    } else {
      return null;
    }
  }

  Future<PictureModel?> getPicByID(String id) async {
    final Map<String, dynamic>? response =
        await _dioHelper.get(Endpoints.pictures + '/$id');
    if (response != null) {
      print('done');
      return PictureModel.fromjson(response);
    } else {
      return null;
    }
  }
}
