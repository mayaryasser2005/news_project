import 'package:news_project/cache_sources.dart';
import 'package:news_project/data/model/NewsDataRespones.dart';
import 'package:news_project/data/model/SourcesResponse.dart';
import 'package:news_project/repo/repo.dart';

class HomeLocalDsImpl implements HomeRepo {
  @override
  Future<NewsDataResponse> getNewsData(String sourceID) {
    // TODO: implement getNewsData
    throw UnimplementedError();
  }

  @override
  Future<SourcesRespones> getSources(String id) async {
    SourcesRespones respones = await CacheSources.getSources();

    return respones;
  }
}
