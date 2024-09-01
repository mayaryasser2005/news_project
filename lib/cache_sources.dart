import 'package:hive/hive.dart';
import 'package:news_project/data/model/SourcesResponse.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
    final collection =
        await BoxCollection.open("NewsAppV1", {"sources"}, path: "./");
    final sourcesBox = await collection.openBox<Map>("sources");

    Map<String, dynamic> respones =
        await sourcesBox.get("sources") as Map<String, dynamic>;

    return SourcesRespones.fromJson(respones);
  }

  static Future<bool> repestPermission() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }
}
