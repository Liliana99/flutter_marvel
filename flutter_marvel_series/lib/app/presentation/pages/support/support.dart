import 'package:flutter/material.dart';
import 'package:flutter_marvel_series/app/presentation/utils/i18n.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Text(
            'app.support'.T,
            style: textTheme.headline3.copyWith(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
