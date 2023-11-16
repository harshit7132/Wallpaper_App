// ignore_for_file: must_be_immutable

part of 'search_api_integration_bloc.dart';

@immutable
sealed class SearchApiState {}

final class SearchApiInitialState extends SearchApiState {}

final class SearchWallpaperLoadingState extends SearchApiState {}

final class SearchWallpaperLoadedState extends SearchApiState {
  DataModal dataPhotoModal;
  SearchWallpaperLoadedState({required this.dataPhotoModal});
}

final class SearchWallpaperErrorState extends SearchApiState {
  String errorMsg;

  SearchWallpaperErrorState({required this.errorMsg});
}
class SearchWallpaperInternetErrorState extends SearchApiState {
  String errorMsg;
  SearchWallpaperInternetErrorState({required this.errorMsg});
}