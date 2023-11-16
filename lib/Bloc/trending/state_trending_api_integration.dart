// ignore_for_file: must_be_immutable

part of 'trending_api_integration_bloc.dart';

@immutable
sealed class TrendingWallpaperState {}

final class TrendingWallpaperInitialState extends TrendingWallpaperState {}

final class TrendingWallpaperLoadingState extends TrendingWallpaperState {}

final class TrendingWallpaperLoadedState extends TrendingWallpaperState {
  DataModal dataPhotoModal;
  TrendingWallpaperLoadedState({required this.dataPhotoModal});
}

final class TrendingWallpaperErrorState extends TrendingWallpaperState {
  String errorMsg;

  TrendingWallpaperErrorState({required this.errorMsg});
}
class TrendingWallpaperInternetErrorState extends TrendingWallpaperState {
  String errorMsg;
  TrendingWallpaperInternetErrorState({required this.errorMsg});
}
