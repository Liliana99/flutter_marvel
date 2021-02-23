import 'package:flutter/material.dart';
import 'package:flutter_marvel_series/app/data/interceptor/models/creators_detail.dart';
import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';
import 'package:flutter_marvel_series/app/data/interceptor/repositories/creators_repository.dart';
import 'package:flutter_marvel_series/app/presentation/utils/get_size_screen.dart';

import 'package:extended_image/extended_image.dart';
import 'package:flutter_marvel_series/app/services/fetch_image.dart';

class SerieDetail extends StatefulWidget {
  final Serie result;
  const SerieDetail({Key key, this.result}) : super(key: key);

  @override
  _SerieDetailState createState() => _SerieDetailState();
}

class _SerieDetailState extends State<SerieDetail> implements Methods {
  CreatorsRepository _repo;
  bool _data = false;
  var _creators = List<CreatorsDetail>();
  var isLoading = false;

  Future<bool> _getCreators() async {
    _data = await _repo.getCreators(widget.result.id.toString());
    setState(() {
      _data = _data;
    });
    return _data;
  }

  @override
  void initState() {
    super.initState();
    this._repo = CreatorsRepository(this);
    _getCreators();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
              _buildImage(context),

              //createButtonRefresh(),
            ];
          },
          body: _data
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _buildMoviesChildsGrid(),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Widget _text() {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          child: Text('Creators', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildMoviesChildsGrid() {
    return GridView.builder(
        padding: EdgeInsets.only(top: 8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 0.0,
          childAspectRatio: 4.55,
        ),
        itemCount: _creators.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          return ListTile(
            leading: ClipOval(
              child: Image(
                image: NetworkImageWithRetry(
                  _creators[index].thumbail.path +
                      "." +
                      _creators[index].thumbail.extension,
                ),
                fit: BoxFit.fill,
              ),
            ),
            title: Text(_creators[index].fullName ?? '',
                style: TextStyle(color: Colors.white)),
          );
        });
  }

  SliverToBoxAdapter _buildImage(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        width: screenWidth(context),
        height: screenHeight(context) * 0.40,
        child: ExtendedImage.network(
          widget.result.thumbnail.path +
              "." +
              widget.result.thumbnail.extension,
          width: screenWidth(context) * 0.70,
          height: screenHeight(context) * 0.50,
          fit: BoxFit.fill,
          cache: true,
          border: Border.all(color: Colors.red, width: 1.0),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
      ),
    );
  }

  @override
  addItemsCreators(List<CreatorsDetail> creators) {
    setState(() {
      this._creators.addAll(creators);
    });
  }

  @override
  clearList() {
    setState(() {
      this._creators.clear();
    });
  }

  @override
  hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  showError() {
    // TODO: implement showError
    throw UnimplementedError();
  }

  @override
  showLoading() async {
    _data = await _repo.getCreators(widget.result.id.toString());
    if (mounted)
      setState(() {
        _data = _data;
      });
  }
}
