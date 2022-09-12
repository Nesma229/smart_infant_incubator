import 'package:final_project/const/color.dart';
import 'package:flutter/material.dart';

class IncubatorTile extends StatelessWidget {
  final String title;
  final bool isLeft, isSelected;
  final void Function()? onPressed;
  const IncubatorTile(
      {Key? key,
      required this.title,
      this.isLeft = true,
      this.isSelected = true,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.32,
        padding: const EdgeInsets.all(8.5),
        decoration: BoxDecoration(
            color: isSelected ? Colors.white : MyColors.grey,
            border: isSelected
                ? Border.all(color: MyColors.grey, width: 1)
                : Border.all(color: Colors.transparent, width: 1),
            borderRadius: BorderRadius.only(
                topLeft: !isLeft ? Radius.zero : const Radius.circular(15),
                topRight: isLeft ? Radius.zero : const Radius.circular(15),
                bottomLeft: !isLeft ? Radius.zero : const Radius.circular(15),
                bottomRight: isLeft ? Radius.zero : const Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            title,
            textScaleFactor: 1,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
