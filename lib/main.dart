import 'package:d_view/d_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'styles/palette.dart';
import 'services/session.dart';
import 'services/firebase_options.dart';
import 'screens/home_page/home_page.dart';
import 'screens/login_page/login_page.dart';
import 'styles/style.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'InterTight',
        primarySwatch: Palette.palette,
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 15,
            color: Palette.palette[50],
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Style.appRadius)),
            padding: const EdgeInsets.fromLTRB(
              Style.appSpacing * 1.25,
              Style.appSpacing / 2,
              Style.appSpacing * 1.25,
              Style.appSpacing / 2,
            ),
            textStyle: Theme.of(context).textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: Palette.palette[50],
                ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Session.getUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DView.loadingCircle();
          }
          if (snapshot.data == null) return DView.nothing();
          if (snapshot.data!.id == null) return LoginPage();
          return const HomePage();
        },
      ),
    );
  }
}
