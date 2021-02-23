import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';

class CreatorsDetail {
  int id;
  String fullName;
  ThumbnailCrerator thumbail;
  CreatorsDetail({this.id, this.thumbail, this.fullName});

  CreatorsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];

    thumbail = json['thumbnail'] != null
        ? ThumbnailCrerator.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['fullName'] = this.fullName;

    return data;
  }
}
