import 'dart:io';

import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/models/user_data_model.dart';
import 'package:final_project/providers/create_incubator_provider.dart';
import 'package:final_project/widgets/circular_button.dart';
import 'package:final_project/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogOfEmptyIncubator extends StatelessWidget {
  const DialogOfEmptyIncubator({
    Key? key,
    // required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IncubatorProvider provider = Provider.of<IncubatorProvider>(context);
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: AlertDialog(
        scrollable: true,
        backgroundColor: const Color.fromRGBO(226, 226, 226, 0.2),
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Builder(
          builder: (context) {
            return SizedBox(
              height: size.height * 0.99,
              width: size.width * 0.99,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 33, vertical: 117),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: MyColors.iconOfAdminClr, width: 0.5),
                      borderRadius: BorderRadius.circular(28),
                      color: Colors.white),
                  child:
                      //  ChangeNotifierProvider(
                      //   create: (_) => IncubatorProvider(userData),
                      //   builder: (context, _) {
                      //     final watch = context.watch<IncubatorProvider>();
                      //     final read = context.read<IncubatorProvider>();
                      //     return
                      Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: MyColors.iconOfAdminClr),
                                    borderRadius: BorderRadius.circular(34),
                                  ),
                                  child: provider.storedImage != null
                                      ? Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(34),
                                            image: DecorationImage(
                                              image: FileImage(
                                                provider.storedImage!,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Text(
                                            'NO IMAGE TAKEN...',
                                            textScaleFactor: 1,
                                            style: TextStyle(
                                                color: MyColors.iconOfAdminClr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            right: size.width * 0.052,
                            bottom: size.height * 0.03,
                            child: CircularButtonInInfo(
                              onPressed: () async {
                                await provider.takePicture();
                              },
                              svgPath: provider.storedImage != null
                                  ? MyAssets.editIcon
                                  : MyAssets.addIcon,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width: size.width * 0.3,
                                  child: const Text(
                                    'incubator code',
                                    textScaleFactor: 1,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  )),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: size.width / 2.0,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0.5),
                                      child: TextFormField(
                                        cursorColor: MyColors.iconOfAdminClr,
                                        cursorHeight: 22,
                                        onChanged: provider.setIncuatorCode,
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
                      const SizedBox(
                        height: 50,
                      ),
                      if (provider.appState == AppState.loading)
                        Row(
                          children: [CircularProgressIndicator()],
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: CircularButtonInInfo(
                                onPressed: () async {
                                  await provider
                                      .createIncbatorr()
                                      .then((value) {
                                    if (provider.appState == AppState.done) {
                                      Navigator.of(context).pop();
                                    } else {
                                      print('error');
                                    }
                                  });
                                },
                                svgPath: MyAssets.saveIcon),
                          ),
                        ),
                    ],
                  ),
                  //   },
                  // ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/*
 TextFieldBesideLable(
                            lable: 'Incubator code',
                            // onChanged: read.setIncuatorCode,
                            validator: (val) {
                              return null;
                            },
                          ),

 const SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: size.width / 2.2 - 20,
                                child: const Text(
                                  'incubator code',
                                  textScaleFactor: 1,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                )),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: size.width / 2.5,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0.5),
                                      child: TextFormField(
                                        cursorColor: MyColors.iconOfAdminClr,
                                        cursorHeight: 22,
                                        // onChanged: read.setDay,
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
                      const SizedBox(
                        height: 50,
                      ),




 storedImage != null
                                  ? Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(34),
                                        image: DecorationImage(
                                          image: FileImage(
                                            storedImage!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : const Center(
                                      child: Text(
                                        'NO IMAGE TAKEN...',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            color: MyColors.iconOfAdminClr,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),



 Padding(
      padding: EdgeInsets.symmetric(horizontal: 33.w, vertical: 117.h),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: MyColors.iconOfAdminClr, width: 0.5),
            borderRadius: BorderRadius.circular(28),
            color: Colors.white),
        child: Column(
          children: [
            Stack(children: [
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  buildContainerOfImage(
                    context,
                    _storedImage != null
                        ? Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              image: DecorationImage(
                                image: FileImage(
                                  _storedImage!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'NO IMAGE TAKEN...',
                              textScaleFactor: 1,
                              style: TextStyle(
                                  color: MyColors.iconOfAdminClr,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                  ),
                ],
              ),
              Positioned(
                  right: MediaQuery.of(context).size.width * 0.052,
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  child: CircleButtonForImageInImptyIncubator(
                    func: () {
                      _takePicture;
                    },
                    svgPath: _storedImage != null
                        ? 'assets/image/edit.svg'
                        : 'assets/image/add1.svg',
                  )),
            ]),
            Form(
              child: TitleBesidesTextForm(
                  title: 'Incubator code',
                  controller: _incuatorCodeController,
                  onSaved: (val) {
                    _incuatorCodeController.text = val!;
                  }),
            ),
            SizedBox(
              height: 65.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  circuleButtonWithNavigator(
                      context,
                      const BabyListScreenViewAdmin(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconSvgBuild(
                              'assets/image/save.svg', MyColors.iconOfAdminClr),
                        ],
                      ),
                      MyColors.iconOfAdminClr),
                ],
              ),
            )
          ],
        ),
      ),
    );
*/
