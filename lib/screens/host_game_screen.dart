import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flu_tic_tac_toe/controllers/game_controller.dart';
import 'package:flu_tic_tac_toe/controllers/lobby_controller.dart';
import 'package:flu_tic_tac_toe/widgets/buttons.dart';
import 'package:flu_tic_tac_toe/widgets/cards.dart';
import 'package:flu_tic_tac_toe/widgets/headers.dart';
import 'package:flutter/material.dart';

class HostGameScreen extends StatefulWidget {
  static const String _id = 'host_game';
  static String get id => _id;

  @override
  _HostGameScreenState createState() => _HostGameScreenState();
}

class _HostGameScreenState extends State<HostGameScreen> {
  LobbyController _lobbyController;
  GameController _gameController;
  StreamSubscription<Event> _hostedStream;
  String _code = '';
  bool _disabled = true;

  @override
  void initState() {
    super.initState();
    _lobbyController = LobbyController();
    _gameController = GameController();
    _lobbyController.hostAndSubscribeToLobby((event) async {
      setState(() {
        _code = event.snapshot.value['code'];
      });
      if (event.snapshot.value['guest'] != null) {
        setState(() {
          _disabled = false;
        });
      }
    }).then((stream) {
      _hostedStream = stream;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _hostedStream.cancel();
    _lobbyController.disposeLobbyWhenExit(_code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
                child: Header(
                  label: 'Host Game',
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 16.0),
                      child: Image(
                        image: AssetImage('assets/vectors/host_game.png'),
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      'Game Code',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .apply(fontWeightDelta: 2),
                    ),
                    TextCard(_code,
                        textStyle: Theme.of(context).textTheme.headline1),
                    SizedBox(height: 48.0),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Button(
                        text: 'LET\'S GO',
                        color: Theme.of(context).primaryColor,
                        disabled: this._disabled,
                        onPressed: () {
                          _gameController.init();
                          Navigator.pushReplacementNamed(context, 'game');
                        },
                      ),
                    ),
                    SizedBox(height: 32.0),
                    Text(
                      this._disabled ? 'Waiting for other player ...' : 'LET\'S GO',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ]
                ),
              ),
            ),
          ],
        )));
  }
}
