import 'dart:ui';

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/sources/source_user.dart';
import '../../services/session.dart';
import '../../styles/layout.dart';
import '../../theme/app_theme.dart';
import '../home_page/home_page.dart';
import 'local_widgets/background_image.dart';
import 'local_widgets/login_input_box.dart';

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
            padding: const EdgeInsets.fromLTRB(
              Layout.appSpacing,
              Layout.appSpacing * 4,
              Layout.appSpacing,
              Layout.appSpacing,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Layout.appRadius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(Layout.appSpacing),
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              Layout.appSpacing / 2,
                              0,
                              Layout.appSpacing * 2,
                            ),
                            child: Text('Login', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: color4)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              0,
                              0,
                              Layout.appSpacing,
                            ),
                            child: loginInputBox(
                              context,
                              'Username:',
                              'Enter your username',
                              usernameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              0,
                              0,
                              Layout.appSpacing,
                            ),
                            child: loginInputBox(
                              context,
                              'Password:',
                              'Enter your username',
                              passwordController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              Layout.appSpacing,
                              0,
                              Layout.appSpacing,
                            ),
                            child: ElevatedButton(
                              onPressed: () => {
                                login(),
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(Layout.appSpacing),
                                child: Text('Login'),
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
