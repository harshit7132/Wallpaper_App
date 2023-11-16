import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nebulae/Api/api_helper.dart';
import 'package:nebulae/Api/my_exception.dart';
import 'package:nebulae/Data/Data_modal/data_modal.dart';

import '../../../Api/urls.dart';

part 'event_search_api_integration.dart';
part 'state_search_api_integration.dart';

class SearchApiBloc extends Bloc<SearchApiEvent, SearchApiState> {
  ApiHelper apiHelper;
  SearchApiBloc({required this.apiHelper}) : super(SearchApiInitialState()) {
    on<GetSearchWallpaper>((event, emit) async {
      emit(SearchWallpaperLoadingState());
      try {
        var res = await apiHelper.getApiData(
            url: "${Urls.searchWallpaper}?query=${event.query}&per_page=20&page =${event.pageNo}");
        emit(SearchWallpaperLoadedState(
            dataPhotoModal: DataModal.fromJson(res)));
      } catch (e) {
        emit(
            SearchWallpaperErrorState(errorMsg: (e is MyException).toString()));
      }
    });
  }
}
