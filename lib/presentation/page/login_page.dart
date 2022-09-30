import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/session.dart';
import '../../data/source/source_user.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final username = TextEditingController();
  final password = TextEditingController();

  login() async {
    var user = await SourceUser.login(username.text, password.text);
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
      appBar: AppBar(
        title: const Text('Laundry Lord'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          DInput(
            title: 'User name',
            controller: username,
            hint: 'Enter your username:',
          ),
          DView.spaceHeight(),
          DInput(
            title: 'Password:',
            controller: password,
            hint: 'Enter your password',
          ),
          DView.spaceHeight(),
          ElevatedButton(
            onPressed: () => login(),
            child: const Text('Login'),
          ),
          OutlinedButton(
            onPressed: () => {},
            child: const Text('Login as Customer'),
          ),
        ],
      ),
    );
  }
}
