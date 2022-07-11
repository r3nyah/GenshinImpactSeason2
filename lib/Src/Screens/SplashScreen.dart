import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:genshin_impact/Src/Screens/HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: HomeGenshin(),
      duration: 3500,
      //text: 'Genshin Impact',
      imageSrc: 'https://pbs.twimg.com/profile_images/1493013339517202434/rosL8p8t_400x400.jpg',
      textStyle: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold
      ),
    );
  }
}
