import 'package:flutter/material.dart';
import 'package:news_project/screens/news_item.dart';
import 'package:news_project/screens/tab_item.dart';
import 'api_manager.dart';
import 'data/model/SourcesResponse.dart';

class NewsUi extends StatefulWidget {
  const NewsUi({super.key});

  @override
  State<NewsUi> createState() => NewsUIState();
}

class NewsUIState extends State<NewsUi> {
  int selectedTapIndex = 0;
  List<Sources> sources = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSources(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        sources = snapshot.data?.sources ?? [];

        // return ListView.builder
        // (
        //   itemBuilder: (context, index)
        //   {
        //     return ListTile
        //      (
        //       title: Text(sources[index].name ?? ""),
        //     );
        //   },
        //   itemCount: sources.length,
        // );

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    onTap: (value) {
                      selectedTapIndex = value;
                      setState(() {});
                    },
                    tabs: sources
                        .map((e) => TabItem(
                              sources: e,
                              isSelected:
                                  sources.elementAt(selectedTapIndex) == e,
                            ))
                        .toList(),
                  )),
              FutureBuilder(
                future:
                    ApiManager.getNewsData(sources[selectedTapIndex].id ?? ""),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }

                  var articles = snapshot.data?.articles ?? [];

                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        return NewsItem(article: articles[index]);
                      },
                      itemCount: articles.length,
                    ),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}