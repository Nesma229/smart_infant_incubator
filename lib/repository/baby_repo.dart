import 'package:final_project/endpoints.dart';
import 'package:final_project/helper/dio_helper.dart';
import 'package:final_project/models/baby_model.dart';

class babyRepo {
  final DioHelper _dioHelper = DioHelper();

  Future<bool> babyRegister({
    required String babyCode,
    required String gander,
    required String birthDate,
    required String incubatorId,
    required String babyImgId,
    required String motherId,
    required String doctorId,
    required String nurseId,
  }) async {
    final Map<String, dynamic>? response =
        await _dioHelper.post(Endpoints.baby, data: {
      "gender": gander,
      "birthDate": birthDate,
      "babyCode": babyCode,
      "incubatorId": incubatorId,
      "babyImgId": babyImgId,
      "motherId": motherId,
      "doctorId": doctorId,
      "nurseId": nurseId,
    });

    if (response != null) {
      return true;
    }
    return false;
  }

  Future<List<BabyModel>?> ListOfBaby() async {
    final List? response = await _dioHelper.getList(
      Endpoints.baby,
    );
    if (response != null) {
      return BabyModel.fromJsonList(response);
    } else {
      return null;
    }
  }
}
