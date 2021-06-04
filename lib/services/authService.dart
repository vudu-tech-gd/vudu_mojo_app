import 'package:firebase_auth/firebase_auth.dart';
import 'package:vudu_mojo_app/locator.dart';
import 'package:vudu_mojo_app/models/mojoUser.dart';
import 'package:vudu_mojo_app/mojoInterface.dart';
import 'package:vudu_mojo_app/services/service.dart';

class AuthService extends Service {
  User? _user;
  String? _accessToken;
  DateTime? _expiryDate;
  bool _isLogout = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MojoInterface _mojo = locator<MojoInterface>();

  bool isAuthenticated() {
    if (_expiryDate == null) return false;

    if (_expiryDate!.isBefore(DateTime.now())) {
      _accessToken = null;
      _expiryDate = null;
      _user = null;
      return false;
    }

    return true;
  }

  User get user {
    return _user!;
  }

  User? get currentUser {
    return _auth.currentUser;
  }

  String? get accessToken {
    return _accessToken;
  }

  Future<bool> isAccountVerified() async {
    await _user!.reload();
    _user = _auth.currentUser;
    var idToken = await _user!.getIdTokenResult(true);
    _accessToken = idToken.token;
    _expiryDate = idToken.expirationTime;
    return _user!.emailVerified;
  }

  Future<void> sendWelcomeEmail() async {
    await _user!.sendEmailVerification();
  }

  Future<void> loginAsync(
      String email, String password, Function onLoginSuccess) async {
    var result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final User? user = result.user;

    final User currentUser = _auth.currentUser!;
    assert(user!.uid == currentUser.uid);

    if (user != null) {
      _user = user;
      var idToken = await user.getIdTokenResult(false);
      _accessToken = idToken.token;
      _expiryDate = idToken.expirationTime;
      _isLogout = false;
      await onLoginSuccess();
      notifyListeners();
    }
  }

  Future<void> logoutAsync() async {
    await _auth.signOut();
    _accessToken = null;
    _expiryDate = null;
    _user = null;
    _isLogout = true;
    notifyListeners();
  }

  bool isLogout() {
    return _isLogout;
  }

  Future<void> passwordResetRequestAsync(emailAddress) async {
    try {
      await _auth.sendPasswordResetEmail(email: emailAddress);
    } on FirebaseAuthException catch (error) {
      if (error.code != 'ERROR_USER_NOT_FOUND') {
        throw Exception(error);
      }
    }
  }

  Future<bool> registerAsync(Map<String, String> registrationData) async {
    return _registerAsync(
        registrationData['email'], registrationData['password']);
  }

  Future<bool> registerAccountAsync(MojoUser registrationData) async {
    return _registerAsync(
        registrationData.emailAddress, registrationData.password);
  }

  Future<bool> _registerAsync(emailAddress, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return true;
    } catch (e) {
      Map<String, String> error = {'error': e.toString()};
      _mojo.logError(error);
    }

    return false;
  }

  Future<void> serverWarmup() async {
    // try {
    //   var callable =
    //       CloudFunctions.instance.getHttpsCallable(functionName: 'healthCheck');
    //   await callable.call({"data": 'abc'});
    // } catch (e) {
    //   print(e);
    // }
  }
}
