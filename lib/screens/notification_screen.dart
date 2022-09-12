import 'package:final_project/const/color.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';

import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key, required this.data}) : super(key: key);
  final bool isSwitched = false;
  final bool isRead = false;
  final UserRoles role = UserRoles.doctor;
  final UserDataModel data;

  @override
  Widget build(BuildContext context) {
    final Color borderColor = MyColors.borderOfProfileClr(role);

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        endDrawer: MyDrawer(role: role, userData: data),
        drawerScrimColor: Colors.white.withOpacity(0),
        body: Column(
          children: [
            MyAppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                  color: Colors.black,
                ),
              ),
              center: const Text(
                'Notification',
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              trainling: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState!.openEndDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  size: 40,
                  color: borderColor,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: borderColor),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile.adaptive(
                    activeColor: Colors.white,
                    activeTrackColor: borderColor,
                    title: const Text(
                      'Allow Notification',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    value: isSwitched,
                    onChanged: (newValue) {
                      //  isSwitched = newValue;
                    }),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            SizedBox(
              width: double.infinity,
              height: 469,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.5),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.only(left: 14),

                              //make height of the container is responsive
                              height: MediaQuery.of(context).size.height * 0.14,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.5, color: borderColor),
                                  borderRadius: BorderRadius.circular(26),
                                  color:
                                      MyColors.notificationContainerClr(role),
                                  boxShadow: [
                                    if (!isRead)
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.18),
                                        blurRadius: 3,
                                        offset: const Offset(0, 4),
                                      )
                                  ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  !isRead
                                      ? const Text(
                                          '●',
                                          textScaleFactor: 1.5,
                                          style: TextStyle(
                                              color: MyColors.edtButtonClr,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : const SizedBox(
                                          height: 10,
                                        ),
                                  const Text(
                                    'Warning!',
                                    textScaleFactor: 1.2,
                                    style: TextStyle(
                                        color: MyColors.edtButtonClr,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const Text(
                                    'baby code 1234 his temperature raised',
                                    textScaleFactor: 1.15,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
