import 'package:final_project/const/roles.dart';
import 'package:flutter/material.dart';

class MyColors {
  static const Color containerOfNotificationClr =
      Color.fromRGBO(238, 241, 243, 0.5);
  static const Color edtButtonClr = Color.fromRGBO(243, 74, 74, 1);
  static const Color numberOfIncTextClr = Color.fromRGBO(245, 34, 34, 1);

  static const Color transparent = Colors.transparent;
  static const Color wideButtonClr = Color.fromRGBO(67, 108, 143, 1);
  static const Color y = Color.fromRGBO(255, 134, 14, 1);
  static const Color grey = Color.fromRGBO(195, 205, 213, 1);

//colors of doctor screens

  static const Color milkyClr = Color.fromRGBO(102, 170, 228, 1.0);
  static const Color drawerOfDocClr = Color.fromRGBO(0, 108, 199, 1);
  static const Color borderOfDocPageClr = Color.fromRGBO(52, 149, 230, 0.9);
  static const Color pageOfDoctorsClr = Color.fromRGBO(242, 250, 255, 0.7);
  static const Color controlButtonOff = Color.fromRGBO(219, 223, 226, 1);

//colors of admin screens

  static const Color iconOfAdminClr = Color.fromRGBO(7, 68, 119, 1);
  static const Color drawerOfAdminClr = Color.fromRGBO(7, 68, 119, 1);
  static const Color borderOfAdminClr = Color.fromRGBO(7, 68, 119, 0.8);
  static const Color pageOfAdminClr = Color.fromRGBO(247, 247, 247, 1.0);

//colos of nurse screens

  static const Color iconOfNurseClr = Color.fromRGBO(112, 217, 206, 1);
  static const Color drawerOfNurseClr = Color.fromRGBO(0, 143, 127, 1);
  static const Color borderOfNurseClr = Color.fromRGBO(0, 206, 185, 0.6);
  static const Color pageOfNurseClr = Color.fromRGBO(246, 255, 254, 1);
  //const Color containerOfNotificationClr = Color.fromRGBO(238, 241, 243, 1);
  static const Color inActiveButtonInIncubatorClr =
      Color.fromRGBO(195, 205, 213, 1);

//colors of mothe screens
  static const Color iconOfMotherClr = Color.fromRGBO(203, 171, 213, 1);
  static const Color drawerOfMotherClr = Color.fromRGBO(203, 171, 213, 1);
  static const Color borderOfMotherClr = Color.fromRGBO(204, 109, 233, 0.5);
  static const Color pageOfMotherClr = Color.fromRGBO(251, 239, 255, 0.8);

//colors of gradient backgroun in auth screens

  static const Color firstTopClrs = Color.fromRGBO(7, 68, 119, 1);
  static const Color secondTopClrs = Color.fromRGBO(128, 161, 201, 1);
  static const Color thirdTopClrs = Color.fromRGBO(142, 191, 242, 1);
  static const Color fourthTopClrs = Color.fromRGBO(207, 226, 245, 1);
  static const Color fifthTopClrs = Color.fromRGBO(255, 255, 255, 1);

//colors of gradient button in login screen

  static const Color firstLeftClrs = Color.fromRGBO(134, 164, 189, 1);
  static const Color secondLeftClrs = Color.fromRGBO(30, 84, 130, 1);
  static const Color thirdLeftClrs = Color.fromRGBO(7, 66, 117, 1);
  static const Color validationMessageClr = Color.fromRGBO(7, 66, 117, 1);

  static Color borderOfProfileClr(UserRoles role) {
    if (role == UserRoles.admin || role == UserRoles.operator) {
      return borderOfAdminClr;
    }
    if (role == UserRoles.doctor) {
      return borderOfDocPageClr;
    }
    if (role == UserRoles.nurse) {
      return borderOfNurseClr;
    }
    {
      return borderOfMotherClr;
    }
  }

  static Color fillingOfProfileClr(UserRoles role) {
    if (role == UserRoles.admin || role == UserRoles.operator) {
      return pageOfAdminClr;
    }
    if (role == UserRoles.doctor) {
      return pageOfDoctorsClr;
    }
    if (role == UserRoles.nurse) {
      return pageOfNurseClr;
    }
    {
      return pageOfMotherClr;
    }
  }

  static Color notificationContainerClr(UserRoles role) {
    if (role == UserRoles.admin || role == UserRoles.operator) {
      return containerOfNotificationClr;
    }
    if (role == UserRoles.doctor) {
      return pageOfDoctorsClr;
    }
    if (role == UserRoles.nurse) {
      return pageOfNurseClr;
    }
    {
      return pageOfMotherClr;
    }
  }
}
