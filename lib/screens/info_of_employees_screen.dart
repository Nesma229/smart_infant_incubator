import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/providers/user_registeration_provider.dart';
import 'package:final_project/repository/validations.dart';
import 'package:final_project/widgets/circular_button.dart';
import 'package:final_project/widgets/image_box.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';
import 'package:final_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfoOfEmployeesScreen extends StatelessWidget {
  final UserRoles role;
  final bool isEdit;
  final UserDataModel userDataModel;
  InfoOfEmployeesScreen(
      {Key? key,
      required this.role,
      required this.userDataModel,
      required this.isEdit})
      : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const namedRoute = 'info-of-employees';
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color borderColor = MyColors.borderOfProfileClr(role);

    return Scaffold(
        key: _scaffoldKey,
        endDrawer: MyDrawer(role: role, userData: userDataModel),
        drawerScrimColor: Colors.white.withOpacity(0),
        body: ChangeNotifierProvider(
          create: (_) => UserRegisterationProvider(role, userDataModel),
          builder: (context, _) {
            final UserRegisterationProvider watch =
                context.watch<UserRegisterationProvider>();
            final UserRegisterationProvider read =
                context.read<UserRegisterationProvider>();
            return SingleChildScrollView(
              child: Column(
                children: [
                  MyAppBar(
                    leading: IconButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: Colors.black,
                      ),
                    ),
                    trainling: IconButton(
                      onPressed: () {
                        //Scaffold.of(context).openDrawer();
                        _scaffoldKey.currentState!.openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        size: 40,
                        color: MyColors.iconOfAdminClr,
                      ),
                    ),
                  ),
                  ImageBox(
                    onPressed: read.takePicture,
                    storedImage: watch.storedImage,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // if (watch.state == AppState.loading)
                  //   const Center(
                  //     child: CircularProgressIndicator(),
                  //   ),
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        TextFieldBesideLable(
                          lable: 'User name',
                          value: isEdit ? userDataModel.userName : '',
                          onChanged: read.setUserName,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'please enter the user name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFieldBesideLable(
                            lable: 'Password',
                            onChanged: read.setPassword,
                            validator: AuthValidation.passwordValidation),
                        TextFieldBesideLable(
                          lable: 'Name',
                          value: isEdit ? userDataModel.name : '',
                          onChanged: read.setName,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'please enter your name';
                            } else {
                              return null;
                            }
                          },
                        ),
                        TextFieldBesideLable(
                            lable: 'E-mail address',
                            value: isEdit ? userDataModel.email : '',
                            onChanged: read.setEmail,
                            validator: AuthValidation.emailValidation),
                        TextFieldBesideLable(
                            lable: 'University',
                            value: userDataModel.university,
                            onChanged: read.setUniversity,
                            validator: (val) {
                              return null;
                            }),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: size.width / 2.2 - 20,
                                  child: const Text(
                                    'Birth date',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  )),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: size.width / 1.7,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.5),
                                        child: TextFormField(
                                          initialValue: isEdit
                                              ? userDataModel.birthDay?.day
                                                  .toString()
                                              : '',
                                          cursorColor: MyColors.iconOfAdminClr,
                                          cursorHeight: 22,
                                          onChanged: read.setDay,
                                          keyboardType: TextInputType.multiline,
                                          validator: (val) {
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: TextFormField(
                                          initialValue: isEdit
                                              ? userDataModel.birthDay?.month
                                                  .toString()
                                              : '',
                                          cursorColor: MyColors.iconOfAdminClr,
                                          cursorHeight: 22,
                                          onChanged: read.setMonth,
                                          keyboardType: TextInputType.multiline,
                                          validator: (val) {
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: TextFormField(
                                          initialValue: isEdit
                                              ? userDataModel.birthDay?.year
                                                  .toString()
                                              : '',
                                          cursorColor: MyColors.iconOfAdminClr,
                                          cursorHeight: 22,
                                          onChanged: read.setYear,
                                          keyboardType: TextInputType.multiline,
                                          validator: (val) {
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextFieldBesideLable(
                            lable: 'National ID',
                            value: isEdit ? userDataModel.ssn : '',
                            onChanged: read.setSsn,
                            validator: (val) {
                              return null;
                            }),
                        TextFieldBesideLable(
                            lable: 'Degree of promotion',
                            value:
                                isEdit ? userDataModel.degreeOfPromotion : '',
                            onChanged: read.setdegreeOfPromotion,
                            validator: (val) {
                              return null;
                            }),
                        TextFieldBesideLable(
                            lable: 'Specialization',
                            value: isEdit ? userDataModel.specialization : '',
                            onChanged: read.setdegreeOfPromotion,
                            validator: (val) {
                              return null;
                            }),
                        TextFieldBesideLable(
                            lable: 'Phone number',
                            value: isEdit ? userDataModel.phoneNumber : '',
                            onChanged: read.setPhone,
                            validator: (val) {
                              return null;
                            }),
                        TextFieldBesideLable(
                            lable: 'Hospital name',
                            value: isEdit ? userDataModel.hospitalName : '',
                            onChanged: read.setHospitalName,
                            validator: (val) {
                              return null;
                            }),
                        TextFieldBesideLable(
                            lable: 'Hospital number',
                            value: isEdit ? userDataModel.hospitalPhone : '',
                            onChanged: read.setHospitalNumber,
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'please enter hospital number';
                              } else {
                                return null;
                              }
                            }),
                        // if (watch.state == AppState.loading)
                        //   const Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: 18),
                        //     child: Align(
                        //       alignment: Alignment.bottomRight,
                        //       child: CircularProgressIndicator(),
                        //     ),
                        //   )
                        // else
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircularButtonInInfo(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    if (isEdit) {
                                      await read.editUsers().then((_) {
                                        if (watch.state == AppState.done) {
                                          Navigator.of(context).pop();
                                        } else if (watch.state ==
                                            AppState.error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('error'),
                                            ),
                                          );
                                        }
                                      });
                                    } else {
                                      await read.registeration().then((_) {
                                        if (watch.state == AppState.done) {
                                          Navigator.of(context).pop();
                                        } else if (watch.state ==
                                            AppState.error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text('error'),
                                            ),
                                          );
                                        }
                                      });
                                    }
                                  }
                                },
                                svgPath: MyAssets.saveIcon),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
