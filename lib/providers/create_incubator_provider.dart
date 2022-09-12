import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:final_project/const/roles.dart';
import 'package:final_project/endpoints.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/helper/dio_helper.dart';
import 'package:final_project/models/auth_model.dart';
import 'package:final_project/models/baby_model.dart';
import 'package:final_project/models/incubator_babay_model.dart' as inc;
import 'package:final_project/models/incubator_model.dart';
import 'package:final_project/models/pictures_model.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/repository/baby_repo.dart';
import 'package:final_project/repository/employee_repo.dart';
import 'package:final_project/repository/incubator_repo.dart';
import 'package:final_project/repository/login_repo.dart';
import 'package:final_project/repository/users_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../repository/pictures_repo.dart';

class IncubatorProvider extends ChangeNotifier {
  final UserDataModel data;
  String _incubatorCode = '',
      _babyCode = '',
      _gender = '',
      _doctorId = '',
      _nurseId = '',
      _motherNumber = '',
      _incubatorID = '',
      _motherEmail = '',
      _motherPassword = '',
      _motherUserName = '',
      _searchedWord = '';
  DateTime _birthDate = DateTime.now(), momBirthDay = DateTime.now();
  Users? currentDoctor, currentNurse;
  DioHelper _helper = DioHelper();
  bool isEmpty = true;
  bool isBusyScreen = true;
  AppState appState = AppState.init;
  List<Users> doctors = [], nurses = [];
  File? storedImage;
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  bool get isInScreach => _searchedWord.trim().isNotEmpty;
  IncubatorProvider(this.data);

  String get gender => _gender;
  DateTime get birthday => _birthDate;
  final List<IncubatorModel> _empty = [];
  final List<IncubatorModel> _busy = [];
  List<IncubatorModel> _emptyFiltered = [];
  List<IncubatorModel> _busyFiltered = [];
  final PicturesRepo _imageRepo = PicturesRepo();
  final babyRepo _babyRepo = babyRepo();
  final AuthMetods _authMethod = AuthMetods();
  final USersRepo _usersRepo = USersRepo();
  final IncubatorRepo _incubatorRepo = IncubatorRepo();
  final EmployeeRepo _employeeRepo = EmployeeRepo();
  List<BabyModel>? _babies = [];

  List<IncubatorModel> get getIncubators =>
      isBusyScreen ? _busyFiltered : _emptyFiltered;

  List<BabyModel> get getBabyList => _babies ?? [];

  buttonToggle(bool val) {
    isBusyScreen = val;
    _searchedWord = '';
    _searchFilter();
    notifyListeners();
  }

  Future<void> getDoctorsAndNurses() async {
    final _doctor = await _usersRepo.getAllUsers(id: UserRoles.doctor.index);
    final _nurse = await _usersRepo.getAllUsers(id: UserRoles.nurse.index);
    if (_doctor != null) {
      doctors = _doctor;
      currentDoctor = _doctor.first;
      _doctorId = _doctor.first.id;
    }
    if (_nurse != null) {
      nurses = _nurse;
      currentNurse = _nurse.first;
      _nurseId = _nurse.first.id;
    }
    print(doctors.length);
    print(nurses.length);
  }

  void searchOnChange(String val) {
    _searchedWord = val;
    _searchFilter();
    notifyListeners();
  }

  void setIncuatorCode(String val) {
    _incubatorCode = val;
  }

  void setCurrentIncubator(int index) {
    _incubatorID = _empty[index].id;
  }

  void setBabyCode(String val) {
    _babyCode = val;
  }

  void setGender(String? val) {
    _gender = val!;
    notifyListeners();
  }

  void setDoctor(Users? val) {
    currentDoctor = val!;
    _doctorId = val.id;
    notifyListeners();
  }

  void setNurse(Users? val) {
    _nurseId = val!.id;
    currentNurse = val;
  }

  void setMotherNumber(String val) {
    _motherNumber = val;
  }

  void setBirthDate(DateTime val) {
    _birthDate = val;
  }

  void setUserName(String val) {
    _motherUserName = val;
  }

  void setMotherEmail(String val) {
    _motherEmail = val;
  }

  void setMotherPassword(String val) {
    _motherPassword = val;
  }

  void _searchFilter() {
    _emptyFiltered = [];
    _busyFiltered = [];
    if (_searchedWord.isNotEmpty) {
      if (isBusyScreen) {
        for (IncubatorModel i in _busy) {
          if (i.babies!.babyCode.contains(_searchedWord)) {
            _busyFiltered.add(i);
          }
        }
      } else {
        for (IncubatorModel i in _empty) {
          if (i.babies!.babyCode.contains(_searchedWord)) {
            _emptyFiltered.add(i);
          }
        }
      }
    } else {
      _emptyFiltered = _empty;
      _busyFiltered = _busy;
    }
    notifyListeners();
  }

