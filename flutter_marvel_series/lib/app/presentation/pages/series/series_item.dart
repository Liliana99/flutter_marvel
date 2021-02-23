import 'package:flutter/material.dart';

import 'package:flutter_marvel_series/app/data/interceptor/models/series.dart';

import 'package:flutter_marvel_series/app/presentation/pages/series/serie_detail.dart';
import 'package:flutter_marvel_series/app/services/fetch_image.dart';

class SeriesListItem extends StatelessWidget {
  SeriesListItem({this.result});

  final Serie result;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Inicia evento del bloc

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SerieDetail(result: result),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(new Radius.circular(8.0)),
        ),
        color: Colors.white,
        elevation: 5.0,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Image(
                  image: NetworkImageWithRetry(
                    result.thumbnail.path + "." + result.thumbnail.extension,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 50),
              height: 50,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 2.0,
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 80, maxHeight: 35),
                      height: 35,
                      child: Text(
                        result.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Text(result.rating, style: TextStyle(fontSize: 10)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
