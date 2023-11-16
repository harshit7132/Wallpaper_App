// ignore_for_file: non_constant_identifier_names

import 'package:nebulae/Data/Data_modal/photo_modal.dart';

class DataModal {
  int? page;
  int? per_page;
  int? total_results;
  String? next_page;
  List<PhotoModal>? photos;

  DataModal(
      {this.page,
      this.next_page,
      this.photos,
      this.per_page,
      this.total_results});

  factory DataModal.fromJson(Map<String, dynamic> json) {
    List<PhotoModal> mPhotos = [];
    for (Map<String, dynamic> eachPic in json['photos']) {
      mPhotos.add(PhotoModal.fromJson(eachPic));
    }

    return DataModal(
      page: json['page'],
      per_page: json['per_page'],
      total_results: json['total_results'],
      next_page: json['next_page'],
      photos: mPhotos,
    );
  }
}
