// ignore_for_file: non_constant_identifier_names

import 'package:nebulae/Data/Data_modal/source_modal.dart';

class PhotoModal {
  int? id;
  int? photographer_id;
  num? width;
  num? height;
  String? url;
  String? photographer;
  String? photographer_url;
  String? avg_color;
  String? alt;
  bool? liked;
  SourceModal? src;

  PhotoModal({
     this.alt,
     this.avg_color,
     this.height,
     this.id,
     this.liked,
     this.photographer,
     this.photographer_id,
     this.photographer_url,
     this.url,
     this.width,
     this.src,
  });

  factory PhotoModal.fromJson(Map<String, dynamic> json) {
    return PhotoModal(
      alt: json['alt'],
      avg_color: json['avg_color'],
      height: json['height'],
      id: json['id'],
      liked: json['liked'],
      photographer: json['photographer'],
      photographer_id: json['photographer_id'],
      photographer_url: json['photographer_url'],
      url: json['url'],
      width: json['width'],
      src: SourceModal.fromJson(json['src']),
    );
  }
}
