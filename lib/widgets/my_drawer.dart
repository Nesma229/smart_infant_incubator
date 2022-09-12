import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/const/color.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/screens/admin_screen.dart';
import 'package:final_project/screens/incubator_screen.dart';
import 'package:final_project/screens/list_of_babies_screen.dart';
import 'package:final_project/screens/list_of_users_screen.dart';
import 'package:final_project/widgets/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyDrawer extends StatelessWidget {
  final Color white = Colors.white;
  final UserDataModel userData;
  final UserRoles role;
  const MyDrawer({
    Key? key,
    required this.role,
    required this.userData,
  }) : super(key: key);

  Color roleColorForDrawer() {
    if (role == UserRoles.admin || role == UserRoles.operator) {
      return MyColors.drawerOfAdminClr;
    }
    if (role == UserRoles.doctor) {
      return MyColors.drawerOfDocClr;
    }
    if (role == UserRoles.nurse) {
      return MyColors.drawerOfNurseClr;
    }
    {
      return MyColors.drawerOfMotherClr;
    }
  }

  String roleLable() {
    if (role == UserRoles.admin) {
      return 'Admin Name';
    }
    if (role == UserRoles.operator) {
      return 'operator Name';
    }
    if (role == UserRoles.doctor) {
      return 'Doctor Name';
    }
    if (role == UserRoles.nurse) {
      return 'Nurse Name';
    }
    {
      return 'Mother Name';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color currentColorForDrawer = roleColorForDrawer();

    return SafeArea(
      child: Container(
        width: size.width / 3,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          border: Border.all(color: currentColorForDrawer, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: currentColorForDrawer,
              // spreadRadius: 0.0005,
              blurRadius: 6,
              offset: const Offset(3, 0),
            )
          ],
        ),
        child: ListView(children: [
          const SizedBox(height: 20),
          DrawerTile(
            icon: const CircleAvatar(
              backgroundImage: AssetImage(MyAssets.personImageForAdmin),
              // foregroundImage: ,
              radius: 22,
            ),
            lable: roleLable(),
          ),
          if (role == UserRoles.admin)
            DrawerTile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListOfUsersScreen(
                      filterRole: UserRoles.operator,
                      data: userData,
                    ),
                  ),
                );
              },
              icon: SvgPicture.asset(
                MyAssets.doctorIcon,
                color: white,
                width: 15,
                height: 20,
              ),
              lable: 'Operators',
            ),
          if (role == UserRoles.mother)
            DrawerTile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ListOfBabiesScreen(userData: userData)),
                );
              },
              icon: SvgPicture.asset(
                MyAssets.heartIcon,
                color: white,
                width: 15,
                height: 20,
              ),
              lable: 'baby',
            ),
          if (role != UserRoles.doctor)
            DrawerTile(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListOfUsersScreen(
                      filterRole: UserRoles.doctor,
                      data: userData,
                    ),
                  ),
                );
              },
              icon: SvgPicture.asset(
                MyAssets.doctorIcon,
                color: white,
                width: 15,
                height: 20,
              ),
              lable: 'Doctors',
            ),
          if (role != UserRoles.nurse)
            DrawerTile(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ListOfUsersScreen(
                              filterRole: UserRoles.nurse,
                              data: userData,
                            )));
              },
              icon: SvgPicture.asset(
                MyAssets.personIcon,
                color: white,
                width: 15,
                height: 20,
              ),
              lable: 'Nurses',
            ),
          if (role == UserRoles.doctor || role == UserRoles.nurse)
            DrawerTile(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminScreen(
                              userID: userData.adminId,
                              data: userData,
                              role: UserRoles.admin,
                            )));
              },
              icon: SvgPicture.asset(
                MyAssets.doctorIcon,
                color: white,
                width: 15,
                height: 20,
              ),
              lable: 'Adminstrator',
            ),
          if (role != UserRoles.mother)
            DrawerTile(
              icon: SvgPicture.asset(
                MyAssets.incubatorIcon,
                color: white,
                width: 15,
                height: 20,
              ),
              lable: 'Incubators',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    if (role == UserRoles.admin || role == UserRoles.operator) {
                      return IncubatorScreen(
                        userData: userData,
                      );
                    } else {
                      return ListOfBabiesScreen(userData: userData);
                    }
                  }),
                );
              },
            ),
          if (role != UserRoles.mother)
            DrawerTile(
              icon: SvgPicture.asset(
                MyAssets.notificationDrawerIcon,
                color: white,
                width: 15,
                height: 20,
              ),
              lable: 'Notifications',
            ),
          //  if (role == UserRoles.admin || role == UserRoles.operator )
          DrawerTile(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(
              MyAssets.logoutIcon,
              color: white,
              width: 15,
              height: 20,
            ),
            lable: 'Logout',
          ),
        ]),
      ),
    );
  }
}
