import 'package:flutter/material.dart';
import 'package:food_diet_app/models/user.dart';

class UserAdapter extends ChangeNotifier {
  String? _token;
  String? _id;
  User? _user;

  User? get user => _user;
  set user(User? user){
    _user = user;
    notifyListeners();
  }
}