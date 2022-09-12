import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/providers/users_provider.dart';
import 'package:final_project/screens/info_of_employees_screen.dart';
import 'package:final_project/screens/profile_screen.dart';
import 'package:final_project/widgets/custom_card.dart';
import 'package:final_project/widgets/dialogs.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ListOfUsersScreen extends StatelessWidget {
  final FocusNode node = FocusNode();
  ListOfUsersScreen({Key? key, required this.data, required this.filterRole})
      : super(key: key);
  static const namedRoute = '/list_of_users-screen';

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserRoles filterRole;
  final UserDataModel data;
  String roleLable() {
    if (data.role == UserRoles.admin) {
      return 'Search by admin name';
    } else if (data.role == UserRoles.operator) {
      return 'Search by operator name';
    } else if (data.role == UserRoles.doctor) {
      return 'Search by doctor name';
    } else if (data.role == UserRoles.nurse) {
      return 'Search by nurse name';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color borderColor = MyColors.borderOfProfileClr(data.role);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MyDrawer(
        role: data.role,
        userData: data,
      ),
      drawerScrimColor: Colors.white.withOpacity(0),
      body: ChangeNotifierProvider(
        create: (context) => UserProvider(dataModel: data)
          ..getListOfUsers(
            role: filterRole,
          ),
        builder: (context, _) {
          final watch = context.watch<UserProvider>();
          final read = context.read<UserProvider>();
          if (watch.state == AppState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (watch.state == AppState.error) {
            return const Center(child: Text('error'));
          }

          return ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
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
                center: TextField(
                  focusNode: node,
                  onChanged: read.searchForUser,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.search,
                      color: MyColors.borderOfProfileClr(data.role),
                    ),
                    hintText: roleLable(),
                    hintStyle: TextStyle(
                      fontSize: 13,
                      color: borderColor.withOpacity(0.5),
                    ),
                  ),
                  showCursor: false,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.start,
                  onTap: () {},
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
              watch.usersFilter.isEmpty
                  ? const Center(
                      child: Text(
                        'no user found',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : SizedBox(
                      height: size.height - 85,
                      child: RefreshIndicator(
                        onRefresh: () async {
                          read.getListOfUsers(role: filterRole);
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          itemCount: watch.usersFilter.length,
                          itemBuilder: (context, index) {
                            return CustomCard(
                              onPressed: () {
                                if (watch.inSeach) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => DeletDialog(
                                            image: watch
                                                .usersFilter[index].imageBytes,
                                            line1:
                                                watch.usersFilter[index].name,
                                            line2:
                                                watch.usersFilter[index].name,
                                            onpressDelete: () {
                                              read.dleteUSerWithID(
                                                  watch.usersFilter[index].id,
                                                  filterRole);
                                              Navigator.pop(context);
                                            },
                                          ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfileScreen(
                                            userID: watch.users[index].id,
                                            role: watch.users[index].role,
                                            data: data),
                                      ));
                                }

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ProfileScreen(
                                //         user: watch.usersFilter[index])));
                              },
                              image: watch.usersFilter[index].imageBytes,
                              title: watch.usersFilter[index].name,
                              subTitle: watch.usersFilter[index].email,
                            );
                          },
                        ),
                      ),
                    ),
            ],
          );
        },
      ),
      floatingActionButton: data.role == UserRoles.admin ||
              data.role == UserRoles.operator
          ? Container(
              width: 35,
              height: 110,
              decoration: BoxDecoration(
                  border: Border.all(color: MyColors.iconOfAdminClr, width: 1),
                  borderRadius: BorderRadius.circular(9),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => InfoOfEmployeesScreen(
                                role: filterRole,
                                userDataModel: data,
                                isEdit: false,
                              )),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        MyAssets.addIcon,
                        height: 30,
                        width: 30,
                        color: MyColors.iconOfAdminClr,
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1.7,
                    color: MyColors.iconOfAdminClr,
                  ),
                  InkWell(
                    onTap: () {
                      node.requestFocus();
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => DeletDialog(
                      //           image: null,
                      //           line1: 'lin1',
                      //           line2: 'line2',
                      //           onpressDelete: () {},
                      //         ));
                      // showDialog(
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //           title: Text('Accept'),
                      //           content: Text('Do you need to delet doctor'),
                      //           actions: [
                      //             TextButton(
                      //                 onPressed: () {}, child: Text('ok')),
                      //             TextButton(
                      //                 onPressed: () {}, child: Text('cancel'))
                      //           ],
                      //         ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        MyAssets.deletIcon,
                        height: 30,
                        width: 30,
                        color: MyColors.iconOfAdminClr,
                      ),
                    ),
                  )
                ],
              ),
            )
          : null,
    );
  }
}
