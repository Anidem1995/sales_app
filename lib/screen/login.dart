import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sales/net/httphandler.dart';
import 'package:sales/screen/home.dart';
import 'package:sales/utils/delayed_animation.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:circular_check_box/circular_check_box.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
    duration: Duration(
      milliseconds: 200,
    ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {
      });
    });
    super.initState();
  }

  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8185E2),
        ),
      ),
    ),
  );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    _showMessage(String text) {
      final snackBar = SnackBar(
        content: Text(text),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.blueGrey,
      );
      _globalKey.currentState.showSnackBar(snackBar);
    }

    _login() async {
      String status = await HttpHandler().atemptLogin(userController.text, passwordController.text);

      if (!status.isEmpty) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        if (isChecked) {
          preferences.setBool('session',  true);
          preferences.setString('username', userController.text);
          preferences.setString('access_token', status.split(",")[0].split(":")[1]);
        } else {
          preferences.setString('username', userController.text);
          preferences.setString('access_token', status.split(",")[0].split(":")[1]);
        }
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false
        );
      } else _showMessage('Nombre de usuario o contraseña incorrectos');
    }

    final username = TextFormField(
      controller: userController,
      style: TextStyle(
          fontSize: 20.0,
          color: Colors.white
      ),
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration.collapsed(
          hintText: 'Username',
          hintStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white
          )
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      style: TextStyle(
          fontSize: 20.0,
          color: Colors.white
      ),
      keyboardType: TextInputType.text,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration.collapsed(
          hintText: 'Password',
          hintStyle: TextStyle(
            fontSize: 20.0,
            color: Colors.white
          )
      ),
    );

    final login_button = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => _login(),
          color: Colors.lightBlueAccent,
          child: Text(
            'Iniciar sesión',
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
      ),
    );

    final remember_check = CircularCheckBox(
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
        });
      },
    );

    final avatarGlow = AvatarGlow(
      endRadius: 90,
      duration: Duration(seconds: 2),
      glowColor: Colors.white24,
      repeat: true,
      repeatPauseDuration: Duration(seconds: 2),
      startDelay: Duration(seconds: 1),
      child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            child: FlutterLogo(
              size: 50.0,
            ),
            radius: 50.0,
          )
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _globalKey,
        backgroundColor: Color(0xFF8185E2),
        body: Center(
          child: Column(
            children: <Widget>[
              avatarGlow,
              SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                child: username,
                delay: delayedAmount + 1000,
              ),
              SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                child: password,
                delay: delayedAmount + 2000,
              ),
              SizedBox(
                height: 70.0,
              ),
              DelayedAnimation(
                child: GestureDetector(
                  onTap: _login,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
                delay: delayedAmount + 3000,
              ),
              DelayedAnimation(
                child: Row(
                  children: <Widget>[
                    Text(
                      'Remember me',
                      style: TextStyle(fontSize: 20.0, color: color),
                    ),
                    remember_check
                  ],
                ),
                delay: delayedAmount + 3000,
              )
            ],
          ),
        ),
      ),
    );
  }
}