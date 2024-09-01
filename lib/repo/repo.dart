import '../data/model/NewsDataRespones.dart';
import '../data/model/SourcesResponse.dart';

abstract class HomeRepo {
  Future<SourcesRespones> getSources(String id);

  Future<NewsDataResponse> getNewsData(String sourceID);
}
