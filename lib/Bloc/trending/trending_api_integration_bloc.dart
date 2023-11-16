// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nebulae/Api/api_helper.dart';
import 'package:nebulae/Api/my_exception.dart';
import 'package:nebulae/Api/urls.dart';
import 'package:nebulae/Data/Data_modal/data_modal.dart';
part 'event_trending_api_integration.dart';
part 'state_trending_api_integration.dart';

class TrendingWalpaperBloc
    extends Bloc<TrendingWallpaperEvent, TrendingWallpaperState> {
  ApiHelper apiHelper;
  TrendingWalpaperBloc({required this.apiHelper})
      : super(TrendingWallpaperInitialState()) {
    on<GetTrendingWallpaper>((event, emit) async {
      emit(TrendingWallpaperLoadingState());
      try {
        var res = await apiHelper.getApiData(url: Urls.trendingWallpaper);
        emit(TrendingWallpaperLoadedState(
            dataPhotoModal: DataModal.fromJson(res)));
      } catch (e) {
        if (e is FetchDataException) {
          emit(TrendingWallpaperInternetErrorState(errorMsg: e.ToString()));
        } else {
          emit(TrendingWallpaperErrorState(
              errorMsg: (e is MyException) ? e.ToString() : 'Unkknown Error'));
        }
      }
    });
  }
}
