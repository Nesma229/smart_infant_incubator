import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/const/color.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/providers/users_provider.dart';
import 'package:final_project/screens/info_of_employees_screen.dart';
import 'package:final_project/widgets/custom_tile.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';
import 'package:final_project/widgets/profile_pic_lables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdminScreen extends StatelessWidget {
  final String userID;
  final UserRoles role;
  final UserDataModel data;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AdminScreen(
      {Key? key, required this.userID, required this.data, required this.role})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color borderColor = MyColors.borderOfProfileClr(
      role,
    );
    return Scaffold(
        key: _scaffoldKey,
        drawerScrimColor: Colors.white.withOpacity(0),
        endDrawer: MyDrawer(
          role: data.role,
          userData: data,
        ),
        body: ChangeNotifierProvider(
          lazy: false,
          create: (_) =>
              UserProvider(dataModel: data)..getUsersWithId(userID, role),
          builder: (context, _) {
            final watch = context.watch<UserProvider>();
            final read = context.read<UserProvider>();
            if (watch.state == AppState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (watch.state == AppState.error) {
              return const Center(
                child: Text('error'),
              );
            }

            return Column(
              children: [
                MyAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  trainling: IconButton(
                    onPressed: () {
                      // Scaffold.of(context).openDrawer();
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
                  padding: const EdgeInsets.only(top: 15),
                  margin: const EdgeInsets.all(10),
                  width: size.width - 10,
                  height: size.height - 103,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: borderColor.withOpacity(0.3), width: 1.0),
                    borderRadius: BorderRadius.circular(26),
                    color: MyColors.fillingOfProfileClr(data.role),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfilePicAndLables(
                          upperRole: data.role,
                          role: role,
                          onPressedForEdit: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InfoOfEmployeesScreen(
                                      role: role,
                                      userDataModel: data,
                                      isEdit: true,
                                    )));
                          },
                          image: null,
                          userName: read.val!.userName,
                          hospitalName: read.val!.hospitalName ?? '',
                          clrOfhospitalName: borderColor),
                      SizedBox(
                        height: size.height / 2 - 12,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            CustomTile(
                               onPressed: () async {
                                    // await launchUrl(Uri(
                                    //     scheme:
                                    //         'tel:${read.currentUSer!.phoneNumber!}'));
                                    // print('${read.currentUSer!.phoneNumber!}');
                                    // await launchUrlString(
                                    //     'tel:${read.currentUSer!.phoneNumber!}');
                                  },
                              title: 'Phone Number',
                              widget: TxtWidget(
                                body: read.val!.phoneNumber ?? '',
                                isHidden: true,
                              ),
                              icon: SvgPicture.asset(
                                MyAssets.callIcon,
                                height: 19,
                                color: MyColors.borderOfProfileClr(data.role),
                              ),
                            ),
                            CustomTile(
                              onPressed: () {},
                              title: 'Email Address',
                              widget: TxtWidget(body: read.val!.email),
                              icon: SvgPicture.asset(
                                MyAssets.messageIcon,
                                height: 19,
                                color: MyColors.borderOfProfileClr(data.role),
                              ),
                            ),
                            CustomTile(
                              onPressed: () async {
                                //  await launchUrlString(
                                //         'tel:${read.currentUSer!.phoneNumber!}');
                              },
                              title: 'Hospital Number',
                              widget: TxtWidget(
                                body: read.val!.hospitalPhone ?? '',
                                isHidden: true,
                              ),
                              icon: SvgPicture.asset(
                                MyAssets.callIcon,
                                height: 19,
                                color: MyColors.borderOfProfileClr(data.role),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
