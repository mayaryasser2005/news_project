import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news_project/bloc/states.dart';

import '../data/model/NewsDataRespones.dart';
import '../data/model/SourcesResponse.dart';
import '../utils/constant.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeinitStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  int selectedTapIndex = 0;
  SourcesResponse? sourcesResponse;

  NewsDataResponse? newsDataRespones;

  changeSource(int value) {
    selectedTapIndex = value;
    emit(HomeChageState());
  }

  Future<void> getSources(String id) async {
    try {
      emit(HomeGetSoursesLoadingStates());
      Uri url = Uri.https(Constants.BaseURL, "v2/top-headlines/sources",
          {"api_key": Constants.API_Key, "category": id});

      http.Response response = await http.get(url);

      var json = jsonDecode(response.body);

      sourcesResponse = SourcesResponse.fromJson(json);
      if (response.statusCode != 200) {
        emit(HomeGetSoursesErrorStates());
        return;
      }
      emit(HomeGetSoursesSuccessStates());
      getNewsData(sourcesResponse?.sources?[selectedTapIndex].id ?? "");
    } catch (e) {
      emit(HomeGetSoursesErrorStates());
    }
  }

  Future<void> getNewsData(String sourceID) async {
    try {
      emit(HomeiGetNewsLoadingStates());
      Uri url = Uri.https(Constants.BaseURL, "/v2/everything", {
        "sources": sourceID,
      });

      http.Response response = await http.get(
        url,
        headers: {
          "x-api-key": Constants.API_Key,
        },
      );

      var json = jsonDecode(response.body);

      newsDataRespones = NewsDataResponse.fromJson(json);

      emit(HomeGetNewsSuccessStates());
    } catch (e) {
      emit(HomeGetNewsErrorStates());
    }
  }
}
