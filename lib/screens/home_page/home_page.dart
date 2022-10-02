import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login_page/login_page.dart';
import '../../styles/palette.dart';
import '../../services/session.dart';
import '../../models/process.dart';
import '../../models/controllers/c_home.dart';
import '../../models/controllers/c_user.dart';
import '../add_page/add_page.dart';
import '../search_page/search_page.dart';
import '../process_page/process_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cUser = Get.put(CUser());
  final cHome = Get.put(CHome());

  logout() {
    Session.clearUser();
    Get.off(() => LoginPage());
  }

  refresh() {
    cHome.setAnalysis();
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laundry Lord'),
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
                logout();
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (cUser.data.id == null) return const Text('');
                        return Text('Username: ${cUser.data.username}');
                      }),
                      DView.spaceHeight(4),
                      Obx(() {
                        if (cUser.data.id == null) return const Text('');
                        return Text('Name: ${cUser.data.name}');
                      }),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => AddPage())?.then((value) {
                      cHome.setAnalysis();
                    });
                  },
                  child: const Text('Add Laundry'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => refresh(),
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            analysToday(context),
            DView.spaceHeight(16),
            ...List.generate(Process.listMenu.length, (index) {
              String status = Process.listMenu[index];
              return menuItem(status, () {
                Get.to(() => ProcessPage(status: status));
              });
            }),
          ], // Listview children
        ),
      ),
    );
  }

  Widget menuItem(String title, Function onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Palette.palette[100],
        child: InkWell(
          onTap: () => onTap(),
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: Theme.of(Get.context!).textTheme.headline6,
                ),
                const Icon(
                  Icons.navigate_next,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget analysToday(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Today',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    DView.spaceHeight(8.0),
                    Expanded(
                      child: Container(
                        width: 100.0,
                        decoration: BoxDecoration(
                          color: Palette.palette[500],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        alignment: Alignment.center,
                        child: Obx(
                          () {
                            return Text(
                              cHome.analysis['Today'].toString(),
                              style: Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Palette.palette[50],
                                  ),
                            );
                          }, // Obx builder
                        ),
                      ),
                    ),
                  ], // Column children
                ),
                DView.spaceWidth(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      Process.listToday.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            index == 0 ? 0 : 4,
                            0,
                            index == Process.listToday.length - 1 ? 0 : 4,
                          ),
                          child: Material(
                            color: Palette.palette[300],
                            borderRadius: BorderRadius.circular(8.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(Process.listToday[index]),
                                  Obx(
                                    () {
                                      String statusKey = Process.listToday[index];
                                      return Text(cHome.analysis[statusKey].toString());
                                    },
                                  ),
                                ], // Row children
                              ),
                            ),
                          ),
                        );
                      }, // List.generate builder
                    ),
                  ),
                ),
              ], // Row children
            ),
          ),
        ),
      ),
    );
  }
}
