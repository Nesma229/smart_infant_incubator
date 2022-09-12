import 'dart:io';

import 'package:final_project/const/roles.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/auth_model.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/repository/user_data_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/employee_repo.dart';
import '../repository/pictures_repo.dart';

class UserDataProvider extends ChangeNotifier {
  final Authentication auth;
  UserDataModel? currentUSer;
  final UserDataRepo _userDataRepo = UserDataRepo();
  AppState appState = AppState.init;

  UserDataProvider(this.auth);

  Future<void> getUserData() async {
    print(auth.role);
    print(auth.role);
    appState = AppState.loading;
    notifyListeners();
    if (auth.role == UserRoles.admin || auth.role == UserRoles.operator) {
      currentUSer = await _userDataRepo.getDataOfAdmin(
        auth.token.uid,
      );
    } else if (auth.role == UserRoles.mother) {
      currentUSer = await _userDataRepo.getDataOfMothers(auth.token.uid);
    } else if (auth.role == UserRoles.doctor) {
      currentUSer = await _userDataRepo.getWithDoctorId(auth.token.uid);
    } else if (auth.role == UserRoles.nurse) {
      currentUSer = await _userDataRepo.getDataOfNuses(auth.token.uid);
    } else {
      appState = AppState.error;
    }
    if (currentUSer != null) {
      appState = AppState.done;
    } else {
      appState = AppState.error;
    }
    notifyListeners();
  }

  File? storedImage;

  final EmployeeRepo _employeeRepo = EmployeeRepo();
  final PicturesRepo _imageRop = PicturesRepo();
  Future<void> takePicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
      maxHeight: 541,
      maxWidth: 360,
    );
    storedImage = File(imageFile!.path);

    notifyListeners();
  }

  // Future<void> editUsers() async {
  //   PictureModel? _image;
  //   appState = AppState.loading;
  //   notifyListeners();
  //   if (storedImage != null) {
  //     final b = await storedImage!.readAsBytes();
  //     final String? i = await _imageToBase64Encoding(b);
  //     _image = await _imageRop.postPicture(i!);
  //   }

  //   final bool user = await _employeeRepo.editUser(
  //     id: currentUSer.id,
  //     email: currentUSer.email,
  //     password: auth.token.,
  //     name: _name.isEmpty ? userDataModel.name : _name,
  //     userName: _userName.isEmpty ? userDataModel.userName : _userName,
  //     birthDay:
  //         '${_year.isEmpty ? userDataModel.birthDay?.year : _year}-${_month.isEmpty ? _twodigit(userDataModel.birthDay?.month.toString() ?? '0') : _twodigit(_month)}-${_day.isEmpty ? _twodigit(userDataModel.birthDay?.day.toString() ?? '0') : _twodigit(_day)}',
  //     degOfPromo: _dergreeOfPormotion.isEmpty
  //         ? userDataModel.degreeOfPromotion
  //         : _dergreeOfPormotion,
  //     hospitalName: _hospitalName.isEmpty
  //         ? userDataModel.hospitalName ?? ''
  //         : _hospitalName,
  //     hospitalPhone: _hospitalNumber.isEmpty
  //         ? userDataModel.hospitalPhone ?? ''
  //         : _hospitalNumber,
  //     phoneNumber: _phone.isEmpty ? userDataModel.phoneNumber ?? '' : _phone,
  //     role: role,
  //     snn: _ssn.isEmpty ? userDataModel.ssn ?? '' : _ssn,
  //     specialization: _specialization.isEmpty
  //         ? userDataModel.specialization ?? ''
  //         : _specialization,
  //     university:
  //         _university.isEmpty ? userDataModel.university ?? '' : _university,
  //     imageId: _image?.picId,
  //   );
  //   if (user != null) {
  //     getUserData();
  //     appState = AppState.done;
  //   }
  // }

  // Future<String?> _imageToBase64Encoding(Uint8List bytes) async {
  //   final String base64 = base64Encode(bytes);
  //   return base64;
  // }

  // Uint8List _imageToBase64decoding(String base64) {
  //   final Uint8List bytes = base64Decode(base64);
  //   return bytes;
  // }
}
