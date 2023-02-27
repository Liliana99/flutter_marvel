import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';

class CreatorsDetail {
  int id;
  String fullName;
  ThumbnailCreator thumbnail;

  CreatorsDetail({this.id, this.fullName, this.thumbnail});

  CreatorsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id']??'';
    fullName = json['fullName']??'';

    thumbnail = json['thumbnail'] != null
        ? ThumbnailCreator.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['fullName'] = fullName;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail.toJson();
    }

    return data;
  }

  int get creatorId => id;
  set creatorId(int id) => this.id = id;

  String get creatorName => fullName;
  set creatorName(String name) => this.fullName = name;

  ThumbnailCreator get creatorThumbnail => thumbnail;
  set creatorThumbnail(ThumbnailCreator thumbnail) =>
      this.thumbnail = thumbnail;

  @override
  String toString() {
    return 'CreatorsDetail{id: $id, fullName: $fullName, thumbnail: $thumbnail}';
  }
}
