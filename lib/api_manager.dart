import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kemo_news_app/constants.dart';
import 'package:kemo_news_app/data/model/News_Data_Response.dart';
import 'package:kemo_news_app/data/model/Sources_Responces.dart';
import 'package:news_project/utils/constant.dart';

import 'data/model/NewsDataResponse.dart';
import 'data/model/SourcesResponse.dart';

class ApiManager {
  static Future<SourcesResponse> getSources() async {
    Uri url = Uri.https(
        Constants.BaseURL, "/v2/everything", {"api_key": Constants.API_Key});

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);

    SourcesResponse sources_responces = SourcesResponse.fromJson(json);

    return sources_responces;
  }

  static Future<News_Data_Response> getNewsData(String sourceID) async {
    Uri url = Uri.https(Constants.BaseURL, "/v2/everything", {
      "sources": sourceID,
    });

    http.Response response = await http.get(
      url,
      headers: {
        "api_key": Constants.API_Key,
      },
    );

    var json = jsonDecode(response.body);

    News_Data_Response model = News_Data_Response.fromJson(json);

    return model;
  }
}