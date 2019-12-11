import 'package:flutter/material.dart';
import 'package:sales/screen/clients.dart';
import 'package:sales/screen/create_client.dart';
import 'package:sales/screen/splash.dart';
import 'package:sales/screen/home.dart';
import 'package:sales/screen/login.dart';
import 'package:flutter/services.dart';
import 'dart:async';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
  "/login": (BuildContext context) => Login(),
  "/clients": (BuildContext context) => Clients(),
  "/createClient": (BuildContext context) => CreateClient()
};

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Cinema());
}

class Cinema extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: routes,
      theme: ThemeData(
        fontFamily: 'RobotoRegular'
      ),
    );
  }
}