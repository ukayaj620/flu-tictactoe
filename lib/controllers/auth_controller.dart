import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flu_tic_tac_toe/utils/random_generator.dart';
import 'package:flu_tic_tac_toe/utils/storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final Storage _storage = Storage();
  final RandomGenerator _random = RandomGenerator();

  /// credentials: {
  ///   email,
  ///   password,
  ///   name,
  ///   nickname,
  /// }
  Future<void> registerWithEmailAndPassword(Map credential) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: credential['email'], password: credential['password']);

      final User user = FirebaseAuth.instance.currentUser;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      final usersRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');
      usersRef.set({
        'name': credential['name'],
        'nickname': credential['nickname'],
        'email': user.email,
        'win': 0,
        'lose': 0,
        'draw': 0,
      });
      await _storage.setUID(user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    DatabaseReference usersRef = FirebaseDatabase.instance
        .reference()
        .child('users/${userCredential.user.uid}');

    DataSnapshot snapshot = await usersRef.once();

    if (snapshot.value == null) {
      usersRef.set({
        'name': userCredential.user.displayName,
        'nickname':
        userCredential.user.displayName.substring(0, 5).toLowerCase() +
            _random.generateNumber(3).toString(),
        'email': userCredential.user.email,
        'win': 0,
        'lose': 0,
        'draw': 0,
      });
    }

    await _storage.setUID(userCredential.user.uid);
    return true;
  }

  /// credentials: {
  ///   email,
  ///   password,
  ///   nickname,
  /// }
  /// TODO: changes is needed (It is better show the error on AlertDialog)
  Future<Map<String, dynamic>> signInWithEmailAndPassword(Map credentials) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: credentials['email'], password: credentials['password']);

      final User user = FirebaseAuth.instance.currentUser;
      if (!user.emailVerified) {
        return _authenticationFailure('User is not verified.');
      }

      await _storage.setUID(user.uid);
      return _authenticationSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return _authenticationFailure('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return _authenticationFailure('Wrong password provided for that user.');
      }
      return _authenticationFailure(e.message);
    }
  }

  Future<bool> isAuthenticated() async {
    await _storage.init();
    return _storage.getUID() != null;
  }

  Future<void> logout() async {
    await _storage.init();
    await _storage.clearUID();
  }

  Map<String, dynamic> _authenticationSuccess () {
    return {'isAuthenticated': true};
  }

  Map<String, dynamic> _authenticationFailure (String message) {
    return {'isAuthenticated': false, 'message': message};
  }
}
