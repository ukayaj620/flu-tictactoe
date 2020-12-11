import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flu_tic_tac_toe/models/user.dart' as model;
import 'package:flu_tic_tac_toe/utils/random_generator.dart';
import 'package:flu_tic_tac_toe/utils/storage.dart';

class LobbyController {
  Storage _storage = Storage();
  RandomGenerator _random = RandomGenerator();

  StreamSubscription<Event> subscribeToLobbies(Function(Event) callback) {
    final refs = FirebaseDatabase.instance.reference().child('lobbies');
    return refs.onValue.listen((event) {
      callback(event);
    });
  }

  Future<model.User> getUserData(uid) async {
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$uid');
    DataSnapshot snapshot = await userRef.once();
    return model.User(
      name: snapshot.value['name'],
      email: snapshot.value['email'],
      gamesWon: snapshot.value['win'],
      gamesLost: snapshot.value['lose'],
      gamesDrawn: snapshot.value['draw'],
      gamesPlayed: snapshot.value['win'] +
          snapshot.value['lose'] +
          snapshot.value['draw'],
    );
  }

  Future<StreamSubscription<Event>> hostAndSubscribeToLobby(
      Function(Event) callback) async {
    await _storage.init();
    String uid = _storage.getUID();

    final code = _random.generateNumber(6);

    final refs = FirebaseDatabase.instance.reference().child('lobbies/$code');
    refs.set({
      'code': code,
      'host': uid,
    });

    await _storage.setGameCode(code);

    return refs.onValue.listen((event) {
      callback(event);
    });
  }

  void disposeLobbyWhenExit(String code) async {
    final refs = FirebaseDatabase.instance.reference().child('lobbies/$code');
    refs.remove();
    await _storage.init();
    await _storage.clearGameCode();
  }
}
