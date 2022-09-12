import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final Widget icon;
  final String lable;
  final void Function()? onPressed;
  const DrawerTile(
      {Key? key, required this.icon, required this.lable, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(height: 3),
            Text(
              lable,
              textScaleFactor: 1,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