  Future<void> createIncbatorr() async {
    PictureModel? _image;
    appState = AppState.loading;
    notifyListeners();
    if (storedImage != null) {
      final b = await storedImage!.readAsBytes();
      final String? i = await _imageToBase64Encoding(b);
      _image = await _imageRepo.postPicture(i!);
    }
    notifyListeners();
    final IncubatorModel? incubatorRespons =
        await _incubatorRepo.creatIncubator(
            incubatorCode: _incubatorCode, incubatorImgId: _image?.picBody);

    if (incubatorRespons != null) {
      appState = AppState.done;
      print('done');
    } else {
      appState = AppState.error;
    }
    notifyListeners();
  }

  Future<void> getListOfIncubator() async {
    _empty.clear();
    _busy.clear();
    _searchedWord = '';
    appState = AppState.loading;
    notifyListeners();
    final List<IncubatorModel> listOfIncubatorsRespons =
        await _incubatorRepo.getListOfIncubator();
    if (listOfIncubatorsRespons.isNotEmpty) {
      _empty.clear();
      _busy.clear();
      for (IncubatorModel inc in listOfIncubatorsRespons) {
        if (inc.incubatorImgId != null) {
          final PictureModel? picrepo =
              await _imageRepo.getPicByID(inc.incubatorImgId!);

          inc.image = _imageToBase64decoding(picrepo!.picBody);
          print('hasImage');
        }
        if (inc.babies?.babyImgId != null) {
          final PictureModel? picrepo =
              await _imageRepo.getPicByID(inc.babies!.babyImgId!);

          inc.babies!.image = _imageToBase64decoding(picrepo!.picBody);
          print('has baby Image');
        }
        if (inc.isEmpty) {
          _empty.add(inc);
          print(inc.id);
        } else {
          _busy.add(inc);
        }
      }
      _emptyFiltered = _empty;
      _busyFiltered = _busy;
    }

    appState = AppState.done;

    notifyListeners();
  }

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

  Uint8List _imageToBase64decoding(String base64) {
    final Uint8List bytes = base64Decode(base64);
    return bytes;
  }

  Future<String?> _imageToBase64Encoding(Uint8List bytes) async {
    final String base64 = base64Encode(bytes);
    return base64;
  }

  Future<void> setBabyToIncubator() async {
    appState = AppState.loading;
    Authentication? authResponse;
    notifyListeners();
    if (storedImage != null) {
      final b = await storedImage!.readAsBytes();
      final String? i = await _imageToBase64Encoding(b);
      final PictureModel? image = await _imageRepo.postPicture(i!);

      if (image != null) {
        authResponse = await _employeeRepo.register(
          email: _motherEmail,
          password: _motherPassword,
          name: _motherUserName,
          userName: _motherUserName,
          phoneNumber: _motherNumber,
          role: UserRoles.mother,
          birthDay: momBirthDay.toUtc().toIso8601String(),
          hospitalName: data.hospitalName ?? '',
          hospitalPhone: data.hospitalPhone ?? '',
        );
        authResponse ??= await _authMethod.login(
            email: _motherEmail, password: _motherPassword);

        if (authResponse != null) {
          final bool babyResponse = await _babyRepo.babyRegister(
              babyCode: _babyCode,
              gander: _gender,
              birthDate: _birthDate.toUtc().toIso8601String(),
              incubatorId: _incubatorID,
              babyImgId: image.picId,
              motherId: authResponse.token.uid,
              doctorId: _doctorId,
              nurseId: _nurseId);
          if (babyResponse) {
            appState = AppState.done;
          } else {
            appState = AppState.error;
          }
        } else {
          appState = AppState.error;
        }
      } else {
        appState = AppState.error;
      }
    } else {
      appState = AppState.error;
    }
    print('done');
    notifyListeners();
  }

  Future<void> getBabies() async {
    _babies = [];
    if (data.role == UserRoles.mother) {
      if (data.babayCodes!.isEmpty) {
        appState = AppState.done;
        notifyListeners();
        return;
      }
      appState = AppState.loading;
      notifyListeners();
      final List<BabyModel>? response = await _babyRepo.ListOfBaby();
      if (response != null) {
        _babies = _filter(response);
        appState = AppState.done;
      } else {
        appState = AppState.error;
      }
    } else {
      data.incubatorsId!.forEach((element) async {
        final respose =
            await _helper.get(Endpoints.incubator + '/$element', headers: {});
        if (respose != null) {
          final IncubatorModel incu = IncubatorModel.fromJson(respose);
          _babies!.add(incu.babies!);
        }
      });
      appState = AppState.done;
    }
    notifyListeners();
  }

  List<BabyModel> _filter(List<BabyModel> lst) {
    List<BabyModel> list = [];
    for (BabyModel baby in lst) {
      if (data.babyId!.contains(baby.id)) {
        list.add(baby);
      }
    }
    return list;
  }

  Future<void> deletBabies(String id) async {
    appState = AppState.loading;
    notifyListeners();
    final bool response = await _incubatorRepo.deletebabies(id);
    if (response) {
      getListOfIncubator();
    } else {
      appState = AppState.error;
      notifyListeners();
    }
  }
}
