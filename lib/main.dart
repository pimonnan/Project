import 'package:flutter/material.dart';
import 'package:projectnan/screens/login_screen.dart';
import 'package:projectnan/screens/splasdscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 5)),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primaryColor: Color(0xFFFFEA18), fontFamily: 'Lato'),
              home: SplasdScreen());
        } else {
          // Loading is done, return the app:
          return MaterialApp(
            // to remove the banner in right corner
            debugShowCheckedModeBanner: false,
            theme:
                ThemeData(primaryColor: Color(0xFFFFEA18), fontFamily: 'Lato'),
            // need to change thos to initial screen, means starting screen
            home: LoginScreen(),
            // routes: {
            //   LoginScreen.id: (context) => LoginScreen(),
            //   // HomeScreen.id: (context) => HomeScreen(),
            //   // CategoryListScreen.id: (context) => CategoryListScreen(),
            //   // AccountListScreen.id: (context) => AccountListScreen(),
            // },
          );
        }
      },
    );
  }
}
