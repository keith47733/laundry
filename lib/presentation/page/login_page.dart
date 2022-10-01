import 'dart:ui';

import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/presentation/page/search_page.dart';

import '../../config/palette.dart';
import '../../config/session.dart';
import '../../data/source/source_user.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  login() async {
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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Text('Laundry Lord'),
      // ),
      body: Stack(
        children: [
          const Image(
            image: AssetImage('./assets/images/login_background.jpg'),
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 20, 0, 20),
                  child: Text(
                    'Login',
                    style: Theme.of(Get.context!).textTheme.headline3!.copyWith(
                          color: Palette.palette[100],
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 16),
                            child: Text(
                              'Username:',
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Palette.palette[50],
                                  ),
                            ),
                          ),
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Palette.palette[100],
                              hintText: 'Enter your username',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
                            child: Text(
                              'Password:',
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: Palette.palette[50],
                                  ),
                            ),
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              filled: true,
                              fillColor: Palette.palette[100],
                              hintText: 'Enter your password',
                            ),
                          ),
                          DView.spaceHeight(32),
                          ElevatedButton(
                            onPressed: () => login(),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Administrator',
                                style: Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Palette.palette[50],
                                    ),
                              ),
                            ),
                          ),
                          DView.spaceHeight(16),
                          ElevatedButton(
                            onPressed: () => {
                              Get.to(() => const SearchPage()),
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Customer',
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Palette.palette[50],
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
