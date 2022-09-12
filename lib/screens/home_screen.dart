import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/const/color.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/auth_model.dart';
import 'package:final_project/providers/user_data_provider.dart';
import 'package:final_project/screens/info_of_employees_screen.dart';
import 'package:final_project/widgets/custom_tile.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';
import 'package:final_project/widgets/profile_pic_lables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatelessWidget {
  final f = DateFormat('dd/MM/yyyy');
  final Authentication authentication;
  final bool hasNotification = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen({Key? key, required this.authentication}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Color borderColor = MyColors.borderOfProfileClr(authentication.role);
    return ChangeNotifierProvider(
      create: (context) => UserDataProvider(authentication)..getUserData(),
      builder: (context, _) {
        final watch = context.watch<UserDataProvider>();
        final read = context.read<UserDataProvider>();
        if (watch.appState == AppState.init ||
            watch.appState == AppState.loading ||
            watch.appState == AppState.error) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
            key: _scaffoldKey,
            drawerScrimColor: Colors.white.withOpacity(0),
            endDrawer: MyDrawer(
              role: authentication.role,
              userData: watch.currentUSer!,
            ),
            body: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                MyAppBar(
                  leading: Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          MyAssets.notificationPageIcon,
                          color: borderColor,
                          height: 30,
                        ),
                      ),
                      if (hasNotification)
                        Positioned(
                          right: 9,
                          top: 9,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                          ),
                        )
                    ],
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
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: size.width - 10,
                  height: size.height - 103,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: borderColor.withOpacity(0.3), width: 1.0),
                    borderRadius: BorderRadius.circular(16),
                    color: MyColors.fillingOfProfileClr(authentication.role),
                  ),
                  child: RefreshIndicator(
                    onRefresh: watch.getUserData,
                    child: ListView(
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        ProfilePicAndLables(
                          upperRole: authentication.role,
                          role: authentication.role,
                          isMain: true,
                          onPressedForEdit: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) => InfoOfEmployeesScreen(
                                    role: authentication.role,
                                    isEdit: true,
                                    userDataModel: watch.currentUSer!)),
                              ),
                            );
                          },
                          image: null,
                          userName: watch.currentUSer!.name,
                          hospitalName: watch.currentUSer!.hospitalName ?? '',
                          clrOfhospitalName: borderColor,
                          clrOfSvgImg: borderColor,
                        ),
                        SizedBox(
                          // height: size.height / 2 - 12,
                          child: ListView(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              CustomTile(
                                title: 'User Name',
                                widget: TxtWidget(
                                  body: watch.currentUSer!.userName,
                                ),
                              ),
                              if (watch.currentUSer!.phoneNumber != null)
                                CustomTile(
                                  title: 'Phone Number',
                                  onPressed: () async {
                                    // await launchUrl(Uri(
                                    //     scheme:
                                    //         'tel:${read.currentUSer!.phoneNumber!}'));
                                    // print('${read.currentUSer!.phoneNumber!}');
                                    await launchUrlString(
                                        'tel:${read.currentUSer!.phoneNumber!}');
                                  },
                                  widget: TxtWidget(
                                    body: watch.currentUSer!.phoneNumber!,
                                    isHidden: true,
                                  ),
                                  icon: SvgPicture.asset(
                                    MyAssets.callIcon,
                                    height: 19,
                                    color: MyColors.borderOfProfileClr(
                                        authentication.role),
                                  ),
                                ),
                              CustomTile(
                                title: 'Email Address',
                                onPressed: () async {
                                  String? encodeQueryParameters(
                                      Map<String, String> params) {
                                    return params.entries
                                        .map((e) =>
                                            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                        .join('&');
                                  }

                                  await launchUrl(Uri(
                                    scheme: 'docotor',
                                    path: watch.currentUSer!.email,
                                    query:
                                        encodeQueryParameters(<String, String>{
                                      'subject': 'flutter app'
                                    }),
                                  ));
                                },
                                widget:
                                    TxtWidget(body: watch.currentUSer!.email),
                                icon: SvgPicture.asset(
                                  MyAssets.messageIcon,
                                  height: 19,
                                  color: MyColors.borderOfProfileClr(
                                      authentication.role),
                                ),
                              ),
                              if (watch.currentUSer!.hospitalPhone != null)
                                CustomTile(
                                  title: 'Hospital Number',
                                  widget: TxtWidget(
                                    isHidden: true,
                                    body: watch.currentUSer!.hospitalPhone!,
                                  ),
                                  icon: SvgPicture.asset(
                                    MyAssets.callIcon,
                                    height: 19,
                                    color: MyColors.borderOfProfileClr(
                                        authentication.role),
                                  ),
                                ),
                              if (watch.currentUSer!.ssn != null)
                                CustomTile(
                                  title: 'National ID',
                                  widget: TxtWidget(
                                    body: watch.currentUSer!.ssn!,
                                    isHidden: true,
                                  ),
                                ),
                              if (watch.currentUSer!.birthDay != null)
                                CustomTile(
                                  title: 'Birth date',
                                  widget: TxtWidget(
                                    body: f.format(
                                        watch.currentUSer!.birthDay ??
                                            DateTime.now()),
                                  ),
                                ),
                              if (watch.currentUSer!.university != null)
                                CustomTile(
                                  title: 'University',
                                  widget: TxtWidget(
                                    body: watch.currentUSer!.university!,
                                  ),
                                ),
                              if (watch.currentUSer!.degreeOfPromotion != null)
                                CustomTile(
                                  title: 'Degree of promotion',
                                  widget: TxtWidget(
                                    body: watch.currentUSer!.degreeOfPromotion!,
                                  ),
                                ),
                              if (watch.currentUSer!.specialization != null)
                                CustomTile(
                                  title: 'Specialization',
                                  widget: TxtWidget(
                                      body: watch.currentUSer!.specialization!),
                                ),
                                
                              if (watch.currentUSer!.babayCodes != null)
                                CustomTile(
                                  title: 'Baby code',
                                  widget: Column(children: [
                                    ...watch.currentUSer!.babayCodes!
                                        .map((e) => BuildContainerOfBabyCode(
                                            text: '●' * (e as String).length,
                                            borderClr: borderColor))
                                        .toList()
                                  ]),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
