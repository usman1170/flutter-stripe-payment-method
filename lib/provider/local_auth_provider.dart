import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as error_code;

class LocalAuthProvider with ChangeNotifier {
  final authentication = LocalAuthentication();
  bool _authStatus = false;
  String _msg = "";
  bool _isLoading = false;
  bool get authStatus => _authStatus;
  bool get isAuth => _isLoading;
  String get msg => _msg;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setMsg(String value) {
    _msg = value;
    notifyListeners();
  }

  Future<bool> authenticate() async {
    try {
      setLoading(true);
      setMsg("");
      _authStatus = await authentication.authenticate(
          localizedReason: "Authentication",
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      log("Auth status = $_authStatus");
      setLoading(false);
      return _authStatus;
    } on PlatformException catch (e) {
      if (e.code == error_code.notAvailable) {
        setMsg("notAvailable");
      }
      setLoading(false);
      log(e.toString());
      return false;
    }
  }
}
