import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_project/bloc/states.dart';

import '../data/model/NewsDataRespones.dart';
import '../data/model/SourcesResponse.dart';
import '../repo/repo.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeRepo repo;

  HomeCubit(this.repo) : super(HomeinitStates());

  static HomeCubit get(context) => BlocProvider.of(context);
  int selectedTapIndex = 0;
  SourcesRespones? sourcesResponse;

  NewsDataResponse? newsDataRespones;

  changeSource(int value) {
    selectedTapIndex = value;
    emit(HomeChageState());
  }

  Future<void> getSources(String id) async {
    try {
      emit(HomeGetSoursesLoadingStates());

      sourcesResponse = await repo.getSources(id);

      emit(HomeGetSoursesSuccessStates());
      getNewsData(sourcesResponse?.sources?[selectedTapIndex].id ?? "");
    } catch (e) {
      emit(HomeGetSoursesErrorStates());
    }
  }

  Future<void> getNewsData(String sourceID) async {
    try {
      emit(HomeGetNewsLoadingStates());

      newsDataRespones = await repo.getNewsData(sourceID);

      emit(HomeGetNewsSuccessStates());
    } catch (e) {
      emit(HomeGetNewsErrorStates());
    }
  }
}
