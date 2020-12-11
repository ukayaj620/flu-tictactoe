import 'package:flu_tic_tac_toe/controllers/auth_controller.dart';
import 'package:flu_tic_tac_toe/controllers/user_controller.dart';
import 'package:flu_tic_tac_toe/models/user.dart';
import 'package:flu_tic_tac_toe/widgets/buttons.dart';
import 'package:flu_tic_tac_toe/widgets/headers.dart';
import 'package:flu_tic_tac_toe/widgets/icons.dart';
import 'package:flu_tic_tac_toe/widgets/lists.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  static const String _id = 'profile';
  static String get id => _id;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserController _userController;
  AuthController _authController;
  User _user = User.empty();

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _userController = UserController();
    _userController.init().then((_) {
      setState(() {
        _user = _userController.user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
              children: [
                Positioned(
                  top: -1 / 5 * MediaQuery.of(context).size.height,
                  left: -1 / 4 * MediaQuery.of(context).size.width,
                  child: SizedBox(
                    width: 3 / 2 * MediaQuery.of(context).size.width,
                    child: Image.asset('assets/vectors/profile_blob.png'),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                  child: Column(
                    children: [
                      Header(label: 'Profile'),
                      SizedBox(height: 24.0),
                      TheIcon('profile', xl: true),
                      SizedBox(height: 8.0),
                      Text(
                        _user.name,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 40.0),
                      ..._user.toProfileData().map((profile) {
                        return InformationList(
                          icon: profile['icon'],
                          label: profile['label'],
                          value: profile['value'],
                        );
                      }).toList(),
                      SizedBox(height: 32.0),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Button(
                              text: 'View History',
                              onPressed: () {
                                print('see history');
                              },
                            ),
                            SizedBox(height: 16.0),
                            Button(
                              text: 'Log Out',
                              onPressed: () async {
                                await _authController.logout();
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'login', (route) => false);
                              },
                              color: Colors.red,
                              dark: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
