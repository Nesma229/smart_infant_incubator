import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/providers/create_incubator_provider.dart';
import 'package:final_project/widgets/circular_button.dart';
import 'package:final_project/widgets/drop_down_menuee.dart';
import 'package:final_project/widgets/image_box.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/my_drawer.dart';
import 'package:final_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InfoOfBabyScreen extends StatelessWidget {
  InfoOfBabyScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final UserRoles role = UserRoles.admin;
  final DateFormat _format = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    final Color borderColor = MyColors.borderOfProfileClr(role);
    final IncubatorProvider provider = Provider.of<IncubatorProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: MyDrawer(role: role, userData: provider.data),
      drawerScrimColor: Colors.white.withOpacity(0),
      body: SingleChildScrollView(
        child: Column(
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
              center: const Text(''),
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
            ImageBox(
              onPressed: provider.takePicture,
              storedImage: provider.storedImage,
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFieldBesideLable(
                    lable: 'Baby code',
                    onChanged: provider.setBabyCode,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter the baby code';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextWithDropDownButton<String>(
                    title: 'Gender',
                    hint: 'Select Your Gender',
                    icon: Icons.expand_more,
                    onchanged: provider.setGender,
                    items: provider.genderItems
                        .map(
                          (item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select gender.';
                      }
                      return null;
                    },
                  ),
                  TextWithDropDownButton<Users>(
                    title: 'Doctor',
                    hint: 'Select the doctor',
                    icon: Icons.expand_more,
                    onchanged: provider.setDoctor,
                    items: provider.doctors
                        .map(
                          (item) => DropdownMenuItem<Users>(
                            value: item,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select doctor';
                      }
                      return null;
                    },
                  ),
                  TextWithDropDownButton<Users>(
                    title: 'Nurse',
                    hint: 'Select the nurse',
                    icon: Icons.expand_more,
                    onchanged: provider.setNurse,
                    items: provider.nurses
                        .map(
                          (item) => DropdownMenuItem<Users>(
                            value: item,
                            child: Text(
                              item.name,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select nurse.';
                      }
                      return null;
                    },
                  ),
                  TextFieldBesideLable(
                    lable: 'Mother user name',
                    onChanged: provider.setUserName,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter the user name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFieldBesideLable(
                    lable: 'Mother E-mail',
                    onChanged: provider.setMotherEmail,
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
                    onChanged: provider.setMotherPassword,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter the user name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFieldBesideLable(
                    lable: 'Mother number',
                    onChanged: provider.setMotherNumber,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter the number';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFieldBesideLable(
                    lable: 'Birth day',
                    readOnly: true,
                    value: _format.format(provider.birthday),
                    onPressedd: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.now(),
                      ).then((packedDate) {
                        if (packedDate != null) {
                          provider.setBirthDate(packedDate);
                        }
                      });
                    },
                    onChanged: (val) {},
                    iconn: Icons.calendar_today_outlined,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'please enter the user name';
                      } else {
                        return null;
                      }
                    },
                  ),
                  if (provider.appState == AppState.loading)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [CircularProgressIndicator()],
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CircularButtonInInfo(
                            onPressed: () async {
                              await provider.setBabyToIncubator().then((value) {
                                if (provider.appState == AppState.done) {
                                  Navigator.pop(context);
                                } else if (provider.appState ==
                                    AppState.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'error please trye again later')));
                                }
                              });
                            },
                            svgPath: MyAssets.saveIcon),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
