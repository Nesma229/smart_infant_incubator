import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:final_project/const/roles.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/pictures_model.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/repository/pictures_repo.dart';
import 'package:final_project/repository/shared_preferences.dart';
import 'package:final_project/repository/user_data_repo.dart';
import 'package:final_project/repository/users_repo.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_data_model.dart';

class UserProvider extends ChangeNotifier {
  final USersRepo _usersRepo = USersRepo();
  final UserDataRepo _userDataRepo = UserDataRepo();
  final PicturesRepo _imageRepo = PicturesRepo();
  final UserDataModel dataModel;

  late final UserDataModel? val;

  List<Users> users = [];
  List<Users> usersFilter = [];
  bool inSeach = false;
  // UserInfo docProfileWithId = UserInfo as dynamic;

  AppState state = AppState.init;

  UserProvider({required this.dataModel});

  Future<void> getListOfUsers({required UserRoles role}) async {
    print('start');
    users = [];
    usersFilter = [];

    state = AppState.loading;
    notifyListeners();
    if (dataModel.role == UserRoles.doctor) {
      if (dataModel.nurseId!.isEmpty) {
        state = AppState.done;
        notifyListeners();
        return;
      }
    } else if (dataModel.role == UserRoles.nurse) {
      if (dataModel.doctorId!.isEmpty) {
        state = AppState.done;
        notifyListeners();
        return;
      }
    } else if (dataModel.role == UserRoles.mother) {
      if (dataModel.doctorId!.isEmpty && role == UserRoles.doctor) {
        print('hello from fun');
        state = AppState.done;
        notifyListeners();
        return;
      } else if (dataModel.nurseId!.isEmpty && role == UserRoles.nurse) {
        state = AppState.done;
        notifyListeners();
        return;
      }
    }
    print('hello from body');
    List<Users>? usersRespons = await _usersRepo.getAllUsers(
        id: role.index,
        headers: {});
        
    if (usersRespons != null) {
      for (Users u in usersRespons) {
        if (u.image != null) {
          final PictureModel? picrepo = await _imageRepo.getPicByID(u.image!);
          if (picrepo != null) {
            u.imageBytes = _imageToBase64decoding(picrepo.picBody);
          } else {
            print('error iamge ');
          }
        }
        users.add(u);
      }
      usersFilter = _filterUsers(users, role);
      state = AppState.done;
    } else {
      state = AppState.error;
    }
    notifyListeners();
  }

  List<Users> _filterUsers(List<Users> users, UserRoles neededRole) {
    List<Users> list = [];
    if (dataModel.role == UserRoles.doctor ||
        dataModel.role == UserRoles.mother && neededRole == UserRoles.nurse) {
      users.forEach((element) {
        if (dataModel.nurseId!.contains(element.id)) {
          list.add(element);
        }
      });
    } else if (dataModel.role == UserRoles.nurse ||
        dataModel.role == UserRoles.mother && neededRole == UserRoles.doctor) {
      users.forEach((element) {
        if (dataModel.doctorId!.contains(element.id)) {
          list.add(element);
        }
      });
    } else {
      list = users;
    }

    return list;
  }

  void searchForUser(String val) {
    if (val.isEmpty) {
      inSeach = false;
      usersFilter = users;
    } else {
      inSeach = true;
      usersFilter = [];
      for (int i = 0; i < users.length; i++) {
        if (users[i].name.contains(val)) {
          usersFilter.add(users[i]);
        }
      }
      // for (User u in users) {
      //   if (u.username.contains(val)) {
      //     usersFilter.add(u);
      //   }
      // }
    }

    notifyListeners();
  }

  void tileFuction() {
    if (inSeach) {
      print('deete');
    } else {
      print('got to profile');
    }
  }

  Future<void> getUsersWithId(String id, UserRoles role) async {
    print('called');
    state = AppState.loading;
    notifyListeners();
    if (role == UserRoles.admin || role == UserRoles.operator) {
      val = await _userDataRepo.getDataOfAdmin(id);
    } else if (role == UserRoles.doctor) {
      val = await _userDataRepo.getWithDoctorId(id);
    } else if (role == UserRoles.nurse) {
      print(role);
      val = await _userDataRepo.getDataOfNuses(id);
    }
    print(val);
    if (val != null) {
      state = AppState.done;
    } else {
      state = AppState.error;
    }
    notifyListeners();
  }

  Future<void> dleteUSerWithID(String id, UserRoles u) async {
    state = AppState.loading;
    notifyListeners();
    await _usersRepo.deleteUser(id);
    // val = doctorIdResponse!;

    getListOfUsers(role: u);
  }

  Uint8List _imageToBase64decoding(String base64) {
    final Uint8List bytes = base64Decode(base64);
    return bytes;
  }
}
