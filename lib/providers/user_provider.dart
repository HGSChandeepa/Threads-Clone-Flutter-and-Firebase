import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_logic.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethodes _authMethodes = AuthMethodes();
  //getter
  User get getUser => _user!;

  //methode for registering the user
  Future<void> refreshUser() async {
    User user = await _authMethodes.getCurrentUser();
    _user = user;

    //notify the listeners
    notifyListeners();
  }
}
