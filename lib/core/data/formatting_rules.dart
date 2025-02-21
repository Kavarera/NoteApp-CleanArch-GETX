import 'package:flutter/material.dart';

class CustomFormattingRules {
  static const Map<String, TextStyle> styles = {
    'b': TextStyle(fontWeight: FontWeight.bold),
    'i': TextStyle(fontStyle: FontStyle.italic),
    'u': TextStyle(decoration: TextDecoration.underline),
  };
}
