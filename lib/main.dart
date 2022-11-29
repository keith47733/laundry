import 'package:d_view/d_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'screens/home_page/home_page.dart';
import 'screens/login_page/login_page.dart';
import 'services/firebase_options.dart';
import 'services/shared_prefs.dart';
import 'styles/layout.dart';
import 'styles/app_theme.dart';

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
      builder: (BuildContext context, Widget? child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(
              textScaleFactor: data.textScaleFactor * Layout.TEXT_SCALE_FACTOR),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Lord of the Linens',
      theme: lightTheme.copyWith(
        appBarTheme: AppBarTheme(
          titleTextStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontFamily: 'InterTight')
              .apply(fontSizeFactor: 0.9),
        ),
      ),
      // darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home: FutureBuilder(
        future: SharedPrefs.getUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return DView.nothing();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return DView.loadingCircle();
          }
          if (snapshot.data.id == null) {
            return LoginPage();
          }
          return const HomePage();
        },
      ),
    );
  }
}
