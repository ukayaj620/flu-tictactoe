import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flu_tic_tac_toe/controllers/game_controller.dart';
import 'package:flu_tic_tac_toe/controllers/lobby_controller.dart';
import 'package:flu_tic_tac_toe/controllers/user_controller.dart';
import 'package:flu_tic_tac_toe/models/user.dart';
import 'package:flu_tic_tac_toe/utils/storage.dart';
import 'package:flu_tic_tac_toe/widgets/cards.dart';
import 'package:flu_tic_tac_toe/widgets/headers.dart';
import 'package:flu_tic_tac_toe/widgets/inputs.dart';
import 'package:flutter/material.dart';

class JoinGameScreen extends StatefulWidget {
  static const String _id = 'join_game';
  static String get id => _id;

  @override
  _JoinGameScreenState createState() => _JoinGameScreenState();
}

class _JoinGameScreenState extends State<JoinGameScreen> {
  LobbyController _lobbyController;
  GameController _gameController;
  List _lobbies = [];
  Map<String, User> _users = {};
  String _uid = '';
  StreamSubscription<Event> _lobbyStream;
  Storage _storage = Storage();

  @override
  void initState() {
    super.initState();
    _loadUserUidFromStorage();
    _lobbyController = LobbyController();
    _gameController = GameController();
    _lobbyStream = _lobbyController.subscribeToLobbies((event) {
      setState(() {
        print(_uid);
        _lobbies = event.snapshot.value.entries
            .where((lobby) => lobby.value['guest'] == null &&
              lobby.value['host'] != _uid)
            .toList();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _lobbyStream.cancel();
  }

  void _loadUserUidFromStorage() async {
    await _storage.init();
    setState(() {
      _uid = _storage.getUID();
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 0.0),
              child: Header(
                label: 'Join Game',
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Input(
                onSaved: (value) => value,
                validator: (value) => value,
                leftIcon: 'search',
              ),
            ),
            SizedBox(height: 24.0),
            Expanded(
              child: ListView.builder(
                itemCount: _lobbies.length,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemBuilder: (context, index) {
                  final code = _lobbies[index].key;
                  final hostUid = _lobbies[index].value['host'];
                  if (_users[code] == null) {
                    _lobbyController.getUserData(hostUid).then((user) {
                      print(user);
                      setState(() {
                        _users[code] = user;
                      });
                    });
                  }
                  return GameCard(
                    roomId: code,
                    username: _users[code]?.name,
                    win: _users[code]?.gamesWon.toString(),
                    lose: _users[code]?.gamesLost.toString(),
                    draw: _users[code]?.gamesDrawn.toString(),
                    onTap: () async {
                      await _gameController.joinGame(code);
                      Navigator.popAndPushNamed(context, 'game');
                    }
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
