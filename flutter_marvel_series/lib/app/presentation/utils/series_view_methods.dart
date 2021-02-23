import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';

abstract class SeriesView {
  addItems(List<Serie> series);
  addItemsCreators(List<Creators> creators);
  showError();
  clearList();
  showLoading();
  hideLoading();
}
