import 'package:flutter/material.dart';


TextField textField(String text, TextEditingController controller) {
  return TextField(

    controller: controller,
    decoration: InputDecoration(
      filled: true,
      hintText: text,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ),
  );
}