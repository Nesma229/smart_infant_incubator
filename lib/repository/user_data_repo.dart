import 'package:final_project/endpoints.dart';
import 'package:final_project/helper/dio_helper.dart';
import 'package:final_project/models/user_data_model.dart';

class UserDataRepo {
  final DioHelper _dioHelper = DioHelper();

  Future<UserDataModel?> getDataOfAdmin(String id,
      {Map<String, String>? headers}) async {
    final Map<String, dynamic>? response = await _dioHelper
        .get(Endpoints.adminId + '?adminId=$id', headers: headers);
    if (response != null) {
      return UserDataModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future<UserDataModel?> getDataOfNuses(String id) async {
    final Map<String, dynamic>? response =
        await _dioHelper.get(Endpoints.nurseId + '?nurseId=$id');
    print(response!["babyCodes"]);
    if (response != null) {
      return UserDataModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future<UserDataModel?> getWithDoctorId(String id) async {
    final Map<String, dynamic>? response = await _dioHelper.get(
      Endpoints.doctorId + '?doctorId=$id',
    );
    print(response);

    if (response != null) {
      return UserDataModel.fromJson(response);
    } else {
      return null;
    }
  }

  Future<UserDataModel?> getDataOfMothers(String id) async {
    final Map<String, dynamic>? response =
        await _dioHelper.get(Endpoints.motherId + '?motherId=$id');
    if (response != null) {
      return UserDataModel.fromJson(response);
    } else {
      return null;
    }
  }
}
