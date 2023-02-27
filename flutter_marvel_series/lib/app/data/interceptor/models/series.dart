import 'creators_detail.dart';

class SerieResponse {
  SerieResponse(this.data);

  final Data data;

  factory SerieResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError('json must not be null');
    }
    return SerieResponse(Data.fromJson(json['data'] ?? {}));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  factory SerieResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      throw ArgumentError('map must not be null');
    }
    return SerieResponse(Data.fromMap(map['data'] ?? {}));
  }
}


class CreatorsResponse {
  CreatorsResponse(this.data);

  final Data2 data;

  factory CreatorsResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError('json must not be null');
    }
    return CreatorsResponse(Data2.fromJson(json['data'] ?? {}));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }

  factory CreatorsResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) {
      throw ArgumentError('map must not be null');
    }
    return CreatorsResponse(Data2.fromMap(map['data'] ?? {}));
  }
}

class Data {
  Data({this.offset, this.limit, this.total, this.count, this.series});
  final List<Serie> series;
  final int offset;
  final int limit;
  final int total;
  final int count;

  factory Data.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw ArgumentError('json must not be null');
    }
    final seriesJson = json['series'] as List;
    final series = seriesJson != null
        ? seriesJson.map((serieJson) => Serie.fromJson(serieJson)).toList()
        : null;
    return Data(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      series: series,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'offset': offset,
      'limit': limit,
      'total': total,
      'count': count,
    };
    if (series != null) {
      data['series'] = series.map((serie) => serie.toJson()).toList();
    }
    return data;
  }
}

class Data2 {
   Data2({
    required int offset,
    required int limit,
    required int total,
    required int count,
    required List<CreatorsDetail> creators,
  })  : _offset = offset,
        _limit = limit,
        _total = total,
        _count = count,
        _creators = creators;

  final int _offset;
  final int _limit;
  final int _total;
  final int _count;
  final List<CreatorsDetail> _creators;
  factory Data2.fromApiResponse(Map<String, dynamic> json) {
    final List<dynamic>? results = json['results'];
    final creators = results?.map((v) => CreatorsDetail.fromJson(v)).toList() ?? [];

    return Data2(
      offset: json['offset'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      count: json['count'] ?? 0,
      creators: creators,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'offset': _offset,
      'limit': _limit,
      'total': _total,
      'count': _count,
      'creators': _creators.map((creator) => creator.toJson()).toList(),
    };
  }

  int get offset => _offset;

  int get limit => _limit;

  int get total => _total;

  int get count => _count;

  List<CreatorsDetail> get creators => _creators;
}


class Serie {
  final int id;
  final String title;
  final String rating;
  final String description;
  final int pageCount;
  final int startYear;
  final int endYear;
  final Thumbnail thumbnail;
  final Creators creators;

  Serie({
    required this.id,
    required this.title,
    required this.rating,
    required this.description,
    required this.pageCount,
    required this.startYear,
    required this.endYear,
    required this.thumbnail,
    required this.creators,
  });

  factory Serie.fromJson(Map<String, dynamic> json) {
    return Serie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      rating: json['rating'] ?? '',
      description: json['description'] ?? '',
      pageCount: json['pageCount'] ?? 0,
      startYear: json['startYear'] ?? 0,
      endYear: json['endYear'] ?? 0,
      thumbnail: json['thumbnail'] != null ? Thumbnail.fromJson(json['thumbnail']) : Thumbnail(),
      creators: json['creators'] != null ? Creators.fromJson(json['creators']) : Creators(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
      'description': description,
      'pageCount': pageCount,
      'startYear': startYear,
      'endYear': endYear,
      'thumbnail': thumbnail.toJson(),
      'creators': creators.toJson(),
    };
  }
}

class Thumbnail {
  Thumbnail({
    required this.path,
    required this.extension,
  });
  final String path;
  final String extension;

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
      path: json['path'] ?? '',
      extension: json['extension'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'extension': extension,
    };
  }
}

class Images {
  final String path;
  final String extension;

  Images({
    required this.path,
    required this.extension,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      path: json['path'] ?? '',
      extension: json['extension'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'path': path,
      'extension': extension,
    };
  }
}


class Creators {
  Creators({this.collection, this.items, this.available, this.thumbnail});
  final String collection;
  final int available;
  final List<Items> items;
  final ThumbnailCreator thumbnail;

  Creators.fromJson(Map<String, dynamic> json) {
    collection = json['collectionURI'];
    available = json['available'];
    if (json['items'] != null) {
      items = List<Items>();
      json['items'].forEach((s) {
        items.add(Items.fromJson(s));
      });
    }
    thumbnail = json['thumbnail'] != null
        ? ThumbnailCreator.fromJson(json['thumbnail'])
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

class ThumbnailCreator {
  ThumbnailCreator({this.path, this.extension});
  final String path;
  final String extension;

  ThumbnailCreator.fromJson(Map<String, dynamic> json) {
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
  Items({this.resourceURI, this.name, this.role});

  final String resourceURI;
  final String name;
  final String role;

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      resourceURI: json['resourceURI'],
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['resourceURI'] = resourceURI;
    data['name'] = name;
    data['role'] = role;
    return data;
  }
}

