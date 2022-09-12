import 'dart:io';

import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final File? storedImage;
  final void Function()? onPressed;
  const ImageBox({Key? key, required this.storedImage, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: size.height * 0.28,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: MyColors.iconOfAdminClr),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Stack(
          children: [
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
            Positioned(
              right: size.width * 0.045,
              bottom: size.height * 0.02,
              child: CircularButtonInInfo(
                onPressed: onPressed,
                svgPath:
                    storedImage != null ? MyAssets.editIcon : MyAssets.addIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
