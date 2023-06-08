import 'package:flutter/material.dart';

import '../../models/user_model.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  databaseError,
}

class AuthChNot extends ChangeNotifier {
  AuthStatus _status = AuthStatus.unknown;
  UserModel? _user;

  UserModel? get user => _user;
  set user(UserModel? value) {
    _user = value;
    if (_user == null) {
      _status = AuthStatus.unauthenticated;
    } else {
      _status = AuthStatus.authenticated;
    }
    notifyListeners();
  }

  AuthStatus get status => _status;
  set status(AuthStatus value) {
    _status = value;
    notifyListeners();
  }

  void logout() {
    _user = null;
    status = AuthStatus.unauthenticated;
    notifyListeners();
  }
}
