import 'dart:ui';

import 'package:d_info/d_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/sources/source_user.dart';
import '../../services/shared_prefs.dart';
import '../../styles/app_theme.dart';
import '../../styles/layout.dart';
import '../home_page/home_page.dart';
import 'background_image.dart';
import 'login_input_box.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  void login(context) async {
    FocusScope.of(context).unfocus();
    var user = await SourceUser.login(
        usernameController.text, passwordController.text);
    if (user == null) {
      DInfo.dialogError('Login failed');
      DInfo.closeDialog();
    } else {
      SharedPrefs.saveUser(user);
      DInfo.dialogSuccess('Login successful');
      DInfo.closeDialog(actionAfterClose: () {
        Get.off(() => const HomePage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          backgroundImage('./assets/images/login_background.jpg'),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: Layout.SPACING * 4, horizontal: Layout.SPACING * 1.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Layout.RADIUS),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Layout.SPACING * 1.5,
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          'Lord of the Linens',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: color4),
                        ),
                        const SizedBox(height: Layout.SPACING * 2),
                        loginInputBox(
                          context,
                          'Username:',
                          'Enter your username',
                          usernameController,
                          TextInputAction.next,
                        ),
                        const SizedBox(height: Layout.SPACING * 1.25),
                        loginInputBox(
                          context,
                          'Password:',
                          'Enter your password',
                          passwordController,
                          TextInputAction.done,
                        ),
                        const SizedBox(height: Layout.SPACING * 2.5),
                        ElevatedButton(
                          onPressed: () => login(context),
                          child: const Padding(
                            padding: EdgeInsets.all(Layout.SPACING),
                            child: Text('Login'),
                          ),
                        ),
                        const SizedBox(height: Layout.SPACING * 2.25),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
