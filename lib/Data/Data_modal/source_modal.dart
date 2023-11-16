class SourceModal {
  String? landscape;
  String? large;
  String? large2x;
  String? medium;
  String? original;
  String? portrait;
  String? small;
  String? tiny;

  SourceModal({
     this.landscape,
     this.large,
     this.large2x,
     this.medium,
     this.original,
     this.portrait,
     this.small,
     this.tiny,
  });

  factory SourceModal.fromJson(Map<String, dynamic> json) {
    return SourceModal(
      landscape: json['landscape'],
      large: json['large'],
      large2x: json['large2x'],
      medium: json['medium'],
      original: json['original'],
      portrait: json['portrait'],
      small: json['small'],
      tiny: json['tiny'],
    );
  }
}
