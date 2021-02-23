import 'creators_detail.dart';

class SerieResponse {
  Data data;

  SerieResponse(this.data);

  SerieResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CreatorsResponse {
  Data2 data;

  CreatorsResponse(this.data);

  CreatorsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data2.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int offset;
  int limit;
  int total;
  int count;
  List<Serie> series;

  Data({this.offset, this.limit, this.total, this.count, this.series});

  Data.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      series = List<Serie>();
      json['results'].forEach((v) {
        series.add(Serie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.series != null) {
      data['results'] = this.series.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data2 {
  int offset;
  int limit;
  int total;
  int count;
  List<CreatorsDetail> creators;

  Data2({this.offset, this.limit, this.total, this.count, this.creators});

  Data2.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    limit = json['limit'];
    total = json['total'];
    count = json['count'];
    if (json['results'] != null) {
      creators = List<CreatorsDetail>();
      json['results'].forEach((v) {
        creators.add(CreatorsDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['limit'] = this.limit;
    data['total'] = this.total;
    data['count'] = this.count;
    if (this.creators != null) {
      data['results'] = this.creators.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Serie {
  int id;
  String title;
  String rating;
  String description;
  int pageCount;
  int startYear;
  int endYear;
  Thumbnail thumbnail;
  Creators creators;

  Serie(
      {this.id,
      this.title,
      this.rating,
      this.description,
      this.pageCount,
      this.startYear,
      this.endYear,
      this.thumbnail,
      this.creators});

  Serie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    rating = json['rating'];
    description = json['description'];
    pageCount = json['pageCount'];
    startYear = json['startYear'];
    endYear = json['endYear'];
    creators =
        json['creators'] != null ? Creators.fromJson(json['creators']) : null;

    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['pageCount'] = this.pageCount;
    data['startYear'] = this.startYear;
    data['endYear'] = this.endYear;
    return data;
  }
}

class Thumbnail {
  String path;
  String extension;

  Thumbnail({this.path, this.extension});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}

class Images {
  String path;
  String extension;
  Images({this.path, this.extension});
  Images.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}

class Creators {
  String collection;
  int available;
  List<Items> items;
  ThumbnailCrerator thumbail;
  Creators({this.collection, this.items, this.available, this.thumbail});

  Creators.fromJson(Map<String, dynamic> json) {
    collection = json['collectionURI'];
    available = json['available'];
    if (json['items'] != null) {
      items = List<Items>();
      json['items'].forEach((s) {
        items.add(Items.fromJson(s));
      });
    }
    thumbail = json['thumbnail'] != null
        ? ThumbnailCrerator.fromJson(json['thumbnail'])
        : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.collection;
    data['available'] = this.available;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ThumbnailCrerator {
  String path;
  String extension;

  ThumbnailCrerator({this.path, this.extension});

  ThumbnailCrerator.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    extension = json['extension'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['extension'] = this.extension;
    return data;
  }
}

class Items {
  String uri;
  String name;
  String role;

  Items({this.uri, this.name, this.role});

  Items.fromJson(Map<String, dynamic> json) {
    uri = json['resourceURI'];
    name = json['name'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resourceURI'] = this.uri;
    data['name'] = this.name;
    data['role'] = this.role;
    return data;
  }
}
