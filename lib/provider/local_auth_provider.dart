import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthProvider with ChangeNotifier {
  final authentication = LocalAuthentication();
  bool _authStatus = false;
  bool _isLoading = false;
  bool get authStatus => _authStatus;
  bool get isAuth => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> authenticate() async {
    try {
      setLoading(true);
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
      setLoading(false);
      log(e.toString());
      return false;
    }
  }
}
