import 'package:final_project/const/color.dart';
import 'package:final_project/const/my_assets.dart';
import 'package:final_project/enums.dart';
import 'package:final_project/providers/auth/auth_provider.dart';
import 'package:final_project/repository/validations.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/widgets/text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MyColors.firstTopClrs,
            MyColors.secondTopClrs,
            MyColors.thirdTopClrs,
            MyColors.fourthTopClrs,
            MyColors.fifthTopClrs
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        //  resizeToAvoidBottomInset: false,
        backgroundColor: MyColors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ChangeNotifierProvider(
                create: (_) => AuthProvider(),
                builder: (context, _) {
                  final read = context.read<AuthProvider>();
                  final watch = context.watch<AuthProvider>();
                  if (watch.state == AppState.loading) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Align(
                    alignment: Alignment.centerRight,
                    child: SafeArea(
                      child: Container(
                        height: (MediaQuery.of(context).size.height * 0.95),
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade100,
                                  blurRadius: 4,
                                  offset: const Offset(-3, 3))
                            ]),
                        child: Form(
                          key: _loginKey,
                          child: Column(
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              TextFieldForLogin(
                                lable: 'E-mail',
                                validator: AuthValidation.emailValidation,
                                onChange: read.setEmail,
                              ),
                              TextFieldForLogin(
                                lable: 'Password',
                                validator: AuthValidation.passwordValidation,
                                onChange: read.setPassword,
                                suffixIcon: watch.isObsecure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                obsocuree: watch.isObsecure,
                                onPressedd: read.changeVisability,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'forgot password',
                                      textScaleFactor: 1.2,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          color: MyColors.edtButtonClr),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: InkWell(
                                  splashColor: Colors.white,
                                  focusColor: Colors.white,
                                  onTap: () async {
                                    await read.loging().then((_) {
                                      if (watch.state == AppState.error) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'something went wrong')));
                                      } else {
                                        print(watch.auth);
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => HomeScreen(
                                            authentication: watch.auth!,
                                          ),
                                        ));
                                      }
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        gradient: const LinearGradient(
                                          colors: [
                                            MyColors.firstLeftClrs,
                                            MyColors.secondLeftClrs,
                                            MyColors.thirdLeftClrs
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            offset: const Offset(0, 3),
                                            blurRadius: 6.0,
                                          ),
                                        ]),
                                    child: const Center(
                                      child: Text(
                                        'Log in',
                                        textScaleFactor: 1,
                                        style: TextStyle(
                                            fontSize: 19, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: MediaQuery.of(context).size.height * -0.066,
                bottom: MediaQuery.of(context).size.height * -0.14,
                child: SvgPicture.asset(
                  MyAssets.handSvg,
                  color: MyColors.iconOfAdminClr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
