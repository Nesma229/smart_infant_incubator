import 'dart:typed_data';

import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/const/roles.dart';
import 'package:final_project/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class ProfilePicAndLables extends StatelessWidget {
  final UserRoles role, upperRole;
  final bool isMain;
  final Function() onPressedForEdit;
  final Function()? onPressedForImg;
  final String userName, hospitalName;
  final Uint8List? image;
  final Color clrOfhospitalName;
  final Color? clrOfSvgImg;
  const ProfilePicAndLables({
    required this.onPressedForEdit,
    required this.image,
    required this.userName,
    required this.hospitalName,
    required this.clrOfhospitalName,
    Key? key,
    this.onPressedForImg,
    this.clrOfSvgImg,
    required this.role,
    this.isMain = false,
    required this.upperRole,
  }) : super(key: key);
  ImageProvider getImage(Uint8List? bytes) {
    if (bytes == null) {
      if (upperRole == UserRoles.mother) {
        return const AssetImage(MyAssets.personImgeForMother);
      } else {
        return const AssetImage(MyAssets.personImageForAdmin);
      }
    }
    return MemoryImage(bytes);
  }

  @override
  Widget build(BuildContext context) {
    print(upperRole);
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: getImage(image),
          ),
          if (role == UserRoles.mother || role == UserRoles.mother || isMain)
            Positioned(
              bottom: size.width * 0.0001, //0,
              right: size.height * -0.042, //-20,
              child: SmallCirculerButtonWithPositionn(
                  svgPath: MyAssets.addIcon
                  // _storedImage != null
                  //   ? MyAssets.addIcon
                  //   : MyAssets.deletIcon
                  ,
                  onPressed: onPressedForImg ?? () {},
                  //  () {
                  //    _takePicture();
                  // },

                  borderOfButtonClr: clrOfSvgImg ?? MyColors.borderOfAdminClr,
                  iconClr: clrOfSvgImg ?? MyColors.borderOfAdminClr),
            ),
        ]),
        SizedBox(height: size.height * 0.015),
        Text(userName,
            textScaleFactor: 1.2,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        Text(
          hospitalName,
          style: TextStyle(
              color: clrOfhospitalName,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
        if (upperRole == UserRoles.admin || isMain)
          TextButton(
            onPressed: onPressedForEdit,
            child: const Text(
              'Edit',
              textScaleFactor: 1.2,
              style: TextStyle(color: MyColors.edtButtonClr),
            ),
          ),
      ],
    );
  }
}
