import 'package:flutter/material.dart';
import 'package:lividcode/mainScreen/SelectUser.dart';

void main() => runApp(LividApp());

class LividApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(47, 44, 66, 1.0)),
      home: SelectUser(),
      initialRoute: '/',
      routes: {},
    );
  }
}
