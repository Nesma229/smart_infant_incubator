import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/providers/create_incubator_provider.dart';
import 'package:final_project/widgets/circular_button.dart';
import 'package:final_project/widgets/custom_card.dart';
import 'package:final_project/widgets/dialog%20_of_empty_incubator.dart';
import 'package:final_project/widgets/dialogs.dart';
import 'package:final_project/widgets/incubater_tile.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../models/user_data_model.dart';
import 'info_of_baby_screen.dart';

class IncubatorScreen extends StatelessWidget {
  final UserDataModel userData;
  final searchFocus = FocusNode();
  IncubatorScreen({Key? key, required this.userData}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color borderColor = MyColors.borderOfProfileClr(userData.role);
    return ChangeNotifierProvider(
        create: (_) => IncubatorProvider(userData)..getListOfIncubator(),
        builder: (context, _) {
          final watch = context.watch<IncubatorProvider>();
          final read = context.read<IncubatorProvider>();

          return Scaffold(
            key: _scaffoldKey,
            endDrawer: MyDrawer(
              role: userData.role,
              userData: userData,
            ),
            drawerScrimColor: Colors.white.withOpacity(0),
            body: ListView(
              physics: NeverScrollableScrollPhysics(),
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
                      )),
                  center: TextField(
                    focusNode: searchFocus,
                    onChanged: watch.searchOnChange,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: MyColors.borderOfProfileClr(userData.role),
                      ),
                      hintText: 'Search by baby code',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color.fromRGBO(143, 172, 196, 1),
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
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IncubatorTile(
                        isSelected: watch.isBusyScreen,
                        title: 'Busy Incubator',
                        onPressed: () {
                          read.buttonToggle(true);
                        },
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      IncubatorTile(
                        title: 'Empty Incubator',
                        isLeft: false,
                        isSelected: !watch.isBusyScreen,
                        onPressed: () {
                          read.buttonToggle(false);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 15, bottom: 6),
                  child: Text(
                    (watch.isBusyScreen
                            ? 'Number of busy incubator'
                            : 'Number of empty incubator') +
                        ' : ' +
                        watch.getIncubators.length.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: MyColors.numberOfIncTextClr),
                  ),
                ),
                SizedBox(
                    height: size.height - 160,
                    child: RefreshIndicator(
                      onRefresh: read.getListOfIncubator,
                      child: watch.appState == AppState.loading
                          ? Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              primary: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 9),
                              shrinkWrap: true,
                              itemCount: watch.getIncubators.length,
                              itemBuilder: (context, index) {
                                return CustomCard(
                                  trailingOnPressed: () async {
                                    read.setCurrentIncubator(index);
                                    await read
                                        .getDoctorsAndNurses()
                                        .then((value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeNotifierProvider.value(
                                            value: read,
                                            builder: (conetxt, _) =>
                                                InfoOfBabyScreen(),
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                  onPressed: () {
                                    if (watch.isInScreach &&
                                        watch.isBusyScreen) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => DeletDialog(
                                          image: watch.isBusyScreen
                                              ? watch.getIncubators[index]
                                                  .babies!.image
                                              : watch
                                                  .getIncubators[index].image,
                                          line1: watch.getIncubators[index]
                                                  .babies?.babyCode ??
                                              '',
                                          line2: 'baby',
                                          onpressDelete: () async {
                                            Navigator.pop(context);

                                            await read.deletBabies(watch
                                                .getIncubators[index]
                                                .babies!
                                                .id);
                                          },
                                        ),
                                      );
                                    } else {}
                                  },
                                  showTrailing: !watch.isBusyScreen,
                                  image: watch.isBusyScreen
                                      ? watch.getIncubators[index].babies!.image
                                      : watch.getIncubators[index].image,
                                  title: watch.getIncubators[index].babies
                                          ?.babyCode ??
                                      watch.getIncubators[index].incubatorCode,
                                  subTitle: watch.getIncubators[index].babies
                                          ?.birthDate
                                          .toString() ??
                                      '',
                                );
                              },
                            ),
                    )),
              ],
            ),
            floatingActionButton: userData.role == UserRoles.admin ||
                    userData.role == UserRoles.operator
                ? !watch.isBusyScreen
                    ? Container(
                        width: 35,
                        height: 110,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: MyColors.iconOfAdminClr, width: 1),
                            borderRadius: BorderRadius.circular(9),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(3, 3))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return ChangeNotifierProvider.value(
                                      value: read,
                                      builder: (context, _) =>
                                          DialogOfEmptyIncubator(
                                              //  userData: userData,
                                              ),
                                    );
                                  },
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
                    : SmallCircularButtonInInfo(
                        onPressed: () {
                          searchFocus.requestFocus();
                        },
                        svgPath: MyAssets.deletIcon)
                : null,
          );
        });
  }
}


/*
 SmallCircularButtonInInfo(
                    onPressed: () {}, svgPath: MyAssets.addIcon)
*/