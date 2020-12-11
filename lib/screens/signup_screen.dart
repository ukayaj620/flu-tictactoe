import 'package:flu_tic_tac_toe/controllers/auth_controller.dart';
import 'package:flu_tic_tac_toe/controllers/form_controller.dart';
import 'package:flu_tic_tac_toe/widgets/buttons.dart';
import 'package:flu_tic_tac_toe/widgets/inputs.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  static const String _id = 'sign_up';
  static String get id => _id;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  AuthController _authController;
  FormController _formController;

  @override
  void initState() {
    super.initState();
    _authController = AuthController();
    _formController = FormController();
  }

  Map _user = {
    "name": '',
    "nickname": '',
    "email": '',
    "password": '',
  };

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
                top: 24.0,
                left: 16.0,
                child: UpButton(),
              ),
              Positioned(
                top: -1 / 9 * MediaQuery.of(context).size.height,
                right: -1 / 3 * MediaQuery.of(context).size.width,
                child: SizedBox(
                  child: Image(
                    image: AssetImage('assets/vectors/signup_blob.png'),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Positioned(
                  top: 1 / 20 * MediaQuery.of(context).size.height,
                  right: 1 / 8 * MediaQuery.of(context).size.width,
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('Let\'s',
                            style: Theme.of(context).textTheme.headline6),
                        Text('Sign Up!',
                            style: Theme.of(context).textTheme.headline1),
                      ],
                    ),
                  )),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1 / 4 * MediaQuery.of(context).size.height,
                    ),
                    Image(image: AssetImage('assets/vectors/signup.png')),
                    SizedBox(
                      height: 16.0,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          LabeledInput(
                            labelText: 'Name',
                            validator: (value) =>
                                _formController.validator(value, 'name'),
                            onSaved: (value) => _user['name'] = value,
                          ),
                          LabeledInput(
                            labelText: 'Nick Name (max. 8 character long)',
                            validator: (value) =>
                                _formController.validator(value, 'nick name', 8),
                            onSaved: (value) => _user['nickname'] = value,
                          ),
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
                            margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 12.0),
                            width: MediaQuery.of(context).size.width,
                            child: Button(
                              text: 'SIGN UP',
                              onPressed: () async {
                                if (_validateForm()) {
                                  await _authController
                                      .registerWithEmailAndPassword(_user);
                                  Navigator.pushNamed(context, 'login');
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('Or sign up with',
                        style: Theme.of(context).textTheme.bodyText1),
                    SizedBox(height: 8.0),
                    GoogleButton(
                      onPressed: () => Navigator.pushNamed(context, 'login'),
                    ),
                    SizedBox(height: 32.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
