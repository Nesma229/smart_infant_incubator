import 'package:final_project/const/color.dart';
import 'package:final_project/widgets/my_appbar.dart';
import 'package:final_project/widgets/paint_trianglee.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _verificationController = TextEditingController();
  final GlobalKey<FormState> _formVelKey = GlobalKey<FormState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(
      () {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _verificationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValide = _formVelKey.currentState!.validate();
    if (!isValide) {
      return;
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          MyAppBar(
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back,
                size: 35,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                if (_focusNode.hasFocus)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 13,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.77,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0, color: MyColors.iconOfAdminClr),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: const Text(
                            'Enter your E-mail or phone number to send you code then reset your password',
                            textScaleFactor: 1,
                            style: TextStyle(
                                color: MyColors.wideButtonClr, fontSize: 14),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        child: SizedBox(
                          height: 10,
                          width: 40,
                          child: CustomPaint(
                            foregroundPainter: MyTrianglePainterr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                Positioned(
                  //  bottom: 10,
                  top: 70,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Form(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (s) {},
                          cursorColor: MyColors.iconOfAdminClr,
                          cursorHeight: 25,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            isDense: false,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 8),
                            hintText: _focusNode.hasFocus
                                ? ''
                                : 'E-mail or Phone Number',
                            hintStyle:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter the email or phone number';
                            } else {
                              return null;
                            }
                          },
                        ),
                      )),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7),
            child: MaterialButton(
              onPressed: () {
                setState(() {
                  _saveForm();
                });
              },
              minWidth: double.infinity,
              height: 49,
              color: MyColors.wideButtonClr,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Next',
                textScaleFactor: 1.2,
                style: TextStyle(fontSize: 19, color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
