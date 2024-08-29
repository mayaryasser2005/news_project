import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_project/screens/tab_item.dart';

import 'api_manager.dart';

class NewsUi extends StatefulWidget {
  const NewsUi({super.key});

  @override
  State<NewsUi> createState() => _NewsUiState();
}

class _NewsUiState extends State<NewsUi> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManager.getSources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          var sources = snapshot.data?.sources ?? [];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DefaultTabController(
                length: sources.length,
                child: TabBar(
                    onTap: (value) {
                      selectedTabIndex = value;
                      setState(() {});
                    },
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabs: sources
                        .map((e) => TabItem(
                              sources: e,
                              isSelected:
                                  sources.elementAt(selectedTabIndex) == e,
                            ))
                        .toList())),
          );
        });
  }
}
