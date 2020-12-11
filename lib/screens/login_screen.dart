import 'package:flu_tic_tac_toe/controllers/auth_controller.dart';
import 'package:flu_tic_tac_toe/controllers/form_controller.dart';
import 'package:flu_tic_tac_toe/widgets/buttons.dart';
import 'package:flu_tic_tac_toe/widgets/dialogs.dart';
import 'package:flu_tic_tac_toe/widgets/inputs.dart';
import 'package:flu_tic_tac_toe/widgets/texts.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String _id = 'login';
  static String get id => _id;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthController _authController;
  FormController _formController;
  Map _user = {
    'email': '',
    'password': '',
  };

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _authController.isAuthenticated().then((value) {
      if (value) {
        Navigator.popAndPushNamed(context, 'home');
      }
    });
    _formController = FormController();
  }

  bool _validateForm() {
    final form = _formKey.currentState;
    bool isValid = form.validate();
    if (isValid) {
      form.save();
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Positioned(
                top: -1 / 9 * MediaQuery.of(context).size.height,
                left: -1 / 3 * MediaQuery.of(context).size.width,
                child: SizedBox(
                  child: Image(
                    image: AssetImage('assets/vectors/login_blob.png'),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Positioned(
                top: 1 / 25 * MediaQuery.of(context).size.height,
                left: 1 / 8 * MediaQuery.of(context).size.width,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Welcome back,',
                          style: Theme.of(context).textTheme.headline6),
                      Text('Log In!',
                          style: Theme.of(context).textTheme.headline1),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1 / 4 * MediaQuery.of(context).size.height,
                    ),
                    Image(
                      image: AssetImage('assets/vectors/login.png'),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LabeledInput(
                            labelText: 'Email',
                            validator: (value) =>
                                _formController.validator(value, 'email'),
                            onSaved: (value) => _user['email'] = value,
                          ),
                          LabeledInput(
                            labelText: 'Password',
                            validator: (value) =>
                                _formController.validator(value, 'password'),
                            secure: true,
                            onSaved: (value) => _user['password'] = value,
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 8.0),
                            width: MediaQuery.of(context).size.width,
                            child: Button(
                              text: 'LOGIN',
                              onPressed: () async {
                                if (_validateForm()) {
                                  Map<String, dynamic> response =
                                  await _authController
                                      .signInWithEmailAndPassword(_user);
                                  if (response['isAuthenticated']) {
                                    Navigator.popAndPushNamed(context, 'home');
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => TheAlert(
                                        title: 'Authentication Failed',
                                        content: response['message'],
                                        buttonText: 'Close',
                                        onPressed: () =>
                                            Navigator.of(context).pop()
                                      )
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.0),
                    Text('Or log in with',
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 8.0),
                    GoogleButton(
                      onPressed: () async {
                        if (await _authController.signInWithGoogle()) {
                          Navigator.popAndPushNamed(context, 'home');
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: AnchorText(
                        leftText: 'Don\'t have account?',
                        rightText: ' Sign Up',
                        onTap: () => Navigator.pushNamed(context, 'sign_up'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
