import 'dart:convert';

import 'package:http/http.dart' as http;

import 'data/model/SourcesResponse.dart';




class ApiManager{
  //https://newsapi.org/v2/top-headlines/sources?apiKey=3f05df5cb5d043a2bab2d335179588ca&category=sports

  static Future<SourcesResponse> getSources() async {
    Uri url = Uri.https("newsapi.org","/v2/top-headlines/sources",{
      "apiKey":"3f05df5cb5d043a2bab2d335179588ca"
    });

   http.Response response = await http.get( url);

   var json = jsonDecode(response.body);

    SourcesResponse sourcesRespones = SourcesResponse.fromJson(json);

    return sourcesRespones;

  }
}