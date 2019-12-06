import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sales/utils/navigator.dart';
import 'package:splashscreen/splashscreen.dart';

import 'login.dart';

Future<bool> getSession() async {
  bool active_login;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.getBool('session') == null || preferences.getBool('session') == false ? active_login = false : active_login = true;
  return active_login;
}

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key : key);

  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool session;
  @override
  void initState() {
    super.initState();
    getSession().then(updateSession);
    Timer(Duration(seconds: 3), () => session ?  MyNavigator.goToHome(context) : MyNavigator.goToLogin(context));
  }

  void updateSession(bool session) {
    setState(() {
      this.session = session;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Login(),
      title: Text('Sales app', style: TextStyle(fontSize: 15),),
      image: Image.network('https://banner2.cleanpng.com/20180519/zci/kisspng-raccoon-t-shirt-logo-brand-giant-panda-5b009586461571.9537690715267649342871.jpg'),
      backgroundColor: Color(0xFF8185E2),
      styleTextUnderTheLoader: TextStyle(),
      photoSize: 100.0,
      onClick: ()=> print('Clic!'),
      loaderColor: Colors.white,
    );
  }

}