import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_project/cache_sources.dart';
import 'package:news_project/data/model/NewsDataRespones.dart';
import 'package:news_project/data/model/SourcesResponse.dart';
import 'package:news_project/repo/repo.dart';

import '../utils/constant.dart';

class HomeRemoteDsImpl implements HomeRepo {
  @override
  Future<NewsDataResponse> getNewsData(String sourceID) async {
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

    NewsDataResponse newsDataRespones = NewsDataResponse.fromJson(json);
    return newsDataRespones;
  }

  @override
  Future<SourcesRespones> getSources(String id) async {
    try {
      Uri url = Uri.https(Constants.BaseURL, "v2/top-headlines/sources",
          {"api_key": Constants.API_Key, "category": id});

      http.Response response = await http.get(url);

      var json = jsonDecode(response.body);
      SourcesRespones sourcesResponse = SourcesRespones.fromJson(json);
      await CacheSources.saveSources(sourcesResponse);

      return sourcesResponse;
    } catch (e) {
      print("Error $e");
      rethrow;
    }
  }
}
