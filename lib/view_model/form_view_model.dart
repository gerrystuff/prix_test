import 'dart:convert';

import 'package:books/model/domain/user.dart';
import 'package:books/model/form_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormViewModel extends ChangeNotifier {
  final FormModel _formModel;
  final User _user;

  bool userExists = false;

  FormViewModel()
      : _formModel = FormModel(),
        _user = User(
            firstLastName: '',
            firstName: '',
            email: '',
            phoneNumber: '',
            sex: 'male',
            secondName: '',
            secondLastName: '',
            yearsOld: '',
            birthday: '');

  User get user => _user;

  int calculateAge(DateTime birthDate) {
    final age = _formModel.calculateAge(birthDate);
    return age;
  }

  Future<bool> saveUser() async {
    bool isSaved = await _formModel.storeUser(user);
    return isSaved;
  }

  Future<bool> restoreUser() async {
    bool userRestored = await _formModel.restoreUser();
    return userRestored;
  }

  dynamic getStoreUser() async {
    final userString = await _formModel.getUserStored();

    if (userString == 0) {
      userExists = false;
    } else {
      userExists = true;
    }

    notifyListeners();
    return userString;
  }
}
