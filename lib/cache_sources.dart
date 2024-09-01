import 'package:hive/hive.dart';
import 'package:news_project/data/model/SourcesResponse.dart';
import 'package:path_provider/path_provider.dart';

class CacheSources {
  static Future<void> saveSources(SourcesRespones respones) async {
    final directory = await getApplicationCacheDirectory();

    final collection = await BoxCollection.open("NewsAppV1", {"sources"},
        path: directory.path);
    final sourcesBox = await collection.openBox<Map>("sources");

    await sourcesBox.put("sources", respones.toJson());
    print("save Data");
  }

  static Future<SourcesRespones> getSources() async {
    final directory = await getApplicationCacheDirectory();

    final collection = await BoxCollection.open("NewsAppV1", {"sources"},
        path: directory.path);

    var sourcesBox = await collection.openBox<Map>("sources");

    var respones = await sourcesBox.get("sources");

    print("Get save Data ${respones}");

    return SourcesRespones.fromJson(respones!);
  }
}
