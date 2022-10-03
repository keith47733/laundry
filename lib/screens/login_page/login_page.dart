import 'dart:ui';

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/sources/source_user.dart';
import '../../services/session.dart';
import '../../styles/style.dart';
import 'local_widgets/login_input_box.dart';
import '../home_page/home_page.dart';
import '../search_page/search_page.dart';
import 'local_widgets/background_image.dart';
import 'local_widgets/login_title.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          backgroundImage('./assets/images/login_background.jpg'),
          Padding(
            padding: const EdgeInsets.all(Style.appSpacing),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                loginTitle('Login'),
                ClipRRect(
                  borderRadius: BorderRadius.circular(Style.appRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(Style.appSpacing),
                        shrinkWrap: true,
                        children: [
                          loginInputBox(
                            context,
                            'Username:',
                            'Enter your username',
                            usernameController,
                          ),
                          loginInputBox(
                            context,
                            'Password:',
                            'Enter your username',
                            passwordController,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              Style.appSpacing,
                              0,
                              Style.appSpacing / 2,
                            ),
                            child: ElevatedButton(
                              onPressed: () => {
                                login(),
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(Style.appSpacing / 2),
                                child: Text('Administrator'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              Style.appSpacing,
                              0,
                              Style.appSpacing / 2,
                            ),
                            child: ElevatedButton(
                              onPressed: () => {
                                Get.to(() => const SearchPage()),
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(Style.appSpacing / 3),
                                child: Text(
                                  'Customer',
                                  textScaleFactor: 0.75,
                                ),
                              ),
                            ),
                          ),
                        ], // ListView children
                      ),
                    ),
                  ),
                ),
              ], // Column children
            ),
          ),
        ], // Stack children
      ),
    );
  }

  void login() async {
    var user = await SourceUser.login(usernameController.text, passwordController.text);
    if (user == null) {
      DInfo.dialogError('Login failed');
      DInfo.closeDialog();
    } else {
      Session.saveUser(user);
      DInfo.dialogSuccess('Login successful');
      DInfo.closeDialog(actionAfterClose: () {
        Get.off(() => const HomePage());
      });
    }
  }
}
