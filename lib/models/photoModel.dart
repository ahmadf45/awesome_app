class PhotoModel {
  final int page;
  final int perPage;
  List<Photos> photos;

  PhotoModel({this.page, this.perPage, this.photos});

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        page: json['page'] as int,
        perPage: json['per_page'] as int,
        photos: new List<Photos>.from(
            json["photos"].map((x) => Photos.fromJson(x))));
  }
}

class Photos {
  final int id;
  final int width;
  final int height;
  final String photographer;
  final String photographerUrl;
  final Src src;

  Photos(
      {this.id,
      this.width,
      this.height,
      this.photographer,
      this.photographerUrl,
      this.src});

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
        id: json['id'] as int,
        width: json['width'] as int,
        height: json['height'] as int,
        photographer: json['photographer'] as String,
        photographerUrl: json['photographer_url'] as String,
        src: json['src'] != null ? new Src.fromJson(json['src']) : null);
  }
}

class Src {
  final String large;
  final String medium;
  final String small;

  Src({this.large, this.medium, this.small});

  factory Src.fromJson(Map<String, dynamic> json) {
    return Src(
        large: json['large'] as String,
        medium: json['medium'] as String,
        small: json['small'] as String);
  }
}
