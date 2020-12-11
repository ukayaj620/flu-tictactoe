import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final ValueSetter<String> onSaved;
  final String Function(String) validator;
  final bool secure;
  final String leftIcon;

  Input({
    @required this.onSaved,
    @required this.validator,
    this.secure = false,
    this.leftIcon = '',
  });

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {

  static bool _isToggle;

  @override
  void initState() {
    _isToggle = widget.secure;
    super.initState();
  }

  void _toggleText() {
    setState(() {
      _isToggle = !_isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 2.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: Row(
        children: [
          widget.leftIcon != ''
            ? Container(
                width: 24.0,
                margin: EdgeInsets.only(right: 8.0),
                child: Image.asset('assets/icons/${widget.leftIcon}.png')
            )
            : Container(),
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              obscureText: widget.secure ? _isToggle : false,
              onSaved: widget.onSaved,
              validator: widget.validator
            ),
          ),
          widget.secure
            ? GestureDetector(
                onTap: _toggleText,
                child: Container(
                  width: 24.0,
                  margin: EdgeInsets.only(right: 8.0),
                  child: Image.asset('assets/icons/${_isToggle ? 'hide' : 'show'}.png')
                ),
            )
            : Container(),
        ],
      ),
    );
  }
}

class LabeledInput extends StatelessWidget {
  final String labelText;
  final ValueSetter<String> onSaved;
  final String Function(String) validator;
  final bool secure;

  LabeledInput({
    this.labelText,
    this.onSaved,
    this.validator,
    this.secure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: Theme.of(context).textTheme.bodyText1
          ),
          Input(
            onSaved: onSaved,
            validator: validator,
            secure: secure,
          )
        ],
      ),
    );
  }
}