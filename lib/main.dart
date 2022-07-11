import 'package:flutter/material.dart';
import 'package:genshin_impact/Src/Screens/SplashScreen.dart';
import 'package:genshin_impact/Src/Screens/DetailScreen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/detail': (BuildContext context){
          return DetailScreen();
        }
      },
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
