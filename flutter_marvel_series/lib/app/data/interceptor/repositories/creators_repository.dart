import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_marvel_series/app/data/interceptor/models/creators_detail.dart';
import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';
import 'package:flutter_marvel_series/app/data/interceptor/repositories/series_repository.dart';
import 'package:flutter_marvel_series/app/presentation/utils/md5.dart';

import '../constants.dart';

abstract class Methods {
  addItemsCreators(List<CreatorsDetail> creators);
  showError();
  clearList();
  showLoading();
  hideLoading();
}

class CreatorsRepository {
  final itemsPerPage = 20;
  var page = 0;
  var offset = 0;
  var lastTotalReturnedItems = 0;
  var firstCall = true;
  var searchTerm = "";
  Methods view;

  CreatorsRepository(this.view);

  Future<bool> getCreators(
    @required String serieId,
  ) async {
    //(/v1/public/series/{seriesId}/creators)
    final url = Const.baseUrl + '/v1/public/series/${serieId}/creators';
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
          view.addItemsCreators(List<CreatorsDetail>());
        }
      }

      //view.showLoading();
      firstCall = false;
      var response = await Dio().get(url, queryParameters: queryParameters);
      if (response == null) {
        throw CustomException(exception: true);
      } else {
        final jsonValue = jsonDecode(response.toString());
        final object = CreatorsResponse.fromJson(jsonValue);

        this.lastTotalReturnedItems = object.data.count;
        page++;
        view.addItemsCreators(object.data.creators);

        //view.hideLoading();
        return true;
      }
    } catch (e) {
      print("Error" + e.toString());
    }
    return false;
  }
}
