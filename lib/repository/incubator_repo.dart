import 'package:final_project/endpoints.dart';
import 'package:final_project/helper/dio_helper.dart';
import 'package:final_project/models/incubator_model.dart';

class IncubatorRepo {
  final DioHelper _dioHelper = DioHelper();

  Future<List<IncubatorModel>> getListOfIncubator() async {
    final List? respons = await _dioHelper.getList(Endpoints.incubator);
    return IncubatorModel.fromJsonList(respons);
  }

  Future<IncubatorModel?> creatIncubator({
    required String incubatorCode,
    required String? incubatorImgId,
    bool isEmpty = true,
  }) async {
    final Map<String, dynamic>? respons = await _dioHelper.post(
      Endpoints.incubator,
      data: {
        'incubatorCode': incubatorCode,
        'incubatorImgId': incubatorImgId,
        'isEmpty': isEmpty
      },
    );
    if (respons != null) {
      return IncubatorModel.fromJson(respons);
    }
    return null;
  }

  Future<bool> deletebabies(String id) async {
    return await _dioHelper.delete(
      Endpoints.baby + '/$id',
    );
  }

  Future<IncubatorModel?> getIncubatorWithId(String id) async {
    final Map<String, dynamic>? respons =
        await _dioHelper.get(Endpoints.incubator + '?id=${id}');
    if (respons != null) {
      return IncubatorModel.fromJson(respons);
    }
    return null;
  }
}
