import 'package:flu_tic_tac_toe/controllers/user_controller.dart';
import 'package:flu_tic_tac_toe/models/user.dart';
import 'package:flu_tic_tac_toe/widgets/buttons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String _id = 'home';
  static String get id => _id;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserController _userController;
  User _user = User.empty();

  @override
  void initState() {
    super.initState();
    _userController = UserController();
    _userController.init().then((_) {
      setState(() {
        _user = _userController.user;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -1 / 9 * MediaQuery.of(context).size.height,
              left: -1 / 5 * MediaQuery.of(context).size.width,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/vectors/signup_blob.png'),
              ),
            ),
            Positioned(
              top: 24.0,
              left: 16.0,
              child: Row(
                children: [
                  ProfileButton(
                    onTap: () => Navigator.pushNamed(context, 'profile'),
                  ),
                  Text(
                    'Hi, ${_user.name}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 1 / 4 * MediaQuery.of(context).size.height,
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 16.0),
                    child: Image.asset(
                      'assets/icons/brand.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 32.0),
                        Button(
                          text: 'JOIN GAME',
                          onPressed: () =>
                              Navigator.pushNamed(context, 'join_game'),
                        ),
                        SizedBox(height: 24.0),
                        Button(
                          text: 'HOST GAME',
                          onPressed: () => Navigator.pushNamed(context, 'host_game'),
                        ),
                        SizedBox(height: 24.0),
                        Button(
                          text: 'ABOUT',
                          onPressed: () =>
                              Navigator.pushNamed(context, 'about'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
