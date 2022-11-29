import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/layout.dart';
import '../../models/controllers/c_home.dart';
import '../../models/controllers/c_user.dart';
import '../../services/shared_prefs.dart';
import '../../styles/app_theme.dart';
import '../add_page/add_page.dart';
import '../login_page/login_page.dart';
import 'daily_summary_card.dart';
import 'process_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());
  final cHome = Get.put(CHome());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lord of the Linens'),
        actions: [
          IconButton(
            onPressed: logoutUser,
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => refreshHomePage(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(Layout.SPACING),
            child: Column(
              children: [
                dailySummaryCard(context, cUser, cHome),
                const SizedBox(height: Layout.SPACING),
                processCard(),
              ], // Column children
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        elevation: Layout.ELEVATION,
        notchMargin: Layout.SPACING / 2,
        child: SizedBox(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lighten(Colors.green, 20),
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddPage())?.then(
            (value) {
              cHome.setAnalysis();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  @override
  void initState() {
    refreshHomePage();
    super.initState();
  }

  logoutUser() {
    SharedPrefs.clearUser();
    Get.off(() => LoginPage());
  }

  refreshHomePage() {
    cHome.setAnalysis();
  }
}
