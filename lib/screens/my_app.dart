import 'package:final_project/const/color.dart';
import 'package:final_project/screens/home_screen.dart';
import 'package:final_project/screens/incubator_screen.dart';
import 'package:final_project/screens/info_of_baby_screen.dart';
import 'package:final_project/screens/info_of_employees_screen.dart';
import 'package:final_project/screens/list_of_users_screen.dart';
import 'package:final_project/screens/login_screen.dart';
import 'package:final_project/screens/notification_screen.dart';
import 'package:final_project/screens/profile_screen.dart';
import 'package:final_project/screens/verification_screen.dart';
import 'package:final_project/view_model/user_login_view_model.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          hintStyle: TextStyle(color: Colors.red.shade200),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: MyColors.iconOfAdminClr, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: MyColors.iconOfAdminClr, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: MyColors.edtButtonClr, width: 0.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                const BorderSide(color: MyColors.edtButtonClr, width: 0.5),
          ),
        ),
      ),
      home: LoginScreen(),
      routes: {
        // HomeScreen.namedRote: (ctx) => HomeScreen(),
        // ProfileScreen.namedRote: (ctx) => ProfileScreen(ctx.a),
        // ListOfUsersScreen.namedRoute: (ctx) => ListOfUsersScreen(),
      },
    );
  }
}
