import 'package:flutter/cupertino.dart';

String convertString(String value) {
  //Apartir de 2 lenght
  String inCaps = '${value[0].toUpperCase()}${value.substring(1)}';

  inCaps = '${inCaps.substring(0, 2)}';
  print(inCaps);
  return inCaps;
}
