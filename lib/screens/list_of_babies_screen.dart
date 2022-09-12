import 'package:final_project/const/color.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/providers/create_incubator_provider.dart';
import 'package:final_project/widgets/custom_card.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_data_model.dart';
import 'info_of_baby_screen.dart';

class ListOfBabiesScreen extends StatelessWidget {
  final UserDataModel userData;
  ListOfBabiesScreen({Key? key, required this.userData}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color borderColor = MyColors.borderOfProfileClr(userData.role);
    return ChangeNotifierProvider(
        create: (_) => IncubatorProvider(userData)..getBabies(),
        builder: (context, _) {
          final watch = context.watch<IncubatorProvider>();
          final read = context.read<IncubatorProvider>();
          if (watch.appState == AppState.loading) {
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }

          return Scaffold(
            key: _scaffoldKey,
            endDrawer: MyDrawer(
              role: userData.role,
              userData: userData,
            ),
            drawerScrimColor: Colors.white.withOpacity(0),
            body: Column(
              children: [
                MyAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  center: const Text(
                    'Incubators',
                    textScaleFactor: 1.2,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
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
                SizedBox(
                  height: size.height - 160,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 9),
                    shrinkWrap: true,
                    itemCount: watch.getBabyList.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        trailingOnPressed: () async {
                          read.setCurrentIncubator(index);
                          await read.getDoctorsAndNurses().then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider.value(
                                  value: read,
                                  builder: (conetxt, _) => InfoOfBabyScreen(),
                                ),
                              ),
                            );
                          });
                        },
                        showTrailing: !watch.isBusyScreen,
                        image: null,
                        title: watch.getBabyList[index].babyCode,
                        subTitle: watch.getBabyList[index].babyCode,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }
}
