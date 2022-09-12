import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../const/color.dart';
import '../const/my_assets.dart';

class DeletDialog extends StatelessWidget {
  const DeletDialog(
      {Key? key,
      required this.image,
      required this.line1,
      required this.line2,
      this.onpressDelete})
      : super(key: key);
  final Uint8List? image;
  final String line1;
  final String line2;

  final void Function()? onpressDelete;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: Builder(builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.9 + 45,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.33),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.84,
                      height: MediaQuery.of(context).size.height * 0.34 + 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: MyColors.edtButtonClr)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /* SizedBox(
                          height: 5.h,
                        ),*/
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(26)),
                            child: image == null
                                ? Image.asset(
                                    MyAssets.personImageForAdmin,
                                    fit: BoxFit.fill,
                                    width: 170,
                                    height: 140,
                                  )
                                : Image.memory(
                                    image!,
                                    fit: BoxFit.fill,
                                    width: 170,
                                    height: 140,
                                  ),
                          ),
                          /* SizedBox(
                          height: 4.h,
                        ),*/
                          textOfDeleteDialogg('Do You want to delete $line1?'),
                          /* SizedBox(
                          height: 5.h,
                        ),*/
                          textOfDeleteDialogg(
                              'You will lose all of $line2 data'),
                          /* SizedBox(
                          height: 5.h,
                        ),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buttonsOfDeleteDialogg(
                                  MyColors.iconOfAdminClr, 'Cancel', () {
                                Navigator.pop(context);
                              }),
                              buttonsOfDeleteDialogg(MyColors.edtButtonClr,
                                  'Delete', onpressDelete!)
                            ],
                          ),
                          /* SizedBox(
                          height: 20.h,
                        )*/
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}

Widget textOfDeleteDialogg(String text) {
  return Center(
    child: Text(
      text,
      textScaleFactor: 1,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget buttonsOfDeleteDialogg(
    Color clrButton, String textData, Function() func) {
  return TextButton(
    onPressed: func,
    child: Container(
      height: 32,
      width: 104,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: clrButton,
      ),
      child: Center(
        child: Text(
          textData,
          textScaleFactor: 1,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    ),
  );
}

dialogForAddEmPtyIncubator(BuildContext context, Widget details) {
  return Center(
    child: AlertDialog(
        scrollable: true,
        backgroundColor: const Color.fromRGBO(226, 226, 226, 0.2),
        elevation: 0,
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Builder(builder: (context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.99,
              width: MediaQuery.of(context).size.width * 0.99,
              child: details);
        })),
  );
}
