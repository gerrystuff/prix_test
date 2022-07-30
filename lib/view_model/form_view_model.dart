import 'package:books/model/form_model.dart';
import 'package:flutter/material.dart';

class FormViewModel extends ChangeNotifier {
  FormModel formModel;

  FormViewModel() : formModel = FormModel();

  int calculateAge(DateTime birthDate) {
    final age = formModel.calculateAge(birthDate);
    return age;
  }
}
