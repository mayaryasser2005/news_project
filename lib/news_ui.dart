import 'package:flutter/material.dart';
import 'package:news_project/screens/tab_item.dart';
import 'api_manager.dart';
import 'data/model/SourcesResponse.dart';

class NewsUi extends StatefulWidget {
  const NewsUi({super.key});

  @override
  State<NewsUi> createState() => _News_UIState();
}

class _News_UIState extends State<NewsUi> {
  int selected_tap_index = 0;
  List<Sources> sources = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: ApiManager.getSources(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            sources = snapshot.data
            ??.sources ?? [];

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
            child: DefaultTabController(
            length: sources.length,
            child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
            onTap: (value) {
            selected_tap_index = value;
            setState(() {});
            },
                    tabs: sources
                        .map((e) => TabItem(
            sources: e,
            isSelected:
            sources.elementAt(selected_tap_index) == e,
            ))
                .toList(),
            )),
            );
          },
        ),
        FutureBuilder(
          future: ApiManager.getNewsData(sources[selected_tap_index], id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Something went wrong"));
            }

            var articles = snapshot.data?.articles ?? [];

            return ListView.builder(
              itemBuilder: (context, index) {
                return Text(articles[index].title ?? "");
              },
              itemCount: articles.length,
            );
          },
        )
      ],
    );
  }
}