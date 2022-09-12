import 'package:final_project/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularButtonInInfo extends StatelessWidget {
  const CircularButtonInInfo(
      {required this.onPressed, required this.svgPath, Key? key})
      : super(key: key);

  final void Function()? onPressed;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 60,
        width: 45,
        decoration: BoxDecoration(
            border: Border.all(
                width: 0.5, color: MyColors.iconOfAdminClr.withOpacity(0.5)),
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade200, offset: const Offset(3, 3))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: MyColors.iconOfAdminClr,
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class SmallCircularButtonInInfo extends StatelessWidget {
  const SmallCircularButtonInInfo(
      {required this.onPressed, required this.svgPath, Key? key})
      : super(key: key);

  final void Function()? onPressed;
  final String svgPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        height: 55,
        width: 38,
        decoration: BoxDecoration(
            border: Border.all(
                width: 0.5, color: MyColors.iconOfAdminClr.withOpacity(0.5)),
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade200, offset: const Offset(3, 3))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: MyColors.iconOfAdminClr,
              height: 27,
            ),
          ],
        ),
      ),
    );
  }
}

class SmallCirculerButton extends StatelessWidget {
  const SmallCirculerButton(
      {required this.svgPath,
      required this.onPressed,
      required this.borderOfButtonClr,
      required this.iconClr,
      Key? key})
      : super(key: key);

  final String svgPath;
  final Function() onPressed;
  final Color borderOfButtonClr;
  final Color iconClr;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: const CircleBorder(),
      onPressed: onPressed,
      // elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 0.5, color: borderOfButtonClr),
        ),
        child: SvgPicture.asset(
          svgPath,
          height: 20,
          //  fit: BoxFit.scaleDown,

          color: iconClr,
        ),
      ),
    );
  }
}

class SmallCirculerButtonWithPositionn extends StatelessWidget {
  const SmallCirculerButtonWithPositionn(
      {required this.svgPath,
      required this.onPressed,
      required this.borderOfButtonClr,
      required this.iconClr,
      Key? key})
      : super(key: key);

  final String svgPath;
  final Function() onPressed;
  final Color borderOfButtonClr;
  final Color iconClr;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: const CircleBorder(),
      onPressed: onPressed,
      // elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(width: 0.5, color: borderOfButtonClr),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade200, offset: const Offset(3, 3))
            ]),
        child: SvgPicture.asset(
          svgPath,
          height: 17,
          //  fit: BoxFit.scaleDown,

          color: iconClr,
        ),
      ),
    );
  }
}
