import 'package:flu_tic_tac_toe/screens/about_screen.dart';
import 'package:flu_tic_tac_toe/screens/game_screen.dart';
import 'package:flu_tic_tac_toe/screens/home_screen.dart';
import 'package:flu_tic_tac_toe/screens/host_game_screen.dart';
import 'package:flu_tic_tac_toe/screens/join_game_screen.dart';
import 'package:flu_tic_tac_toe/screens/login_screen.dart';
import 'package:flu_tic_tac_toe/screens/profile_screen.dart';
import 'package:flu_tic_tac_toe/screens/signup_screen.dart';
import 'package:flu_tic_tac_toe/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

final kTheme = ThemeData(
  primaryColor: Color(0xffffc803),
  primaryColorDark: Color(0xff300000),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  backgroundColor: Colors.yellow[100],
  fontFamily: 'Nunito',
  textTheme: TextTheme(
    button: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    bodyText1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    bodyText2: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800),
    headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
    headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
    headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w900),
    caption: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
  ).apply(
    bodyColor: Color(0xff300000),
    displayColor: Color(0xff300000),
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(new App()));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: kTheme,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        JoinGameScreen.id: (context) => JoinGameScreen(),
        GameScreen.id: (context) => GameScreen(),
        AboutScreen.id: (context) => AboutScreen(),
        HostGameScreen.id: (context) => HostGameScreen(),
      },
    );
  }
}
