import 'dart:io';

import 'package:flutter/cupertino.dart';

class MainProvider extends ChangeNotifier {
  bool enable = true;

  bool get getEnable => enable;

  set setEnable(bool enable) {
    this.enable = enable;
    notifyListeners();
  }

  bool rememberAnswer = false;

  bool get getRememberAnswer => rememberAnswer;

  set setRememberAnswer(bool rememberAnswer) {
    this.rememberAnswer = rememberAnswer;
    notifyListeners();
  }

  // Login - Information - - - - - - - - - - - - - - - - - //

  Map userInfo = {};

  Map get getUserInfo => userInfo;

  set setUserInfo(Map userInfo) {
    this.userInfo = userInfo;
    notifyListeners();
  }

  // Validation - - - - - - - - - - - - - - - - - - - - - //

  String token = '';

  String get getToken => token;

  set setToken(String token) {
    this.token = token;
    notifyListeners();
  }

  File image = File('');

  File get getImage => image;

  set setImage(File image) {
    this.image = image;
    notifyListeners();
  }

  // Order - Map - Coordinates - - - - - - - - - - - - - //

  String currentOrderAddress = '';

  get getCurrentOrderAddress => currentOrderAddress;

  set setCurrentOrderAddress(currentOrderAddress) {
    this.currentOrderAddress = currentOrderAddress;
    notifyListeners();
  }
}
