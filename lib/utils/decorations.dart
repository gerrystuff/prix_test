
  import 'package:flutter/material.dart';

InputDecoration customInputDecoration(String hintText, [icon]) {
    var estandardBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 32, 74, 245), width: 1.0),
    );

    var errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 230, 16, 16), width: 1.0),
    );

    return InputDecoration(
      errorStyle: const TextStyle(color: Color.fromARGB(255, 220, 13, 13)),
      hintText: hintText,
      enabledBorder: estandardBorder,
      focusedBorder: estandardBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
    );
}

   InputDecoration phoneInputDecoration(String hintText, [icon]) {
  
    var estandardBorder = OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.yellow,width: 2.5),
        borderRadius: BorderRadius.circular(30.0),
      );
    
    return InputDecoration(
      errorStyle: TextStyle(color: Colors.yellow),
      prefixIcon: icon != null ? icon : null,
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      enabledBorder       : estandardBorder,
      focusedBorder       : estandardBorder,
      errorBorder         : estandardBorder,
      focusedErrorBorder  : estandardBorder,
      contentPadding      : EdgeInsets.symmetric(vertical: 21,horizontal: 25)
    );
  }