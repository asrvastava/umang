import 'package:flutter/widgets.dart';
import '../models/user.dart';
import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final Authmethods _authMethods = Authmethods();

  User? get getuser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getuserdetails();
    _user = user;
    notifyListeners();
  }
}
