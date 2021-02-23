import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dio/dio.dart';

import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';

import 'package:flutter_marvel_series/app/presentation/utils/series_view_methods.dart';
import '../constants.dart';

class CustomException {
  final bool exception;
  CustomException({this.exception = false});
}

class SeriesRepository {
  final itemsPerPage = 20;
  final url = Const.baseUrl + "/v1/public/series";

  var page = 0;
  var offset = 0;
  var lastTotalReturnedItems = 0;
  var firstCall = true;
  var searchTerm = "";
  SeriesView view;

  SeriesRepository(this.view);

  Future<bool> getSeries() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final hash =
        generateMd5(timestamp + Keys.privateKey + Keys.publicKey).toString();

    try {
      offset = (page * itemsPerPage);
      Map<String, dynamic> queryParameters = {
        "apikey": Keys.publicKey,
        "hash": hash,
        "ts": timestamp,
        "limit": itemsPerPage.toString(),
        "offset": offset.toString()
      };

      if (this.searchTerm.isNotEmpty && searchTerm != null) {
        queryParameters['titleStartsWith'] = searchTerm;
      }

      if (!firstCall) {
        if (this.lastTotalReturnedItems < itemsPerPage) {
          view.addItems(List<Serie>());
        }
      }

      view.showLoading();
      firstCall = false;
      var response = await Dio().get(url, queryParameters: queryParameters);
      if (response == null) {
        throw CustomException(exception: true);
      } else {
        final jsonValue = jsonDecode(response.toString());
        final object = SerieResponse.fromJson(jsonValue);

        this.lastTotalReturnedItems = object.data.count;
        page++;
        view.addItems(object.data.series);

        view.hideLoading();
        return true;
      }
    } catch (e) {
      print("Error" + e.toString());
    }
    return false;
  }

  void searchCharacters([String searchTerm = ""]) async {
    refresh();
    this.searchTerm = searchTerm;
    getSeries();
  }

  generateMd5(String data) {
    var content = Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  void refresh() {
    this.page = 0;
    this.offset = 0;
    this.lastTotalReturnedItems = 0;
    this.firstCall = true;
    this.searchTerm = "";
    if (view != null) view.clearList();
  }
}
