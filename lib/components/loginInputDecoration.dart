import 'package:flutter/material.dart';

InputDecoration getLoginInputDecoration(String label, {Icon? icon}) {
  return InputDecoration(
    icon: icon,
    hintText: label,
    fillColor: Colors.white,
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0)
  );
}