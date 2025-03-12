import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_araby_ai/Screens/starting_screens/araby_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_araby_ai/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AnApp());
}

class AnApp extends StatelessWidget {
  const AnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child,
          );
        },
        child: const Araby_SC(), // Starts with splash, then moves to EmailScreen
      ),
    );
  }
}




/*
1- Sign in/login Authentication
2- Sign up and connecting to the firebase
3- saving the credintials (email, pass, username) to a DB
4- verification email
5- In the Home Page, 'Hello (username)' must show the name of the user that he chose

6- Image page functionalites
7- Social media page functionalities
8- Emails page functionaliteis
9- Search bar function
10- notification function
12- Editing profile page functionalites

13- Log out

//learn clean code
//learn responsive design

*/
