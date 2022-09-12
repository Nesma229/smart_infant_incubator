//!registration
// {
//   "name": "string",
//   "username": "string",
//   "email": "string",
//   "password": "string"
// }
//! employee
// {
//   "userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
//   "university": "string",
//   "degreeOfPromotion": "string",
//   "specialization": "string"
// }
//! hospital
// {
//   "name": "string",
//   "phone": "string"
// }

import 'dart:convert';

import 'package:final_project/const/roles.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/auth_model.dart';
import 'package:final_project/models/pictures_model.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/repository/employee_repo.dart';
import 'package:final_project/repository/pictures_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import "dart:io";
import 'dart:typed_data';

class UserRegisterationProvider extends ChangeNotifier {
  String _name = '',
      _userName = '',
      _email = '',
      _password = '',
      _university = '',
      _dergreeOfPormotion = '',
      _specialization = '',
      _hospitalName = '',
      _hospitalNumber = '',
      _ssn = '',
      _day = '',
      _month = '',
      _year = '',
      _phone = '';
  final UserRoles role;
  AppState state = AppState.init;
  final EmployeeRepo _employeeRepo = EmployeeRepo();
  final PicturesRepo _imageRop = PicturesRepo();
  final UserDataModel userDataModel;
  File? storedImage;

  UserRegisterationProvider(this.role, this.userDataModel);
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

  void setName(String val) {
    _name = val;
    print(_name);
  }

  //!seters in dart
  // set setNames(String val)=>_name=val;
  void setUserName(String val) {
    _userName = val;
  }

  void setEmail(String val) {
    _email = val;
  }

  void setPassword(String val) {
    _password = val;
  }

  void setUniversity(String val) {
    _university = val;
  }

  void setdegreeOfPromotion(String val) {
    _dergreeOfPormotion = val;
  }

  void setSpecialization(String val) {
    _specialization = val;
  }

  void setHospitalName(String val) {
    _hospitalName = val;
  }

  void setHospitalNumber(String val) {
    _hospitalNumber = val;
  }

  void setPhone(String val) {
    _phone = val;
  }

  void setSsn(String val) {
    _ssn = val;
  }

  void setDay(String val) {
    _day = val;
  }

  void setMonth(String val) {
    _month = val;
  }

  String _twodigit(String val) {
    if (val.length < 2) {
      val = '0' + val;
    }
    return val;
  }

  void setYear(String val) {
    _year = val;
  }

  Future<void> registeration() async {
    PictureModel? _image;
    state = AppState.loading;
    notifyListeners();
    if (storedImage != null) {
      final b = await storedImage!.readAsBytes();
      final String? i = await _imageToBase64Encoding(b);
      _image = await _imageRop.postPicture(i!);
    }

    final Authentication? user = await _employeeRepo.register(
      email: _email,
      password: _password,
      name: _name,
      userName: _userName,
      birthDay: '$_year-${_twodigit(_month)}-${_twodigit(_day)}',
      degOfPromo: _dergreeOfPormotion,
      hospitalName: _hospitalName,
      hospitalPhone: _hospitalNumber,
      phoneNumber: _phone,
      role: role,
      snn: _ssn,
      specialization: _specialization,
      university: _university,
      imageId: _image?.picId,
    );
    if (user != null) {
      state = AppState.done;
    } else {
      print('auth error');
      state = AppState.error;
    }
    notifyListeners();
    //! onther way of writing the methode
// await _employeeRepo.register(email: email, password: password, name: name, userName: userName).then((value) async{
// if(value != null){
// await _employeeRepo.postEmploees(userId: value!.token.uid, university: university, degreeOfPromotion: degreeOfPromotion, specializatin: specializatin).then((value) => null);

// }
//     });
  }

  Future<void> editUsers() async {
    PictureModel? _image;
    state = AppState.loading;
    notifyListeners();
    if (storedImage != null) {
      final b = await storedImage!.readAsBytes();
      final String? i = await _imageToBase64Encoding(b);
      _image = await _imageRop.postPicture(i!);
    }

    final bool user = await _employeeRepo.editUser(
      id: userDataModel.id,
      email: _email.isEmpty ? userDataModel.email : _email,
      password: _password,
      name: _name.isEmpty ? userDataModel.name : _name,
      userName: _userName.isEmpty ? userDataModel.userName : _userName,
      birthDay:
          '${_year.isEmpty ? userDataModel.birthDay?.year : _year}-${_month.isEmpty ? _twodigit(userDataModel.birthDay?.month.toString() ?? '0') : _twodigit(_month)}-${_day.isEmpty ? _twodigit(userDataModel.birthDay?.day.toString() ?? '0') : _twodigit(_day)}',
      degOfPromo: _dergreeOfPormotion.isEmpty
          ? userDataModel.degreeOfPromotion
          : _dergreeOfPormotion,
      hospitalName: _hospitalName.isEmpty
          ? userDataModel.hospitalName ?? ''
          : _hospitalName,
      hospitalPhone: _hospitalNumber.isEmpty
          ? userDataModel.hospitalPhone ?? ''
          : _hospitalNumber,
      phoneNumber: _phone.isEmpty ? userDataModel.phoneNumber ?? '' : _phone,
      role: role,
      snn: _ssn.isEmpty ? userDataModel.ssn ?? '' : _ssn,
      specialization: _specialization.isEmpty
          ? userDataModel.specialization ?? ''
          : _specialization,
      university:
          _university.isEmpty ? userDataModel.university ?? '' : _university,
      imageId: _image?.picId,
    );
    if (user != null) {
      state = AppState.done;
    } else {
      print('auth error');
      state = AppState.error;
    }
    notifyListeners();
  }

  Future<String?> _imageToBase64Encoding(Uint8List bytes) async {
    final String base64 = base64Encode(bytes);
    return base64;
  }

  Uint8List _imageToBase64decoding(String base64) {
    final Uint8List bytes = base64Decode(base64);
    return bytes;
  }
}
