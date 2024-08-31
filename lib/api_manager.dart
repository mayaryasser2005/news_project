import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_project/utils/constant.dart';

import 'data/model/NewsDataRespones.dart';
import 'data/model/SourcesResponse.dart';

//https://newsapi.org/v2/top-headlines/sources?apiKey=3f05df5cb5d043a2bab2d335179588ca
class ApiManager {
  static Future<SourcesResponse> getSources() async {
    Uri url = Uri.https(Constants.BaseURL, "v2/top-headlines/sources",
        {"api_key": Constants.API_Key});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    SourcesResponse sourcesResponces = SourcesResponse.fromJson(json);

    return sourcesResponces;
  }

//https://newsapi.org/v2/everything?q=bitcoin&apiKey=3f05df5cb5d043a2bab2d335179588ca
  static Future<NewsDataRespones> getNewsData(String sourceID) async {
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
    print(json);
    NewsDataRespones model = NewsDataRespones.fromJson(json);

    return model;
  }
}