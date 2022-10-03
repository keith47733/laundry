import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/controllers/c_home.dart';
import '../../models/controllers/c_user.dart';
import '../../services/session.dart';
import '../../styles/palette.dart';
import '../../styles/style.dart';
import '../add_page/add_page.dart';
import '../login_page/login_page.dart';
import '../search_page/search_page.dart';
import 'local_widgets/homepage_banner.dart';
import 'local_widgets/process_card.dart';
import 'local_widgets/daily_summary_card.dart';

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
      backgroundColor: Palette.palette[50],
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
              Style.appSpacing,
              0,
              Style.appSpacing,
              Style.appSpacing,
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
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(() => AddPage())?.then(
            (value) {
              cHome.setAnalysis();
            },
          ); // Page Navigation
        }, // onPressed
      ),
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
