import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _instance;

  FirebaseAuthService(this._instance);

  Future<void> signOut() => _instance.signOut();

  /// Registers a new user using the native email/password provider.
  Future<void> signUp({
    required String email,
    required String password,
    Function(String)? onFail,
    Function(User?)? onSuccess,
  }) async {
    try {
      final UserCredential credential =
          await _instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (onSuccess != null) {
        onSuccess(credential.user);
      }
    } on FirebaseAuthException catch (exception) {
      if (onFail != null) {
        return onFail(exception.message!);
      }
    }
  }

  /// Logs in the user if it exists and the email has been verified.
  /// Otherwise a [FirebaseAuthException] may be thrown.
  Future<User?> signIn({
    required String email,
    required String password,
    Function(String)? onFail,
    Function(User?)? onSuccess,
  }) async {
    try {
      final UserCredential credential =
          await _instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (onSuccess != null) {
        onSuccess(credential.user);
      }
      return credential.user;
    } on FirebaseAuthException catch (exception) {
      if (onFail != null) {
        return onFail(exception.message!);
      }
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Sends a verification email to a user.
  Future<void> sendEmailVerification() {
    return _instance.currentUser!.sendEmailVerification();
  }

  Stream<User?> get authStateChanges => _instance.authStateChanges();

  /// Refreshes the current user, if signed in.
  Future<void> reloadUser() => _instance.currentUser!.reload();

  bool get isEmailVerified => _instance.currentUser!.emailVerified;

  User? get user => _instance.currentUser;
}
