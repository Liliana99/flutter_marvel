import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';
import 'package:flutter_marvel_series/app/data/interceptor/repositories/series_repository.dart';

import 'package:flutter_marvel_series/app/presentation/pages/series/series_item.dart';
import 'package:flutter_marvel_series/app/presentation/utils/convert_string_Upper.dart';
import 'package:flutter_marvel_series/app/presentation/utils/get_size_screen.dart';
import 'package:flutter_marvel_series/app/presentation/utils/series_view_methods.dart';
import 'package:flutter_marvel_series/app/presentation/widgets/drawer_main.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class SeriesPage extends StatefulWidget {
  SeriesPage({Key key}) : super(key: key);

  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> implements SeriesView {
  SeriesRepository repo;
  var _search = false;
  var _data = false;
  var series = List<Serie>();
  var _editTextController = TextEditingController();
  var isLoading = false;
  final ScrollController scrollController = ScrollController();
  int currentPageNumber;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  toggleDrawer() async {
    if (_scaffoldKey.currentState.isDrawerOpen) {
      _scaffoldKey.currentState.openEndDrawer();
    } else {
      _scaffoldKey.currentState.openDrawer();
    }
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    repo.refresh();
    _data = await repo.getSeries();
    setState(() {
      _data = _data;
    });
  }

  void _onLoading() async {
    // monitor network fetch

    // if failed,use loadFailed(),if no data return,use LoadNodata()
    repo.refresh();
    _data = await repo.getSeries();
    if (mounted)
      setState(() {
        _data = _data;
      });
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    this.repo = SeriesRepository(this);
    repo.getSeries().then((value) {
      if (mounted)
        setState(() {
          _data = value;
        });
    });
  }

  Widget _text() {
    return SliverToBoxAdapter(
      child: Center(
        child: Container(
          child: Text('Pull to refresh', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  SliverAppBar createSilverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.black,
      pinned: true,
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          controller: _editTextController,
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          textAlign: TextAlign.center,
          onSubmitted: (text) {
            setState(() {
              _search = !_search;
            });
            _prepareSearch();
            FocusScope.of(context).requestFocus(FocusNode());
          },
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          suffix: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: NotificationListener(
          onNotification: onNotification,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: _data
                ? _buildListMovies(context)
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          )),
      drawer: CustomDrawer(
        closeDrawer: () => toggleDrawer(),
      ),
    );
  }

  Widget _buildSmartRefresher(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      physics: BouncingScrollPhysics(),
      header: WaterDropHeader(
        waterDropColor: Theme.of(context).primaryColor,
        completeDuration: Duration(milliseconds: 500),
      ),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 50.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: _buildMoviesChildsGrid(),
    );
  }

  NestedScrollView _buildListMovies(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
        return <Widget>[
          createSilverAppBar(),
          _text(),
          //createButtonRefresh(),
        ];
      },
      body: _buildSmartRefresher(context),
    );
  }

  Widget _buildMoviesChildsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: FutureBuilder(builder: (context, projectSnap) {
        if (projectSnap.connectionState == ConnectionState.none &&
            projectSnap.hasData == null) {
          return Center(
            child: Container(
              child: Text('No hay datos'),
            ),
          );
        }

        return GridView.builder(
            padding: EdgeInsets.only(top: 8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.75,
                crossAxisSpacing: 5.5,
                mainAxisSpacing: 20),
            controller: scrollController,
            itemCount: series.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return SeriesListItem(result: series[index]);
            });
        future:
        repo.getSeries();
      }),
    );
  }

  @override
  addItems(List<Serie> series) {
    setState(() {
      this.series.addAll(series);
    });
  }

  @override
  clearList() {
    setState(() {
      this.series.clear();
      this._editTextController.clear();
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
    print("Error encontrado");
  }

  @override
  showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  _prepareSearch() {
    if (_editTextController.text.length > 2) {
      String value = convertString(_editTextController.text);
      repo.searchCharacters(value);
    } else {
      //Avisar usuario no es valido el input
    }
  }

  bool onNotification(ScrollNotification notification) {
    print("Notification");

    if (notification is ScrollUpdateNotification) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (!isLoading) {
          repo.getSeries();
        }
      }
    }

    return true;
  }

  @override
  addItemsCreators(List<Creators> creators) {
    // TODO: implement addItemsCreators
    throw UnimplementedError();
  }
}
