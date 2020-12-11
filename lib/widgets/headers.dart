import 'package:flu_tic_tac_toe/widgets/buttons.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String label;

  Header({@required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          UpButton(),
          SizedBox(width: 8.0),
          Text(
            label,
            style: Theme.of(context).textTheme.headline2
          ),
        ],
      ),
    );
  }
}
