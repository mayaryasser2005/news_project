import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:news_project/bloc/states.dart';
import 'package:news_project/repo/home_remote_ds_impl.dart';
import 'package:news_project/ui/tab_item.dart';

import '../bloc/cubit.dart';
import '../repo/home_local_ds_impl.dart';
import 'news_item.dart';

class NewsUi extends StatelessWidget {
  String id;

  NewsUi({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocProvider(
        create: (context) =>
            HomeCubit(true ? HomeRemoteDsImpl() : HomeLocalDsImpl())
              ..getSources(id),
        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is HomeGetSoursesLoadingStates ||
                state is HomeGetNewsLoadingStates) {
              context.loaderOverlay.show();
            } else {
              context.loaderOverlay.hide();
            }

            if (state is HomeGetNewsErrorStates) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Error"),
                  content: Text("Something went wrong"),
                ),
              );
            }

            if (state is HomeGetSoursesErrorStates) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Something went wrong")));
            }

            if (state is HomeChageState) {
              HomeCubit.get(context).getNewsData(HomeCubit.get(context)
                      .sourcesResponse
                      ?.sources?[HomeCubit.get(context).selectedTapIndex]
                      .id ??
                  "");
            }
          },
          builder: (context, state) {
            if (state is HomeGetSoursesErrorStates) {
              return Text("Something went wrong");
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DefaultTabController(
                    length: HomeCubit.get(context)
                            .sourcesResponse
                            ?.sources
                            ?.length ??
                        0,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      onTap: (value) {
                        HomeCubit.get(context).changeSource(value);
                      },
                      tabs: HomeCubit.get(context)
                              .sourcesResponse
                              ?.sources
                              ?.map(
                                (e) => TabItem(
                                  sources: e,
                                  isSelected: HomeCubit.get(context)
                                          .sourcesResponse!
                                          .sources!
                                          .elementAt(HomeCubit.get(context)
                                              .selectedTapIndex) ==
                                      e,
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8,
                      ),
                      itemBuilder: (context, index) {
                        return NewsItem(
                            article: HomeCubit.get(context)
                                .newsDataRespones!
                                .articles![index]);
                      },
                      itemCount: HomeCubit.get(context)
                              .newsDataRespones
                              ?.articles
                              ?.length ??
                          0,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}