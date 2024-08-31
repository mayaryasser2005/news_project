import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_project/data/model/SourcesResponseNew.dart';
import 'package:news_project/utils/constant.dart';

import 'data/model/NewsDataResponse.dart';

class ApiManager {
  static Future<SourcesResponseNew> getSources() async {
    Uri url = Uri.https(
        Constants.BaseURL, "/v2/everything", {"api_key": Constants.API_Key});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    SourcesResponseNew sources_responces = SourcesResponseNew.fromJson(json);

    return sources_responces;
  }

  static Future<News_Data_Response> getNewsData(String sourceID) async {
    Uri url = Uri.https(Constants.BaseURL, "/v2/everything", {
      "sources": sourceID,
    });

    http.Response response = await http.get(
      url,
      headers: {
        "x_api_key": Constants.API_Key,
      },
    );

    var json = jsonDecode(response.body);
    print(json);
    News_Data_Response model = News_Data_Response.fromJson(json);

    return model;
  }
}