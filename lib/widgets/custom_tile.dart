import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String title;
  final Widget widget;
  final Widget? icon;
  final void Function()? onPressed;
  const CustomTile({
    Key? key,
    required this.title,
    required this.widget,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textScaleFactor: 1.1,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  widget,
                ],
              ),
              if (icon != null) IconButton(onPressed: onPressed, icon: icon!)
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class TxtWidget extends StatelessWidget {
  const TxtWidget({required this.body, this.isHidden = false, Key? key})
      : super(key: key);
  final String body;
  final bool isHidden;
  @override
  Widget build(BuildContext context) {
    return Text(
      isHidden ? '●' * body.length : body,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
    );
  }
}

class BuildContainerOfBabyCode extends StatelessWidget {
  const BuildContainerOfBabyCode(
      {required this.text, required this.borderClr, Key? key})
      : super(key: key);

  final String text;
  final Color borderClr;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 75,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.8,
          color: borderClr.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )),
      ),
    );
  }
}
