import 'package:firebase_auth/firebase_auth.dart';

import './screen/auth_screen.dart';
import './screen/splash_screen.dart';
import './screen/chat_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color =
    {
      50:Color.fromRGBO (10 , 8 , 39 , .1),
      100:Color.fromRGBO(10 , 8 , 39 , .2),
      200:Color.fromRGBO(10 , 8 , 39 ,.3),
      300:Color.fromRGBO(10 , 8 , 39 ,.4),
      400:Color.fromRGBO(10 , 8 , 39 ,.5),
      500:Color.fromRGBO(10 , 8 , 39 , .6),
      600:Color.fromRGBO(10 , 8 , 39 , .7),
      700:Color.fromRGBO(10 , 8 , 39 , .8),
      800:Color.fromRGBO(10 , 8 , 39 , .9),
      900:Color.fromRGBO(10 , 8 , 39 , 1),
    };
    MaterialColor colorCustom = MaterialColor(0xFF0a0827, color);
    return MaterialApp(
      title: 'Ping Pong',
      theme: ThemeData(
        primarySwatch: colorCustom,
        backgroundColor: Colors.pink,
        accentColor: colorCustom[600],
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: colorCustom[500],
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamBuilder(
        // هنا سيتم ملاحقة اي تغير على تسجيل الدخول او الخروج او حالة ال token
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (ctx, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return SplashScreen();
            }
          if(snapshot.hasData)
            {
              return ChatScreen();
            }
          return AuthScreen();
        },
      ),
    );
  }
}
