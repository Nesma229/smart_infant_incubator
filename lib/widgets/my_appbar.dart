import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final Widget? leading, trainling, center;
  const MyAppBar({Key? key, this.leading, this.trainling, this.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            leading ?? Container(),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: center ?? Container(),
            )),
            trainling ?? Container()
          ],
        ),
      ),
    );
  }
}
