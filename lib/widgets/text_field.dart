import 'package:final_project/const/color.dart';
import 'package:flutter/material.dart';

class TextFieldBesideLable extends StatelessWidget {
  const TextFieldBesideLable(
      {Key? key,
      this.readOnly = false,
      this.children,
      required this.lable,
      this.onChanged,
      this.validator,
      this.iconn,
      this.onPressedd,
      this.child,
      this.value})
      : super(key: key);

  //final UserRoles role = UserRoles.admin;
  final String lable;
  final String? value;
  final bool readOnly;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<Widget>? children;
  final Widget? child;
  final IconData? iconn;
  final Function()? onPressedd;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final Color borderColor = MyColors.borderOfProfileClr(role);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: size.width / 2.2 - 20,
            child: Text(
              lable,
              textScaleFactor: 1,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: size.width / 1.7,
            child: child ??
                TextFormField(
                  initialValue: value,
                  readOnly: readOnly,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    suffixIconConstraints: const BoxConstraints(minHeight: 8),
                    suffixIcon: InkWell(
                      onTap: () {
                        if (onPressedd != null) {
                          onPressedd!();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          iconn,
                          size: 20,
                          color: MyColors.iconOfAdminClr,
                        ),
                      ),
                    ),
                  ),
                  cursorColor: MyColors.iconOfAdminClr,
                  cursorHeight: 22,
                  keyboardType: TextInputType.multiline,
                  validator: validator,
                ),
          ),
        ],
      ),
    );
  }
}

//textField for login screen

class TextFieldForLogin extends StatelessWidget {
  const TextFieldForLogin(
      {Key? key,
      required this.lable,
      this.onChange,
      this.validator,
      this.obsocuree,
      this.suffixIcon,
      this.onPressedd})
      : super(key: key);
  final String lable;
  final void Function(String)? onChange;
  final String? Function(String?)? validator;
  final bool? obsocuree;
  final IconData? suffixIcon;
  final Function()? onPressedd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 45),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            lable,
            textScaleFactor: 1,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: MyColors.iconOfAdminClr),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            style: const TextStyle(
              fontSize: 18,
            ),
            onChanged: onChange,
            obscureText: obsocuree ?? false,
            cursorColor: MyColors.iconOfAdminClr,
            cursorHeight: 25,
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.iconOfAdminClr)),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: MyColors.thirdTopClrs),
              ),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: MyColors.thirdTopClrs)),
              constraints: const BoxConstraints(maxHeight: 65, minHeight: 50),
              suffixIcon: InkWell(
                onTap: () {
                  if (onPressedd != null) {
                    onPressedd!();
                  }
                },
                child: Icon(
                  suffixIcon,
                  color: MyColors.iconOfAdminClr,
                ),
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
