import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool dark;
  final bool disabled;

  Button({
    @required this.text,
    @required this.onPressed,
    this.color,
    this.dark = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: disabled ? null : onPressed,
      color: color != null ? color : Theme.of(context).primaryColor,
      disabledColor: Colors.grey[300],
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.button.apply(
          color: dark ? Colors.white : Theme.of(context).primaryColorDark
        )
      ),
    );
  }
}

class GoogleButton extends StatelessWidget {
  final VoidCallback onPressed;

  GoogleButton({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/icons/google.png'),
            height: 32.0
          ),
          SizedBox(width: 8.0),
          Text(
            'GOOGLE',
            style: Theme.of(context).textTheme.button
          ),
        ],
      ),
    );
  }
}

class UpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 36.0,
            height: 36.0,
            padding: EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/up_button.png'),
          ),
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {

  final VoidCallback onTap;

  ProfileButton({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: 1 / 6 * MediaQuery.of(context).size.width,
            height: 1 / 6 * MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8.0),
            child: Image.asset('assets/icons/profile.png'),
          ),
        ),
      ),
    );
  }
}
