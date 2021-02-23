import 'package:flutter/material.dart';
import 'package:flutter_marvel_series/app/presentation/pages/series/series_page.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //Funcion para abrir automaticamente la página principal
  Future<void> _openScreen(BuildContext context) async {
    try {
      if (mounted) {
        Future.delayed(const Duration(seconds: 2), () {
          //SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SeriesPage()),
            ModalRoute.withName('/'),
          );
        });
      }
    } on Exception catch (e) {
      print('Exception details:\n $e');
      // ignore: avoid_catches_without_on_clauses
    } catch (e, s) {
      print('Exception details:\n $e');
      print('Stack trace:\n $s');
    } finally {
      print('finally Open Welcome');
    }
  }

  @override
  void initState() {
    super.initState();
    _openScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: SizedBox(
                height: 5.0,
              ),
            ),
            Container(
              child: Text('SERIES',
                  style: TextStyle(color: Colors.green, fontSize: 30)),
            ),
            Expanded(child: Image.asset('assets/images/giphy_marvel.gif')),
          ],
        ),
      ),
    );
  }
}
