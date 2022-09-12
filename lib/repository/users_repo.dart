import 'package:final_project/const/roles.dart';
import 'package:final_project/endpoints.dart';
import 'package:final_project/helper/dio_helper.dart';

import '../models/user.dart';

class USersRepo {
  final DioHelper _helper = DioHelper();

  Future<List<Users>?> getAllUsers(
      {int id = 0, Map<String, String>? headers}) async {
    final List? response =
        await _helper.getList(Endpoints.users + '?type=$id', headers: headers);
    print(response);

    if (response != null) {
      print('valid');

      return Users.fromJsonList(response);
    }
    return null;
  }

  Future<bool> deleteUser(String id) async {
    return await _helper.delete(
      Endpoints.users + '/$id',
    );
  }

  Future<bool> editUser({
    required String id,
    required String email,
    required String password,
    required String name,
    required String userName,
    required String phoneNumber,
    required UserRoles role,
    String? snn,
    required String birthDay,
    required String hospitalName,
    required String hospitalPhone,
    String? specialization,
    String? university,
    String? degOfPromo,
    String? imageId,
  }) async {
    final Map<String, dynamic>? response = await _helper.put(
      Endpoints.users + '?userId=$id',
      data: {
        "name": name,
        "username": userName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "type": role.index,
        "ssn": snn,
        "birthDate": DateTime.parse(birthDay).toUtc().toIso8601String(),
        "isEmployee": UserRoles.mother == role ? false : true,
        "hospitalName": hospitalName,
        "hospitalPhone": hospitalPhone,
        "specialization": specialization,
        "university": university,
        "degreeOfPromotion": degOfPromo,
        'userImgId': imageId,
      },
    );
    return response != null;
  }
}
