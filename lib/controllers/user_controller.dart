import 'package:firebase_database/firebase_database.dart';
import 'package:flu_tic_tac_toe/models/user.dart';
import 'package:flu_tic_tac_toe/utils/storage.dart';

class UserController {
  User _user = User.empty();
  User get user => _user;
  Storage _storage = Storage();

  Future<void> init() async {
    await _storage.init();
    String uid = _storage.getUID();

    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$uid');

    DataSnapshot snapshot = await userRef.once();

    _user = User(
      name: snapshot.value['name'],
      nickname: snapshot.value['nickname'],
      email: snapshot.value['email'],
      gamesWon: snapshot.value['win'],
      gamesLost: snapshot.value['lose'],
      gamesDrawn: snapshot.value['draw'],
      gamesPlayed: snapshot.value['win'] +
          snapshot.value['lose'] +
          snapshot.value['draw'],
    );
  }

  Future<String> getNickName(String uid) async {
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$uid');

    DataSnapshot snapshot = await userRef.once();
    return snapshot.value['nickname'];
  }

  Future<void> updateUserGamePlay(String uid, String result) async {
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users/$uid');
    DataSnapshot snapshot = await userRef.once();

    Map<String, dynamic> valueToBeUpdated = {};
    switch(result) {
      case 'win':
        valueToBeUpdated = {'win': snapshot.value['win'] + 1};
        break;
      case 'lose':
        valueToBeUpdated = {'lose': snapshot.value['lose'] + 1};
        break;
      case 'draw':
        valueToBeUpdated = {'draw': snapshot.value['draw'] + 1};
        break;
    }

    userRef.update(valueToBeUpdated);
  }
}
