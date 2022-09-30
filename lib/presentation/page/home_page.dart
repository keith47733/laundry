import 'package:d_view/d_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  logout() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laundry Lord'),
        actions: [
          IconButton(
            onPressed: () {},
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
                    children: const [
                      Text('Username'),
                      Text('Name'),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Add Laundry'),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          analysToday(context),
					...List.generate(Status.listMenu.length, (index) => {
						String status = Status.listMenu[index];
						return menuItem(status, () {
							Get.to(() => WhereStatusPage(status: status));
						});
					}),
        ],
      ),
    );
  }

  Card analysToday(BuildContext context) {
    return Card(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '100',
                        style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ], // Column children
              ),
              DView.spaceWidth(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(Status.listToday.length, (index) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          0,
                          index == 0 ? 0 : 4,
                          0,
                          index == Status.listToday.length - 1 ? 0 : 4,
                        ),
                        child: Material(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(Status.listToday[index]),
                                const Text('0'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ], // Row children
          ),
        ),
      ),
    );
  }
}
