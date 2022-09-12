import 'dart:developer';
import 'dart:io';

import 'package:final_project/const/roles.dart';
import 'package:final_project/endpoints.dart';
import 'package:final_project/helper/dio_helper.dart';
import 'package:final_project/models/employee_model.dart';
import 'package:http/http.dart';
import '../models/auth_model.dart';

class EmployeeRepo {
  final DioHelper _dioHelper = DioHelper();

  // Future<EmployeeInfo?> postEmploees(
  //     {
  //       required String userId,
  //     required String university,
  //     required String degreeOfPromotion,
  //     required String specializatin}) async {
  //   final Map<String, dynamic>? respons =
  //       await _dioHelper.post(Endpoints.employees, data: );
  //   log('$respons');
  //   if (respons == null) {
  //     return null;
  //   }
  //   {
  //     return EmployeeInfo.fromjson(respons);
  //   }
  // }

  Future<Authentication?> register({
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
    Map<String, String> headers = const {},
  }) async {
    final Map<String, dynamic>? respons = await _dioHelper.post(
      Endpoints.register,
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
      headers: headers,
    );
    if (respons != null) {
      return Authentication.fromJson(respons);
    }
    return null;
  }

  Future<EmployeeInfo?> gettEmploees() async {
    final Map<String, dynamic>? respons = await _dioHelper.post(
      Endpoints.employees,
    );
    log('$respons');
    if (respons == null) {
      return null;
    }
    {
      return EmployeeInfo.fromjson(respons);
    }
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
    final Map<String, dynamic>? response =
        await _dioHelper.put(Endpoints.users + '?userId=$id', data: {
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
      'userImgId': imageId
    }, headers: {});
    return response != null;
  }
}
