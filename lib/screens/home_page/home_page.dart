import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/controllers/c_home.dart';
import '../../models/controllers/c_user.dart';
import '../../services/session.dart';
import '../../theme/layout.dart';
import '../add_page/add_page.dart';
import '../login_page/login_page.dart';
import '../search_page/search_page.dart';
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
      // backgroundColor: Palette.palette[50],
      appBar: AppBar(
        title: const Text('Lord of the Linens'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                logoutUser();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
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
              0,
              Layout.appSpacing,
              Layout.appSpacing * 2,
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
        shape: const CircularNotchedRectangle(),
        // color: Palette.palette[300],
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.menu),
              // color: Colors.transparent,
              onPressed: () {},
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5.0,
        // backgroundColor: Colors.lightBlue[100],
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
