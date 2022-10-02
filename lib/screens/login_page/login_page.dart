import 'dart:ui';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_page/home_page.dart';
import '../search_page/search_page.dart';
import '../../models/sources/source_user.dart';
import '../../services/session.dart';
import '../../styles/palette.dart';
import '../../styles/style.dart';
import '../../widgets/text_input_box.dart';
import 'widgets/login_page_widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                          TextInputBox(
                            context,
                            'Username:',
                            'Enter your username',
                            usernameController,
                          ),
                          DView.spaceHeight(Style.appSpacing),
                          TextInputBox(
                            context,
                            'Password:',
                            'Enter your username',
                            passwordController,
                          ),
                         DView.spaceHeight(Style.appSpacing * 2),
                          ElevatedButton(
                            onPressed: () => login(),
                            child: const Text('Administrator'),
                          ),
                          DView.spaceHeight(Style.appSpacing),
                          ElevatedButton(
                            onPressed: () => {
                              Get.to(() => const SearchPage()),
                            },
                            child: Text(
                              'Customer',
                              style: Theme.of(context).textTheme.headline6!.copyWith(color: Palette.palette[50]),
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
}
