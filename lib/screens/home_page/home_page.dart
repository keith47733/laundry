import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../styles/layout.dart';
import '../../models/controllers/c_home.dart';
import '../../models/controllers/c_user.dart';
import '../../services/session.dart';
import '../add_page/add_page.dart';
import '../login_page/login_page.dart';
import 'local_widgets/daily_summary_card.dart';
import 'local_widgets/homepage_banner.dart';
import 'local_widgets/process_card.dart';

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
            icon: const Icon(Icons.logout_sharp),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => refreshHomePage(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Layout.appSpacing,
              Layout.appSpacing,
              Layout.appSpacing,
              Layout.appSpacing,
            ),
            child: Column(
              children: [
                homepageBanner(),
                dailySummaryCard(context, cUser, cHome),
                processCard(),
              ], // Column children
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Visibility(
              maintainAnimation: true,
              maintainSize: true,
              maintainState: true,
              visible: false,
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddPage())?.then(
            (value) {
              cHome.setAnalysis();
            },
          ); // Page Navigation
        }, // onPressed
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
    Session.clearUser();
    Get.off(() => LoginPage());
  }

  refreshHomePage() {
    cHome.setAnalysis();
  }
}
