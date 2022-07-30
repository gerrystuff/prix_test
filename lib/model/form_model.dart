import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'domain/user.dart';

class FormModel {

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }


  Future<bool> storeUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    bool isSaved =  await prefs.setString('user', json.encode(user));

    return isSaved;
  }


  Future<bool> restoreUser() async {
  final prefs = await SharedPreferences.getInstance();
    bool userRestored = await  prefs.remove('user');

    return userRestored;
  }


  dynamic  getUserStored() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.get('user');

    if(userString == null){
      return 0;
    } else {
      return userString;
    }
  } 


  
}
