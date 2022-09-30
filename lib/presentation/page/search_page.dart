import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/controller/c_search.dart';
import 'package:laundry/data/source/source_laundry.dart';
import 'package:laundry/presentation/component/detail_laundry.dart';

import '../../data/model/laundry.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    final cSearch = Get.put(CSearch());

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Search Laundry'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: DInput(
                      controller: searchController,
                      hint: 'Enter laundry ID',
                    ),
                  ),
                  DView.spaceWidth(),
                  SizedBox(
                    height: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        var laundry = await SourceLaundry.searchById(searchController.text);
                        cSearch.data = laundry ?? Laundry();
                      },
                      child: const Text('Search'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          if (cSearch.data.id == null) return DView.empty('Laundry not found');
          Laundry laundry = cSearch.data;
          return DetailLaundry(laundry: laundry);
        },
      ),
    );
  }
}
