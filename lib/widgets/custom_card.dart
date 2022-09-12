import 'dart:typed_data';

import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/screens/info_of_baby_screen.dart';
import 'package:final_project/widgets/circular_button.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title, subTitle;
  final Uint8List? image;
  final void Function()? onPressed;
  final void Function()? trailingOnPressed;
  final bool showTrailing;
  const CustomCard(
      {Key? key,
      this.title = '',
      required this.image,
      this.subTitle = '',
      this.onPressed,
      this.showTrailing = false,
      this.trailingOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: size.height * 1 / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(0, 2),
                blurRadius: 3),
          ],
        ),
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: size.width * .4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: image == null
                      ? Image.asset(
                          MyAssets.personImageForAdmin,
                          fit: BoxFit.fill,
                        )
                      : Image.memory(
                          image!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              //size.width - (size.width * 0.4) - 25
              Container(
                //  color: Colors.green,
                width: size.width * .43,
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      textScaleFactor: 1.2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Bahnschrift',
                      ),
                    ),
                    Text(
                      subTitle,
                      textScaleFactor: 1.2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Bahnschrift',
                      ),
                    ),
                  ],
                ),
              ),
              if (showTrailing)
                // IconButton(onPressed: trailingOnPressed, icon: Icon(Icons.add))
                SmallCircularButtonInInfo(
                    onPressed: trailingOnPressed, svgPath: MyAssets.addIcon)
              // SmallCirculerButton(
              //   svgPath: MyAssets.addIcon,
              //   onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const InfoOfBabyScreen(),
              //   ),
              // );
              //   },
              //   iconClr: MyColors.iconOfAdminClr,
              //   borderOfButtonClr: MyColors.borderOfAdminClr,
              // )
              // Padding(
              //   padding: const EdgeInsets.only(right: 13, bottom: 13),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [Container(child: Text('+'))],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
