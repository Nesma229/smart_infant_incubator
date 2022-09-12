import 'package:final_project/const/color.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TextWithDropDownButton<T> extends StatelessWidget {
  const TextWithDropDownButton({
    Key? key,
    required this.title,
    required this.items,
    required this.validator,
    this.onSaved,
    this.hint,
    required this.icon,
    this.onchanged,
    this.value,
    // required this.onTap,
  }) : super(key: key);

  final String title;

  final List<DropdownMenuItem<T>> items;
  final String? Function(T?) validator;
  final void Function(T?)? onchanged;
  final Function(T?)? onSaved;
  final String? hint;
  final T? value;
  final IconData? icon;
  // final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Text(
              title,
              textScaleFactor: 1,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
            ),
          ),
          Flexible(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.only(left: 8),
              child: FormFieldWithDropDownButton<T>(
                itemss: items,
                value: value,
                validatorr: validator,
                onSavedd: onSaved,
                hintt: hint,
                iconn: icon, onChanged: onchanged,
                // onTapp: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormFieldWithDropDownButton<T> extends StatelessWidget {
  const FormFieldWithDropDownButton({
    Key? key,
    required this.itemss,
    required this.validatorr,
    required this.onSavedd,
    this.hintt,
    required this.iconn,
    required this.onChanged,
    required this.value,
    // required this.onTapp,
  }) : super(key: key);

  final List<DropdownMenuItem<T>> itemss;
  final String? Function(T?) validatorr;
  final Function(T?)? onSavedd;
  final void Function(T?)? onChanged;
  final String? hintt;
  final T? value;
  final IconData? iconn;
  // final Function()? onTapp;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: DropdownButtonFormField2<T>(
        value: value,
        decoration: InputDecoration(
          //Add isDense true and zero Padding.
          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          //Add more decoration as you want here
          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
        ),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        isExpanded: true,
        hint: Text(
          hintt ?? '',
          textScaleFactor: 1,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
        icon: Icon(
          iconn,
          color: MyColors.iconOfAdminClr,
        ),
        iconSize: 25,
        buttonHeight: 45,
        buttonPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        items: itemss,
        validator: validatorr,
        onChanged: onChanged,
        onSaved: onSavedd,
        //  onTap: onTapp,
      ),
    );
  }
}
